---
title: Provide Your Active Directory Users Access to Your Claims-Aware Applications and Services
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 386bb112-5d32-443d-95c4-742437c9b793
author: billmath
---
# Provide Your Active Directory Users Access to Your Claims-Aware Applications and Services
When you are an administrator in the account partner organization in an [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] deployment and you have a deployment goal to provide single\-sign\-on \(SSO\) access for employees on the corporate network to your hosted resources:  
  
-   Employees who are logged on to an Active Directory forest in the corporate network can use SSO to access multiple applications or services in the perimeter network in your own organization. These applications and services are secured by [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)].  
  
    For example, Fabrikam may want corporate network employees to have federated access to Web\-based applications that are hosted in the perimeter network for Fabrikam.  
  
-   Remote employees who are logged on to an Active Directory domain can obtain AD FS tokens from the federation server in your organization to gain federated access to AD FS\-secured Web\-based applications or services that also reside in your organization.  
  
-   Information in the Active Directory attribute store can be populated into the employees' AD FS tokens.  
  
The following components are required for this deployment goal:  
  
-   **Active Directory Domain Services \(AD DS\):** AD DS contains the employees' user accounts that are used to generate AD FS tokens. Information, such as group memberships and attributes, is populated into AD FS tokens as group claims and custom claims.  
  
    > [!NOTE]  
    > You can also use Lightweight Directory Access Protocol \(LDAP\) or Structured Query Language \(SQL\) to contain the identities for AD FS token generation.  
  
-   **Corporate DNS:** This implementation of Domain Name System \(DNS\) contains a simple host \(A\) resource record so that intranet clients can locate the account [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]. This implementation of DNS may also host other DNS records that are required in the corporate network. For more information, see [Name Resolution Requirements for Federation Servers](../Topic/Name-Resolution-Requirements-for-Federation-Servers.md).  
  
-   **Account partner [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]:** This [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] is joined to a domain in the account partner forest. It authenticates employee user accounts and generates AD FS tokens. The client computer for the employee performs Windows Integrated Authentication against this [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] to generate an AD FS token. For more information, see [Review the Role of the Federation Server in the Account Partner](../Topic/Review-the-Role-of-the-Federation-Server-in-the-Account-Partner.md).  
  
    The account partner [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] can authenticate the following users:  
  
    -   Employees with user accounts in this domain  
  
    -   Employees with user accounts anywhere in this forest  
  
    -   Employees with user accounts anywhere in forests that are trusted by this forest \(through a two\-way Windows trust\)  
  
-   **Employee:** An employee accesses a Web\-based service \(through an application\) or a Web\-based application \(through a supported Web browser\) while he or she is logged on to the corporate network. The employee's client computer on the corporate network communicates directly with the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] for authentication.  
  
After reviewing the information in the linked topics, you can begin deploying this goal by following the steps in [Checklist: Implementing a Federated Web SSO Design](../Topic/Checklist--Implementing-a-Federated-Web-SSO-Design.md).  
  
The following illustration shows each of the required components for this [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] deployment goal.  
  
![](../Image/31394ea8-fecb-4372-ac3f-cc3cf566ffc9.gif)  
  
