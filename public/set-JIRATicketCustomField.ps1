function set-JIRATicketCustomField {
    param (
        $ticketID,
        $CustomFieldName,
        $CustomFieldData
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
        $CustomFieldBody=@"
{
    "fields": {
        "$($CustomFieldName)":"$($CustomFieldData)"
    }
}
"@
        $customFieldURI="/rest/api/latest/issue/$($TicketID)"
        $CustomField=Invoke-RestMethod -Uri "$($JIRAUrl)$($customFieldURI)" -Method Put -ContentType 'application/json' -Headers $headers -body $CustomFieldBody
    }
    end{
        Write-Verbose "CustomField has been edited on Ticket: $($TicketID)" -Verbose
        $CustomField
    }    
}