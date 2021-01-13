function Set-JIRAConnection {
    param (
        [parameter(Mandatory=$true)]$APIKey,
        [parameter(Mandatory=$true)]$User,
         $URL="https://lplfinancial.atlassian.net"
         
    )

    $global:JIRAURL = $URL
    $global:JIRAAPIKey = $APIKey
    $global:JIRAUser = $User
}