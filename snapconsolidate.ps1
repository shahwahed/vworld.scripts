# -----------------------------------------------------------------------------
# Script    : consolide snapshot on vm
# Author    : Shah Mohsin WAHED
# Date      : 19/06/2012
# copyright : Copyright 2012, Shah Mohsin WAHED
# credits   : Shah Mohsin WAHED
# email     : shahmohsin.wahed@gmail.com
# maintainer: Shah Mohsin WAHED
# status    : v1.0
# Keywords  : vsphere esx5.x snapshot performance
# comments  : this script will consolidate snapshot automaticaly (could be launch in schedule manager or other crontab like)
#             BEWARE it you vm got his vdisk attach to another vm (hotadd backup for example) you cannot consolidate it
#
# ----------------------------------------------------------------------------- 

# just to make sure we could launch the script in crontab like
set-ExecutionPolicy RemoteSigned

# add vmware snapin
Add-PSSnapin VMware.VimAutomation.Core

# connect to the vcenter (add user/pass if script not run directly on the vcenter)
connect-viserver localhost -WarningAction SilentlyContinue

#let starts consolidate vm

# we retrive vm need to be consolidate
$vms = Get-VM | where {$_.ExtensionData.Runtime.consolidationNeeded}


if ( $vms -ne $null )
# just in case no vm need consolidatation we test if $vms is empty or not
{
#quick loop to cycle between 
	foreach ($myvm in $vms) {
		$myvm.ExtensionData.ConsolidateVMDisks_Task()
	}

}

# uncomment this line for debug and see what's happen
#Read-Host "Press anykey to exit"

