# File path to the users onedrive (make sure to have the .html file as the last item in the path.)
$bookmarkFilePath = "$env:USERPROFILE\OneDrive\Documents\Browser Favorites Backups\ChromeBookmarks.html"

# Check if the file exists
if (-not (Test-Path -Path $bookmarkFilePath)) {
    Write-Host "File does not exist."
    exit 1
}

# Check the file's last write time
$lastWriteTime = (Get-Item -Path $bookmarkFilePath).LastWriteTime
$currentTime = Get-Date
$daysDifference = ($currentTime - $lastWriteTime).Days

# Check if the file is older than 7 days
if ($daysDifference -gt 7) {
    Write-Host "File is older than 7 days."
    exit 1
} else {
    exit 0
}
