# This code is for getting some diagnostics about your vice
Write-Host "----Disk Data------"
Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name='Free(GB)';Expression={[math]::Round($_.Free/1GB,2)}}, @{Name='Used(GB)';Expression={[math]::Round(($_.Used)/1GB,2)}}, @{Name='Total(GB)';Expression={[math]::Round($_.Used/1GB + $_.Free/1GB, 2)}}

# This portion deals with memory usage
Write-Host "`n-----Mem Stats-------"
$os = Get-CimInstance Win32_OperatingSystem
$totalMem = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
$freeMem = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
$usedMem = [math]::Round($totalMem - $freeMem, 2)
Write-Host "Total Memory: $totalMem GB"
Write-Host "Used Memory : $usedMem GB"
Write-Host "Free Memory : $freeMem GB"

# Here, we switch uo to more volatile stats
Write-Host "`n---Top 5 CPU Usage------"
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 Name, Id, CPU

Write-Host "`n----Services-------"
Get-Service | Where-Object { $_.Status -eq 'Running' } | Select-Object DisplayName, Status

Write-Host "`n----Processes by Mem-------"
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5 Name, Id, @{Name="Memory(GB)";Expression={[math]::Round($_.WorkingSet/1GB,2)}}
