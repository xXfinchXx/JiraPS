function Set-JIRATicketStatus {
    param (
        [parameter(Mandatory)]$ticketID
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
        $statusURI="/rest/api/2/issue/$($TicketID)/transitions"
        $p.fields
        $temp=Invoke-RestMethod -Uri "$($JIRAURL)$($statusuri)" -Method Get -ContentType 'application/json' -Headers $Headers
        $temp.transitions | Select ID,name | FT 
        $Selection = Read-Host -prompt "Please type an ID from the Above choices."
        $transition=[pscustomobject]@{
            transition= [pscustomobject]@{
                id = $Selection
            }
        }
        $StatusUpdate=Invoke-RestMethod -Uri "$($baseuri)$($statusuri)" -Method Post -ContentType 'application/json' -Headers $headers -body ($transition | ConvertTo-Json -Depth 3)   
    }
    end{
        Write-Verbose "Ticket: $($TicketId) has been updated to status: $($Temp.Transitions | Where ID -match $Selection)"
        $StatusUpdate
    }
}