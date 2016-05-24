---
title: Server Isolation Policy Design
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7ed847ca-8795-4ee5-95a7-b44eaa78a9ee
author: vhorne
---
# Server Isolation Policy Design
In the server isolation policy design, you assign servers to a zone that allows access only to users and computers that authenticate as members of an approved network access group \(NAG\).  
  
This design typically begins with a network configured as described in the [Domain Isolation Policy Design](../Topic/Domain-Isolation-Policy-Design.md) section. For this design, you then create zones for servers that have additional security requirements. The zones can limit access to the server to only members of authorized groups, and can optionally require the encryption of all traffic in or out of these servers. This can be done on a per server basis, or for a group of servers that share common security requirements.  
  
You can implement a server isolation design without using domain isolation. To do this, you use the same principles as domain isolation, but instead of applying them to an Active Directory domain, you apply them only to the computers that must be able to access the isolated servers. The GPO contains connection security and firewall rules that require authentication when communicating with the isolated servers. In this case, the NAGs that determine which users and computers can access the isolated server are also used to determine which computers receive the GPO.  
  
The design is shown in the following illustration, with arrows that show the permitted communication paths.  
  
![](../Image/WFAS-DomainISOHighSec.gif)  
  
Characteristics of this design include the following:  
  
-   Isolated domain \(area A\) \- The same isolated domain described in the [Domain Isolation Policy Design](../Topic/Domain-Isolation-Policy-Design.md) section. If the isolated domain includes a boundary zone, then computers in the boundary zone behave just like other members of the isolated domain in the way that they interact with computers in server isolation zones.  
  
-   Isolated servers \(area B\) \- Computers in the server isolation zones restrict access to computers, and optionally users, that authenticate as a member of a network access group \(NAG\) authorized to gain access.  
  
-   Encryption zone \(area C\) \- If the data being exchanged is sufficiently sensitive, the connection security rules for the zone can also require that the network traffic be encrypted. Encryption zones are most often implemented as rules that are part of a server isolation zone, instead of as a separate zone. The diagram illustrates the concept as a subset for conceptual purposes only.  
  
To add support for server isolation, you must ensure that the authentication methods are compatible with the requirements of the isolated server. For example, if you want to authorize user accounts that are members of a NAG in addition to authorizing computer accounts, you must enable both user and computer authentication in your connection security rules.  
  
> [!IMPORTANT]  
> This design builds on the [Domain Isolation Policy Design](../Topic/Domain-Isolation-Policy-Design.md), which in turn builds on the [Basic Firewall Policy Design](../Topic/Basic-Firewall-Policy-Design.md). If you plan to deploy all three designs, do the design work for all three together, and then deploy in the sequence presented.  
  
This design can be applied to computers that are part of an Active Directory forest. Active Directory is required to provide the centralized management and deployment of Group Policy objects that contain the connection security rules.  
  
For more information about this design:  
  
-   This design coincides with the deployment goals to [Protect Computers from Unwanted Network Traffic](../Topic/Protect-Computers-from-Unwanted-Network-Traffic.md), [Restrict Access to Only Trusted Computers](../Topic/Restrict-Access-to-Only-Trusted-Computers.md), [Restrict Access to Only Specified Users or Computers](../Topic/Restrict-Access-to-Only-Specified-Users-or-Computers.md), and [Require Encryption When Accessing Sensitive Network Resources](../Topic/Require-Encryption-When-Accessing-Sensitive-Network-Resources.md).  
  
-   To learn more about this design, see [Server Isolation Policy Design Example](../Topic/Server-Isolation-Policy-Design-Example.md).  
  
-   Before completing the design, gather the information described in [Designing a Windows Firewall with Advanced Security Strategy](../Topic/Designing-a-Windows-Firewall-with-Advanced-Security-Strategy.md).  
  
-   To help you make the decisions required in this design, see [Planning Server Isolation Zones](../Topic/Planning-Server-Isolation-Zones.md) and [Planning Group Policy Deployment for Your Isolation Zones](../Topic/Planning-Group-Policy-Deployment-for-Your-Isolation-Zones.md).  
  
-   For a list of tasks that you can use to deploy your server isolation policy design, see "Checklist: Implementing a Standalone Server Isolation Policy Design" in the [Windows Firewall with Advanced Security Deployment Guide](http://go.microsoft.com/fwlink/?linkid=xxxxx) at http:\/\/go.microsoft.com\/fwlink\/?linkid\=xxxx.  
  
**Next:**[Certificate-based Isolation Policy Design](../Topic/Certificate-based-Isolation-Policy-Design.md)  
  
