function New-JIRAIssue {
    param(
        $ProjectKey,
        $issueTypeID,
        $issueDescription,
        $issueSummary
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
        $IssueURI="/rest/api/latest/issue"
        $Body = @{
            "project"   = @{"id" = $ProjectKey}
            "issuetype" = @{"id" = [String] $IssueTypeId}
            "summary"   = $IssueSummary
        } | ConvertTo-Json
        $Out=Invoke-RestMethod -Uri "$($JIRAURL)$($Issueuri)" -Method POST -Headers $headers -Body $body -ContentType "application/json"
    }
    end{
        $Out
    }
}