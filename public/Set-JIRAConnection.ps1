function Set-JIRAConnection {
    param (
        [parameter(Mandatory=$true)]$APIKey,
        [parameter(Mandatory=$true)]$User,
         $URL=""
         
    )

    $global:JIRAURL = $URL
    $global:JIRAAPIKey = $APIKey
    $global:JIRAUser = $User
}#FmLvwOfWlvLSijyhFrwC2688