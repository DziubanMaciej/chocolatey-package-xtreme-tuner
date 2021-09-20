$ErrorActionPreference = 'Stop'

$packageParams = Get-PackageParameters
$noAutohotkey = $packageParams.noAutohotkey
$installDir = $packageParams.installDir
if ($installDir -and $noAutohotkey) {
    throw "Cannot specify /installDir with /noAutohotkey"
}

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = "https://www.kfa2.com/downloads/XtremeTuner_Android(1.0.5.8).rar"
$rarPackage = "$toolsDir\" + ($url.split('/') | Select-Object -Last 1)
$downloadArgs = @{
    PackageName  = $packageName
    FileFullPath = $rarPackage
    Url          = $url
}
Get-ChocolateyWebFile @downloadArgs
7z e $rarPackage -aoa "-o$toolsDir"

$installArgs = @{
    PackageName    = $packageName
    FileType       = "exe"
    SilentArgs     = "/S"
    File           = "$toolsDir\XtremeTuner_Android.EXE"
    ValidExitCodes = @(0)
}
if ($installDir) {
    Write-Host "Overriding installation path to $installDir"
}
if (-not $noAutohotkey) {
    $installArgs.SilentArgs = ""
    $ahkFile = Join-Path $toolsDir "install.ahk"
    Write-Host "Running $ahkFile"
    $ahkProc = Start-Process -FilePath 'AutoHotKey' `
                             -ArgumentList "`"$ahkFile`" `"$installDir`"" `
                             -PassThru
}
Install-ChocolateyInstallPackage @installArgs
