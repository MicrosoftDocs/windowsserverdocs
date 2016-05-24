---
title: Configure the VLAN tenant VM Contoso App 2
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eca0c31e-3386-4257-8754-d79a04bbc7da
---
# Configure the VLAN tenant VM Contoso App 2
You can use this topic to configure the virtual machine \(VM\) named ContosoApp2 on the Hyper\-V Network Virtualization \(HNV\) host.  
  
> [!IMPORTANT]  
> The Windows PowerShell script that is provided in this topic must be run from within the VM named ContosoApp2. Do not run this script on the HNV host. In addition, you must replace variable values in the script with values that are appropriate for your deployment.  
  
### To configure the ContosoApp2 VM  
  
1.  On the HNV host, open Hyper\-V Manager, and then double\-click the VM named ContosoApp2. The VM opens in a new window. Start the VM.  
  
2.  During the operating system installation on the VM, create an Administrator password and provide other information as required.  
  
3.  When installation is complete, log on to the VM ContosoApp2.  
  
4.  Rename the computer and restart the VM by running the following Windows PowerShell commands.  
  
    ```  
    Rename-Computer ContosoApp2  
    Restart-Computer  
    ```  
  
5.  After the computer is restarted, log on to the VM.  
  
6.  Copy the Windows PowerShell script below to the VM.  
  
7.  On the VM, open Windows PowerShell with Administrator privileges. Run the script by typing the folder location and file name of the script. For example, if the file name of the script is ContosoApp2.ps1 and the folder location is C:\\Users\\Administrator\\Documents, type **C:\\Users\\Administrator\\Documents\\ContosoApp2.ps1**, and then press ENTER.  
  
## Full Windows PowerShell script  
Following is the full script that you can run on the VM ContosoApp2. This script configures the VM network adapter so that it will function correctly in the Contoso customer address space.  
  
```  
  
################################### Macros for Cloud VM - ContosoApp2 ##############################  
  
$Contoso_CloudVM2_Address = "10.0.1.111"  
$Contoso_CloudVM_DefaultGW = "10.0.1.1"  
$Contoso_CloudVM_Subnet = "10.0.1.0/24"  
  
$Contoso_CloudGW_Address = "10.0.2.2"  
  
######################### Configure Contoso Cloud VM #########################  
  
$iface = Get-NetAdapter -Name "Ethernet"  
  
New-NetIPAddress $Contoso_CloudVM2_Address -InterfaceIndex $iface.ifIndex -DefaultGateway $Contoso_CloudVM_DefaultGW -PrefixLength 24  
Rename-NetAdapter -Name "Ethernet" -NewName "Cloud"  
  
## End Cloud VM - Contoso Tenant Config ##  
  
```  
  
