---
title: Start the DFS Replication Service and Netlogon Service
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 2184276a-a728-4856-9fb2-c11077ed9b25
author: Femila
---
# Start the DFS Replication Service and Netlogon Service
  After you relocate the SYSVOL tree or the SYSVOL staging area, or both, use this procedure to restart the Distributed File System \(DFS\) Replication service, the Netlogon service, or both. After you restart the service or services, review the event log to ensure that the services restarted successfully.  
  
 You can use the Windows graphical user interface \(GUI\) or the command line to start the DFS Replication service and the Netlogon service.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To start the DFS Replication service or Netlogon service, or both, by using the Windows GUI  
  
1.  On the **Start** menu, point to **Administrative Tools** and then click **Services**.  
  
2.  In the **Name** column, right\-click **DFS Replication** or **Netlogon**, and then click **Restart**.  
  
### To start the DFS Replication service or Netlogon service, or both, by using the command line  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  To start the DFS Replication service, at the command prompt, type the following command, and then press ENTER:  
  
    ```  
    net start dfsr  
    ```  
  
3.  To start the Netlogon service, at the command prompt, type the following command, and then press ENTER:  
  
    ```  
    net start netlogon  
    ```  
  
> [!NOTE]  
>  You can use Event Viewer to verify that DFS Replication restarted correctly. In the DFS Replication log \(in Applications and Services Logs\), Event ID 1004 indicates that the service restarted. Look for Event IDs 1210, 1206, and 6102 to verify that the domain controller is running and ready for service. If you moved SYSVOL to a new location or relocated the staging areas folder, look for Event IDs 4604 and 6018, which indicate success. Event ID 7036 in the System event log reports that the Netlogon service is running. This event reports on all services that are stopped or started.  
>   
>  Also verify that the Netlogon service is sharing the sysvol \(SYSVOL share\) and scripts \(NETLOGON share\) folders. At a command prompt, type `net share`, and then press ENTER.  
  
  