#20. Напишите функцию для предыдущего задания. Запустите её на выполнение.
function sum
{
$n=Read-Host "n:"
$S=0
for ($i=1; $i -le $n; $i++)
{
$S=$S+$i*3
Write-Output "Step: $S"
}
Write-Output "Sum=$S"
}
sum
