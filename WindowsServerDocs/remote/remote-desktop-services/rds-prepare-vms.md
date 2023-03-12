---
title: Prepare your virtual machines for Remote Desktop
description: Get your VMs ready for Remote Desktop components
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 07/21/2017  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2fc39dff-61ca-4eba-81ab-52289081bead
author: lizap
manager: dongill
---
# Create virtual machines for Remote Desktop

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

You can install Remote Desktop Services components on physical servers or on virtual machines. 

The first step is to [create Windows Server virtual machines in Azure](/azure/virtual-machines/windows/quick-create-portal). You'll want to create three VMs: one for the RD Session Host, one for the Connection Broker, and one for the RD Web and RD Gateway. To ensure the availability of your RDS deployment, create an availability set (under **High availablility** in the VM creation process) and group multiple VMs in that availability set.
 
After you create your VMs, use the following steps to prepare them for RDS.

1.  Connect to the virtual machine using the Remote Desktop Connection (RDC) client:  
    1.  In the Azure portal open the  Resource groups view, and then click the resource group to use for the deployment.  
    2.  Select the new RDSH virtual machine (for example, Contoso-Sh1).  
    3.  Click **Connect > Open** to open the Remote Desktop client.  
    4.  In the client, click **Connect**, and then click **Use another user account**. Enter the user name and password for the local administrator account.  
    5.  Click **Yes** when warned about the certificate.  
2.  Enable remote management:  
    1.  In Server Manager, click **Local Server > Remote management current setting (disabled)**.  
    2.  Select **Enable remote management for this server**.  
    3.  Click **OK**.  
3.  Optional: You can temporarily set Windows Update to not automatically download and install updates. This helps prevent changes and system restarts while you deploy the RDSH server.  
    1.  In Server Manager, click **Local Server > Windows Update current setting**.  
    2.  Select **Advanced options > Defer upgrades**.   
4.  Add the server to the domain:  
    1.  In Server Manager, click **Local Server > Workgroup current setting**.  
    2.  Click **Change > Domain**, and then enter the domain name (for example, Contoso.com).  
    3.  Enter the domain administrator credentials.  
    4.  Restart the virtual machine.  
5.  Repeat steps 1 through 4 for the RD Web and GW virtual machine.  
6.  Repeat steps 1 through 4 for the RD Connection Broker virtual machine.  
7.  Initialize and format the attached disk on the RD Connection Broker virtual machine:  
    1.  Connect to the RD Connection Broker virtual machine (step 1 above).  
    2.  In Server Manager, click **Tools > Computer Management**.  
    3.  Click **Disk Management**.  
    4.  Select the attached disk, then **MBR (Master Boot Record)**, and then click **OK**.  
    5.  Right-click the new disk (marked as **Unallocated**) and click **New Simple Volume**.  
    6.  In the **New Simple Volume** wizard, accept the default values but provide a applicable name for the **Volume label** (like Shares).  
8.  On the RD Connection Broker virtual machine create file shares for the user profile disks and certificates:   
    1.  Open File Explorer, click **This PC**, and open the disk that you added for file shares.  
    2.  Click **Home** and **New Folder**.  
    3.  Enter a name for the user disks folder, for example, **UserDisks**.  
    4.  Right-click the new folder and click **Properties > Sharing > Advanced Sharing**.  
    5.  Select **Share this folder** and click **Permissions**.  
    6.  Select **Everyone**, and then click **Remove**. Now click **Add**, enter **Domain Admins**, and click **OK**.  
    7.  Select **Allow Full Control**, and then click **OK > OK > Close**.  
    8.  Repeat steps c. to g. to create a shared folder for certificates.   


