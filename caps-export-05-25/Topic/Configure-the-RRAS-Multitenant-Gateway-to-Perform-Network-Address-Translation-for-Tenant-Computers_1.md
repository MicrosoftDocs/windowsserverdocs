---
title: Configure the RRAS Multitenant Gateway to Perform Network Address Translation for Tenant Computers_1
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7e41ca8c-340f-4aed-988b-0f3f8f5e3bdb
author: vhorne
---
# Configure the RRAS Multitenant Gateway to Perform Network Address Translation for Tenant Computers_1
You can use this topic to enable Network Address Translation \(NAT\) on the public interface of the RRAS Multitenant Gateway virtual machine \(VM\).  
  
This topic has the following sections.  
  
-   [Prerequisites](#bkmk_pre)  
  
-   [To enable NAT on the public interface](#bkmk_proc)  
  
-   [Windows PowerShell command reference links](#bkmk_links)  
  
## <a name="bkmk_pre"></a>Prerequisites  
Before you perform this procedure, you must do the following.  
  
-   Either rename the public interface network adapter to “Internet” or change the Windows PowerShell command in the procedure below to use the actual name of the network adapter. If the network adapter name on the computer and the network adapter name in the command do not match, the command will fail.  
  
-   Ensure that your multitenant gateway VM is named “MTCloudGW.” If this is not the name of your VM, you must change the Windows PowerShell command below to use the correct VM name.  
  
-   Ensure that the RRAS Multitenant Gateway VM is not running.  
  
-   Obtain the external IP interface address range for the network adapter that is the public interface, and use the actual address range as the value for the parameter **–ExternalIPInterfaceAddress** of the **New\-NetNat** command in the procedure below.  
  
## <a name="bkmk_proc"></a>To enable NAT on the public interface  
  
1.  On the Hyper\-V host where the RRAS Mulitenant Gateway VM is configured, open Windows PowerShell with Administrator privileges.  
  
2.  Create a virtual switch, add a virtual network adapter to connect the VM to the switch, and enable NAT on the network adapter that has the public interface by typing the following commands and pressing ENTER.  
  
    ```  
    New-VMSwitch "InternetSwitch" -NetAdapterName "Internet"  
    Add-VMNetworkAdapter -VMName MTCloudGW -Name ExtNic -SwitchName InternetSwitch  
    New-NetNat -Name "AllTenants" -ExternalIPInterfaceAddress "a.b.c.0/24"  
    ```  
  
## <a name="bkmk_links"></a>Windows PowerShell command reference links  
The script in this topic uses the following Windows PowerShell commands. Click a link to open the help topic for the command.  
  
-   [New\-VMSwitch](http://technet.microsoft.com/library/hh848455.aspx). Creates a new virtual switch on one or more virtual machine hosts.  
  
-   [Add\-VMNetworkAdapter](http://technet.microsoft.com/library/hh848564.aspx). Adds a virtual network adapter to a virtual machine.  
  
-   [New\-NetNat](http://technet.microsoft.com/library/dn283361.aspx). Creates a new NAT object.  
  
## See Also  
[Additional Resources_1](../Topic/Additional-Resources_1.md)  
  
