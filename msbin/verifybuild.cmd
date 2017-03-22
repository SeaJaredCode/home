@echo off

SET buildcmd=Build\RunFastBuildVerification.cmd

if exist "%buildcmd%" (
    "%buildcmd%"
) else (
    pushd c:\git\main\
    "%buildcmd%"
    popd
)
