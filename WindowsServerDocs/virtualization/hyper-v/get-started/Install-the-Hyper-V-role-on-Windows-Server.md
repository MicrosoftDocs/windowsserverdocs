---
title: Install the Hyper-V role on Windows Server
description: "Gives instructions for installing Hyper-V using Server Manager or Windows PowerShell"
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 8e871317-09d2-4314-a6ec-ced12b7aee89
author: KBDAzure
ms.author: kathydav
ms.date: 12/02/2016
---
# Install the Hyper-V role on Windows Server

>Applies To: Windows Server 2016, Windows Server 2019
  
To create and run virtual machines, install the Hyper-V role on Windows Server by using Server Manager or the **Install-WindowsFeature** cmdlet in Windows PowerShell. 
For Windows 10, see [Install Hyper-V on Windows 10](https://docs.microsoft.com/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v).

To learn more about Hyper-V, see the [Hyper-V Technology Overview](../Hyper-V-Technology-Overview.md). To try out Windows Server 2019, you can download and install an evaluation copy. See the [Evaluation Center](https://www.microsoft.com/evalcenter/evaluate-windows-server-2019).

Before you install Windows Server or add the Hyper-V role, make sure that:
- Your computer hardware is compatible. For details, see [System Requirements for Windows Server](../../../get-started/System-Requirements.md) and [System requirements for Hyper-V on Windows Server](../System-requirements-for-Hyper-V-on-Windows.md).
- You don't plan to use third-party virtualization apps that rely on the same processor features that Hyper-V requires. Examples include VMWare Workstation and VirtualBox. You can install Hyper-V without uninstalling these other apps. But, if you try to use them to manage virtual machines when the Hyper-V hypervisor is running, the virtual machines might not start or might run unreliably. For details and instructions for turning off the Hyper-V hypervisor if you need to use one of these apps, see [Virtualization applications do not work together with Hyper-V, Device Guard, and Credential Guard](https://support.microsoft.com/help/3204980/virtualization-applications-do-not-work-together-with-hyper-v-device-g).

If you want to install only the management tools, such as Hyper-V Manager, see [Remotely manage Hyper-V hosts with Hyper-V Manager](../Manage/Remotely-manage-Hyper-V-hosts.md).
  
## Install Hyper-V by using Server Manager  
  
1. In **Server Manager**, on the **Manage** menu, click **Add Roles and Features**.  
  
2. On the **Before you begin** page, verify that your destination server and network environment are prepared for the role and feature you want to install. Click **Next**.  
  
3. On the **Select installation type** page, select **Role-based or feature-based installation** and then click **Next**.  
  
4. On the **Select destination server** page, select a server from the server pool and then click **Next**.  
  
5. On the **Select server roles** page, select **Hyper-V**.  
  
6. To add the tools that you use to create and manage virtual machines, click **Add Features**. On the Features page, click **Next**.  
  
7. On the **Create Virtual Switches** page, **Virtual Machine Migration** page, and **Default Stores** page, select the appropriate options.  
  
8. On the **Confirm installation selections** page, select **Restart the destination server automatically if required**, and then click **Install**.  
  
9. When installation is finished, verify that Hyper-V installed correctly. Open the **All Servers** page in Server Manager and select a server on which you installed Hyper-V. Check the **Roles and Features** tile on the page for the selected server.  
  
## Install Hyper-V by using the Install-WindowsFeature cmdlet  
  
1. On the Windows desktop, click the Start button and type any part of the name **Windows PowerShell**.  
  
2. Right-click Windows PowerShell and select **Run as Administrator**.  
  
3. To install Hyper-V on a server you're connected to  remotely, run the following command and replace `<computer_name>` with the name of server.  
  
    ```powershell
    Install-WindowsFeature -Name Hyper-V -ComputerName <computer_name> -IncludeManagementTools -Restart  
    ```  
  
    If you're connected locally to the server, run the command without `-ComputerName <computer_name>`.  
  
4. After the server restarts, you can see that the Hyper-V role is installed and see what other roles and features are installed by running the following command:  
  
    ```powershell
    Get-WindowsFeature -ComputerName <computer_name>  
    ```  
  
    If you're connected locally to the server, run the command without `-ComputerName <computer_name>`.  
  
> [!NOTE]  
> If you install this role on a server that runs the Server Core installation option of Windows Server 2016 and use the parameter `-IncludeManagementTools`, only the Hyper-V Module for Windows PowerShell is installed. You can use the GUI management tool, Hyper-V Manager, on another computer to remotely manage a Hyper-V host that runs on a Server Core installation. For instructions on connecting remotely, see [Remotely manage Hyper-V hosts with Hyper-V Manager](../Manage/Remotely-manage-Hyper-V-hosts.md).  
  
## See also  
  
- [Install-WindowsFeature](https://docs.microsoft.com/powershell/module/Microsoft.Windows.ServerManager.Migration/Install-WindowsFeature)  
