'
' A collection of programs for convenient table modification

Sub InsertRowsToTable()
'
' Insert the specified number of rows to the selected table

Dim intRowsToAdd As Integer
Dim intRowsAdded As Integer
Dim intCurrentRows As Integer
Dim strMessage As String

intCurrentRows = GetRowsInTable

If intCurrentRows < 1 Then
    MsgBox "No table selected!", vbCritical
    Exit Sub
End If

strMessage = "There are " & intCurrentRows & " rows in the selected table." & vbCrLf
strMessage = strMessage & "How many rows should be inserted?"

intRowsToAdd = InputBox(strMessage)

Do While intRowsAdded <> intRowsToAdd
    ActiveDocument.Tables(GetTableIndex).Rows.Add
    intRowsAdded = intRowsAdded + 1
Loop

End Sub

Sub CountRowsInTable()
'
' Display the number of rows in a table

Dim intRowsInTable As Integer

intRowsInTable = GetRowsInTable

If intRowsInTable < 1 Then
    MsgBox "No table selected!", vbCritical
    Exit Sub
Else
    MsgBox _
        "There are " & intRowsInTable - 1 & " rows in the selected table " & _
        "(" & intRowsInTable & " including header)."
End If
End Sub


Function GetRowsInTable() As Integer
'
' Get the number of rows in a table

Dim intTableIndex As Integer

intTableIndex = GetTableIndex

If intTableIndex > 1 Then
    GetRowsInTable = ActiveDocument.Tables(intTableIndex).Rows.Count
Else
    GetRowsInTable = -1
End If

End Function


Function GetTableIndex() As Integer
'
' Get the index of the selected table

If Selection.Information(wdWithInTable) Then
    GetTableIndex = ActiveDocument.Range(0, Selection.Tables(1).Range.End).Tables.Count
Else
    GetTableIndex = -1
End If

End Function


