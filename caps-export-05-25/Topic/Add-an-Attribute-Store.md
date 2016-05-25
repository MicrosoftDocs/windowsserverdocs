---
title: Add an Attribute Store
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cda2d7dc-b10c-4ab6-9b30-f212f8ab5b23
author: billmath
---
# Add an Attribute Store
User accounts and computer accounts that require access to a resource that is protected by [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] are stored in an attribute store, such as Active Directory Domain Services \(AD DS\). The claims issuance engine uses attribute stores to gather data that is necessary to issue claims. Data from the attribute stores is then projected as claims.  
  
You can use the following procedure to add an attribute store to the Federation Service.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum requirement to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To add an attribute store  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press Enter.  
  
2.  Under the **[!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]\\Trust Relationships** folder, right\-click **Attribute Stores**, and then click **Add an attribute store**.  
  
3.  In the **Add an attribute store** dialog box, configure the following properties for the attribute store that you want to add:  
  
    -   In **Display name**, type the name that you want to use to identify the attribute store.  
  
    -   In **Attribute store type**, select a supported attribute store type, either **Active Directory**, **LDAP**, or **SQL**.  
  
    -   In **Connection string**, if you have selected either a Lightweight Directory Access Protocol \(LDAP\) store or a Structured Query Language \(SQL\) store, enter the string that you used to establish a connection to the attribute store. For Active Directory attribute stores, no connection string is required; therefore, this field is disabled.  
  
        > [!NOTE]  
        > [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] automatically creates an Active Directory attribute store, by default.  
  
4.  Click **OK**.  
  
## See Also  
[AD FS Operations](../Topic/AD-FS-Operations.md)  
[The Role of Attribute Stores](../Topic/The-Role-of-Attribute-Stores.md)  
  
