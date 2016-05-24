---
title: Reapply Default SYSVOL Security Settings
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 48ae32d0-39b2-472c-aa9f-e85d074c7de6
author: Femila
---
# Reapply Default SYSVOL Security Settings
  When you relocate the entire SYSVOL directory, you can use a **robocopy** command that transfers all security settings with the files when you copy them. Therefore, when you use the procedure in [Administering the Windows Time Service](../Topic/Administering-the-Windows-Time-Service.md) to relocate SYSVOL, updating security settings is not required.  
  
 However, if security settings are in question, you can use this procedure to reapply the default security settings to SYSVOL folders. The settings will be the equivalent of the settings that are set by default during installation of Active Directory Domain Services \(AD DS\). If additional security settings have been applied to SYSVOL folders since AD DS was installed, you must reapply those settings manually after you complete this procedure.  
  
> [!CAUTION]  
>  Failure to reapply security changes that were made after AD DS was installed might result in unauthorized access to logon and logoff scripts and Group Policy objects \(GPOs\).  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To reapply default SYSVOL security settings  
  
1.  Open Notepad, and then enter the following information:  
  
     \[Unicode\]  
  
     Unicode\=yes  
  
     \[Version\]  
  
     signature\="$CHICAGO$"  
  
     Revision\=1  
  
     \[Profile Description\]  
  
     Description\=default perms for sysvol  
  
     \[File Security\]  
  
     ;"%SystemRoot%\\SYSVOL",0,"D:AR\(A;OICI;FA;;;BA\)"  
  
     "%Sysvol%",2,"D:P\(A;CIOI;GRGX;;;AU\)\(A;CIOI;GRGX;;;SO\)\(A;CIOI;GA;;;BA\)\(A;CIOI;GA;;;SY\)\(A;CIOI;GA;;;CO\)"  
  
     "%Sysvol%\\domain\\policies",2,"D:P\(A;CIOI;GRGX;;;AU\)\(A;CIOI;GRGX;;;SO\)\(A;CIOI;GA;;;BA\)\(A;CIOI;GA;;;SY\)\(A;CIOI;GA;;;CO\)\(A;CIOI;GRGWGXSD;;;PA\)"  
  
     Use this file to apply the security settings to the new SYSVOL folders.  
  
    > [!NOTE]  
    >  Do not include a space between the sets of parentheses.  
  
2.  Save this file as Sysvol.inf.  
  
3.  Open a new Command Prompt. Do not use an existing command prompt that has been open on your desktop because it will not have the proper environment settings. Change the directory to the folder where you saved the Sysvol.inf file in step 11.  
  
4.  At the new command prompt, type the following command all on one line, and then press ENTER:  
  
    ```  
    secedit /configure /cfg <path>\sysvol.inf /db <path>\sysvol.db /overwrite  
    ```  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |\/configure|Performs directed configurations.|  
    |\/cfg \<path\> \(to security template\)|Specifies the path where you saved Sysvol.inf in step 11.|  
    |\/db \<path\> \(to database\)|Specifies the path to the database that is used to perform the security configuration. This should be the new path for the SYSVOL folder.|  
    |\/overwrite|Specifies that the database should be emptied before it is imported into the security template. If this parameter is not specified, the settings in the security template are accumulated into the database. If this parameter is not specified and there are conflicting settings in the database and the template that is being imported, the template settings take precedence.|  
  
     Click Y to confirm the overwrite.  
  
  