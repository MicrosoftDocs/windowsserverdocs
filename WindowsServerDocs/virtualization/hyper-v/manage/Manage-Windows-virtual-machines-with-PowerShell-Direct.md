---
title: Manage Windows virtual machines with PowerShell Direct
description: "Gives instructions for using PowerShell Direct to manage virtual machines without relying on a network or remote connection to them."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b5715c02-a90f-4de9-a71e-0fc09093ba2d
author: KBDAzure
ms.author: kathydav
ms.date: 10/04/2016
---
# Manage Windows virtual machines with PowerShell Direct

>Applies To: Windows 10, Windows Server 2016, Windows Server 2019
  
You can use PowerShell Direct to remotely manage a Windows 10, Windows Server 2016, or Windows Server 2019 virtual machine from a Windows 10, Windows Server 2016, or Windows Server 2019 Hyper-V host. PowerShell Direct allows Windows PowerShell management inside a virtual machine regardless of the network configuration or remote management settings on either the Hyper-V host or the virtual machine. This makes it easier for Hyper-V Administrators to automate and script virtual machine management and configuration.  
  
There are two ways to run PowerShell Direct:  
  
- Create and exit a PowerShell Direct session using PSSession cmdlets
  
- Run script or command with the Invoke-Command cmdlet
  
If you're managing older virtual machines, use Virtual Machine Connection (VMConnect) or [configure a virtual network for the virtual machine](https://technet.microsoft.com/library/cc816585.aspx).  
  
## Create and exit a PowerShell Direct session using PSSession cmdlets  
  
1. On the Hyper-V host, open Windows PowerShell as Administrator.  
  
2. Use the [Enter-PSSession](https://technet.microsoft.com/library/hh849707.aspx) cmdlet to connect to the virtual machine. Run one of the following commands to create a session by using the virtual machine name or GUID:  
  
    ```  
    Enter-PSSession -VMName <VMName>  
    ```  
  
    ```  
    Enter-PSSession -VMGUID <VMGUID>  
    ```  
  
3. Type your credentials for the virtual machine.   
4. Run whatever commands you need to. These commands run on the virtual machine that you created the session with.  
  
5.  When you're done, use the [Exit-PSSession](https://technet.microsoft.com/library/hh849743.aspx) to close the session.   
  
    ```  
    Exit-PSSession  
    ```  
  
## Run script or command with Invoke-Command cmdlet  
You can use the [Invoke-Command](https://docs.microsoft.com/powershell/module/Microsoft.PowerShell.Core/Invoke-Command) cmdlet to run a pre-determined set of commands on the virtual machine. Here is an example of how you can use the Invoke-Command cmdlet where PSTest is the virtual machine name and the script to run (foo.ps1) is in the script folder on the C:/ drive:  
  
```  
Invoke-Command -VMName PSTest  -FilePath C:\script\foo.ps1  
```  
  
To run a single command, use the **-ScriptBlock** parameter:  
  
```  
Invoke-Command -VMName PSTest  -ScriptBlock { cmdlet }  
```  
  
## What's required to use PowerShell Direct?  
To create a PowerShell Direct session on a virtual machine,  
  
-   The virtual machine must be running locally on the host and booted.  
  
-   You must be logged into the host computer as a Hyper-V administrator.  
  
-   You must supply valid user credentials for the virtual machine.  
  
-   The host operating system must run at least Windows 10 or Windows Server 2016.
  
-   The virtual machine must run at least Windows 10 or Windows Server 2016.  
  
You can use the [Get-VM](https://docs.microsoft.com/powershell/module/hyper-v/get-vm) cmdlet to check that the credentials you're using have the Hyper-V administrator role and to get a list of the virtual machines running locally on the host and booted.  
  
## See Also  
[Enter-PSSession](https://docs.microsoft.com/powershell/module/Microsoft.PowerShell.Core/Enter-PSSession)  
[Exit-PSSession](https://docs.microsoft.com/powershell/module/Microsoft.PowerShell.Core/Exit-PSSession)  
[Invoke-Command](https://docs.microsoft.com/powershell/module/Microsoft.PowerShell.Core/Invoke-Command)  
  


