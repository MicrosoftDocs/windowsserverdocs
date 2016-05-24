---
title: Step 4: Verify the WSUS Migration
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6bd90de9-ac6e-46cb-8243-8cb43fc6a151
author: britw
---
# Step 4: Verify the WSUS Migration
The final step in the migration of your Windows Server Update Services \(WSUS\) server role is to verify that the migration was performed correctly and if the clients can obtain updates from the new WSUS server.  
  
|Task|Description|  
|--------|---------------|  
|[4.1. Verify the destination server configuration](../Topic/Step-4--Verify-the-WSUS-Migration.md#BKMK_1.1)|Verify if the destination server is synchronized.|  
|[4.2. Verify client computer functionality](../Topic/Step-4--Verify-the-WSUS-Migration.md#BKMK_1.2)|Verify if the clients are correctly obtaining updates from the new WSUS server.|  
  
## <a name="BKMK_1.1"></a>4.1. Verify the destination server configuration  
Perform the following procedure on the new WSUS destination server to verify that it is configured properly and functioning correctly before you point the WSUS clients and any downstream servers to the new WSUS server.  
  
1.  In Server Manager, click **Tools**, and then click **Windows Server Update Services**.  
  
2.  In the WSUS Administration Console, expand **Computers**, and verify that all the Computer Groups that existed on the source server are displayed.  
  
3.  Expand **Synchronizations**. In the **Actions** pane, click **Synchronize now**. After the synchronization is complete, \(this may take several minutes\), confirm that **Succeeded** is displayed in the **Results** column.  
  
If the synchronization fails, click **Options**. Confirm that the **Update Source and Proxy Server** settings and password are correct. Confirm that the firewall access is configured correctly for the new server’s environment. Make the necessary changes, and then run the synchronization again.  
  
## <a name="BKMK_1.2"></a>4.2. Verify client computer functionality  
Select a client computer so that you can force a detection to verify that the client and server communication is functioning correctly. Use the ollowing procedure to perform this verification:  
  
1.  Open a command prompt and type `wuauclt.exe /detectnow` to force the detection.  
  
2.  After the detection is finished, open Windows Explorer and check the **%WinDir%\\WindowsUpdate.log** to verify that the forced detection was successful.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 3: Migrate WSUS](../Topic/Step-3--Migrate-WSUS.md)  
  
-   [WSUS server role description](assetId:///77f5db8a-4b8f-4bd5-8493-387310adf46e#BKMK_OVER)  
  
