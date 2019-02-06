# 18.	Откройте любо документ в MS Word (не важно как) и закройте его с помощью PowerShell
$word = New-Object -ComObject word.application
$word.Visible = $true
$doc = $word.documents.add()
#создаем документ MS Word
$doc.Close()
$word.Quit()
#закрываем открытый документ MS Word
Get-Process -Name WINWORD|Stop-Process
