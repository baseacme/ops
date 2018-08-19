####################################################################
# install-powershell.ps1
# written by jtatman 7/17/2008
#
# This script is used to initially setup powershell, after the initial
# installation.  It covers installing required addons, and setting 
# up the environment, and profile.  It is primarily for production, but
# should work on any network, provided the same code signing cert is used.
#
####################################################################

write-host "This program can be cancled/interrupted at any time with CNTRL+C`n"

#Create a new drive for access to the G
if (test-path g:\) {
	echo "Error: g:\ drive is already mapped, if it is not the G, it will manually need to be switched out"
	}
elseif (Test-Path "$env:homedrive$env:homepath\G") {
	subst g: "$env:homedrive$env:homepath\G"
	New-PSDrive g -psprovider filesystem -root "$env:homedrive$env:homepath\G"
	echo "Creating a new drive letter for g: at $env:homedrive$env:homepath\G"
}
elseif (test-path "c:\$env:homepath\G") {
	subst g: "c:\$env:homepath\G"
	New-PSDrive g -psprovider filesystem -root "c:\$env:homepath\G"
	echo "Creating a new drive letter for g: at c:\$env:homepath\G"
}
elseif (test-path "c:\$env:homepath\Google Drive") {
	subst g: "c:\$env:homepath\Google Drive"
	New-PSDrive g -psprovider filesystem -root "c:\$env:homepath\Google Drive"
	echo "Creating a new drive letter for g: at c:\$env:homepath\Google Drive"
}
elseif (test-path "C:\Users\jtatman\G") {
	subst g: "C:\Users\jtatman\G"
	New-PSDrive g -psprovider filesystem -root "C:\Users\jtatman\G"
	echo "Creating a new drive letter for g: at C:\Users\jtatman\G"
}
else {
	echo "G not available at $env:homedrive+$env:homepath\G , g:\ drive will need to be mapped manually to the local G"
}

<##Install Community Extensions
echo "Installing Powershell Community Extenstions (Version 3)"
if ((ls $pshome\modules\pscx\pscx.dll).versioninfo.productversion -eq "2.1.1.0" ){
	echo "Powershell Community Extensions Version 3 is already installed"
}
else {
	if ((test-path "C:\opt\src\powershell\requiredaddons\PowershellCommunityExtenstions\Pscx-3.0.0.msi")) {
		echo "Installing from local drive"
		& "C:\opt\src\powershell\requiredaddons\PowershellCommunityExtenstions\Pscx-3.0.0.msi"
		}
	else 
		{
		echo "local path not found C:\opt\src\powershell\requiredaddons\PowershellCommunityExtenstions\Pscx-3.0.0.msi, looking for G"
		if ((test-path "$env:homedrive$env:homepath\G\opt\src\powershell\requiredaddons\PowershellCommunityExtenstions\Pscx-3.0.0.msi")) {
			echo "Installing from G"
			& "$env:homedrive$env:homepath\G\opt\src\powershell\requiredaddons\PowershellCommunityExtenstions\Pscx-3.0.0.msi"
		}
		else {
		echo "Could not locate Powershell Community Extension (version 3), please download and install"
		}
	}
}
#>

#Copy the common profile
$p = $NULL
$ProfileDir = $profile.tostring().replace("Microsoft.PowerShell_profile.ps1","")

if (test-path $profile) {
	$p = read-host "Profile already exists, would you like to overwrite?"
	if ($p -eq "y" -or $p -eq "yes") {
		echo "overwriting $profile"
		cp g:\opt\profile\defaultprofile.ps1 $profile
	}
	else {
		echo "Skipping profile setup"
	}
}
else {
	echo "Copying the default profile to $profile"
    if ((test-path $ProfileDir) -eq $FALSE) {
        new-item -itemtype directory $ProfileDir
    }
	cp g:\opt\profile\defaultprofile.ps1 $profile
}

#Set the environment variable to be able to load jttools from Google drive
$CurrentValue = [Environment]::GetEnvironmentVariable("PSModulePath", "Machine")
if (!($CurrentValue -contains "g:\opt\bin\PowerShellModules")) {
    [Environment]::SetEnvironmentVariable("PSModulePath", $($CurrentValue + ";G:\opt\bin\PowerShellModules"), "Machine")
}

elseif (!($CurrentValue -contains "c:\opt\bin\PowerShellModules")) {
    [Environment]::SetEnvironmentVariable("PSModulePath", $($CurrentValue + ";C:\opt\bin\PowerShellModules"), "Machine")
}


