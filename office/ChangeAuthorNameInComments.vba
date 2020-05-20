Sub ChangeAllAuthorNamesInComments()
  Dim objComment As Comment

  ' Change all author names in comments
  For Each objComment In ActiveDocument.Comments
    objComment.Author = "Test Name"
    objComment.Initial = "TN"
  Next objComment
End Sub
