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

$ahkFile = Join-Path $toolsDir "uninstall.ahk"
Write-Host "Running $ahkFile"
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
