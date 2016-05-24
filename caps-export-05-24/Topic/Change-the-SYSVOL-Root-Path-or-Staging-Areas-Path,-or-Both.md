---
title: Change the SYSVOL Root Path or Staging Areas Path, or Both
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: aa16dced-8161-41f4-b720-ebc77a999b33
author: Femila
---
# Change the SYSVOL Root Path or Staging Areas Path, or Both
  If you are moving the SYSVOL tree or the SYSVOL staging areas tree, or if you are updating these locations after hardware reconfiguration that has resulted in a drive letter change, you can use this procedure to change the SYSVOL root path, the staging areas path, or both in Active Directory Domain Services \(AD DS\).  
  
 Before you perform this procedure, you must stop the Distributed File System \(DFS\) Replication service and the Netlogon service, as described in [Stop the DFS Replication Service and Netlogon Service](../Topic/Stop-the-DFS-Replication-Service-and-Netlogon-Service.md).  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To change the SYSVOL root path or the staging areas path, or both  
  
1.  Click **Start**, point to **Administrative Tools**, and then click **ADSI Edit**.  
  
2.  Right\-click **ADSI Edit**, and then, if the domain whose path information you want to check is not listed, click **Connect to**.  
  
3.  Under **Connection Point**, click **Select a well known Naming Context**, click **Default naming context**, and then click **OK**.  
  
4.  In the console tree, expand the domain component, and then expand **OU\=Domain Controllers**.  
  
5.  Double\-click the container that represents a domain controller on which you can check the path information, double\-click **CN\=DFSR\-LocalSettings**, and then click **CN\=Domain System Volume**.  
  
6.  In the details pane, right\-click **CN\=SYSVOL Subscription**, and then click **Properties**.  
  
7.  Click **Filter**. Ensure that **Show mandatory attributes** is selected. Select this option if it is not selected.  
  
8.  In **Attributes**, double\-click one or both of the following:  
  
    -   **msDFSR\-RootPath** to change the SYSVOL root path.  
  
    -   **msDFSR\-StagingPath** to change the SYSVOL staging areas path.  
  
9. In **Value**, type the new folder path, and then click **OK**.  
  
10. Click **OK** to close the **CN\=Subscription Properties** dialog box.  
  
## See Also  
 [Start the DFS Replication Service and Netlogon Service](../Topic/Start-the-DFS-Replication-Service-and-Netlogon-Service.md)  
  
  