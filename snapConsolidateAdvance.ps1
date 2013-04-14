# -----------------------------------------------------------------------------
# Script    : consolide snapshots on vms from a vSphere Host
# Author    : Shah Mohsin WAHED
# Date      : 02/04/2013
# copyright : Copyright 2013, Shah Mohsin WAHED
# credits   : Shah Mohsin WAHED
# email     : shahmohsin.wahed@gmail.com
# maintainer: Shah Mohsin WAHED
# status    : v1.1
# Keywords  : vsphere esx5.x snapshot performance
# comments  : this script will consolidate snapshots automaticaly 
#             (Could be launched through the Windows task scheduler)
#             WARNING: If your vm got a vdisk attached to another vm 
#             (hotadd backup for example) you cannot consolidate it. 
#             This script can be used when you have an ESX host which keeps 
#             disconnecting due to a VM with too much ghost snapshots chained 
#             useful against this vmware kb : http://kb.vmware.com/kb/2009217
#
# WARNING : do not use on vcloud environnement
#
# Version history script simplification submit by Timo Sugliani
# ----------------------------------------------------------------------------- 

#$vSphereHost = "vSphere.hostname.com" or "192.168.0.101"
#$username = "Administrator"
#$password = "Password123"

# add vmware snapin
Add-PSSnapin VMware.VimAutomation.Core

Write-Host "*****  WARNING do not use on vCloud Environnement *****"
Read-Host "Press enter to continue"

$vSphereHost = read-host "Please enter your vSphere Host (FQDN) or IP address you want to connect to: "

Write-Host "Enter your vSphere Administrator credentials" 
$username = read-host "Username: "
$password = read-host -assecurestring "Password: "

# Connect to the vSphere host
Write-Host "Connecting to " $vSphereHost -foregroundcolor green

Connect-VIServer $vSphereHost -User $username -Password $password -WarningAction SilentlyContinue

# Fetch all the VMs which needs consolidation.
$vms = Get-VM | where-Object { $_.ExtensionData.Runtime.consolidationNeeded }

if ($vms -ne $null) { # if value of $vms is null we have no vm needed consolidation
    # let start the job cycle from $vms to consolidated all of them!!
    foreach ($myvm in $vms) {
        Write-Host $myvm " need consolidate"
        $myvm.ExtensionData.ConsolidateVMDisks_Task() 
    }
}
