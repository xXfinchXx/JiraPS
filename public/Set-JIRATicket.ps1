Function Set-JIRATicket {
    Param(
        $TicketID,
        $fieldsJson
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
        $Issueuri="/rest/api/latest/issue/$($TicketID)"
        $Final=Invoke-RestMethod -Uri "$($JIRAUrl)$($Issueuri)" -Method PUT -ContentType 'application/json' -Headers $headers -Body $fieldsJson
    }
    end{
        $Final
    }
}

$fieldsJson = [pscustomobject]@{
    fields = [pscustomobject]@{
        components = @(
            [pscustomobject]@{
                name = 'Octopus'
            }
        )
    } 
}  