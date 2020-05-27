Private Sub CheckBox1_Click()

' Hide text with the "text_to_hide" bookmark prefix

Dim strTextToHidePrefix As String
Dim objRegex As regexp

' Make sure regexp is enabled!
Set objRegex = New regexp
 
strTextToHidePrefix = "text_to_hide"
objRegex.Pattern = strTextToHidePrefix

For Each objbmk In ActiveDocument.Bookmarks
    If objRegex.Test(objbmk.Name) Then
        objbmk.Range.Font.Hidden = CheckBox1.Value
    End If
Next objbmk

End Sub
