---
title: Verify SYSVOL is shared in the new location
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 592ecce6-8625-444b-9277-3e2358b2ac6b
author: Femila
---
# Verify SYSVOL is shared in the new location
  You can use this procedure to reset the SYSVOLReady registry entry value to 1 and to ensure that the SYSVOL shared folder and netlogon \(scripts\) shared folder are created and shared. The SYSVOLReady registry entry was set to 0 temporarily to allow the copy of the SYSVOL folder. After the copy is complete, you need to set the SYSVOLReady registry entry value back to 1  
  
 Membership in **Domain Admins**, or equivalent, is required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To reset the SYSVOLReady registry entry to 1  
  
1.  Click **Start**, click **Run**, type **regedit**, and then press ENTER.  
  
2.  Navigate to **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters**.  
  
3.  Right\-click **SysvolReady**, and then click **Modify**.  
  
4.  In the **Value data** box, type **0**, and then click **OK**.  
  
5.  Close Registry Editor.  
  
### To check the status of the SYSVOL and Netlogon shares  
  
1.  Open an elevated command prompt, type the following command, and then press ENTER:  
  
     `net share`  
  
2.  Check the list to be sure that it includes `%systemroot%\SYSVOL\sysvol\` \(the SYSVOL share\) and `%systemroot%\SYSVOL\sysvol\<Domain Name>\SCRIPTS` \(the NETLOGON share\), where `<Domain Name>` is the domain of the new domain controller.  
  
    > [!NOTE]  
    >  If neither `%systemroot%\SYSVOL\sysvol\` nor `%systemroot%\SYSVOL\sysvol\<Domain Name>\SCRIPTS` are present, see [Verify Active Directory Replication](../Topic/Verify-Active-Directory-Replication.md).  
  
3.  Verify that the proper permissions are set for SYSVOL replication. At the command prompt, type the following command, and then press ENTER:  
  
     `dcdiag /test:netlogons`  
  
     Look for a message that states that `<ComputerName> passed test NetLogons`, where `<ComputerName>` is the name of the domain controller. If you do not see the “passed test” message, check the permissions that are set on the Scripts and Sysvol shared folders. For information about default SYSVOL permissions, see [Reapply Default SYSVOL Security Settings](../Topic/Reapply-Default-SYSVOL-Security-Settings.md).  
  
  