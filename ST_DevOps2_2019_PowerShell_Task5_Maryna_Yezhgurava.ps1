#1.	При помощи WMI перезагрузить все виртуальные машины.
$cred = "VM1\Administrator"
Invoke-Command -ScriptBlock {Restart-Computer -Force} -ComputerName 192.168.10.1 -Credential $cred
Invoke-Command -ScriptBlock {Restart-Computer -Force} -ComputerName 192.168.10.2 -Credential $cred
Invoke-Command -ScriptBlock {Restart-Computer -Force} -ComputerName 192.168.10.3 -Credential $cred

#2.	При помощи WMI просмотреть список запущенных служб на удаленном компьютере.
$cred = "VM1\Administrator"
Invoke-Command -ScriptBlock { Get-Service | Where-Object {$_.Status -eq "Running" }} -ComputerName 192.168.10.1 -Credential $cred

#3.	Настроить PowerShell Remoting, для управления всеми виртуальными машинами с хостовой.
Set-Item WSMan:\Localhost\Client\Trustedhosts -Value *

#4.	Для одной из виртуальных машин установить для прослушивания порт 42658. Проверить работоспособность PS Remoting.
Invoke-Command -ScriptBlock {Set-Item WSMan:\localhost\listener\listener*\port} -ComputerName 192.168.10.1 -Port 42658 -Credential VM1\Administrator
#PS C:\Windows\system32> Enter-PSSession -ComputerName 192.168.10.1 -Credential VM1\Administrator -Port 42658

#[192.168.10.1]: PS C:\Users\Administrator\Documents>

#5.	Создать конфигурацию сессии с целью ограничения использования всех команд, кроме просмотра содержимого дисков.
New-PSSessionConfigurationFile -Path C:\config.pssc -VisibleCmdlets Get-ChildItem
Register-PSSessionConfiguration -Name config -Path "C:\config.pssc"