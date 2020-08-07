Function Get-JIRATicket {
    Param(
        $searchterm,
        $jiraProject,
        [switch]$table,
        $TicketID,
        $TicketName,
        [switch]$Mine

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
        if($TicketID){
            $Issueuri="/rest/api/3/issue/$($TicketID)"
            $Final=Invoke-RestMethod -Uri "$($JIRAUrl)$($Issueuri)" -Method Get -ContentType 'application/json' -Headers $headers
        }elseif ($TicketName) {
            if($jiraProject){}Else{
                Write-Warning "JIRAProject Parameter is needed to use the TicketName Parameter."
                $jiraProjectAsk = Read-Host -Prompt "Do you know your JIRA Project? Yes or No"
                If ($jiraProjectAsk -match "^Y"){
                    $jiraProject = Read-Host -prompt "Enter the JIRA Project here:"
                }else {
                    Write-Warning 'Please use the SearchTerm Parameter instead'
                    end
                }
            }
            $IssueNameuri="/rest/api/3/search?jql=project = $($JiraProject) AND summary ~ $($TicketName) &maxResults=300&fields=*all"
            $Final=Invoke-RestMethod -Uri "$($JIRAUrl)$($IssueNameuri)" -Method Get -ContentType 'application/json' -Headers $headers
        }elseif ($SearchTerm) {
            $allIssuesuri="/rest/api/3/search?jql=text ~ $($SearchTerm) &maxResults=300&fields=*all"
            $issuelist=Invoke-RestMethod -Uri "$($JIRAUrl)$($allIssuesuri)" -Method Get -ContentType 'application/json' -Headers $headers
            $final = $issuelist | Where Summary -Match $searchterm
        }elseif ($Mine) {
            $Self=Get-JIRAselfAccountInfo
            $IssueNameuri="/rest/api/3/search?jql=assignee = ($($self.accountId)) &maxResults=300&fields=*all"
            $Final=Invoke-RestMethod -Uri "$($JIRAUrl)$($IssueNameuri)" -Method Get -ContentType 'application/json' -Headers $headers
        }    
    }
    end{
        if ($table){
            $Final | FT *
        }else{
            $Final
        }
    }
}