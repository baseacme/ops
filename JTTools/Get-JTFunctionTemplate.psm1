Function Get-JTScriptTemplate {

<#
.SYNOPSIS
An explanation of what the function does, inputs and outputs, in an outlined format.

--This script is a template, but will also attempt to self explain it's use.

.DESCRIPTION
Name: Get-JTFunctionTemplate
Author: jtatman 6/13/2016

.NOTES

TODO - NA
    First
Updates
    1/1/2010 - User - Explaination

.PARAMETER StringParameter
An input of a string
.PARAMETER InstanceID
The Instance of the job being run
.PARAMETER CallingScript
The script, or job that is writing to the log file
.PARAMETER Step
The name of the function, or the step in the script being run
.PARAMETER Status
The status of the job step
.PARAMETER User
The user the log function (and script) was written by


.EXAMPLE
Write-SFLYLog -LogFile "c:\log\Test-Script.log" -InstanceID 20160304.054557.Test-Script -CallingScript Test-Script -Step Test-Function -Status START -User ($env:USERNAME + "@" + $env:USERDNSDOMAIN)

#>

[CmdletBinding()]
param (
    [Parameter(
        Position=0, 
        Mandatory=$false, 
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)
    ][String]$StringParameter,
    [Parameter(
        Position=1, 
        Mandatory=$false, 
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)
    ][array]$ArrayParameter, 
    [Parameter(
        Position=2, 
        Mandatory=$false, 
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)
    ][String]$Credentials,
    [Parameter(
        Position=3, 
        Mandatory=$false, 
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)    
    ]$CallingScript,
    [Parameter(
        Position=4, 
        Mandatory=$false, 
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)
    ][bool]$bool
)

##################################################################################################
#Configurable Script Variables
##################################################################################################


#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#
#Hard Coded Values
#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#
#!#!#!#!#
#Hard Coded Variables
#!#!#!#!#
function FN_WL {
    Write-JTLog -InstanceID $InstanceID -message $Message
    Write-Verbose $Message
}


##################################################################################################
#Script Code
##################################################################################################
##########
#Do Main - The main overall logic of the script
##########
function Do-Main {
    #!#!#!#!#
    #Log the start of the function
    $Message = "Starting function: $CallingScript - Command: $($MyInvocation.line)" 
    FN_WL
    #!#!#!#!#

    #Run various functions


    #Log the end of the function
    $Message = "Completed function: $CallingScript - Command: $($MyInvocation.line)" 
    FN_WL
    #!#!#!#!#
}


##########
#Script Functions
##########



##################################################################################################
#Execute Script Code
##################################################################################################

Do-Main

}

Export-ModuleMember Get-JTFunctionTemplate