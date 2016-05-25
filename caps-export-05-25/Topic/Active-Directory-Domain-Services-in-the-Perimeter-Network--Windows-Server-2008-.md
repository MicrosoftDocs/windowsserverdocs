---
title: Active Directory Domain Services in the Perimeter Network (Windows Server 2008)
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f182ccf5-852c-4b19-9823-0b5cd9544a2e
author: Femila
---
# Active Directory Domain Services in the Perimeter Network (Windows Server 2008)
  Perimeter networks \(also known as DMZs or extranets\) can be a challenging environment for an information technology \(IT\) department. Security mandates, such as auditing and protecting assets, often contrast with the constantly changing connectivity requirements of mobile and remote users and applications that are deployed in a perimeter network.  
  
> [!NOTE]  
>  For a printable .doc version of this guide, see [Active Directory Domain Services in the Perimeter Network \(Windows Server 2008\).doc](http://go.microsoft.com/fwlink/?LinkId=150091) at the Microsoft Download Center \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=150091\).  
  
 This guide contains information about the following:  
  
-   Determining whether Active Directory® Domain Services \(AD DS\) is appropriate for your perimeter network  
  
-   The various models for deploying AD DS in perimeter networks  
  
-   Planning and deploying read\-only domain controllers \(RODCs\) in perimeter networks  
  
 Because RODCs provide new capabilities for perimeter networks, most of the content in this guide describes how to plan for and deploy this new Windows Server 2008 feature. However, the other Active Directory models introduced later in this guide are also viable. Choose an appropriate model in accordance with the business needs of your organization.  
  
 **In this guide**  
  
 [Planning Deployment of AD DS in the Perimeter Network](../Topic/Planning-Deployment-of-AD-DS-in-the-Perimeter-Network.md)  
  
 [Designing RODCs in the Perimeter Network](../Topic/Designing-RODCs-in-the-Perimeter-Network.md)  
  
 [Deploying RODCs in the Perimeter Network](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md)  
  
## Planning your perimeter network  
 Applications that provide services to customers, partners, and corporate users drive the security and connectivity requirements of a perimeter network. These applications greatly influence the design of the network topology and the infrastructure services that are provided.  
  
 As shown in the Figure 1, a typical perimeter network design can require constraints on communication between the internal network and the perimeter network. The constraints can be modeled either at the physical network layer \(routers and firewalls\) or at a logical layer \(Internet Protocol security \(IPsec\), Secure Sockets Layer \(SSL\), and so on.  
  
 ![](../Image/61da0bf6-32fb-4d83-b12a-d00fdb7dfbf4.gif)  
  
 **Figure 1  Perimeter networks**  
  
### Corporate and remote access to perimeter network resources  
 Many organizations provide resources in their perimeter networks that customers, partners, and corporate users need to access. Typical resources include Microsoft® Office SharePoint® Server 2007 for collaborating on documents, SQL Server databases, or tools such as remote connection software. Planning for and deploying identity infrastructure for partner or customer resource access is beyond the scope of this document. However, this document describes the following scenarios:  
  
1.  Intranet identities access resources that are also accessible to partners.  
  
2.  Intranet identities access resources that are dedicated to those identities \(such as e\-mail\).  
  
 ![](../Image/Scenario1_CorpUsersAccessDMZResources.gif)  
  
 **Figure 2  Using perimeter networks to manage identities that access resources**  
  
 As shown in Figure 2, placing Active Directory servers in the perimeter network is a strong consideration for organizations that have intranet\-owned identities that are needed for authentication or authorization. AD DS in the perimeter network also enables scalability and is a cost\-effective way to manage the users and computers.  
  
### Centrally managed perimeter network resources  
 As shown in Figure 3, many solutions for AD DS in perimeter networks require a large number of servers as a result of different layers of design or the number of front\-line servers that are required for workload balance.  
  
 ![](../Image/70b82f90-fb6d-4df0-b9bc-90f799a68942.gif)  
  
 **Figure 3  Perimeter solutions often require a large number of servers**  
  
 The central or delegated administration, management, and configuration that AD DS provides can be a key consideration in your decision to place domain controllers in your perimeter network. Placing servers that belong to the perimeter network solution in a domain or organizational unit \(OU\) makes it possible to take advantage of the management technologies, tools, and procedures that are common to all Windows\-domain\-based systems.  
  
  