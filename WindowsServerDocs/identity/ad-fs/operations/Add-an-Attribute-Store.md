---
ms.assetid: c60227a8-7b44-40f8-b807-a6532851a4a6
title: Add an Attribute Store
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Add an Attribute Store


User accounts and computer accounts that require access to a resource that is protected by Active Directory Federation Services \(AD FS\) are stored in an attribute store, such as Active Directory Domain Services \(AD DS\). The claims issuance engine uses attribute stores to gather data that is necessary to issue claims. Data from the attribute stores is then projected as claims.  
  
You can use the following procedure to add an attribute store to the Federation Service.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
#### To add an attribute store  
  
1.  Open **AD FS Management**.  
  
2.  Under **Actions** click **Add an attribute store**.  

![add attribute store](media/Add-an-Attribute-Store/addstore1.PNG)
  
3. In the **Add an attribute store** dialog box, configure the following properties for the attribute store that you want to add:  
  
   -   In **Display name**, type the name that you want to use to identify the attribute store.  
  
   -   In **Attribute store type**, select a supported attribute store type, either **Active Directory**, **LDAP**, or **SQL**.  
  
   -   In **Connection string**, if you have selected either a Lightweight Directory Access Protocol \(LDAP\) store or a Structured Query Language \(SQL\) store, enter the string that you used to establish a connection to the attribute store. For Active Directory attribute stores, no connection string is necessary; therefore, this field is disabled.  
  
       > [!NOTE]  
       > AD FS automatically creates an Active Directory attribute store, by default.  
 
![add attribute store](media/Add-an-Attribute-Store/addstore2.PNG) 

4. Click **OK**.  
  
## Additional references  

[AD FS Operations](../../ad-fs/AD-FS-2016-Operations.md)
  
[The Role of Attribute Stores](../../ad-fs/technical-reference/The-Role-of-Attribute-Stores.md)  
