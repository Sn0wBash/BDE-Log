#Run as admin - needed by Get-BitlockerVolume cmdlet

$name = hostname
$path = "c:\temp\" + $name + "-BDE.txt"
$start = date

Write-output "$name `n" | Out-File -FilePath $path -Append
Write-Output "started at $start `n" | Out-File -FilePath $path -Append
Get-BitLockerVolume | Format-List | Out-File -FilePath $path -Append

do {
    $stats = Get-BitLockerVolume
    $date = date
    $info = "`nDrive encryption at " + ($stats).encryptionpercentage + "% - " + $date | Out-File -FilePath $path -Append
    Start-Sleep -s 300
} While (($stats).encryptionpercentage -lt 100)

Get-BitLockerVolume | Format-List | Out-File -FilePath $path -Append
