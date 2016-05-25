---
title: Copy SYSVOL to a New Location
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e2a605b1-69a9-49c8-bd29-b81e54447a5c
author: Femila
---
# Copy SYSVOL to a New Location
  If you want to relocate the SYSVOL directory, you can use this procedure to create the new directory location and copy the SYSVOL folders to the new location. By default, the root of the SYSVOL directory is located at %systemroot%\\SYSVOL. To move SYSVOL properly, you must correctly copy the contents of the SYSVOL folder. A subfolder with the default location of %systemroot%\\SYSVOL is also named sysvol. Ensure that you copy the root folder \(%systemroot%\\SYSVOL\) and not the subfolder \(%systemroot%\\SYSVOL\\sysvol\).  
  
> [!IMPORTANT]  
>  To retain the SYSVOL security settings, you must use the proper **robocopy** command, as described in this procedure. To prevent conflicts, use the updated version of Robocopy available in [Microsoft Knowledge Base article 979808](http://support.microsoft.com/kb/979808). If you perform a simple copy and paste in Windows Explorer, security settings are not copied. In this case, you must reapply security settings. For information about reapplying security settings, see [Reapply Default SYSVOL Security Settings](../Topic/Reapply-Default-SYSVOL-Security-Settings.md). For information about using **robocopy**, see Robocopy \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122544](http://go.microsoft.com/fwlink/?LinkId=122544)\).  
  
 Before you perform this procedure, you must have performed the following procedures:  
  
-   [Identify Replication Partners](../Topic/Identify-Replication-Partners.md). After you relocate SYSVOL, you will force replication of the changes to replication partners so that SYSVOL is updated as soon as possible on other domain controllers.  
  
-   [Check the Status of the SYSVOL and Netlogon Shares](../Topic/Check-the-Status-of-the-SYSVOL-and-Netlogon-Shares.md). Make sure that the sysvol and scrips folders are shared on the domain controller.  
  
-   [Verify Active Directory Replication](../Topic/Verify-Active-Directory-Replication.md). Make sure that you resolve any replication issues before you move SYSVOL.  
  
-   [Gather the SYSVOL Path Information](../Topic/Gather-the-SYSVOL-Path-Information.md). You must have the current path information, and you must also document the new location.  
  
-   [Stop the DFS Replication Service and Netlogon Service](../Topic/Stop-the-DFS-Replication-Service-and-Netlogon-Service.md). Do not make any changes to the SYSVOL location while these services are running.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To copy SYSVOL to a new location  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `robocopy <Source Folder> <Destination Folder> /copyall /mir /b /r:0 /xd "DfsrPrivate" "<domain>" /xf "DfsrPrivate"`  
  
     Where \<domain\> is the fully qualified domain name, such as contoso.com. This Robocopy command will create the destination folder. It will also exclude junction points so you can re\-create them later using mklink.exe without encountering an error. If you do not exclude the junction points, mklink.exe can return an error “Cannot create a file when that file already exists.”.  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |\<Source Folder\>|The path to the SYSVOL directory that you are copying. The default location is %systemroot%\\SYSVOL.|  
    |\<Destination Folder\>|The path to the new SYSVOL location that you created in step 1.|  
    |\/copyall|Copies the following file information: data, attributes, time stamps, NTFS access control list \(ACL\), owner information, and auditing information.|  
    |\/mir|Mirrors the directory tree that you are copying.|  
    |\/b|Copies files in backup mode. Robocopy uses backup mode to override file and folder permission settings \(ACLs\).|  
    |\/r:0|Specifies performing 0 \(zero\) retries on failed copies.|  
    |\/xd "DfsrPrivate" “\<domain\>”|Excludes the DfsrPrivate and domain directory from the copy.|  
    |\/xf "DfsrPrivate"|Excludes the DfsrPrivate file from the copy.|  
  
3.  Verify that the folder structure was copied correctly. To compare the new folder structure to the original, open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
4.  Verify that the folder structure was copied correctly. To compare the new folder structure to the original, change directories to the new SYSVOL folder. To list the contents of the folder and subfolders by size, type the following command, and then press ENTER:  
  
    ```  
    dir /s  
    ```  
  
     Compare the ouptut with the output for the original SYSVOL folder. Ensure that all folders exist and that file sizes are the same. If any folders are missing at the new location \(such as \\scripts\), re\-create them.  
  
5.  Verify that the security settings on the moved SYSVOL are the same as the settings on the original location.  
  
  