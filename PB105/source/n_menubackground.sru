$PBExportHeader$n_menubackground.sru
forward
global type n_menubackground from nonvisualobject
end type
type menuinfo from structure within n_menubackground
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

global type n_menubackground from nonvisualobject autoinstantiate
end type

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

forward prototypes
public subroutine of_setbackground (window aw, menu am, string as_img)
end prototypes

public subroutine of_setbackground (window aw, menu am, string as_img);Long   ll_hwnd, ll_BitMapBrush
Long   ll_hMainMenu, ll_hSubMenu
Long   ll_hBitMap
String ls_BitMapFileName
MENUINFO lstr_MenuInfo

Integer i

//handle window
ll_hwnd = Handle(aw)

//LoadImage()
ls_BitMapFileName = as_img
ll_hBitMap = LoadImage(0, ls_BitMapFileName, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE)

ll_BitMapBrush = CreatePatternBrush(ll_hBitMap)

//MENUINFO
lstr_MenuInfo.cbSize = 28
lstr_MenuInfo.cyMax = 0
lstr_MenuInfo.fMask = MIM_BACKGROUND
lstr_MenuInfo.hbrBack = ll_BitMapBrush

//get menu from window
ll_hMainMenu = GetMenu(ll_hwnd)

For i = 0 To UpperBound(am.Item[]) -1
	
	If UpperBound(am.Item[i + 1].Item) = 0 Then Continue
	
	ll_hSubMenu = GetSubMenu(ll_hMainMenu, i)
	
	SetMenuInfo(ll_hSubMenu, lstr_MenuInfo)
	
	DrawMenuBar(ll_hwnd)
Next


DeleteObject(ll_hBitMap)


end subroutine

on n_menubackground.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_menubackground.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

