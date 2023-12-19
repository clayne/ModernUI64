;==============================================================================
;
; ModernUI Library x64
;
; Copyright (c) 2023 by fearless
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
includelib kernel32.lib

include ModernUI.inc


.CODE


MUI_ALIGN
;------------------------------------------------------------------------------
; Allocs memory for the properties of a control
;------------------------------------------------------------------------------
MUIAllocMemProperties PROC FRAME hWin:MUIWND, cbWndExtraOffset:MUIPROPERTIES, SizeToAllocate:MUIVALUE
    LOCAL pMem:QWORD
    Invoke GlobalAlloc, GMEM_FIXED or GMEM_ZEROINIT, SizeToAllocate
    .IF rax == NULL
        mov rax, FALSE
        ret
    .ENDIF
    mov pMem, rax
    
    Invoke SetWindowLongPtr, hWin, cbWndExtraOffset, pMem
    
    mov rax, TRUE
    ret
MUIAllocMemProperties ENDP


MUI_ALIGN
;------------------------------------------------------------------------------
; Frees memory for the properties of a control
;------------------------------------------------------------------------------
MUIFreeMemProperties PROC FRAME hWin:MUIWND, cbWndExtraOffset:MUIPROPERTIES
    Invoke GetWindowLongPtr, hWin, cbWndExtraOffset
    .IF rax != NULL
        invoke GlobalFree, rax
        Invoke SetWindowLongPtr, hWin, cbWndExtraOffset, 0
        mov rax, TRUE
    .ELSE
        mov rax, FALSE
    .ENDIF
    ret
MUIFreeMemProperties ENDP



MODERNUI_LIBEND



