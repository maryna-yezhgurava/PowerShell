#1.	Вывести список всех классов WMI на локальном компьютере.
Get-WmiObject -List
 
#2.	Получить список всех пространств имён классов WMI. 
Get-WmiObject -Namespace "root" -Class "__Namespace" | select Name

#3.	Получить список классов работы с принтером.
Get-WmiObject -List | where {$_.name -like "*print*"}

#4.	Вывести информацию об операционной системе, не менее 10 полей.
Get-WmiObject -Class "Win32_OperatingSystem" | Select-Object -Property Name, Caption, Locale, `
Manufacturer, LocalDateTime, OSType, Version, Status, SystemDrive, Primary | Write-Output

#5.	Получить информацию о BIOS.
Get-WmiObject -Class "Win32_OperatingSystem"

#6.	Вывести свободное место на локальных дисках. На каждом и сумму.
Get-WmiObject win32_LogicalDisk | Select-Object -Property FreeSpace | % {$_.freespace/1Gb}

#7.	Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.
[int]$t = 0
(Get-WmiObject -Class win32_pingstatus -Filter "128.100.1.2").ResponseTime | foreach {
    $t += $_
}

Write-Host "Ping time: $t ms"

#8.	Создать файл-сценарий вывода списка установленных программных продуктов в виде таблицы с полями Имя и Версия.
Get-WmiObject Win32_Product | Format-Table -Property Name, Version

#9.	Выводить сообщение при каждом запуске приложения MS Word.
register-wmiEvent -query "select * from __instancecreationevent within 5 where targetinstance isa 'Win32_Process' `
and targetinstance.name='winword.exe'" -sourceIdentifier "ProcessStarted" -Action { Write-Host "RUNNING" } 