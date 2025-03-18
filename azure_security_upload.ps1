# Define the event ID you want to store, I used 4624 for logon events
$eventID = 4624

# Query the Security Event Log for the latest logon event
$logonEvent = Get-WinEvent -LogName Security -FilterXPath "*[System[EventID=$eventID]]" -MaxEvents 1

# Extract whatever details you want from the event
# I used logon events, so I decided to use the 6 below
$eventData = @{
    TimeCreated = $logonEvent.TimeCreated
    EventID = $logonEvent.Id
    UserName = $logonEvent.Properties[5].Value
    ComputerName = $logonEvent.MachineName
    LogonType = $logonEvent.Properties[8].Value
    SourceIP = $logonEvent.Properties[18].Value
}

# Convert the event logs to JSON format or whatever format you wish to see once it's uploaded
$jsonData = $eventData | ConvertTo-Json

# Define tstorge details, I used Azure Blob
$name_of_storage_account= "[YOUR STORAGE ACCOUNT NAME]"
$containerName = "[YOUR CONTAINER NAME]"
$blob_name = "logon-event-$((Get-Date).ToString('yyyyMMddHHmmss')).json"
$sasToken = "?[YOUR SAS TOKEN]"

# Upload the JSON data to Azure Blob Storage
$uri = "https://$name_of_storage_account.blob.core.windows.net/$containerName/$blob_name$sasToken"
$headers = @{
    "x-ms-blob-type" = "BlockBlob"
}
Invoke-RestMethod -Uri $uri -Method Put -Headers $headers -Body $jsonData -ContentType "application/json"

Write-Output "Logon event uploaded to Azure Blob Storage: $blob_name"
