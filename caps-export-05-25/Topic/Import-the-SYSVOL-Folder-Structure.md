---
title: Import the SYSVOL Folder Structure
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: ef38f989-a50f-4b83-bfb9-edb8bc1fa69d
author: Femila
---
# Import the SYSVOL Folder Structure
  If a domain controller has a nonfunctioning SYSVOL, you can use this procedure to rebuild SYSVOL on the domain controller by copying the SYSVOL folder structure on another domain controller and importing it to the offline domain controller, which cannot operate as a domain controller without a functioning SYSVOL. To properly import SYSVOL, you must copy the SYSVOL folder and its contents.  
  
 In this procedure, you copy an existing SYSVOL folder structure on a healthy, online domain controller to the target domain controller, which has a failed SYSVOL. After you delete the failed SYSVOL folder, you copy the healthy SYSVOL folder structure to the same location as the original \(deleted\) SYSVOL folder.  
  
 This procedure has the following preliminary requirements:  
  
-   You have identified a replication partner domain controller whose SYSVOL folder structure you will copy.  
  
-   You have restarted the domain controller to which you are importing SYSVOL in Directory Services Restore Mode \(DSRM\).  
  
-   You have stopped the Netlogon service on the target domain controller after restarting the domain controller in DSRM. The Distributed File System \(DFS\) Replication service is stopped automatically when you restart the domain controller in DSRM.  
  
-   The default shared folder ADMIN$ must exist on the domain controller from which you plan to copy the SYSVOL folder structure. Some organizations remove this shared folder or rename it for security reasons. If this shared folder is not available, you must share the %systemroot% folder and name the share ADMIN$.  
  
    > [!NOTE]  
    >  To view the shared folders to see whether ADMIN$ is shared, on the source domain controller, open Server Manager. In the navigation pane for the domain controller, view **Roles** and **File Services**, and then click **Share and Storage Management**. As an alternative, you can open a command prompt and type `net share` at the command prompt.  
  
-   If the ADMIN$ share has been renamed, use the name that is assigned by your organization instead of ADMIN$ as you complete this procedure.  
  
-   You have determined the target domain controller values for rows 4 \(Sysvol junction point\) and 5 \(Staging areas junction point\) in the table you that created in [Gather the SYSVOL Path Information](../Topic/Gather-the-SYSVOL-Path-Information.md).  
  
 This procedure has the following follow\-up requirements:  
  
-   If you share the %systemroot% folder on the source domain controller to complete this procedure, be sure to remove the share after the procedure is complete to maintain any security policies that are established on your network.  
  
-   On the target domain controller, perform the verification tests in [Check the Status of the SYSVOL and Netlogon Shares](../Topic/Check-the-Status-of-the-SYSVOL-and-Netlogon-Shares.md).  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure on the domain controller from which you are copying SYSVOL. The DSRM administrator password is the minimum required to complete this procedure on the controller to which you are importing SYSVOL. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To import the SYSVOL folder structure  
  
1.  On the domain controller to which you are importing the SYSVOL folder structure, open Windows Explorer.  
  
2.  Navigate to the existing SYSVOL folder that you are rebuilding, and then delete it.  
  
3.  Map a network drive to the **ADMIN$** shared directory on the domain controller that you identified earlier as the replication partner from which you plan to copy the SYSVOL folder structure.  
  
4.  When you are connected to the **ADMIN$** share, verify that a folder labeled **SYSVOL** appears. Right\-click the **SYSVOL** folder, and then click **Copy**.  
  
5.  In the same ADMIN$ shared directory, right\-click some blank space, and then click **Paste**.  
  
6.  Verify that the original **SYSVOL** folder and a new folder labeled **SYSVOL – Copy** both appear. Right\-click **SYSVOL \- Copy**, and then click **Rename**. Type **SYSVOL2**, and then press ENTER.  
  
7.  Open a Command Prompt. At the command prompt, change to the drive letter that represents the connection to the remote domain controller where you created the **SYSVOL2** folder.  
  
8.  Change the directory to `SYSVOL2\sysvol`.  
  
9. Type `dir /a:L`, and then press ENTER. Verify that `<JUNCTION>` appears in the command output and that it is followed by the name of the domain.  
  
10. You must update the path in this junction point so that it references the new location on the target domain controller. At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    mklink <FQDN> <newpath>  
    ```  
  
     Where `<FQDN>` is the fully qualified domain name \(FQDN\) and `<newpath>` is the new value that you recorded in row 4 of the table in [Gather the SYSVOL Path Information](../Topic/Gather-the-SYSVOL-Path-Information.md).  
  
11. If the staging areas subfolder has been relocated and it is no longer inside the SYSVOL folder, skip steps 11 and 12, and proceed to step 13. If the staging areas subfolder has not been relocated, at a command prompt, change the directory to `\SYSVOL2\staging areas` under the copy of SYSVOL that you created. Type `dir` to list the contents, and verify that `<JUNCTION>` appears in the output of the `dir` command.  
  
12. Update the junction so that it points to the new location on the target domain controller. At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    linkd <junctionname> <newpath>  
    ```  
  
     Where `<newpath>` is the new value that you recorded in row 5 of the table in [Gather the SYSVOL Path Information](../Topic/Gather-the-SYSVOL-Path-Information.md).  
  
13. At the command prompt, change back to the %systemroot% directory for the domain controller that is receiving the imported SYSVOL.  
  
14. At the command prompt, use the **robocopy** command\-line tool to copy the contents of the \\SYSVOL2 folder that you created to a new SYSVOL folder on your local drive. At the command prompt, type the following command, and then press ENTER:  
  
     `robocopy <Source Folder> <Destination Folder> /copyall /mir /b /r:0 /xd "DfsrPrivate" /xf "DfsrPrivate"`  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |\<Source Folder\>|Drive letter and path to the SYSVOL2 directory on the source domain controller.|  
    |\<Destination Folder\>|Drive letter and path to the parent location of the SYSVOL folder that you deleted in step 2 on the local domain controller. For example, if you deleted the original SYSVOL folder from C:\\Windows\\SYSVOL, the path in \<Destination Folder\> is C:\\Windows.|  
    |\/copyall|Copies the following file information: data, attributes, time stamps, NTFS access control list \(ACL\), owner information, and auditing information.|  
    |\/mir|Mirrors the directory tree that you are copying.|  
    |\/b|Copies files in backup mode. Backup mode allows Robocopy to override file and folder permission settings \(ACLs\).|  
    |\/r:0|Specifies performing 0 \(zero\) retries on failed copies.|  
    |\/xd "DfsrPrivate"|Excludes the DfsrPrivate directory from the copy.|  
    |\/xf "DfsrPrivate"|Excludes the DfsrPrivate file from the copy.|  
  
15. Verify that the folder structure copied correctly. Compare the new folder structure to the SYSVOL \(not SYSVOL2\) folder structure on the remote \(source\) domain controller. Open a command prompt, and type `dir /s` to list the contents of the folders and subfolders. Ensure that all folders exist.  
  
16. Delete the SYSVOL2 folder that you created on the remote domain controller.  
  
17. If you shared the %systemroot% folder and created an ADMIN$ share on the remote domain controller, remove the ADMIN$ share. Disconnect from the remote domain controller.  
  
18. Restart the domain controller in normal mode.  
  
     When you restart the domain controller, the Netlogon service and the DFS Replication service start automatically.  
  
## See Also  
 [Check the Status of the SYSVOL and Netlogon Shares](../Topic/Check-the-Status-of-the-SYSVOL-and-Netlogon-Shares.md)  
  
  