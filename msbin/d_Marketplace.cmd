C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Tools\VsDevCmd.bat 

net stop Mercent.Marketplace

@if exist "%ProgramFiles%\MSBuild\12.0\bin" set PATH=%ProgramFiles%\MSBuild\12.0\bin;%PATH%
@if exist "%ProgramFiles(x86)%\MSBuild\12.0\bin" set PATH=%ProgramFiles(x86)%\MSBuild\12.0\bin;%PATH%

d: 
cd git\main
msbuild Solution\Marketplace\Setup\Marketplace.Setup.proj /p:configuration=debug
msbuild Deployment\Components\Marketplace\Marketplace.deploy.proj
net start Mercent.Marketplace