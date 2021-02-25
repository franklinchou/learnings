Sub AcceptFormatChangesExHighlightsInSelection()
'
' AcceptFormatChangesExHighlightsInSelection Macro
' Accept formatting changes in selection but exclude highlights
'


If Not Selection.Active Then
    MsgBox "No selected text!", _
        vbCritical + vbOKOnly, "Cannot perform action"
    Exit Sub
End If
    
Application.ScreenUpdating = False

Dim objRevision As Revision
Dim objDoc As Document
Dim rngR As Range
Dim intHighlights As Integer

Set objDoc = ActiveDocument
Set rngR = Selection.Range
  
intHighlights = 0
For Each objRevision In rngR.Revisions
    With objRevision
        If objRevision.Type = wdRevisionProperty And _
            objRevision.FormatDescription = "Formatted: Highlight" Then
                intHighlights = intHighlights + 1
        ElseIf objRevision.Type = wdRevisionParagraphProperty Then
            objRevision.Accept
        End If
    End With
Next objRevision
 
Application.ScreenUpdating = True
Set objDoc = Nothing

MsgBox "Skipped: " & intHighlights & " highlight(s)", _
   vbOKOnly, "End subroutine"

End Sub
