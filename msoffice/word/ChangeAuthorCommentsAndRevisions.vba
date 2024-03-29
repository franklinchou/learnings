Sub ChangeAuthorCommentsAndRevisions()
'
' Change all  tracked changes and comments in a document
' labeled with a given author to the current author
' Accept all formatting changes

Application.ScreenUpdating = False

Dim sCurrentAuthor As String
Dim sOldAuthor As String
Dim sRevision As String

Dim TCStatus As Boolean
Dim BCStatus As Boolean

Dim myRange As Range
Dim revRange As Range

Dim myRev As Revision
Dim myComment As Comment

Dim cIns As New Collection
Dim cDel As New Collection
Dim cFormat As New Collection
Dim cComment As New Collection

If ActiveDocument.Revisions.Count = 0 And ActiveDocument.Comments.Count = 0 Then
    MsgBox "No track-changes or comments in this document!", _
      vbCritical + vbOKOnly, "Cannot perform action"
    Exit Sub
End If

Dim r As Variant
r = InputBox("Old author name? (Defaults to ""Author"")", "Old Author Name")
If r = 0 Then
    Exit Sub
ElseIf r = "" Then
    sOldAuthor = "Author"
Else
    sOldAuthor = r
End If

BCStatus = ActiveDocument.TrackRevisions

ActiveDocument.TrackRevisions = True

For Each myRev In ActiveDocument.Revisions
    If myRev.Author = sOldAuthor Then
        If myRev.Type = wdRevisionInsert Then
            cIns.Add myRev
        End If
        If myRev.Type = wdRevisionDelete Then
            cDel.Add myRev
        End If
        If myRev.Type <> wdNoRevision And myRev.FormatDescription <> "" Then
            cFormat.Add myRev
        End If
    End If
Next

For Each myComment In ActiveDocument.Comments
    If myComment.Author = sOldAuthor Then
        cComment.Add myComment
    End If
Next

' Accept all format changes
For Each myRev In cFormat
    myRev.Accept
Next
    

' Reassign author for insertions
Set revRange = Nothing
For Each myRev In cIns
    Set revRange = myRev.Range
    myText = revRange.Text
    myRev.Reject
    revRange.InsertAfter myText
Next

' Reassign author for deletions
Set revRange = Nothing
For Each myRev In cDel
    Set revRange = myRev.Range
    myRev.Reject
    revRange.Delete
Next

' Reassign author for comments
Set revRange = Nothing
For Each myComment In cComment
    
    Set revRange = myComment.Range
    cText = myComment.Range.Text
    Set cRange = myComment.Scope
    
    ' TODO Fix this to support reply migration
    If myComment.Replies.Count > 0 Then
        MsgBox "Warning! Comment contains replies!", vbCritical + vbOKOnly, "Warning!"
    End If
    
    myComment.DeleteRecursively
    
    If cRange.StoryType = wdMainTextStory Then
        ActiveDocument.StoryRanges(wdMainTextStory).Comments.Add _
            cRange, cText
    End If
Next

ActiveDocument.TrackRevisions = BCStatus

End Sub

