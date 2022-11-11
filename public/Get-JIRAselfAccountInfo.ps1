function Get-JIRAselfAccountInfo {
    param (
        [switch]$SetAsGlobalVariable
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
        $out=Invoke-RestMethod -Uri "$($JIRAurl)/rest/api/latest/myself" -Method Get -ContentType 'application/json' -Headers $headers
    }
    end{
        if ($SetAsGlobalVariable){
            $Global:JIRAaccountInfo = $out
        }else{
            $out
        }
    }
}