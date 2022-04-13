Sub HighlightSpecial2()
'
' HighlightSpecial2 Macro
' Return default highlight to yellow; highlight in bright green
'
' As of March 13, 2022 - assigned to Ctrl + Shift + H, 2

If Not Selection.Active Then
    Options.DefaultHighlightColorIndex = wdYellow
    Exit Sub
End If

Set objDoc = ActiveDocument
Set rngR = Selection.Range

rngR.HighlightColorIndex = wdBrightGreen
Options.DefaultHighlightColorIndex = wdYellow

Set objDoc = Nothing

End Sub
