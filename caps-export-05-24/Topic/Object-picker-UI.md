---
title: Object picker UI
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 084c5529-77c8-466a-ab4e-2466391b459f
---
# Object picker UI
[!INCLUDE[client_redir](../Token/client_redir_md.md)]  
  
This topic contains examples of object types that you can select when configuring access to various types of computer objects \(for example, ownership and permissions\).  
  
Use the Object Picker control to type the object names that you want to find on the network or the local computer. You can search for multiple objects by separating each name with a semicolon. For information about Active Directory objects that you can specify in this dialog box when your computer is part of a domain, see [Active Directory Domain Services objects](../Topic/Object-picker-UI.md#BKMK_ADobjcts) later in this topic.  
  
|Object Type|Details|Examples|  
|---------------|-----------|------------|  
|Built\-in security principal|Represents default built\-in groups and security principals.<br /><br />To view built\-in principals, type **Users** on the Start screen, click **Edit local users and groups**, and then double\-click **Groups** or **Users**.|**Users:**<br /><br />-   Administrator<br />-   Guest<br /><br />**Groups:**<br /><br />-   Administrators<br />-   Guests<br />-   Users<br />-   Power Users<br />-   Everyone<br />-   Authenticated Users|  
|Computer|Represents a computer's access to network resources.<br /><br />The computer name was established when the operating system was installed. The computer name is recorded on the computer information page in [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]. To view it, type **System** on the Start screen.|CarrollB\-HomeComputer|  
|Group|Can contain users, computers, and other groups as members.<br /><br />To view these security principals, type  **Groups** on the Start screen, click **Edit local users and groups**, and then double\-click **Groups**.|**Client operating system groups:**<br /><br />-   Administrators<br />-   Users<br />-   Power Users<br />-   Guests<br /><br />**Server operating system groups:**<br /><br />-   Administrators<br />-   System Operators<br />-   Users<br />-   Power Users<br />-   Everyone<br />-   Authenticated Users<br />-   Anonymous Logon<br />-   Guests<br />-   System|  
|Users|Allows people to access network resources.<br /><br />To view users who currently have accounts on this local computer, type  **Users** on the Start screen, click **Edit local users and groups**, and then double\-click **Users**.|CarrollB<br /><br />HomeServer\\CarrollB|  
|Contact|Locates information about people. Contact objects cannot be assigned permissions, and therefore, they do not have access to network resources.<br /><br />Local Contact objects can be found in the following directory path on your computer: <drive>\\Users\\<user name>\\Contacts.|Carroll Blythe|  
|Other|Can be created by applications.|Specific for each instance|  
  
## <a name="BKMK_ADobjcts"></a>Active Directory Domain Services objects  
Real\-world objects such as users and computers are represented as objects in Active Directory. And these objects can be contained in other objects called container objects. Active Directory Domain Services supports numerous object types, and each is represented by a unique global identifier.  
  
Each object has a set of attributes that best describe it. For example, consider a user object. Each user can have attributes such as Name, Address, and Telephone number. The objects that can be authenticated and to which permissions can be assigned are called security principals. Each security principal object has a security identifier \(SID\) associated with it, in addition to the global identifier \(GUID\).  
  
|Object Type|Details|Examples|  
|---------------|-----------|------------|  
|Built\-in security principal|Represents default built\-in groups and security principals.|**Users:**<br /><br />-   Administrator<br />-   Cert Publishers<br />-   Domain Guests<br />-   Guest<br /><br />**Groups:**<br /><br />-   Administrators<br />-   Server Operators<br />-   Print Operators<br />-   Users<br />-   Hyper\-V Administrators<br />-   Guests|  
|Computer|Represents a work station or a server in a network. A computer account helps in authenticating and authorizing its access to network resources.|CarrollB<br /><br />CARROLLB.sales.contoso.com|  
|Group|Represents a collection of user accounts, computer accounts, contacts, and other groups that can be managed as a single unit. Groups facilitate role\-based access to network resources. There are two types of groups:<br /><br />-   Security groups are mainly used for the purpose of providing access to network resources.<br />-   Distribution groups are not security\-enabled and can be used only for communication purposes. Groups can vary in scope, limiting their membership and scope of operation.|**Client operating system groups:**<br /><br />-   Administrators<br />-   Users<br />-   Power Users<br />-   Guests<br /><br />**Server operating system groups:**<br /><br />-   Administrators<br />-   System Operators<br />-   Users<br />-   Power Users<br />-   Everyone<br />-   Authenticated Users<br />-   Anonymous Logon<br />-   Guests<br />-   System|  
|User|Represents individuals who need access to the resources in a network. Each user account has a user name and a password. The purpose behind creating user accounts is to authenticate the identity of the user and authorize the user's access to network resources. Active Directory supports two types of built\-in user accounts: Administrator and Guest.|CarrollB<br /><br />Contoso\\CarrollB|  
|Contact|Contains the contact information about people who are associated with the organization but are not part of it, for example, contractors or suppliers. A contact object does not have a SID associated with it, which prevents it from having access to network resources.|Carroll Blythe|  
|Shared folder|Used to share files across the network. It is mapped to a file share on a server.<br /><br />In Active Directory, published shared folders are located in an organizational unit.|<drive>:\\Users\\CarrollB\\Public|  
|Printer|Corresponds to a printer resource in a network. Printer objects are listed under the Domain Controllers container in Active Directory Users and Computers.|Printer object naming is organization\-specific, for example: 2012\-ColorTone 200 Driver, which is a driver associated with Type of Printer.|  
  
## See also  
  
-   [Security Principals Technical Overview](../Topic/Security-Principals-Technical-Overview.md)  
  
-   [Security Identifiers Technical Overview](../Topic/Security-Identifiers-Technical-Overview.md)  
  
-   [Active Directory Accounts](../Topic/Active-Directory-Accounts.md)  
  
-   [Active Directory Security Groups](../Topic/Active-Directory-Security-Groups.md)  
  
-   [Local Accounts](../Topic/Local-Accounts.md)  
  
