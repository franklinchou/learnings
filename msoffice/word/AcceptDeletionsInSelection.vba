Sub AcceptDeletionsInSelection()
'
' AcceptDeletionsInSelection Macro
' Accept all track changes DELETIONS in a selection
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

Set objDoc = ActiveDocument
Set rngR = Selection.Range
  
For Each objRevision In rngR.Revisions
    With objRevision
        If .Type = wdRevisionDelete Then
            .Accept
        End If
    End With
Next objRevision
 
Application.ScreenUpdating = True
Set objDoc = Nothing

End Sub
