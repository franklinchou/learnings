Sub ChangeAuthorCommentsAndRevisions()
'
' Change all the tracked changes and comments in a document
' labeled with a given author to a new author
'

Dim sCurrentAuthor As String
Dim sOldAuthor As String
Dim sNewAuthor As String
Dim sRevision As String

Dim TCStatus As Boolean

Dim myRange As Range
Dim revRange As Range

Dim myRev As Revision
Dim myComment As Comment

Dim cIns As New Collection
Dim cDel As New Collection
Dim cComment As New Collection

If ActiveDocument.Revisions.Count = 0 And ActiveDocument.Comments.Count = 0 Then
    MsgBox "No track-changes or comments in this document!", _
      vbCritical + vbOKOnly, "Cannot perform action"
    Exit Sub
End If


Dim r As Variant
r = InputBox("Old author name? (Defaults to Author)", "Old Author Name")
If r = 0 Then
    Exit Sub
ElseIf r = "" Then
    sOldAuthor = "Author"
Else
    sOldAuthor = r
End If

r = InputBox("New author name?", "New Author Name")
If r = 0 Or r = "" Then
    MsgBox "Input new author name!", vbokayonly, "Cannot perform action"
    Exit Sub
Else
    sNewAuthor = r
End If

BCStatus = ActiveDocument.TrackRevisions
sCurrentAuthor = Application.UserName

ActiveDocument.TrackRevisions = True

For Each myRev In ActiveDocument.Revisions
    If myRev.Author = sOldAuthor Then
        If myRev.Type = wdRevisionInsert Then
            cIns.Add myRev
        End If
        If myRev.Type = wdRevisionDelete Then
            cDel.Add myRev
        End If
    End If
Next

For Each myComment In ActiveDocument.Comments
    If myComment.Author = sOldAuthor Then
        cComment.Add myComment
    End If
Next

Application.UserName = sNewAuthor

For Each myRev In cIns
    Set revRange = myRev.Range
    myText = revRange.Text
    myRev.Reject
    revRange.InsertAfter myText
Next

For Each myRev In cDel
    Set revRange = myRev.Range
    myRev.Reject
    revRange.Delete
Next


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
        'revRange.Select
        ActiveDocument.StoryRanges(wdMainTextStory).Comments.Add _
            cRange, cText
    End If
Next

Application.UserName = sCurrentAuthor
ActiveDocument.TrackRevisions = BCStatus


End Sub
