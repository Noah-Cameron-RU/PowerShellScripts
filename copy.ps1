# First, let's define our source:
$sourceFile = "sample.txt"
$destFolder = "destFold"

Copy-Item -Path $sourceFile -Destination $destFolder

Write-Output "Done successfully"
# this worked so that's cool