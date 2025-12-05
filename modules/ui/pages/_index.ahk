#Requires AutoHotkey v2

; pages aggregator: include framework first, then all pages

; framework
#Include "..\UI_Framework.ahk"
; profile API（先于其他页）
#Include "profile\Page_Profile_API.ahk"
; dialogs
#Include "..\dialogs\GUI_ImportWizard.ahk"
#Include "..\dialogs\GUI_SkillEditor.ahk"
#Include "..\dialogs\GUI_PointEditor.ahk"
#Include "..\dialogs\BatchRecolor_Core.ahk"
#Include "..\dialogs\GUI_SkillBatchRecolor.ahk"
#Include "..\dialogs\GUI_PointBatchRecolor.ahk"
#Include "..\dialogs\GUI_BuffEditor.ahk"
#Include "..\dialogs\GUI_CastDebug.ahk"
#Include "..\dialogs\GUI_SkillPresetImport.ahk"
; profile
#Include "profile\Page_Profile.ahk"
; data
#Include "data\Page_Skills.ahk"
#Include "data\Page_Points.ahk"
#Include "data\Page_DefaultSkill.ahk"
; tools
#Include "tools\Page_Tools_IO.ahk"
#Include "tools\Page_Tools_Quick.ahk"
; settings
#Include "settings\Page_Settings_Lang.ahk"
#Include "settings\Page_Settings_About.ahk"