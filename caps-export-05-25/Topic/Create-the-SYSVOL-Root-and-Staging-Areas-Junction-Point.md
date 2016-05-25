---
title: Create the SYSVOL Root and Staging Areas Junction Point
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: dd5d6a9a-9d3f-47f5-bc10-042bca2abc0e
author: Femila
---
# Create the SYSVOL Root and Staging Areas Junction Point
  If you move the SYSVOL tree, you must create a junction point that is named for the fully qualified domain name \(FQDN\) of the domain. You create this junction point under \<NewLocationForSYSVOL\>\\sysvol\\domain. The junction point must point to \<NewLocationForSYSVOL\>\\domain. If you move the tree or if hardware reconfiguration results in a change in the drive letter, you must recreate the SYSVOL junction point for the new location.  
  
 You should also re\-create the junction point for the staging areas folder.  
  
 To perform this procedure, you can use the Mklink.exe command\-line tool, which is included with [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To create the sysvol root junction point  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, change the directory to the new sysvol root location, for example, *FolderName*\\SYSVOL\\sysvol.  
  
3.  To create the junction point for the sysvol root, at the command prompt, type the following command, and then press ENTER:  
  
     `mklink /J <FQDN> <New sysvol root junction path>`  
  
     Example: `mklink /J contoso.com D:\ContosoRoot\SYSVOL\domain`  
  
    |Parameter|Definition|  
    |---------------|----------------|  
    |**mklink \/J**|Creates a junction point for the specified domain in the specified path location.|  
    |\<FQDN\>|The fully qualified domain name of the SYSVOL domain|  
    |\<New sysvol root junction path\>|The drive letter and path to the SYSVOL root, for example, *Drive*:\\*FolderName*\\SYSVOL\\domain or *Drive*:\\*FolderName*\\SYSVOL\_DFSR\\domain if SYSVOL has been migrated from File Replication Service \(FRS\) to Distributed File System \(DFS\) Replication|  
  
4.  Create the junction point for the staging areas folder. Change directories to *FolderName*\\sysvol\\staging areas, and type the following command, and then press ENTER:  
  
    ```  
    mklink /J <FQDN> <New staging areas junction path>  
    ```  
  
     For example: `mklink /J contoso.com c:\NewSYSVOL\staging\domain`  
  
5.  To verify the creation of the junction point, at the command prompt, type the following command, and then press ENTER:  
  
     `dir /a:L`  
  
     Verify the presence of the \<JUNCTION\> folder type and the value that you specified in step 3.  
  
  