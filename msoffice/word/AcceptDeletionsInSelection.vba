Sub AcceptDeletionsInSelection()
'
' AcceptDeletionsInSelection Macro
' Accept all track changes DELETIONS in a selection
'

Dim objRevision As Revision
Dim objDoc As Document
 
Application.ScreenUpdating = False
 
Set objDoc = Selection
If Not Selection.Active Then
    MsgBox "No selected text!", _
        vbCritical + vbOKOnly, "Cannot perform action"
    Exit Sub
End If
    
  
For Each objRevision In objDoc.Revisions
    With objRevision
        If .Type = wdRevisionDelete Then
            .Accept
        End If
    End With
Next objRevision
 
Application.ScreenUpdating = True
Set objDoc = Nothing

End Sub
