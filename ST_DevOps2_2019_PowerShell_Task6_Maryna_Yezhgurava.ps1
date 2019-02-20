#Задание 6
#1.	Для каждого пункта написать и выполнить соответсвующий скрипт автоматизации администрирования:
#1.1.	Вывести все IP адреса вашего компьютера (всех сетевых интерфейсов)
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName . | Select-Object -Property IPAddress

#1.2.	Получить mac-адреса всех сетевых устройств вашего компьютера и удалённо.
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName . | Select-Object -Property MACAddress
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName VM2 -Credential administrator |`
Select-Object -Property MACAddress 

#1.3.	На всех виртуальных компьютерах настроить (удалённо) получение адресов с DHСP.
$cred = Get-Credential administrator
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=true -ComputerName VM2 -Credential $cred |`
ForEach-Object -Process {$_.InvokeMethod("EnableDHCP", $null)}

#1.4.	Расшарить папку на компьютере
net share tempshare=c:\EPAM\Test /users:25 /remark:"test share of the temp folder"

#1.5.	Удалить шару из п.1.4
net share tempshare /delete

#1.6.	Скрипт входными параметрами которого являются Маска подсети и два ip-адреса. Результат  – сообщение (ответ) в одной ли подсети эти адреса.

#2.	Работа с Hyper-V

#2.1.	Получить список коммандлетов работы с Hyper-V (Module Hyper-V)
Get-Command -Module hyper-v 

#2.2.	Получить список виртуальных машин 
Get-VM

#2.3.	Получить состояние имеющихся виртуальных машин
Get-vm | Select-Object Name, State

#2.4.	Выключить виртуальную машину
Stop-VM -Name VM3_Yezhgurava

#2.5.	Создать новую виртуальную машину
New-VM -Name "VM4_Yezhgurava" -MemoryStartupBytes 1GB

#2.6.	Создать динамический жесткий диск
Get-Command -Noun VHD* -Module Hyper-V
New-VHD -Path C:\EPAM\Test\Y.vhds -SizeBytes 10Gb

#2.7.	Удалить созданную виртуальную машину
Remove-VM -Name "VM4_Yezhgurava" -Force

