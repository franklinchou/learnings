Sub KillHighlightInSelection()
'
' KillHighlightInSelection Macro
' Remove all highlighting in selection
' As of 3/20/2021 - assigned to Ctrl + Alt + Shift + H

If Not Selection.Active Then
    Exit Sub
End If

Set objDoc = ActiveDocument
Set rngR = Selection.Range

rngR.HighlightColorIndex = wdNoHighlight

Set objDoc = Nothing

End Sub
