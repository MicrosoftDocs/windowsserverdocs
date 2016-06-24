---
title: Creating a DNS Infrastructure Design
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: 282f1e06-9f13-43b0-abb1-76af2d78d2c5
author: Femila
---
# Creating a DNS Infrastructure Design
After you create your Active Directory forest and domain designs, you must design a Domain Name System (DNS) infrastructure to support your Active Directory logical structure. DNS enables users to use friendly names that are easy to remember to connect to computers and other resources on IP networks. Active Directory Domain Services (AD DS) in  Windows Server 2008  requires DNS.  
  
The process for designing DNS to support AD DS varies according to whether your organization already has an existing DNS Server service or you are deploying a new DNS Server service:  
  
-   If you already have an existing DNS infrastructure, you must integrate the Active Directory namespace into that environment. For more information, see [Integrating AD DS into an Existing DNS Infrastructure](../../ad-ds/plan/../../ad-ds/plan/Integrating-AD-DS-into-an-Existing-DNS-Infrastructure.md).  
  
-   If you do not have a DNS infrastructure in place, you must design and deploy a new DNS infrastructure to support AD DS. For more information, see Deploying Domain Name System (DNS) ([http://go.microsoft.com/fwlink/?LinkId=93656](http://go.microsoft.com/fwlink/?LinkId=93656)).  
  
If your organization has an existing DNS infrastructure, you must make sure that you understand how your DNS infrastructure will interact with the Active Directory namespace. For a worksheet to assist you in documenting your existing DNS infrastructure design, download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip from Job Aids for Windows Server 2003 Deployment Kit ([http://go.microsoft.com/fwlink/?LinkID=102558](http://go.microsoft.com/fwlink/?LinkID=102558)) and open "DNS Inventory" (DSSLOGI_8.doc).  
  
> [!NOTE]  
> In addition to IP version 4 (IPv4) addresses,  Windows Server 2008  also supports IP version 6 (IPv6) addresses. For a worksheet to assist you in listing the IPv6 addresses while documenting the recursive name resolution method of your current DNS structure, see [Appendix A: DNS Inventory](../../ad-ds/plan/Appendix-A--DNS-Inventory.md).  
  
Before you design your DNS infrastructure to support AD DS, it can be helpful to read about the DNS hierarchy, the DNS name resolution process, and how DNS supports AD DS. For more information about the DNS hierarchy and name resolution process, see the DNS Technical Reference ([http://go.microsoft.com/fwlink/?LinkID=48145](http://go.microsoft.com/fwlink/?LinkID=48145)). For more information about how DNS supports AD DS, see the DNS Support for Active Directory Technical Reference ([http://go.microsoft.com/fwlink/?LinkID=48147](http://go.microsoft.com/fwlink/?LinkID=48147)).  
  
## In this section  
  
-   [Reviewing DNS Concepts](../../ad-ds/plan/Reviewing-DNS-Concepts.md)  
  
-   [DNS and AD DS](../../ad-ds/plan/DNS-and-AD-DS.md)  
  
-   [Assigning the DNS for AD DS Owner Role](../../ad-ds/deploy/Assigning-the-DNS-for-AD-DS-Owner-Role.md)  
  
-   [Integrating AD DS into an Existing DNS Infrastructure](../../ad-ds/plan/../../ad-ds/plan/Integrating-AD-DS-into-an-Existing-DNS-Infrastructure.md)  
  

