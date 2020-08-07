function Set-JIRATicketAssignee {
    param(
        [parameter(Mandatory)]$TicketID,
        [parameter(Mandatory)]$accountId
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
        $assigneeURI="/rest/api/2/issue/$($ticketID)/assignee"
        $AssignedTo = Get-JIRAUser -AccountID $accountId
        $accountIdJson = [pscustomobject]@{
            accountId = $accountId
        }
        $Assigned=Invoke-RestMethod -Uri "$($JIRAURL)$($assigneeuri)" -Method Put -ContentType 'application/json' -Headers $headers -body ($accountIdJson | ConvertTo-Json)
    }
    end{
        Write-Verbose "JIRA Ticket: $($TicketID) has been assigned to $($AssignedTo.DisplayName)"
        $Assigned
    }
}    