---
ms.assetid: d254fca3-85a1-424d-ac22-d6687ec3798e
title: Provide Your Active Directory Users Access to Your Claims-Aware Applications and Services
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Provide Your Active Directory Users Access to Your Claims-Aware Applications and Services

When you are an administrator in the account partner organization in an Active Directory Federation Services \(AD FS\) deployment and you have a deployment goal to provide single\-sign\-on \(SSO\) access for employees on the corporate network to your hosted resources:  
  
-   Employees who are logged on to an Active Directory forest in the corporate network can use SSO to access multiple applications or services in the perimeter network in your own organization. These applications and services are secured by AD FS.  
  
    For example, Fabrikam may want corporate network employees to have federated access to Web\-based applications that are hosted in the perimeter network for Fabrikam.  
  
-   Remote employees who are logged on to an Active Directory domain can obtain AD FS tokens from the federation server in your organization to gain federated access to AD FS\-secured Web\-based applications or services that also reside in your organization.  
  
-   Information in the Active Directory attribute store can be populated into the employees' AD FS tokens.  
  
The following components are required for this deployment goal:  
  
-   **Active Directory Domain Services \(AD DS\):** AD DS contains the employees' user accounts that are used to generate AD FS tokens. Information, such as group memberships and attributes, is populated into AD FS tokens as group claims and custom claims.  
  
    > [!NOTE]  
    > You can also use Lightweight Directory Access Protocol \(LDAP\) or Structured Query Language \(SQL\) to contain the identities for AD FS token generation.  
  
-   **Corporate DNS:** This implementation of Domain Name System \(DNS\) contains a simple host \(A\) resource record so that intranet clients can locate the account federation server. This implementation of DNS may also host other DNS records that are required in the corporate network. For more information, see [Name Resolution Requirements for Federation Servers](Name-Resolution-Requirements-for-Federation-Servers.md).  
  
-   **Account partner federation server:** This federation server is joined to a domain in the account partner forest. It authenticates employee user accounts and generates AD FS tokens. The client computer for the employee performs Windows Integrated Authentication against this federation server to generate an AD FS token. For more information, see [Review the Role of the Federation Server in the Account Partner](Review-the-Role-of-the-Federation-Server-in-the-Account-Partner.md).  
  
    The account partner federation server can authenticate the following users:  
  
    -   Employees with user accounts in this domain  
  
    -   Employees with user accounts anywhere in this forest  
  
    -   Employees with user accounts anywhere in forests that are trusted by this forest \(through a two\-way Windows trust\)  
  
-   **Employee:** An employee accesses a Web\-based service \(through an application\) or a Web\-based application \(through a supported Web browser\) while he or she is logged on to the corporate network. The employee's client computer on the corporate network communicates directly with the federation server for authentication.  
  
After reviewing the information in the linked topics, you can begin deploying this goal by following the steps in [Checklist: Implementing a Federated Web SSO Design](../../ad-fs/deployment/Checklist--Implementing-a-Federated-Web-SSO-Design.md).  
  
The following illustration shows each of the required components for this AD FS deployment goal.  
  
![access to your claims](media/31394ea8-fecb-4372-ac3f-cc3cf566ffc9.gif)  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
