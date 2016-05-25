---
title: Create the SYSVOL Staging Areas Folder Structure
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 2acdccc8-8ca2-4b10-afd2-e582893968ca
author: Femila
---
# Create the SYSVOL Staging Areas Folder Structure
  You can use this procedure to create the SYSVOL staging areas subdirectory folder structure when you move the staging areas tree to a new location. The %systemroot%\\SYSVOL\\staging areas folder is the top of the staging areas tree in SYSVOL. To move the staging areas tree properly, you must select and copy the contents of %systemroot%\\SYSVOL\\staging areas. A different subfolder of %systemroot%\\SYSVOL is named staging. Ensure that you select the contents of the staging areas subfolder \(%systemroot%\\SYSVOL\\staging areas\) and not the staging subfolder \(%systemroot%\\SYSVOL\\staging\).  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To create the SYSVOL staging areas folder structure  
  
1.  In Windows Explorer, create a new folder for the new location of the staging areas folder.  
  
2.  Navigate to the folder that represents the top of your current staging areas tree. By default, this folder is %systemroot%\\SYSVOL\\staging areas.  
  
3.  In the console tree, right\-click the **staging areas** folder, and then click **Copy**.  
  
4.  In the console tree, navigate to the new folder that you created for the staging areas tree, right\-click the folder, and then click **Paste**.  
  
    > [!NOTE]  
    >  This folder must be empty when you paste the staging areas folders.  
  
5.  Verify that the folder structure was copied correctly. To compare the new folder structure to the original, open a command prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
6.  Change directories to the new staging areas folder. To list the contents of the folder and subfolders, type the following command, and then press ENTER:  
  
    ```  
    dir /s  
    ```  
  
     Ensure that all folders exist. If any folders are missing at the new location \(such as \\scripts\), re\-create them.  
  
  