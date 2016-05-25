---
title: Add an Attribute Store_1
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bcca5f8d-e925-494f-a39a-f010025462fa
author: billmath
---
# Add an Attribute Store_1
User accounts and computer accounts that require access to a resource that is protected by [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] are stored in an attribute store, such as Active Directory Domain Services \(AD DS\). The claims issuance engine uses attribute stores to gather data that is necessary to issue claims. Data from the attribute stores is then projected as claims.  
  
You can use the following procedure to add an attribute store to the Federation Service.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To add an attribute store  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press ENTER.  
  
2.  Under the **[!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]\\Trust Relationships** folder, right\-click **Attribute Stores**, and then click **Add an attribute store**.  
  
3.  In the **Add an attribute store** dialog box, configure the following properties for the attribute store that you want to add:  
  
    -   In **Display name**, type the name that you want to use to identify the attribute store.  
  
    -   In **Attribute store type**, select a supported attribute store type, either **Active Directory**, **LDAP**, or **SQL**.  
  
    -   In **Connection string**, if you have selected either a Lightweight Directory Access Protocol \(LDAP\) store or a Structured Query Language \(SQL\) store, enter the string that you used to establish a connection to the attribute store. For Active Directory attribute stores, no connection string is necessary; therefore, this field is disabled.  
  
        > [!NOTE]  
        > [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] automatically creates an Active Directory attribute store, by default.  
  
4.  Click **OK**.  
  
## Additional references  
[Checklist: Configuring the Account Partner Organization](../Topic/Checklist--Configuring-the-Account-Partner-Organization.md)  
  
[The Role of Attribute Stores](../Topic/The-Role-of-Attribute-Stores.md)  
  
