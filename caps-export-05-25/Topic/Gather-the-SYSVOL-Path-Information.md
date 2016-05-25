---
title: Gather the SYSVOL Path Information
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: c7942c67-0b00-4103-8607-b0938e23531f
author: Femila
---
# Gather the SYSVOL Path Information
  When you relocate the SYSVOL tree or staging areas subtree, it is helpful to record the current and new values for the path locations in the SYSVOL tree that are required for SYSVOL to function. By recording these values in advance, you can facilitate the move process.  
  
 When you move SYSVOL, you first copy the folder structure to a new location. Then, you update the locations where folder paths are specified: junction points in the file system, Netlogon parameters in the registry, and attributes in Active Directory Domain Services \(AD DS\). As an option, you can relocate the staging areas subtree and leave the rest of the SYSVOL tree at its original location. In this case, you must update an attribute in AD DS, but the junction point for the staging areas folder is updated automatically. You also have to record this path information when you are rebuilding SYSVOL on one domain controller by importing the SYSVOL of another domain controller.  
  
> [!NOTE]  
>  The instructions in this procedure relate to domains in which Distributed File System \(DFS\) Replication is used to replicate SYSVOL. For information about relocating SYSVOL when you use File Replication Service \(FRS\), see Relocating SYSVOL Manually \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122590](http://go.microsoft.com/fwlink/?LinkId=122590)\).  
  
 For more information about the folder structure and the relationships between the folders and the path information that is stored in the registry, AD DS, and the SYSVOL directory itself, see [Introduction to Administering DFS-Replicated SYSVOL](../Topic/Introduction-to-Administering-DFS-Replicated-SYSVOL.md).  
  
 You can use these procedures to locate the SYSVOL path information and then record the values in the following table. Use the rows and columns in the table according to the goals of your procedure. Record the current values and also the new values if you are moving the SYSVOL tree or the staging areas subtree or if you are rebuilding SYSVOL:  
  
-   Relocating the entire SYSVOL tree: Record the current and new path values in rows 1 through 5.  
  
-   Relocating the staging areas subtree only: Record the current and new path values in rows 2 and 5.  
  
-   Restoring and rebuilding SYSVOL: Record path information as follows:  
  
    -   Record the current values from the domain controller that you are restoring in rows 1, 2, and 3.  
  
    -   In the **Current Value** column in rows 4 and 5, record the values in the junction points that are located on the domain controller from which you are copying the SYSVOL folder structure.  
  
    -   In the **New Value** column in rows 4 and 5, record the values in the junction points that are located on the domain controller whose SYSVOL you are rebuilding.  
  
||Parameter|Current value|New value|  
|------|---------------|-------------------|---------------|  
|1|msDFSR\-RootPath in AD DS|||  
|2|msDFSR\-StagingPath in AD DS|||  
|3|SysVol Netlogon parameter in the registry|||  
|4|Sysvol junction point|||  
|5|Staging areas junction point|||  
  
## To gather the SYSVOL path information  
 Perform the following procedures to gather values for SYSVOL paths and record the data in the preceding table.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To determine the msDFSR\-RootPath and the msDFSR\-StagingPath values in AD DS  
  
1.  Click **Start**, point to **Administrative Tools**, and then click **ADSI Edit**.  
  
2.  Right\-click **ADSI Edit**, and then, if the domain whose path information you want to check is not listed, click **Connect to**.  
  
3.  Under **Connection Point**, click **Select a well known Naming Context**, click **Default naming context**, and then click **OK**.  
  
4.  In the tree view, expand the domain component, and then expand **OU\=Domain Controllers**.  
  
5.  Double\-click the container that represents a domain controller on which you can check the path information, double\-click **CN\=DFSR\-LocalSettings**, and then click **CN\=Domain System Volume**.  
  
6.  In the details pane, right\-click **CN\=SYSVOL Subscription**, and then click **Properties**.  
  
7.  Click **Filter**. Ensure that **Show mandatory attributes** is selected. Select this option if it is not selected.  
  
8.  In **Attributes**, locate **msDFSR\-RootPath** and **msDFSR\-StagingPath**, and then record the current values in rows 1 and 2, respectively, in the previous table. If you are moving SYSVOL, also record the new values for the new location in both rows. If you are moving the staging areas subtree, record the new path value in row 2.  
  
     If the domain controller was migrated to using DFS Replication for SYSVOL, the **msDFSR\-StagingPath** in Active Directory will not have any value. For DFS Replication, if staging path is not set then the default staging path is %sysvolpath%\\domain\\DfsrPrivate\\Staging.  
  
9. Click **Cancel** to close the **CN\=Subscription Properties** dialog box.  
  
#### To determine the SysVol Netlogon parameter value in the registry  
  
1.  Click **Start**, click **Run**, type **regedit**, and then press ENTER.  
  
2.  In Registry Editor, navigate to **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters**.  
  
3.  In the details pane, double\-click **SysVol**. The current value is listed in **Value data**.  
  
4.  Record the current value in row 3 of the previous table, and then click **Cancel** to close the **Edit String** dialog box. If you are moving SYSVOL, also record the new value for the new location.  
  
5.  Close Registry Editor.  
  
#### To determine the value in the sysvol junction point  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, change the directory to %systemroot%\\SYSVOL\\sysvol, or to the current location if SYSVOL has been moved from the default location.  
  
3.  To view the junction point for the sysvol folder, at the command prompt, type the following command, and then press ENTER:  
  
     `dir /a:L`  
  
4.  Record the current value in row 4 in the previous table. If you are moving SYSVOL, also record the new value for the new location.  
  
> [!NOTE]  
>  Do not perform the following procedure if SYSVOL has been migrated from FRS to DFS Replication because there is no junction point value. In that case, the value of the staging area directory is \[*Drive*:\\%systemroot%\\SYSVOL\_DFSR\\staging\\domain\].  
  
#### To determine the value in the staging areas junction point  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, change the directory to %systemroot%\\SYSVOL\\staging areas or to the current location if the staging areas subtree has been moved from the default location.  
  
3.  To view the junction point for the staging areas folder, at the command prompt, type the following command, and then press ENTER:  
  
     `dir /a:L`  
  
4.  The output identifies the \<JUNCTION\> folder type and the value that is stored in the staging areas junction point in brackets. For example, the default value is \[*Drive*:\\%systemroot%\\SYSVOL\\staging\\domain\]. Record the current value in row 5 of the previous table. If you are moving SYSVOL or the staging areas subtree, also record the new value for the new location.  
  
  