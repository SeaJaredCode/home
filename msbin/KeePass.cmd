@echo off
if exist %TEMP%\keepass?.sock del /a %temp%\keepass?.sock

pushd %HOME%\apps\KeePass
start KeePass.exe
popd
