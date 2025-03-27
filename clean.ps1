# Here is where we ask the user what they want to clean out
$folderPath = Read-Host "Enter the full path of the folder you want to clear"

# Make sure the path is right and the folder actually exists
if (Test-Path -Path $folderPath -PathType Container) {
    # Delete all files and folders recursively inside the specified folder
    Get-ChildItem -Path $folderPath -Recurse -Force | Remove-Item -Force -Recurse
    Write-Host "All contents in '$folderPath' have been deleted."
} else {
    Write-Host "The specified folder does not exist."
}
