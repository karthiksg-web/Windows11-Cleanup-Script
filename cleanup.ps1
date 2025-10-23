# Run this script as Administrator

Write-Host "Starting system cleanup..." -ForegroundColor Cyan

# 1. Run Disk Cleanup silently
Start-Process cleanmgr.exe -ArgumentList "/sagerun:1"

# 2. Delete temp files
Write-Host "Cleaning TEMP folders..." -ForegroundColor Yellow
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

# 3. Delete %temp% files
Write-Host "Cleaning %TEMP% folder..." -ForegroundColor Yellow
Remove-Item -Path "$env:USERPROFILE\AppData\Local\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

# 4. Delete Prefetch files
Write-Host "Cleaning Prefetch folder..." -ForegroundColor Yellow
Remove-Item -Path "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue

# 5. Empty Recycle Bin
Write-Host "Emptying Recycle Bin..." -ForegroundColor Yellow
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

# 6. Check Storage Sense status
$storageSense = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense" -ErrorAction SilentlyContinue
if ($storageSense) {
    Write-Host "Storage Sense is configured." -ForegroundColor Green
} else {
    Write-Host "Storage Sense is not enabled. You can turn it on via Settings > System > Storage." -ForegroundColor Red
}

Write-Host "Cleanup complete! Consider restarting your PC for best performance." -ForegroundColor Green