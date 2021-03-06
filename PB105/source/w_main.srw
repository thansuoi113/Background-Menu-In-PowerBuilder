$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type menuinfo from structure within w_main
end type
end forward

type menuinfo from structure
	long		cbsize
	long		fmask
	long		dwstyle
	long		cymax
	long		hbrback
	long		dwcontexthelpid
	long		dwmenudata
end type

global type w_main from window
integer width = 1824
integer height = 1380
boolean titlebar = true
string title = "Background Menu"
string menuname = "m_main"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
end type
global w_main w_main

type prototypes

FUNCTION Long SetMenu ( Long hwnd, Long hMenu) LIBRARY "user32.dll"
FUNCTION Long GetMenu ( Long hwnd) LIBRARY "user32.dll"
FUNCTION Long GetSubMenu ( Long hMenu, Long nPos) LIBRARY "user32.dll"
FUNCTION Long DrawMenuBar ( Long hwnd) LIBRARY "user32.dll"
FUNCTION Long SetMenuInfo (Long hmenu, REF MENUINFO mi) LIBRARY "user32.dll"

FUNCTION Long CreatePatternBrush(Long hBitmap) LIBRARY "gdi32.dll" 

FUNCTION Long LoadImage(Long hInst, string lpsz, Long uType, Long cxDesired, Long cyDesired, Long fuLoad) LIBRARY "user32.dll" ALIAS FOR "LoadImageA;Ansi"

FUNCTION Long DeleteObject(Long hObject) LIBRARY "gdi32.dll"


end prototypes

type variables
//LoadImage
CONSTANT Long LR_LOADFROMFILE = 16
CONSTANT Long IMAGE_BITMAP = 0
CONSTANT Long IMAGE_ICON = 1
CONSTANT Long IMAGE_CURSOR = 2

//MENUINFO
CONSTANT Long MIM_BACKGROUND = 2
CONSTANT Long MIM_APPLYTOSUBMENUS = 2147483648
end variables

on w_main.create
if this.MenuName = "m_main" then this.MenuID = create m_main
end on

on w_main.destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;n_menubackground ln_menubackground
ln_menubackground.of_setbackground( This, MenuID, "bgmenu.bmp")

end event

