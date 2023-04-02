Function Get-JIRATicketJQL {
    Param(
        $JQL,
        [switch]$table
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
            if ($JQL -contains " "){$jql=$jql -replace " ","\+" }
            $allIssuesuri="/rest/api/latest/search?jql=$($JQL)&maxResults=250&fields=*all"
            $issuelist=Invoke-RestMethod -Uri "$($JIRAUrl)$($allIssuesuri)" -Method Get -ContentType 'application/json' -Headers $headers
            $final = $issuelist
    }
    end{
        if ($table){
            $Final | FT *
        }else{
            $Final
        }
    }
}