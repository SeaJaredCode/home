@echo off
SET BASH="%ProgramFiles%\Git\bin\bash.exe"

%BASH% -c "export -p" > vsvars.local.env.0"
call "%VS140COMNTOOLS%\vsvars32.bat"
%BASH% -c "export -p" > vsvars.local.env.1"

