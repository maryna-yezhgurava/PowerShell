#1.	Просмотреть содержимое ветви реeстра HKCU
cd HKCU:
cd Software\Microsoft
dir
#2.	Создать, переименовать, удалить каталог на локальном диске
#создаем каталог
New-Item -Path 'C:\Temp' -ItemType 'directory'
#переименовывыем созданный каталог
Rename-Item -LiteralPath 'C:\Temp' -NewName 'C:\BU'
#удаляем созданный каталог
Remove-Item -LiteralPath 'C:\BU'
#3.	Создать папку C:\M2T2_ФАМИЛИЯ. Создать диск ассоциированный с папкой C:\M2T2_ФАМИЛИЯ.
#создаем папку
New-Item -Path 'C:\M2T2_Yezhgurava' -ItemType 'directory'
#создаем диск
New-PSDrive -Name M2T2_Yezhgurava -PSProvider FileSystem -Root 'C:\M2T2_Yezhgurava'
#4.	Сохранить в текстовый файл на созданном диске список запущенных(!) служб.
# Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
Get-Service | where {$_. Status -eq 'running'} | Out-File C:\M2T2_Yezhgurava\Services.txt
cd M2T2_Yezhgurava:
dir
Get-Content C:\M2T2_Yezhgurava\Services.txt
#5.	Просуммировать все числовые значения переменных текущего сеанса.
[int]$a = 1 

[int]$b = 2

[int]$c = 3

[string]$st = "a-z"

[int]$Sum = 0

foreach ($x in (Get-Variable | Select-Object Value))

{

    

    if ($x.Value -is [int])

    {

        Write-Host("Intermediate value: " + $x.Value)

        $Summ += $x.Value

    }

}

Write-Host("Sum = $Sum.")

#6.	Вывести список из 6 процессов занимающих дольше всего процессор.
Get-Process | Sort-Object -Descending -ErrorAction SilentlyContinue | Select-Object Id, Name, UserProcessorTime -First 6
#7.	Вывести список названий и занятую виртуальную память (в Mb)`
#каждого процесса, разделённые знаком тире, при этом если процесс 
#занимает более 100Mb – выводить информацию красным цветом, иначе зелёным.
$array = @(Get-Process | Select-Object VirtualMemorySize, Name)
foreach($x in $array)
{
    if(($x.VirtualMemorySize / 1000000) -gt 100.0)
    {
    Write-Host ('process: ' + $x.Name + " - " + ( $x.VirtualMemorySize / 1000000 ) + 'MB') -ForegroundColor red
    }
    else
    {
    Write-Host ('process: ' + $x.Name + " - " + ( $x.VirtualMemorySize / 1000000 ) + 'MB') -ForegroundColor Green
    }
    
}

#8.	Подсчитать размер занимаемый файлами в папке C:\windows (и во всех подпапках) за исключением файлов *.tmp
Get-ChildItem C:\Windows -Recurse -Exclude "*.tmp" -File -ErrorAction`
 SilentlyContinue | Measure-Object -Property Length -Sum
 #9.	Сохранить в CSV-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
 Set-Location HKLM:\SOFTWARE\Microsoft
 Get-ChildItem > C:\M2T2_Yezhgurava\Info.csv -ErrorAction SilentlyContinue
 #10.	Сохранить в XML -файле историческую информацию о командах выполнявшихся в текущем сеансе работы PS.
 Get-History > C:\M2T2_Yezhgurava\history.html
 #11. Загрузить данные из полученного в п.10 xml-файла и вывести в виде списка информацию о каждой записи,
 #в виде 5 любых (выбранных Вами) свойств.
 Get-Content -Path C:\M2T2_Yezhgurava\history.html | Select-Object PsChaildName, PsProvider, PsPath, Lenght, ReadCount
 #12. Удалить созданный диск и папку С:\M2T2_ФАМИЛИЯ
 Remove-Item -Path C:\M2T2_Yezhgurava -Recurse
 Remove-PSDrive -Name M2T2_Yezhgurava