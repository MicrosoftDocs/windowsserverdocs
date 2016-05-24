---
title: Permissions on WSUS Directories and Registry Keys
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0eeba30a-390a-4891-8c73-71605c4152f4
author: britw
---
# Permissions on WSUS Directories and Registry Keys
To operate correctly, [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2 requires that permissions for the WSUS web services folders and registry keys be correctly set. This topic describes how to check these permissions.  
  
In this topic:  
  
-   [Access control lists](../Topic/Permissions-on-WSUS-Directories-and-Registry-Keys.md#icacls)  
  
-   [Permissions for WSUS registry keys](../Topic/Permissions-on-WSUS-Directories-and-Registry-Keys.md#reg)  
  
## <a name="icacls"></a>Access control lists  
Use the **icacls** system command to display or modify folder or file access control lists \(ACLs\). The output of this command specifies the level of access and whether the access is inherited. For more information about the **icacls** command, see [Icacls](http://go.microsoft.com/fwlink/?LinkID=203890).  
  
WSUS Setup creates the following web service folders under the **<drive>:\\Program Files\\Update Services folder**, where **<drive>:\\Program Files\\Update Services** is the drive and folder where WSUS is installed.  
  
-   **\\WebServices\\apiremoting30**  
  
-   **\\WebServices\\clientwebservice**  
  
-   **\\WebServices\\dssauthwebservice**  
  
-   **\\WebServices\\reportingwebservice**  
  
-   **\\WebServices\\serversyncwebservice**  
  
-   **\\WebServices\\simpleauthwebservice**  
  
-   **\\Inventory**  
  
-   **\\Selfupdate**  
  
All of these folders, except for the **\\Selfupdate** folder, should have the following ACLs:  
  
-   NT AUTHORITY\\NETWORK SERVICE:\(OI\)\(CI\)R  
  
-   BUILTIN\\Users:\(OI\)\(CI\)R  
  
-   NT AUTHORITY\\Authenticated Users:\(OI\)\(CI\)R  
  
-   BUILTIN\\Administrators:\(OI\)\(CI\)F  
  
-   NT AUTHORITY\\SYSTEM:\(OI\)\(CI\)F  
  
The **\\Selfupdate** folder should have the following ACLs:  
  
-   BUILTIN\\Users:\(OI\)\(CI\)R  
  
-   BUILTIN\\Administrators:\(OI\)\(CI\)F  
  
-   NT AUTHORITY\\SYSTEM:\(OI\)\(CI\)F  
  
### <a name="reg"></a>Permissions for WSUS registry keys  
  
> [!WARNING]  
> [!INCLUDE[Registry](../Token/Registry_md.md)]  
  
The following permissions are set for the registry during WSUS Setup:  
  
-   The **Users** and **WSUS Reporters** groups have **Read** permissions to the **\\HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\Update Services\\Server** registry key.  
  
-   The following accounts must have **Full Control** permissions to the **\\HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\Update Services\\Server\\Setup** registry key:  
  
    -   Network Service  
  
    -   WSUS Administrators  
  
    -   Administrators  
  
    -   System  
  
## See Also  
[Troubleshoot an existing WSUS 3.0 SP2 installation](assetId:///208c8ae1-5f67-4b85-a347-ecb5823f90b3)  
[Secure the WSUS 3.0 SP2 Deployment](assetId:///5c494e41-05d1-4403-ae7b-4fbca2e56cd7)  
[WSUS 3.0 SP2 Security Settings](../Topic/WSUS-3.0-SP2-Security-Settings.md)  
  
