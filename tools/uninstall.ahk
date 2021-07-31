#Include %A_ScriptDir%
#Include utils.ahk

; First screen, select "Custom"
SafeClick("Button7", "&Custom", "XtremeTuner")
SafeClick("Button1", "&Next >", "XtremeTuner")

; There are 5 identical screens. Click "Select All" and then Next in all of them
Loop, 5 {
    SafeClick("Button4", "Select &All", "XtremeTuner")
    SafeClick("Button1", "&Next >", "XtremeTuner")
}

SafeClick("Button1", "&Finish", "XtremeTuner")
