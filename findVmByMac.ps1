# -----------------------------------------------------------------------------
# Script    : find a vm by mac address
# Author    : Shah Mohsin WAHED
# Date      : 20/04/2012
# copyright : Copyright 2012, Shah Mohsin WAHED
# credits   : Shah Mohsin WAHED
# email     : shahmohsin.wahed@gmail.com
# maintainer: Shah Mohsin WAHED
# status    : v1.0
# Keywords  : vsphere esx mac address
# comments  : this script look for a mac address in all your vm within a cluster, useful to find decoy vm :)
#
# ----------------------------------------------------------------------------- 


# just to make sure we could launch the script in crontab like
set-ExecutionPolicy RemoteSigned

# add vmware snapin
Add-PSSnapin VMware.VimAutomation.Core



# connect to the vcenter (add user/pass if script not run directly on the vcenter)
#Connect-VIServer <IP> -User <user> -Password <pass>

$vcenterip = read-host "Enter your vcenter ip/hostname (leave blank for localhost)"

if(($vcenterip -eq $null) -or ($vcenterip -eq "")){"localhost"}

$userid = read-host "Enter your userid to run script (admin right) (leave black to use your windows credentials)"

if(($userid -eq $null) -or ($userid -eq "")){
connect-viserver localhost -WarningAction SilentlyContinue
}
else { $userpass= read-host "Enter your password"
while (($userpass -eq $null) -or ($userpass -eq "")) {$userpass= read-host "Enter your password (break script if you don't know it :)"}

Connect-VIServer $vcenterip -User $userid -Password $userpass -WarningAction SilentlyContinue
}


Write-Host ""
Write-Host "identify decoy vm by mac address" -foregroundcolor green
Write-Host ""
Write-Host "Cluster list"
Write-Host ""
foreach($cluster in Get-Cluster){
    Write-Host $cluster
}

$cluster = read-host "Please enter your Cluster name"
$macaddress = read-host "Select MAC Address to find"

Get-Cluster $cluster | Get-VM | Get-NetworkAdapter | Where-Object {$_.MacAddress -eq "$macaddress"} | Format-List -Property *



