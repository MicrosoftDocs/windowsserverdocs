---
title: Uninstall Windows PowerShell Web Access
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: acaccee1-a376-4a9a-a410-d7568c91e4c2
author: jpjofre
---
# Uninstall Windows PowerShell Web Access
Follow steps in this topic to delete the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] website and application from the gateway server that is running [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]. Before you begin, notify users of the web\-based console that you are removing the website.  
  
## <a name="BKMK_uninstall"></a>Uninstalling Windows PowerShell Web Access  
Before you uninstall [!INCLUDE[pswa_2](includes/pswa_2_md.md)] from the gateway server, either run the `Uninstall-PswaWebApplication` cmdlet to remove the website and [!INCLUDE[pswa_2](includes/pswa_2_md.md)] web applications, or use the IIS Manager procedure, [To delete the Windows PowerShell Web Access website and web applications](#BKMK_delsite).  
  
Uninstalling [!INCLUDE[pswa_2](includes/pswa_2_md.md)] does not uninstall IIS or any other features that were installed automatically because [!INCLUDE[pswa_2](includes/pswa_2_md.md)] requires them to run. The uninstallation process leaves features installed upon which [!INCLUDE[pswa_2](includes/pswa_2_md.md)] was dependent; you can uninstall those features separately if needed.  
  
## Recommended \(quick\) uninstallation  
Procedures in this section help you uninstall both the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] web application and the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] feature by using [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets.  
  
### Step 1: Delete the web application  
If you have specified your own, custom website name, add the `WebsiteName` parameter to your command, and specify the website name. If you have used a custom web application \(not the default application, **pswa**, add the `WebApplicationName` parameter to your command, and specify the name of the web application.  
  
##### To delete the website and web applications by using the Uninstall\-PswaWebApplication cmdlet  
  
1.  Do one of the following to open a [!INCLUDE[wps_2](includes/wps_2_md.md)] session.  
  
    -   On the Windows desktop, right\-click **Windows PowerShell** on the taskbar.  
  
    -   On the Windows **Start** screen, click **Windows PowerShell**.  
  
2.  Type **Uninstall\-PswaWebApplication**, and then press **Enter**.  
  
3.  If you are using a test certificate, add the `DeleteTestCertificate` parameter to the cmdlet, as shown in the following example.  
  
    ```  
    Uninstall-PswaWebApplication -DeleteTestCertificate  
    ```  
  
### Step 2: Uninstall Windows PowerShell Web Access  
  
##### To uninstall Windows PowerShell Web Access by using Windows PowerShell cmdlets  
  
1.  Do one of the following to open a [!INCLUDE[wps_2](includes/wps_2_md.md)] session with elevated user rights. If a session is already open, go on to the next step.  
  
    -   On the Windows desktop, right\-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.  
  
    -   On the Windows **Start** screen, right\-click **Windows PowerShell**, and then click **Run as Administrator**.  
  
2.  Type the following, and then press **Enter**, where *computer\_name* represents a remote server from which you want to remove [!INCLUDE[pswa_2](includes/pswa_2_md.md)]. The `–Restart` parameter automatically restarts destination servers if required by the removal.  
  
    ```  
    Uninstall-WindowsFeature –Name WindowsPowerShellWebAccess -ComputerName <computer_name> -Restart  
    ```  
  
    To remove roles and features from an offline VHD, you must add both the `-ComputerName` parameter and the `-VHD` parameter. The `-ComputerName` parameter contains the name of the server on which to mount the VHD, and the `-VHD` parameter contains the path to the VHD file on the specified server.  
  
    ```  
    Uninstall-WindowsFeature –Name WindowsPowerShellWebAccess –VHD <path> -ComputerName <computer_name> -Restart  
    ```  
  
3.  When removal is finished, verify that you removed [!INCLUDE[pswa_2](includes/pswa_2_md.md)] by opening the **All Servers** page in [!INCLUDE[sm](includes/sm_md.md)], selecting a server from which you removed the feature, and viewing the **Roles and Features** tile on the page for the selected server. You can also run the `Get-WindowsFeature` cmdlet targeted at the selected server \(Get\-WindowsFeature \-ComputerName <*computer\_name*>\) to view a list of roles and features that are installed on the server.  
  
## Custom uninstallation  
Procedures in this section help you uninstall both the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] web application and the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] feature by using the [!INCLUDE[rrfw](includes/rrfw_md.md)] in [!INCLUDE[sm](includes/sm_md.md)], and the IIS Manager console.  
  
### Step 1: Delete the web application  
  
#### <a name="BKMK_delsite"></a>To delete the Windows PowerShell Web Access website and web applications by using IIS Manager  
  
1.  Open the IIS Manager console by doing one of the following. If it is already open, go on to the next step.  
  
    -   On the Windows desktop, start [!INCLUDE[sm](includes/sm_md.md)] by clicking **Server Manager** in the Windows taskbar. On the **Tools** menu in [!INCLUDE[sm](includes/sm_md.md)], click **Internet Information Services \(IIS\) Manager**.  
  
    -   On the Windows **Start** screen, type any part of the name **Internet Information Services \(IIS\) Manager**. Click the shortcut when it is displayed in the **Apps** results.  
  
2.  In the IIS Manager tree pane, select the website that is running the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] web application.  
  
3.  In the **Actions** pane, under **Manage Website**, click **Stop**.  
  
4.  In the tree pane, right\-click the web application in the website that is running the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] web application, and then click **Remove**.  
  
5.  In the tree pane, select **Application Pools**, select the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] application pool folder, click **Stop** in the **Actions** pane, and then click **Remove** in the content pane.  
  
6.  Close IIS Manager.  
  
    > [!NOTE]  
    > The certificate is not deleted during uninstallation. If you created a self\-signed certificate or used a test certificate and want to remove it, delete the certificate in IIS Manager.  
  
### Step 2: Uninstall Windows PowerShell Web Access  
  
##### To uninstall Windows PowerShell Web Access by using the Remove Roles and Features Wizard  
  
1.  If [!INCLUDE[sm](includes/sm_md.md)] is already open, go on to the next step. If [!INCLUDE[sm](includes/sm_md.md)] is not already open, open it by doing one of the following.  
  
    -   On the Windows desktop, start [!INCLUDE[sm](includes/sm_md.md)] by clicking **Server Manager** in the Windows taskbar.  
  
    -   On the Windows **Start** screen, click **Server Manager**.  
  
2.  On the **Manage** menu, click **Remove Roles and Features**.  
  
3.  On the **Select destination server** page, select the server or offline VHD from which you want to remove the feature. To select an offline VHD, first select the server on which to mount the VHD, and then select the VHD file. After you have selected the destination server, click **Next**.  
  
4.  Click **Next** again to skip to the **Remove features** page.  
  
5.  Clear the check box for **Windows PowerShell Web Access**, and then click **Next**.  
  
6.  On the **Confirm removal selections** page, click **Remove**.  
  
## See Also  
[Install and Use Windows PowerShell Web Access](Install-and-Use-Windows-PowerShell-Web-Access.md)  
[IIS Manager 7.0 Help](http://technet.microsoft.com/library/cc732664.aspx)  
  

