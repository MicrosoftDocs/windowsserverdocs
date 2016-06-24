---
title: Redirect Users and Computers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b0ffde9f-0d04-46dd-889d-1197955be917
author: Femila
---
# Redirect Users and Computers
The default CN=Users and CN=Computers containers that are created when AD DS is installed are not OUs. Objects in the default containers are more difficult to manage because Group Policy cannot be applied directly to them. New user accounts, computer accounts, and security groups that are created by using earlier versions of user interface (UI) and command-line management tools do not allow administrators to specify a target OU. For this reason, administrators are not allowed to create these objects in either the CN=Computers container or the CN=User container, by default. Examples of these earlier versions include the **net user** and **net computer** commands, the **net group** command, or the **netdom add** command where the **/ou** parameter is either not specified or not supported.  
  
When the domain functional level is Windows Server 2003 or higher, you can redirect the default CN=Users and CN=Computers containers to OUs that you specify so that each can support Group Policy, making them easier to manage.  
  
We recommend that administrators redirect the well-known path for the CN=Users and CN=Computers containers to an OU that is specified by the administrator so that Group Policy can be applied to containers hosting newly created objects. For more information about creating an OU design, see [Designing the Logical Structure for Windows Server 2008 AD DS \[LH\]](assetId:///23d96652-a0d9-4f70-9742-514110c99da6).  
  
> [!IMPORTANT]  
> The CN=Users and CN=Computers containers are computer-protected objects. For backward-compatibility reasons, you cannot (and must not) remove them. However, you can rename these objects.  
  
Membership in **Domain Admins** or **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](includes/review_details_md.md)]  
  
### To redirect the CN=Users container  
  
1.  Use the Active Directory Users and Computers snap-in to create an OU container to which you will redirect user objects that were created with earlier versions of UI and command-line management tools:  
  
    1.  To open the Active Directory Users and Computers snap-in, click **Start**, click **Control Panel**, double-click **Administrative Tools**, and then double-click **Active Directory Users and Computers**.  
  
    2.  In the console tree, right-click the domain name.  
  
    3.  Point to **New**, and then click **Organizational Unit**.  
  
    4.  Type the name of the OU.  
  
2.  At the command line, change to the System32 folder by typing:  
  
    **cd %systemroot%\system32**  
  
3.  Type the following, where **<newuserou>** is the name of the new user OU, and **<domainname>** is the name of the domain:  
  
    **redirusr ou=<newuserou>,DC=<domainname>,dc=com**  
  
### To redirect the CN=Computers container  
  
1.  Use the Active Directory Users and Computers snap-in to create an OU container to which you will redirect computer objects that were created with earlier versions of UI and command-line management tools.  
  
    1.  To open Active Directory Users and Computers, click **Start**, click **Control Panel**, double-click **Administrative Tools**, and then double-click **Active Directory Users and Computers**.  
  
    2.  In the console tree, right-click the domain name.  
  
    3.  Point to **New**, and then click **Organizational Unit**.  
  
    4.  Type the name of the OU.  
  
2.  At the command line, change to the System32 folder by typing:  
  
    **cd %systemroot%\system32**  
  
3.  Type the following, where **<newcomputerou>** is the name of the new computer OU, and **<domainname>** is the name of the domain:  
  
    **redircmp ou=<newcomputerou>,DC=<domainname>,dc=com**  
  
## Change History  
  
|Date|Revision|  
|--------|------------|  
|June 29, 2010|Clarified that the redirection procedures are appropriate for all domains at Windows Server 2003 domain functional level or higher. The topic originally incorrectly indicated that only domain controllers that run Windows 2000 require them.|  
  

