Param(
    [Parameter(Mandatory=$true, Position=1)]
    [string] $compressedFile
    )

if ((Test-Path -Path $compressedFile) -and ($compressedFile -match "(?<path>.*\\)(?<filename>[^\\]*)(?<ext>\..{2,3})$"))
{
    Write-Host "No bueno"
    return
}

switch ($Matches["ext"])
{
    ".gz" {
        gzip -d -k $compressedFile
        start "$(-join @($Matches["path"], $Matches["filename"]))"
     }
}