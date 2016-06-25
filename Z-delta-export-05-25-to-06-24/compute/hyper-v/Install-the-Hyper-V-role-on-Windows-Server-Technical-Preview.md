---
title: Install the Hyper-V role on Windows Server Technical Preview
H1: na
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 8e871317-09d2-4314-a6ec-ced12b7aee89
---
# Install the Hyper-V role on Windows Server Technical Preview
**This is preliminary content and subject to change.**  
  
To create and run virtual machines, install Hyper\-V on  [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)] by using  Server Manager or by using the Install\-WindowsFeature cmdlet in [!INCLUDE[wps_2](../Token/wps_2_md.md)].  To install the Hyper\-V role on a Nano Server, see [Getting Started with Nano Server](../../compute/hyper-v/Getting-Started-with-Nano-Server.md). For [!INCLUDE[winthreshold_client_2_md](/Token/winthreshold_client_2_md.md)], see [Install Hyper-V on Windows 10](https://msdn.microsoft.com/virtualization/hyperv_on_windows/quick_start/walkthrough_install).    
  
Before you install [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)] or enable Hyper-V, make sure your system is compatible. For more information, see [System Requirements for Windows Server](System%20Requirements%20%20and%20Installation.md) and [System requirements for Hyper-V on Windows Server 2016](../../compute/hyper-v/System-requirements-for-Hyper-V-on-Windows-Server-2016-Technical-Preview.md). Install the Hyper-V role after you [download and install Windows Server 2016 Technical Preview](http://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-technical-preview).    
  
## <a name="BKMK_SERV"></a>Install Hyper\-V role by using Server Manager  
  
1.  In **Server Manager**, on the **Manage** menu, click **Add Roles and Features**.  
  
2.  On the **Before you begin** page, verify that your destination server and network environment are prepared for the role and feature you want to install. Click **Next**.  
  
3.  On the **Select installation type** page, select **Role\-based or feature\-based installation** and then click **Next**.  
  
4.  On the **Select destination server** page, select a server from the server pool and then click **Next**.  
  
5.  On the **Select server roles** page, select **Hyper\-V**.  
  
6.  To add the tools that you use to create and manage virtual machines, click **Add Features**. On the Features page, click **Next**.  
  
7.  On the **Create Virtual Switches** page, **Virtual Machine Migration** page, and **Default Stores** page, select the appropriate options.  
  
8.  On the **Confirm installation selections** page, select **Restart the destination server automatically if required**, and then click **Install**.  
  
9. When installation is finished, verify that Hyper\-V installed correctly. Open the **All Servers** page in [!INCLUDE[sm](../Token/sm_md.md)] and select a server on which you installed Hyper\-V. Check the **Roles and Features** tile on the page for the selected server.  
  
## <a name="BKMK_PWRSH"></a>Install Hyper\-V role by using [!INCLUDE[wps_2](../Token/wps_2_md.md)]   
  
1.  On the Windows desktop, click the Start button and type any part of the name **Windows PowerShell**.  
  
2.  Right\-click [!INCLUDE[wps_2](../Token/wps_2_md.md)] and select **Run as Administrator**.  
  
3.  To install Hyper\-V on a server you're connected to  remotely, run the following command and  replace <computer\_name> with the name of server.  
  
    ```  
    Install-WindowsFeature –Name Hyper-V -ComputerName <computer_name> -IncludeManagementTools -Restart  
    ```  
  
    If you're connected locally to the server, run the command without `-ComputerName <computer_name>`.  
  
4.  After the server restarts, you can see that the Hyper\-V role is installed and see what other roles and features are installed  by running the following command.  
  
    ```  
    Get-WindowsFeature -ComputerName <computer_name>  
    ```  
  
    If you're connected locally to the server, run the command without `-ComputerName <computer_name>`.  
  
> [!NOTE]  
> If you install this role on a server that runs the Server Core installation option of [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)] and use the parameter `-IncludeManagementTools`, only the Hyper\-V Module for [!INCLUDE[wps_2](../Token/wps_2_md.md)] will be installed. You can use the GUI management tool, Hyper\-V Manager,  on another computer to remotely manage a Hyper\-V host that runs on a Server Core installation.   To remotely manage a Hyper\-V host server from a computer that runs [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)], see [Install Hyper-V on Windows 10](https://msdn.microsoft.com/virtualization/hyperv_on_windows/quick_start/walkthrough_install).  
  
## See also  
  
-   [Install-WindowsFeature](http://technet.microsoft.com/jj205467.aspx)  
  
