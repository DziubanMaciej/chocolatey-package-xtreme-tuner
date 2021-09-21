$ErrorActionPreference = 'Stop'

$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
if ((Get-ProcessorBits 64)) {
    $uninstallerPath = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\XtremeTuner"
} else {
    $uninstallerPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\XtremeTuner"
}
$uninstallerPath = (Get-ItemProperty $uninstallerPath).UninstallString.split(' ')[0]
$uninstallerPath = (Get-Item $uninstallerPath).FullName
Write-Host "XtremeTuner uninstaller is $uninstallerPath"

$temporaryFolder = "$Env:Temp\$(Get-Random)"
mkdir $temporaryFolder -Force
Copy-Item (Join-Path $toolsDir "*.ahk") $temporaryFolder\
$ahkFile = "$temporaryFolder\uninstall.ahk"

Write-Host "Running AutoHotKey uninstall script for XtremeTuner: $ahkFile"
$ahkProc = Start-Process -FilePath 'AutoHotKey' `
					     -ArgumentList "`"$ahkFile`"" `
					     -PassThru

$uninstallArgs = @{
    PackageName    = $packageName
    FileType       = "exe"
    SilentArgs     = ""
    File           = $uninstallerPath
    ValidExitCodes = @(0)
}
Uninstall-ChocolateyPackage @uninstallArgs

Write-Host "Removing temporary folder $temporaryFolder"
Remove-Item $temporaryFolder -Force -Recurse
