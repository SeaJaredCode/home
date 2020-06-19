#!/usr/bin/env bash

set -e

show_help() {
cat <<EOF
Usage:
   $(basename $0) -i | --init [[ -b | --branch ] BRANCH_NAME ]
   $(basename $0) -h | --help
   $(basename $0) [ -p | --push [ -d | --delete ]] [ -r | --remote REMOTE ] [[ -b | --branch ] BRANCH_NAME ] [ PATH_TO_REPO ]

Options:
   -i | --init                  Change default repository template

   -b | --branch BRANCH_NAME    Specify default branch name.
                                Defaults to \"main\"

   -h | --help                  Show this help screen
   
   -p | --push                  Push the new remote branch to the remote
                                specified
   
   -r | --remote REMOTE         Specify the remote to fetch head and optionally
                                push to. Defaults to \"origin\"
   
   -d | --delete                Remove the default branch on the remote

   PATH_TO_REPO specifies a path into a repository to configure. Will default
   to the current directory.
EOF
}

__branch=main
while [ "$#" -gt 0 ]; do
    case "$1" in
        -h | --help)
            show_help
            exit
            ;;
        -i | --init)
            __init=true
            shift
            ;;
        -b | --branch)
            __branch=$2
            shift 2
            ;;
        -p | --push)
            __push=true
            shift
            ;;
        -r | --remote)
            __remote=$2
            shift 2
            ;;
        -d | --delete)
            __delete=true
            shift
            ;;
        *)
            __repo_path="$1"
            break
            ;;
    esac
done

if ! which git >> /dev/null 2>&1; then
    echo "Could not find git! Is it installed?" >&2
    exit 1
fi

if [ -n "${__init}" ]; then
    __temp_dir=$(mktemp -d)
    trap "rm -r $__temp_dir" EXIT

    __template_dir=~/.config/git_template
    if [ -d "$__template_dir" ]; then
        while true; do
            read -p "Template directory exists. [R]eplace [I]gnore [C]ancel: " response
            case response in
                [Rr]*)
                    rm -r "$__template_dir"
                    break
                    ;;
                [Ii]*)
                    break
                    ;;
                [Cc]*)
                    exit 1
                    ;;
            esac
        done
    else
        mkdir -p "$__template_dir"
    fi

    (
        cd "$__temp_dir"
        git init . >> /dev/null
        cp -R .git/ "${__template_dir}"
        echo "ref: refs/heads/${__branch}" > "$__template_dir"/HEAD
        git config --global --replace-all init.templateDir "$__template_dir"
    )
    exit
fi


cd "${__repo_path:-.}" >> /dev/null
__git_dir="$(git rev-parse --git-dir 2>> /dev/null)" 
if [ -z "$__git_dir" ]; then
    echo "${__repo_path:-This} is not a git repository!"
    exit 1
fi

if [ -n "$__push" ]; then
    __master_ref="${__git_dir}/refs/remotes/${__remote:-origin}/master"
    __ref=${__remote:-origin}/master
else
    __master_ref="${__git_dir}/refs/heads/master"
    __ref=master
fi

if [[ -n "$__remote" || -n "$__push" ]]; then
    git fetch ${__remote:-origin}
fi

if [[ ! -f "${__master_ref}" ]]; then
    echo "Master branch not found $__master_ref. Not sure what you want me to do!"
    exit 1
fi

if [[ -f "${__git_dir}/refs/heads/${__branch}" ]]; then
    while true; do
        read -p "Branch [$__branch] already exists. [R]eplace or [C]ancel? " response
        case "$response" in
            [Rr]*)
                if [[ "$(head -n 1 $__git_dir/HEAD)" == "ref: refs/heads/$__branch" ]]; then
                    echo "$__branch Currently checked out. Checking out headless."
                    git checkout $(git rev-parse HEAD) >> /dev/null 2>&1
                    __checkout=true
                fi
                git branch -D "$__branch" >> /dev/null 2>&1
                break;;
            [Cc]*)
                exit 1;;
        esac
    done
fi

if [[ -n "$__push" && -f "${__git_dir}/refs/remotes/${__remote:-origin}/${__branch}" ]]; then
    while true; do
        read -p "Remote branch [$__branch] already exists. [R]eplace or [C]ancel?" response
        case "$response" in
            [Rr]*)
                git push -f "${__remote:-origin}" :"$__branch"
                break;;
            [Cc]*)
                exit 1;;
        esac
    done
fi

git branch "$__branch" "$__ref"

if [ -n "$__push" ]; then
    git push "${__remote:-origin}" "$__branch":"$__branch"

    cat <<EOF
 You must now change the default on the remote because the main branch can't be
 deleted while in use.

 See the administration of the remote for information on how to do this.

 This can also be done with some apis, like for github or bitbucket.
EOF

    if git remote -v | grep "$__branch.*github"; then cat <<EOF
 This looks like a github repository. This can be changed in the admin UI or 
 via an API.

 With the appropriate credentials, repo and user variables filled, the api call
 will look something like:

    curl -u \$GITHUB_CREDS \
        -X PATCH \
        --data '{"default_branch":"${__branch}"}' \
        https://api.github.com/repos/\$user/\$response

EOF
    elif git remote -v | grep "$__branch.*bitbucket"; then cat <<EOF
 This looks like a bitbucket repository. This can be changed in the UI or via
 an API call similar to:

 ....
EOF
    fi
    read -p "Press enter to continue. " __does_not_matter__
fi

if [ -n "$__delete" ]; then
    git branch -D master
    if [ -n "$__push" ]; then
        git push -f "${__remote:-origin}" :master
    fi
fi

if [ -n "$__checkout" ]; then
    git branch --unset-upstream
    git checkout "$__branch"
fi
