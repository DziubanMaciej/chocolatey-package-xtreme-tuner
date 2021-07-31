#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 1
SetControlDelay 100

WaitForButtonsToShowUp(controlName, controlText, windowName) {
    isLoaded := 0
    isNextButton := 0
    while not (isLoaded and label == controlText) {
        ControlGet, isLoaded, Visible,, %controlName%, %windowName%
        ControlGetText, label, %controlName%, %windowName%
        Sleep, 100
    }
}
SafeClick(controlName, controlText, windowName) {
    WaitForButtonsToShowUp(controlName, controlText, windowName)
    ControlClick, %controlName%, %windowName%,,,, NA
}
