---
title: Known Issues for Creating Domain and Forest Trusts
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 99a8b842-16e2-4fa2-b1dd-5f6adb7e7831
author: Femila
---
# Known Issues for Creating Domain and Forest Trusts
  Review the following known issues before creating domain and forest trusts in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]:  
  
-   You cannot delegate the creation of trusts to any user who is not a member of the Domain Admins group or the Enterprise Admins group. Even though you can grant a user the Create TDO \(Trusted Domain Object\) right or the Delete TDO right in the System container of a domain, the user will not be granted the right to create a trust. This issue occurs because Netlogon and the trust\-creation tools \(Active Directory Domains and Trusts and Netdom\) are designed so that only members of the Domain Admins group and the Enterprise Admins group can create trusts. However, any user who is a member of the Incoming Forest Trust Builders group can create one\-way, incoming forest trusts to your forest.  
  
-   When you are logged on locally to a domain controller and you try to create a new trust by using Active Directory Domains and Trusts, the operation may be unsuccessful and you may receive the message “Access denied.” This issue occurs only if you are logged on locally to the domain controller as an ordinary user \(that is, you are not logged on as Administrator or as a member of any administrative groups for the domain\). By default, ordinary users are blocked from logging on locally to a domain controller unless Group Policy is modified to permit this.  
  
-   When you use the Active Directory Domains and Trusts snap\-in to create a trust, you may receive the message “Operation failed. Parameter incorrect.” This issue may occur if you try to establish a trust relationship when the source domain and the target domain have one or more of the following identifiers that are the same:  
  
    -   Security identifier \(SID\)  
  
    -   Domain Name System \(DNS\) name  
  
    -   NetBIOS name  
  
     To resolve this issue, do one of the following before you try to create the trust, as appropriate to your situation:  
  
    -   If you have a duplicate SID in the domain to which you are trying to establish a trust, delete the object that is associated with the duplicate SID to create the trust.  
  
    -   If you have a duplicate DNS or NetBIOS name, you have two options to successfully establish the trust:  
  
        -   Rename the domain with the duplicate name \- For more information about domain rename see, [Administering Active Directory Domain Rename](http://go.microsoft.com/fwlink/?LinkID=187639) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=187639\)  
  
        -   Migrate from the domain with the duplicate name to a new domain \- To perform this migration, you can use the Active Directory Migration Tool \(ADMT\).  For more information about ADMT see, [ADMT Guide: Migrating and Restructuring Active Directory Domains](http://go.microsoft.com/fwlink/?LinkID=93678) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=93678\)  
  
-   The option to create a forest trust may not appear in the New Trust Wizard. This issue typically occurs when one or both of the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forests are not set to the Windows Server 2003 forest functional level or higher. For more information about forest functional levels, see Active Directory Functional Levels Technical Reference \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111466](http://go.microsoft.com/fwlink/?LinkId=111466)\).  
  
-   You cannot create a trust relationship with a Microsoft Windows Small Business Server 2003 \(Windows SBS\) domain. For information about Windows SBS software, see Introduction to Windows Small Business Server 2003 for Enterprise IT Pros \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=121891](http://go.microsoft.com/fwlink/?LinkId=121891)\).  
  
  