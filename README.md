vworld.scripts
==============

vmware and other virtualization scripts

http://shah.vworld.scripting.cloudcorner.net

//Scripts list
1. snapconsolidate.ps1        : consolidate vm who need it, useful in crontab like :)
2. findVmByMac.ps1            : lookout for vm by mac address
3. snapConsolidateAdvance.ps1 : consolidate vm, helpful to fix http://kb.vmware.com/kb/2009217

--------------------------------------------------------------------------------

//snapconsolidate.ps1
This script will consolidate snapshot on your vCenter Server

///Requirements / Pre-requisites
This script will require the following components:

1. Windows PowerShell 2.0+
2. VMware vSphere™ PowerCLI
///usage
Simply launch the script from the PowerCLI prompt or schedule it from windows

PowerCLI DRIVE:\PathToScript> snapconsolidate.ps1


--------------------------------------------------------------------------------

//findVmByMac.ps1
This script will identify vm by is mac address

///Requirements / Pre-requisites
This script will require the following components:

1. Windows PowerShell 2.0+
2. VMware vSphere™ PowerCLI
///usage
Simply launch the script from the PowerCLI prompt or schedule it from windows

PowerCLI DRIVE:\PathToScript> findVmByMac.ps1

//snapConsolidateAdvance.ps1
This script will consolidate snapshot on your vcenter or esx. very usefull to fix vmware kb 2009217

///Requirements / Pre-requisites
This script will require the following components:

1. Windows PowerShell 2.0+
2. VMware vSphere™ PowerCLI
///usage
Simply launch the script from the PowerCLI prompt and follow the wizard. If you want to make user/pass static fill $userid and $userpass For fixing esx or vcenter fill $esx variable. 

PowerCLI DRIVE:\PathToScript> snapConsolidateAdvance.ps1

have fun!


--------------------------------------------------------------------------------
