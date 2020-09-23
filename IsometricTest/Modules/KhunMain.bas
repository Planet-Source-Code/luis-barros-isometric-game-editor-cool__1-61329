Attribute VB_Name = "KhunMain"
Option Explicit

Public Sub MainEditor()
    
    InitGame
    InitTexture
    InitKeyboard
    InitMouse
    InitText
    '------------------- Flow Game --------------------
    bRunning = True
    GAMELOOP = CDT_GAME_PLAY
    While bRunning = True
        Select Case GAMELOOP
            Case CDT_GAME_PLAY: GamePlay
            Case CDT_GAME_EXIT: GameExit
        End Select
    DoEvents
    Wend
    '---------------------------------------------------
    
End Sub

Public Sub GamePlay()
    Dim i As Integer
    Dim j As Integer
    While GAMELOOP = CDT_GAME_PLAY
        If Engine.DBKeyInput.ReturnKeyDown(2) = True Then
            If ScreenX > SpeedScreen Then
                'Engine.DBMap.SetXPosition 1, Engine.DBMap.GetXPosition(1) + SpeedScreen
                Engine.DBMath.MoveMapRight 1
                Engine.DBMath.MoveMapRight 2
                If Engine.DBSprite.GetSpriteCount >= 3 Then
                    With Engine.DBSprite
                        For j = 3 To .GetSpriteCount
                            .SetXPosition j, .GetXPosition(j) + SpeedScreen
                        Next
                    End With
                End If
                ScreenX = ScreenX - SpeedScreen
            End If
        End If
        If Engine.DBKeyInput.ReturnKeyDown(3) = True Then
            If ScreenX < WorldSize - SpeedScreen Then
                'Engine.DBMap.SetXPosition 1, Engine.DBMap.GetXPosition(1) - SpeedScreen
                Engine.DBMath.MoveMapLeft 1
                Engine.DBMath.MoveMapLeft 2
                If Engine.DBSprite.GetSpriteCount >= 3 Then
                    With Engine.DBSprite
                        For j = 3 To .GetSpriteCount
                            .SetXPosition j, .GetXPosition(j) - SpeedScreen
                        Next
                    End With
                End If
                ScreenX = ScreenX + SpeedScreen
            End If
        End If
        If Engine.DBKeyInput.ReturnKeyDown(4) = True Then
            If ScreenY > SpeedScreen Then
                'Engine.DBMap.SetYPosition 1, Engine.DBMap.GetYPosition(1) + SpeedScreen
                Engine.DBMath.MoveMapDown 1
                Engine.DBMath.MoveMapDown 2
                If Engine.DBSprite.GetSpriteCount >= 3 Then
                    With Engine.DBSprite
                        For j = 3 To .GetSpriteCount
                            .SetYPosition j, .GetYPosition(j) + SpeedScreen
                        Next
                    End With
                End If
                ScreenY = ScreenY - SpeedScreen
            End If
        End If
        If Engine.DBKeyInput.ReturnKeyDown(5) = True Then
            If ScreenY < WorldSize - SpeedScreen Then
                'Engine.DBMap.SetYPosition 1, Engine.DBMap.GetYPosition(1) - SpeedScreen
                Engine.DBMath.MoveMapUp 1
                Engine.DBMath.MoveMapUp 2
                If Engine.DBSprite.GetSpriteCount >= 3 Then
                    With Engine.DBSprite
                        For j = 3 To .GetSpriteCount
                            .SetYPosition j, .GetYPosition(j) - SpeedScreen
                        Next
                    End With
                End If
                ScreenY = ScreenY + SpeedScreen
            End If
        End If
        
        ScreenMoveX = Engine.DBMouse.GetX + ScreenX
        ScreenMoveY = Engine.DBMouse.GetY + ScreenY
        tMouseMap.xMap = ScreenMoveX Mod 64
        tMouseMap.yMap = ScreenMoveY Mod 32
        
        Select Case tMouseMap.data(tMouseMap.xMap, tMouseMap.yMap)
        Case vbBlue:
            Engine.DBSprite.SetXPosition 2, (ScreenMoveX \ 64) * 64 - 32 - ScreenX
            Engine.DBSprite.SetYPosition 2, (ScreenMoveY \ 32) * 32 - 16 - ScreenY
            BlockX = ((ScreenMoveX \ 64) * 64 - 32) \ 32
            BlockY = ((ScreenMoveY \ 32) * 32 - 16) \ 16
        Case vbRed:
            Engine.DBSprite.SetXPosition 2, (ScreenMoveX \ 64) * 64 + 32 - ScreenX
            Engine.DBSprite.SetYPosition 2, (ScreenMoveY \ 32) * 32 - 16 - ScreenY
            BlockX = ((ScreenMoveX \ 64) * 64 + 32) \ 32
            BlockY = ((ScreenMoveY \ 32) * 32 - 16) \ 16
        Case vbMagenta:
            Engine.DBSprite.SetXPosition 2, (ScreenMoveX \ 64) * 64 - 32 - ScreenX
            Engine.DBSprite.SetYPosition 2, (ScreenMoveY \ 32) * 32 + 16 - ScreenY
            BlockX = ((ScreenMoveX \ 64) * 64 - 32) \ 32
            BlockY = ((ScreenMoveY \ 32) * 32 + 16) \ 16
        Case vbGreen:
            Engine.DBSprite.SetXPosition 2, (ScreenMoveX \ 64) * 64 + 32 - ScreenX
            Engine.DBSprite.SetYPosition 2, (ScreenMoveY \ 32) * 32 + 16 - ScreenY
            BlockX = ((ScreenMoveX \ 64) * 64 + 32) \ 32
            BlockY = ((ScreenMoveY \ 32) * 32 + 16) \ 16
        Case vbWhite:
            Engine.DBSprite.SetXPosition 2, (ScreenMoveX \ 64) * 64 - ScreenX
            Engine.DBSprite.SetYPosition 2, (ScreenMoveY \ 32) * 32 - ScreenY
            BlockX = ((ScreenMoveX \ 64) * 64) \ 32
            BlockY = ((ScreenMoveY \ 32) * 32) \ 16
        End Select
        
        If Engine.DBKeyInput.ReturnKeyDown(1) = True Then GAMELOOP = CDT_GAME_EXIT
        
        If Engine.DBKeyInput.ReturnKeyDown(6) = True Then
            ShowGrid = Not ShowGrid
            If ShowGrid = True Then
                Engine.DBMap.SetVisible 2, True
            Else
                Engine.DBMap.SetVisible 2, False
            End If
        End If
        
        If Engine.DBMouse.GetLeftButton = True Then
            With Engine.DBSprite
                .Add
                .SetTextureReference .GetSpriteCount, 7
                .QMSetGetRectangle .GetSpriteCount, 0, 0, 256, 256
                .QMSetPutRectangle .GetSpriteCount, -128, -256, 256, 256
                .RenderNewStyle .GetSpriteCount
                .SetXPosition .GetSpriteCount, BlockX * 32 + 32 - ScreenX
                .SetYPosition .GetSpriteCount, BlockY * 16 + 16 - ScreenY
                .SetZOrder .GetSpriteCount, 1
            End With
        End If
        
        
        Engine.Render
        Engine.DBText.SetText 1, "FPS : " & Engine.DBFPS.GetFPS
        Engine.DBText.SetText 2, "MouseMapX : " & tMouseMap.xMap & "MouseMapY : " & tMouseMap.yMap
        Engine.DBText.SetText 3, "BlockMapX : " & BlockX & "BlockMapY : " & BlockY
        Engine.DBText.SetText 4, "Clic Left Add Tree (Count : " & Engine.DBSprite.GetSpriteCount - 2 & ")"
        Engine.DBText.SetText 5, "Toggle Grid F3"
        Engine.DBText.SetText 6, "Exit Esc"
    DoEvents
    Wend
End Sub
Public Sub GameExit()
    bRunning = False
    Set Engine = Nothing
    Unload Main
End Sub


