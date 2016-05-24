---
title: Check the Status of the SYSVOL and Netlogon Shares
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e6d11a98-bdbe-492d-8f84-f5da59e5823a
author: Femila
---
# Check the Status of the SYSVOL and Netlogon Shares
  You can use this procedure to make sure that the Distributed File System \(DFS\) Replication service is started properly and then ensure that the sysvol shared folder and netlogon \(scripts\) shared folder are created and shared.  
  
 For information about checking SYSVOL status for File Replication Service \(FRS\), see the Windows Server 2003 topic Check the status of the shared SYSVOL \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120774](http://go.microsoft.com/fwlink/?LinkId=120774)\).  
  
 Membership in **Domain Admins**, or equivalent, is required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To check the status of the SYSVOL and Netlogon shares  
  
1.  On the **Start** menu, point to **Administrative Tools**, and then click **Services**.  
  
2.  Verify that the **DFS Replication** service and the **Netlogon** service have a status of **Started**. If a service is stopped, click **Restart**.  
  
3.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
4.  To verify that the SYSVOL tree includes the sysvol and scripts shared folders, at the command prompt, type the following command, and then press ENTER:  
  
     `net share`  
  
5.  Check the list to be sure that it includes `%systemroot%\SYSVOL\sysvol\` \(the SYSVOL share\) and `%systemroot%\SYSVOL\sysvol\<Domain Name>\SCRIPTS` \(the NETLOGON share\), where `<Domain Name>` is the domain of the new domain controller.  
  
    > [!NOTE]  
    >  If neither `%systemroot%\SYSVOL\sysvol\` nor `%systemroot%\SYSVOL\sysvol\<Domain Name>\SCRIPTS` are present, see [Verify Active Directory Replication](../Topic/Verify-Active-Directory-Replication.md).  
  
6.  Verify that the proper permissions are set for SYSVOL replication. At the command prompt, type the following command, and then press ENTER:  
  
     `dcdiag /test:netlogons`  
  
     Look for a message that states that `<ComputerName> passed test NetLogons`, where `<ComputerName>` is the name of the domain controller. If you do not see the “passed test” message, check the permissions that are set on the Scripts and Sysvol shared folders. For information about default SYSVOL permissions, see [Reapply Default SYSVOL Security Settings](../Topic/Reapply-Default-SYSVOL-Security-Settings.md).  
  
  