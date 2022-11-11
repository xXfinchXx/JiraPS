function Add-JIRATicketComment {
    param (
        $ticketID,
        $comment
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
        $JIRAComment = [pscustomobject]@{
            body= $comment
        }
        $commentURI="/rest/api/latest/issue/$($TicketID)/comment"
        $Comment=Invoke-RestMethod -Uri "$($JIRAUrl)$($commenturi)" -Method Post -ContentType 'application/json' -Headers $headers -body ($JIRAComment | ConvertTo-Json)
    }
    end{
        Write-Verbose "Comment has been added to Ticket: $($TicketID)" -Verbose
        $comment
    }    
}