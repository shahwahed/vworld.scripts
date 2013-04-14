# -----------------------------------------------------------------------------
# Script    : consolide snapshot on vm on esx of vcenter
# Author    : Shah Mohsin WAHED
# Date      : 02/04/2013
# copyright : Copyright 2013, Shah Mohsin WAHED
# credits   : Shah Mohsin WAHED
# email     : shahmohsin.wahed@gmail.com
# maintainer: Shah Mohsin WAHED
# status    : v1.0
# Keywords  : vsphere esx5.x snapshot performance
# comments  : this script will consolidate snapshot automaticaly (could be launch in schedule manager or other crontab like)
#             BEWARE it you vm got his vdisk attach to another vm (hotadd backup for example) you cannot consolidate it
#             This script can be use when you have an ESX host who keep disconnect due to a VM with too much ghost snapshot chained
#             usefull to fix this vmware kb : http://kb.vmware.com/kb/2009217
#
# ----------------------------------------------------------------------------- 

# just to make sure we could launch the script in crontab like
set-ExecutionPolicy RemoteSigned

# add vmware snapin
Add-PSSnapin VMware.VimAutomation.Core


Write-Host "Welcome to the magical snapshot killer" -foregroundcolor green


$esx = read-host "Please enter esx name or IP addres (full or short name) you wan't to clean"

# define $userid and $userpass if you doesn't want to ask user/password each time



if(($userid -eq $null) -or ($userid -eq "")){

$userid = read-host "Enter your userid to run script (admin right)"

while (($userid -eq $null) -or ($userid -eq "")) {$userid = read-host "Enter your userid to run script (admin right)"}

$userpass= read-host "Enter your password"
while (($userpass -eq $null) -or ($userpass -eq "")) {$userpass= read-host "Enter your password (break script if you don't know it :)"}

}

Write-Host "As you wish!" -foregroundcolor green

#connect to $esx

Write-Host "Connecting to " $esx -foregroundcolor green

Connect-VIServer $esx -User $userid -Password $userpass -WarningAction SilentlyContinue

# we look at vm who need to be consolidated
$vms = Get-VM | where-Object {$_.ExtensionData.Runtime.consolidationNeeded}


if ( $vms -ne $null )
# if value of $vms is null we have no vm needed consolidation
{
#let start the job cycle from $vms to consolidated all of them!!
	foreach ($myvm in $vms) {
	    Write-Host $myvm " need consolidate, task launch to take care of that chief!"
		$myvm.ExtensionData.ConsolidateVMDisks_Task() 

	}

}

# uncomment this line for debug and see what's happen
#Read-Host "Press anykey to exit"

