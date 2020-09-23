Attribute VB_Name = "KhunGlobals"
Option Explicit

Public Declare Function GetPixel Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long) As Long

'=========================== The Engine ===========================
Public Engine As New DBTurbo2DEngine

'=========================== Const ================================
Public Const SCREENW = 1024, SCREENH = 768
Public Const lFPS = 60
Public Const SpeedScreen = 32
Public Const SpeedMouse = 1
Public Const WorldSize = 32678
Public Const bWindowsMode As Boolean = True
'=========================== ENUM =================================
Public Enum ENUM_STATELOOP
    CDT_GAME_PLAY
    CDT_GAME_EXIT
End Enum

'=========================== TYPE ================================
Public Type MouseMap
    xMap As Long
    yMap As Long
    data(63, 31) As Long
End Type
'========================= Variable ==============================
Public bRunning As Boolean
Public GAMELOOP As ENUM_STATELOOP
Public ShowFPS As Boolean
Public tMouseMap As MouseMap
Public ScreenMoveX As Long
Public ScreenMoveY As Long
Public ScreenX As Long
Public ScreenY As Long
Public BlockX As Long
Public BlockY As Long
Public ShowGrid As Boolean
