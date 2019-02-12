########################################################
##################Task 1.1##############################
########################################################
#1.1.	Сохранить в текстовый файл на диске список запущенных(!) служб. 
#Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.


[CmdletBinding()]
Param
(

     [parameter(Mandatory = $true, HelpMessage = "Disk:")]
    [string]$disk_name,
    
    [string]$root = "C:\",
    
    [parameter(Mandatory = $true, HelpMessage = "Directory:")]
    [string]$directory_name,

    [string]$file = "Services.txt"

)

New-PSDrive -Name $disk_name -Root $root -PSProvider FileSystem #создаем диск
Set-Location $disk_name #переходим на диск
New-Item -Path $disk_name -Name $directory_name -ItemType "Directory" #создаем директорию
Get-Service | where {$_. Status -eq 'running'} >$disk_name":\"$directory_name":\"$file # данные в файл
Get-ChildItem -Path $disk_name
Get-Content $disk_name":\"$directory_name":\"$file #вывод в консоль

########################################################
##################Task 1.2##############################
########################################################
#1.2.	Просуммировать все числовые значения переменных среды Windows. 
#(Параметры не нужны)

[CmdletBinding()]
Param
(
    [int]$a = 1, 

    [int]$b = 2,

    [int]$c = 3,

    [string]$st = "a-z",

    [int]$Sum = 0
)

foreach ($x in (Get-Variable | Select-Object Value))

{

    if ($x.Value -is [int])

    {

        Write-Output("Intermediate value: " + $x.Value)

        $Summ += $x.Value

    }

}

Write-Output("Sum = $Sum.")

########################################################
##################Task 1.3##############################
########################################################
#1.3.	Вывести список из 10 процессов занимающих дольше всего процессор. 
#Результат записывать в файл.
[CmdletBinding()]
Param
(
    
    [string]$path = "C:\M2T2\",

    [string]$file = "Processes",

    [string]$expansion = ".txt"

)

Get-Process | Select-Object Id, Name, UserProcessorTime -First 10 > $path$file$expansion
#1.3.1.	Организовать запуск скрипта каждые 10 минут
#$t= New-JobTrigger -RepetitionInterval 10 min
#$cred=Get-Credential contoso\administrator
#$o=New-ScheduledJobOption -RunElevated
#Register-ScheduledJob -Name Task_1_3 -FilePath C:\M2T2_Yezhgurava\1.3.ps1
# -Trigger $t -Credential $cred -ScheduledJobOption $o

########################################################
##################Task 1.4##############################
########################################################

#1.4. Подсчитать размер занимаемый файлами в папке (например C:\windows) 
#     за исключением файлов с заданным расширением(напрмер .tmp)
[CmdletBinding()]
param
    (
        $directory='c:\windows'
    )
Get-ChildItem $directory -Recurse -Exclude "*.tmp" -File -ErrorAction SilentlyContinue`| Measure-Object -Property Length -Sum

########################################################
##################Task 1.5##############################
########################################################

#1.5.1.	Сохранить в CSV-файле информацию обо всех обновлениях безопасности ОС.
#1.5.2.	Сохранить в XML-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
#1.5.3.	Загрузить данные из полученного в п.1.5.1 или п.1.5.2 файла и вывести в виде списка  разным разными цветами

[CmdletBinding()]
param

(
        $PathForCSV='C:\M2T2\1_5.csv',
        $PathForXML='C:\M2T2\1_5.xml'   
)
Get-HotFix -Description 'security*'|Export-Csv -Path $PathForCSV
Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft|Export-Clixml $PathForXML
Import-Csv $PathForCSV|Format-List 
Import-Clixml $PathForXML|Format-List -Property Name, psprovider
Write-Host $PathForCSV -ForegroundColor Blue
Write-Host $PathForXML -BackgroundColor Cyan


########################################################
##################Task 2################################
########################################################

#2.1.	Создать профиль
New-Item -ItemType File -Path $profile -Force

#2.2.	В профиле изненить цвета в консоли PowerShell
(Get-Host).UI.RawUI.ForegroundColor = "Yellow"
(Get-Host).UI.RawUI.BackgroundColor = "Red"

#2.3.	Создать несколько собственный алиасов

Set-Alias Help Get-Help
Set-Alias New New-Item

#2.4.	Создать несколько констант

Set-Variable N -option Constant -Value 10.0 
Set-Variable P -Option Constant -Value 3.14

#2.5.	Изменить текущую папку

Set-Location C:\M2T2\

#2.6.	Вывести приветсвие

Write-Host("HI, WORLD!")

#2.7.	Проверить применение профиля




########################################################
##################Task 3################################
########################################################

Get-Module -ListAvailable -All