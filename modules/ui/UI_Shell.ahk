; ============================== modules\ui\UI_Shell.ahk ==============================
#Requires AutoHotkey v2
#Include "pages\_index.ahk"

; 主壳：左侧 TreeView + 右侧面板（严格块结构）

UI_ShowMain() {
    global UI, UI_NavMap
    UI_EnablePerMonitorDPI()

    try {
        if !(IsSet(gLang) && gLang.Has("Code")) {
            Lang_Init("zh-CN")
        }
    } catch {
        Lang_Init("zh-CN")
    }

    UI.Main := Gui("+Resize +OwnDialogs", T("app.title", "Game Macro - v0.2.4"))
    UI.Main.MarginX := 12
    UI.Main.MarginY := 10
    UI.Main.SetFont("s10", "Segoe UI")
    UI.Main.OnEvent("Size", UI_OnResize_LeftNav)
    UI.Main.OnEvent("Close", UI_OnMainClose)

    UI.Nav := UI.Main.Add("TreeView", "xm ym w220 h620 +Lines +Buttons")
    UI.Nav.OnEvent("Click", UI_OnNavChange)

    rootProfile := UI.Nav.Add("概览与配置")
    rootData    := UI.Nav.Add("数据与检测")
    rootTools   := UI.Nav.Add("工具")
    rootSet     := UI.Nav.Add("设置")

    nodeProfile := UI.Nav.Add("概览与配置", rootProfile)

    nodeSkills  := UI.Nav.Add("技能配置",   rootData)
    nodePoints  := UI.Nav.Add("取色点位",   rootData)
    nodeDefault := UI.Nav.Add("默认技能",   rootData)

    nodeToolsIO    := UI.Nav.Add("导入 / 导出", rootTools)
    nodeToolsQuick := UI.Nav.Add("快捷测试",    rootTools)

    nodeSettingsLang  := UI.Nav.Add("界面 / 语言", rootSet)
    nodeSettingsAbout := UI.Nav.Add("关于",       rootSet)

    try {
        UI.Nav.Modify(rootProfile, "Expand")
        UI.Nav.Modify(rootData,    "Expand")
        UI.Nav.Modify(rootTools,   "Expand")
        UI.Nav.Modify(rootSet,     "Expand")
    }
    UI_NavMap[nodeProfile]      := "profile"
    UI_NavMap[nodeSkills]       := "skills"
    UI_NavMap[nodePoints]       := "points"
    UI_NavMap[nodeDefault]      := "default_skill"

    UI_NavMap[nodeToolsIO]      := "tools_io"
    UI_NavMap[nodeToolsQuick]   := "tools_quick"
    UI_NavMap[nodeSettingsLang] := "settings_lang"
    UI_NavMap[nodeSettingsAbout]:= "settings_about"

    UI_RegisterPage("profile",        "概览与配置", Page_Profile_Build,        Page_Profile_Layout, Page_Profile_OnEnter)
    UI_RegisterPage("skills",         "技能配置",   Page_Skills_Build,         Page_Skills_Layout, Page_Skills_OnEnter)
    UI_RegisterPage("points",         "点位",      Page_Points_Build,         Page_Points_Layout, Page_Points_OnEnter)
    UI_RegisterPage("default_skill",  "默认技能",   Page_DefaultSkill_Build,   Page_DefaultSkill_Layout,  Page_DefaultSkill_OnEnter)
    UI_RegisterPage("tools_io",       "导入导出",   Page_ToolsIO_Build,        Page_ToolsIO_Layout, Page_ToolsIO_OnEnter)
    UI_RegisterPage("tools_quick",    "快捷测试",   Page_ToolsQuick_Build,     Page_ToolsQuick_Layout, Page_ToolsQuick_Layout)

    UI_RegisterPage("settings_lang",  "界面语言",   Page_Settings_Lang_Build,  Page_Settings_Lang_Layout, Page_Settings_Lang_OnEnter)
    UI_RegisterPage("settings_about", "关于",       Page_Settings_About_Build, Page_Settings_About_Layout,Page_Settings_About_OnEnter)

    UI.Main.Show("w1060 h780")

    try {
        UI.Nav.Modify(nodeProfile, "Select")
    }
    UI_OnNavChange()
}

UI_OnMainClose(*) {
    ExitApp()
}

UI_OnNavChange(*) {
    global UI, UI_NavMap

    sel := UI.Nav.GetSelection()
    if (!sel) {
        return
    }
    if (!UI_NavMap.Has(sel)) {
        try {
            UI.Nav.Modify(sel, "Expand")
        } catch {
        }
        return
    }
    key := UI_NavMap[sel]
    UI_SwitchPage(key)
}

UI_OnResize_LeftNav(gui, minmax, w, h) {
    global UI

    if (minmax = 1) {
        return
    }
    if (minmax = -1) {
        return
    }
    if (w <= 0 || h <= 0) {
        return
    }
    navW := 220
    UI.Nav.Move(UI.Main.MarginX, UI.Main.MarginY, navW, Max(h - UI.Main.MarginY * 2, 320))
    UI_LayoutCurrentPage()
}