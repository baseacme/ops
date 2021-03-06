######################################################
function Get-NetworkShare {   
<#     
.SYNOPSIS     
    Enumerates current network shares.   
     
.DESCRIPTION   
    Enumerates current network shares.     
                  
.NOTES     
    Name: Get-NetworkShare 
    Author: Jason Tatman     
    Date Created: 1/4/2016   
       
    To Do:                
      
.EXAMPLE     
    Get-NetworkShare 
    Lists all Network Drives
             
#>  

$net = New-Object -com WScript.Network
$net.enumNetworkDrives() | where { $_ -match "\w" }

}


######################################################
function Remove-NetworkShare {   
<#     
.SYNOPSIS     
    Removes a network share.   
     
.DESCRIPTION   
    Removes a network share.     
                  
.NOTES     
    Name: New-NetworkShare 
    Author: Jason Tatman     
    Date Created: 1/4/2016   
       
    To Do:                
      
.EXAMPLE     
    Remove-NetworkShare -all 
    Removes all connected network drives

.EXAMPLE     
    Remove-NetworkShare -share "\\server.domain.com\share" 
    Removes a single share
             
#>  

Param(

  [Parameter(
    Mandatory = $True,   
    Position = 0,   
    ParameterSetName = 'All',   
    ValueFromPipeline = $True)] 
    [switch]$All,

  [Parameter(
    Mandatory = $True,   
    Position = 0,   
    ParameterSetName = 'Single',   
    ValueFromPipeline = $True)] 
    [string]$share

 )

$net = New-Object -com WScript.Network
$ConnectedShares = $net.enumNetworkDrives() | where { $_ -match "\w" }

if ($All) {
    if ($ConnectedShares) {
        Write-Host "The following shares will be disconnected:"
        Write-Host $ConnectedShares 
        $ConnectedShares | Foreach-Object {
            $Share = $_
            Write-Host "Removing: $Share"
            $net.RemoveNetworkDrive($Share)
        }
    }
    else {
        Write-Host "No shares available to disconnect"
    }
}

elseif ($Share) {
    if ($ConnectedShares -contains $Share) {
        Write-Host "Removing: $Share"
        $net.RemoveNetworkDrive($Share)
    }
    else {
        Write-Host "Share was not available to disconnect"
    }
}

Else {
    Write-Host "Problem with input parameter"
}
   
}

######################################################
function New-NetworkShare {   
<#     
.SYNOPSIS     
    Connects to a network share.   
     
.DESCRIPTION   
    Connects to a network share.   
      
.PARAMETER share   
    Name of share to connect to 
       
.PARAMETER credential   
    The credentials to use.  This can be passed as a parameter, and set up with:
      > $credential = get-credential  
                  
.NOTES     
    Name: New-NetworkShare 
    Author: Jason Tatman     
    Date Created: 1/4/2016   
       
    To Do:                
      
.EXAMPLE     
    New-NetworkShare -share \\server.domain.com\share -credential $credential   
    Maps to this network drive   
             
#>  
  
[cmdletbinding(   
    DefaultParameterSetName = '',   
    ConfirmImpact = 'low'   
)]   
    Param(   
        [Parameter(   
            Mandatory = $True,   
            Position = 0,   
            ParameterSetName = '',   
            ValueFromPipeline = $True)]   
            [string]$share,   
        [Parameter(   
            Position = 1,   
            Mandatory = $False,   
            ParameterSetName = '')]   
            $credential                      
        )   

$net = New-Object -com WScript.Network
$ConnectedShares = $net.enumNetworkDrives()
 
if (!($credential)) {
    $Credential = Get-Credential
}
if ($ConnectedShares -contains $Share ) {
    write-host "Drive already mapped.  use Get-NetworDrive/Remove-NetworDrive to disconnect before continuing"
}
else {
    $net.mapNetworkDrive($drive, "$share", "true", $cred.username, $cred.GetNetworkCredential().Password) 
}

}

Export-ModuleMember -Function New-NetworkShare,Get-NetworkShare,Remove-NetworkShare