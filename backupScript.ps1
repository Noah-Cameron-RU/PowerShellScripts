# Define source folder and backup destination
$sourceFolder = "C:\Users\YourUsername\Documents\ImportantFiles"
$backupRoot = "C:\Users\YourUsername\Documents\Backups"

# Generate backup folder name with current date (MM-DD-YYYY)
$date = Get-Date -Format "MM-dd-yyyy"
$backupFolder = "$backupRoot\backup_$date"

# Create backup folder if it doesn’t exist
if (!(Test-Path $backupFolder)) {
    New-Item -ItemType Directory -Path $backupFolder | Out-Null
}

# Copy files to the backup folder
Copy-Item -Path $sourceFolder\* -Destination $backupFolder -Recurse -Force

# Print confirmation
Write-Output "Backup completed: $backupFolder"
