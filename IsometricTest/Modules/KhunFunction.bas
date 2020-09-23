Attribute VB_Name = "KhunFunction"
Option Explicit

Public Function InitGame() As Boolean
    InitGame = False
    
    Main.Width = SCREENW * Screen.TwipsPerPixelX
    Main.Height = SCREENH * Screen.TwipsPerPixelY
    DoEvents
    Main.Show
    Set Engine = New DBTurbo2DEngine
    
    Engine.InitializeDisplay Main.hWnd, bWindowsMode, SCREENW, SCREENH
    Engine.DBFPS.SetFrameRate lFPS
    Engine.SetUpMapView 0, 0, SCREENW, SCREENH, 1024
    Engine.ClearScreen
    Engine.SetUpViewPort 0, 0, SCREENW, SCREENH
    Engine.SetMaxLevel 3
    InitGame = True
End Function

Public Function InitTexture() As Boolean
    With Engine.DBTexture
        .SetFolder App.Path + "\Media\Textures\Sprites\Cursor\"
        .Add 64, "Cursor.png", , 4
        
        .SetFolder App.Path + "\Media\Textures\Sprites\Terrain\"
        .Add 256, "BG01", , 2
        .Add 1024
        .Add 1024
        .SetFolder App.Path + "\Media\Textures\Sprites\MouseMap\"
        .Add_Odd 64, 32, "Block", , 2
        .Add_Odd 64, 32, "Grid", , 2
        .SetFolder App.Path + "\Media\Textures\Sprites\Tree\"
        .Add 256, "Tree.png", , 4
    End With
    
    Dim x As Single, y As Single
    For x = 0 To 1024 - 256 Step 256
        For y = 0 To 1024 - 256 Step 256
            With Engine.DBTexture
                .CopyRegion 2, 3, 0, 0, x, y, 256, 256
            End With
        Next y
    Next x
    
    For x = 0 To 1024 - 64 Step 64
        For y = 0 To 1024 - 32 Step 32
            With Engine.DBTexture
                .CopyRegion 6, 4, 0, 0, x, y, 64, 32
            End With
        Next y
    Next x
    
    With Engine.DBMap
        
        .SetXCount 1, 1
        .SetYCount 1, 1
        .SetLooping 1, True
        .SetSubMapHeight 1, 1024
        .SetSubMapWidth 1, 1024
        .SetVisible 1, True
        .SetXIncrement 1, SpeedScreen
        .SetYIncrement 1, SpeedScreen
        .SetZOrder 1, 0
        
        .SetXCount 2, 1
        .SetYCount 2, 1
        .SetLooping 2, True
        .SetSubMapHeight 2, 1024
        .SetSubMapWidth 2, 1024
        .SetVisible 2, False
        .SetXIncrement 2, SpeedScreen
        .SetYIncrement 2, SpeedScreen
        .SetZOrder 2, 0
    End With
'set up submaps
    With Engine.DBSubMap
        .SetTextureReference 1, 1, 1, 3
        .SetTextureReference 2, 1, 1, 4
        
    End With
    

    Dim n As Integer
    Dim i As Long
    Dim j As Long
    
    With Engine.DBSprite
        .Add
        .SetTextureReference 1, 1
        .QMSetGetRectangle 1, 0, 0, 64, 64
        .QMSetPutRectangle 1, 0, 0, 32, 32
        .RenderNewStyle 1
        .SetZOrder 1, 1
        
        .Add
        .SetTextureReference 2, 5
        .QMSetGetRectangle 2, 0, 0, 64, 32
        .QMSetPutRectangle 2, 0, 0, 64, 32
        .SetZOrder 2, 0
    End With
    
End Function

Public Function InitMouse() As Boolean
    InitMouse = False
    With Engine.DBMouse
        .InitializeMouse Main.hWnd
        .AttachSpriteToCursor 1
        .SetUpMouseViewRect 0, 0, SCREENW, SCREENH
        .SetMouseSpeed SpeedMouse
        .SetLeftAutoFire False
    End With
        
    Dim x As Integer
    Dim y As Integer
    Dim m As Long
    m = vbWhite
    For y = 0 To 31
        For x = 0 To 63
            tMouseMap.data(x, y) = GetPixel(Main.PicMouseMap.hdc, x, y)
        Next
    Next
    
    InitMouse = True
End Function

Public Function InitKeyboard() As Boolean
    InitKeyboard = False
    With Engine.DBKeyInput
        .Initialize Main.hWnd
        .Add DIK_ESCAPE
        .Add DIK_LEFT
        .Add DIK_RIGHT
        .Add DIK_UP
        .Add DIK_DOWN
        .SetAutoFire 2, True
        .SetAutoFire 3, True
        .SetAutoFire 4, True
        .SetAutoFire 5, True
        .Add DIK_F3
    End With
    InitKeyboard = True
End Function

Public Function InitText() As Boolean
    InitText = False
    Dim i As Integer
        With Engine.DBText
            .CreateFont "AngsanaUPC", 18, True
            For i = 0 To 5
                .Add
                .QMSetPutRectangle i + 1, 0, 0, 800, 600
                .SetXPosition i + 1, 0
                .SetYPosition i + 1, 30 * i
                .SetZOrder i + 1, 2
            Next
        End With
    InitText = True
End Function
