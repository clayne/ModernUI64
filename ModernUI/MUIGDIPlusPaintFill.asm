;==============================================================================
;
; ModernUI Library x64
;
; Copyright (c) 2019 by fearless
;
; All Rights Reserved
;
; http://github.com/mrfearless/ModernUI64
;
;==============================================================================
.686
.MMX
.XMM
.x64

option casemap : none
option win64 : 11
option frame : auto
option stackbase : rsp

_WIN64 EQU 1
WINVER equ 0501h

include windows.inc
includelib user32.lib
includelib gdi32.lib

include ModernUI.inc


IFDEF MUI_USEGDIPLUS
include gdiplus.inc
includelib gdiplus.lib


IFNDEF GDIPRECT
GDIPRECT     STRUCT
    left     REAL4 ?
    top	     REAL4 ?
    right	 REAL4 ?
    bottom	 REAL4 ?
GDIPRECT     ENDS
ENDIF


.CODE


MUI_ALIGN
;------------------------------------------------------------------------------
; MUIGDIPlusPaintFill - Fills a rectangle with a specific color
;
; lpFillRect is a pointer to a GDIPRECT containing the bounding box to fill
; dwFillColor is an ARGBCOLOR to paint fill the rectangle with
;------------------------------------------------------------------------------
MUIGDIPlusPaintFill PROC FRAME pGraphics:QWORD, lpFillGdipRect:QWORD, qwFillColor:QWORD
    LOCAL pBrush:QWORD
    Invoke GdipCreateSolidFill, dword ptr qwFillColor, Addr pBrush
    Invoke GdipFillRectangle, pGraphics, pBrush, [lpFillGdipRect].GDIPRECT.left, [lpFillGdipRect].GDIPRECT.top, [lpFillGdipRect].GDIPRECT.right, [lpFillGdipRect].GDIPRECT.bottom
    Invoke GdipDeleteBrush, pBrush
    ret
MUIGDIPlusPaintFill ENDP

MUI_ALIGN
;------------------------------------------------------------------------------
; MUIGDIPlusPaintFillI - Fills a rectangle with a specific color
;
; lpFillRectI is a pointer to a RECT containing the bounding box to fill
; dwFillColor is an ARGBCOLOR to paint fill the rectangle with
;------------------------------------------------------------------------------
MUIGDIPlusPaintFillI PROC FRAME pGraphics:QWORD, lpFillRectI:QWORD, qwFillColor:QWORD
    LOCAL pBrush:QWORD
    Invoke GdipCreateSolidFill, dword ptr qwFillColor, Addr pBrush
    Invoke GdipFillRectangleI, pGraphics, pBrush, [lpFillRectI].RECT.left, [lpFillRectI].RECT.top, [lpFillRectI].RECT.right, [lpFillRectI].RECT.bottom
    Invoke GdipDeleteBrush, pBrush
    ret
MUIGDIPlusPaintFillI ENDP


ENDIF


MODERNUI_LIBEND

