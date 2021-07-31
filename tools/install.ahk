#Include %A_ScriptDir%
#Include utils.ahk

; Parse arguments
installPath :=
if A_Args.Length() >= 1 {
    installPath := A_Args[1]
}

; Wait for installer window to show
SafeClick("Button1", "&Next >", "XtremeTuner")

; Second screen, select installation path and click Next
if installPath {
    SafeClick("Button5", "B&rowse...", "XtremeTuner")
    Send, %installPath%
    SafeClick("Button1", "OK", "Select Destination Directory")

    if WinExist("Select Destination Directory") and WinExist("Install") {
        WinGet, InstallerPid, PID, XtremeTuner
        Run, taskkill /F /PID %InstallerPid%
        ExitApp, 1
    }
}
SafeClick("Button1", "&Next >", "XtremeTuner")

; Third screen, click Next and start installation
SafeClick("Button1", "&Next >", "XtremeTuner")

; Wait for installation to end and click Finish
SafeClick("Button1", "&Finish >", "XtremeTuner")
