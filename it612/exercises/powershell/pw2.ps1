Get-Process
Get-Process | Select-Object Name, Id, CPU, WorkingSet
Get-Process | Select-Object Name, Id, CPU, WorkingSet | Format-Table -AutoSize
Get-Process | Select-Object Name, Id, CPU, WorkingSet | Format-List 

Get-Process | SOrt-Object WorkingSet -Descending | Select-Object -First 10 Name, Id, @{Name='MemMB';Expression={[math]::Round($_.WorkingSet/1MB,1)}}

Get-Process | Where-Object { $_.WorkingSet -gt 50MB }
Get-Process | Where-Object { $_.WorkingSet -gt 50MB } | Sort-Object WorkingSet -Descending | Select-Object Name, Id, @{Name='MemMB';Expression={[math]::Round($_.WorkingSet/1MB,1)}}

Get-Process | Measure-Object
Get-Process | Measure-Object WorkingSet -Sum -Average -Maximum
$stats = Get-Process | Measure-Object WorkingSet -Sum -Average -Maximum
Write-Host "Total process: $($stats.count)"
Write-Host "Total memory: $([math]::Round($stats.Sum/1GB,2)) GB"

Get-ChildItem -Path /workspaces -Recurse -File | Measure-Object
Get-ChildItem -Path /workspaces -Recurse -File | Where-Object { $_.length -gt 1MB } | Select-Object Fullname, @{Name='SizeMB';Expression={[math]::Round($_.Length/1MB,1)}} | Sort-Object SizeMB -Descending

Get-Process | Select-Object Name, Id, CPU, @{Name='MemMB';Expression={[math]::Round($_.WorkingSet/1MB,1)}} | Export-Csv -Path ./process-report.csv -NoTypeInformation

Write-Host "=== System Recon Report ===" -ForegroundColor Cyan
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 10 Name, Id, @{Name='MemMB';Expression={[math]::Round($_.WorkingSet/1MB,1)}} | Format-Table -AutoSize