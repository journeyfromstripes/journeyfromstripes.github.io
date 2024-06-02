Import-Module .\tb\ConvertTo-MarkdownTable.ps1

# Import recent allycode data
$allyCodes = import-csv .\tb\allycodes.csv

# Get most recently added TB report data uploaded to github repo and convert to JSON
$newestTBOutput = Get-ChildItem -Path .\tb\wookiebot-output -File | Sort-Object -Property LastWriteTime -Descending | Select-Object -First 1
$wookieBotROTEJSON = Get-Content $newestTBOutput | ConvertFrom-Json
$wookieBotPlatoonAssignments = $wookieBotROTEJSON | Select-Object -ExpandProperty platoonassignments

$reportOutput = foreach ($p in $wookieBotPlatoonAssignments) {
    $platoonUsername = $null
    $platoonUsername = ($allyCodes | Where-Object {$_.allycode -eq $p.allycode}).name
    
    if ($platoonUsername){
        $newROTEOutput = [PSCustomObject]@{
            Username = $platoonUsername
            Toon    = $p.unitBaseId
            Zone = $p.zoneId
            PlatoonID = $p.platoonDefinitionId
        }
    }
    $newROTEOutput  
}

$reportOutput | sort-object username | ConvertTo-MarkdownTable | Out-File .\tb\rote-plan.md

# Pre-pending header text to the markdown file
#$currentDate = get-date -format MM-yyyy
#$webPagePrependedText = "# $currentDate - ROTE Platoon Assignments"
#$originalReport = Get-Content .\tb\rote-plan.md
#$newContent = $webPagePrependedText, $originalReport
#Set-Content -Path .\tb\rote-plan.md -Value $newContent

