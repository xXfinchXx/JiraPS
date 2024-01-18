<#
.SYNOPSIS
Flag Map for use with LaunchDarkly

.DESCRIPTION
This function is meant to be used to map JIRA Statuses to Environment Flagging. Pairs well with the LaunchDarklyPS Module.

.NOTES
Follow the format to be able to have a psobject to reference
#>
function get-jirastatusmap {
    process{
        ([pscustomObject]@{JIRAStatus  = "Open"
        development = "On"
        'dev-1'     = "Off"
        'dev-2'     = "Off"
        'dev-3'     = "Off"
        qa          = "Off"
        'qa-2'      = "Off"
        'qa-3'      = "Off"
        uat         = "Off"
        production  = "Off"
        demo        = "Off"},
        [pscustomObject]@{JIRAStatus  = "In Development"
        development = "On"
        'dev-1'     = "Off"
        'dev-2'     = "Off"
        'dev-3'     = "Off"        
        qa          = "Off"
        'qa-2'      = "Off"
        'qa-3'      = "Off"
        uat         = "Off"
        production  = "Off"
        demo        = "Off"},
        [pscustomObject]@{JIRAStatus  = "QA Testing"
        development = "On"
        'dev-1'     = "On"
        'dev-2'     = "On"
        'dev-3'     = "On"        
        qa          = "On"
        'qa-2'      = "On"
        'qa-3'      = "On"
        uat         = "Off"
        production  = "Off"
        demo        = "Off"},
        [pscustomObject]@{JIRAStatus  = "QA Confirmed"
        development = "On"
        'dev-1'     = "On"
        'dev-2'     = "On"
        'dev-3'     = "On"        
        qa          = "On"
        'qa-2'      = "On"
        'qa-3'      = "On"
        uat         = "On"
        production  = "Off"
        demo        = "Off"},
        [pscustomObject]@{JIRAStatus  = "Done"
        development = "On"
        'dev-1'     = "On"
        'dev-2'     = "On"
        'dev-3'     = "On"        
        qa          = "On"
        'qa-2'      = "On"
        'qa-3'      = "On"
        uat         = "On"
        production  = "On"
        demo        = "On"},
        [pscustomObject]@{JIRAStatus  = "Code Checked In"
        development = "On"
        'dev-1'     = "On"
        'dev-2'     = "On"
        'dev-3'     = "On"        
        qa          = "Off"
        'qa-2'      = "Off"
        'qa-3'      = "Off"
        uat         = "Off"
        production  = "Off"
        demo        = "Off"},
        [pscustomObject]@{JIRAStatus  = "Flag Disabled"
        development = "On"
        'dev-1'     = "On"
        'dev-2'     = "On"
        'dev-3'     = "On"        
        qa          = "Off"
        'qa-2'      = "Off"
        'qa-3'      = "Off"
        uat         = "Off"
        production  = "Off"
        demo        = "Off"},
        [pscustomObject]@{JIRAStatus  = "Won't Do"
        development = "Off"
        'dev-1'     = "Off"
        'dev-2'     = "Off"
        'dev-3'     = "Off"        
        qa          = "Off"
        'qa-2'      = "Off"
        'qa-3'      = "Off"
        uat         = "Off"
        production  = "Off"
        demo        = "Off"})
    }
}        