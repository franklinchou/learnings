Sub HighlightSpecial1()
'
' HighlightSpecial1 Macro
' Return default highlight to yellow; highlight in bright blue
'
' As of March 13, 2022 - assigned to Ctrl + Shift + H, 1

If Not Selection.Active Then
    Options.DefaultHighlightColorIndex = wdYellow
    Exit Sub
End If

Set objDoc = ActiveDocument
Set rngR = Selection.Range

rngR.HighlightColorIndex = wdTurquoise

Set objDoc = Nothing

End Sub
