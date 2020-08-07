function Set-JIRATicketLabel {
    param(
        [parameter(Mandatory)]$TicketID,
        [parameter(Mandatory)]$label,
        [switch]$add,
        [switch]$remove
    )
    begin{
        If (!($JIRAuser)){
            Write-Warning "Looks like you haven't set your connection yet. Let me help you with that."
            $APIKey = Read-Host -Prompt "What is your JIRA APIKey?"
            $user= Read-Host -Prompt "What is your JIRA account username?"
            Set-JIRAConnection -APIKey $APIKey -User $user
        }
        $pair = "$($JIRAuser):$($JIRAAPIKey)"
        $encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
        $basicAuthValue = "Basic $encodedCreds"
        $Headers = @{Authorization = $basicAuthValue}
    }
    process{
        $LabelURI="/rest/api/3/issue/$($ticketID)"
        if ($add){
            $labelJson =@"
            {
                "fields": {
                    "labels": [
                        "$label"
                    ]
                }
            }
"@    
        }elseif ($remove) {
            $labelJson =@"
            {
                "fields": {
                    "labels": [
                    ]
                }
            }
"@ 
        }
        $Labeled=Invoke-RestMethod -Uri "$($JIRAURL)$($labeluri)" -Method Put -ContentType 'application/json' -Headers $headers -body ($labelJson)
    }
    end{
        Write-Verbose "JIRA Ticket: $($TicketID) has $(if ($add){"Added"}else{"Removed"}) the Label $($Label)" -Verbose
    }
}    