---
title: Restrict Access to Only Specified Users or Computers
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5a85a0a9-1734-4a46-82c5-e004470517c9
author: vhorne
---
# Restrict Access to Only Specified Users or Computers
Domain isolation \(as described in the previous goal [Restrict Access to Only Trusted Computers](https://technet.microsoft.com/library/cc725659.aspx)\) prevents computers that are members of the isolated domain from accepting network traffic from untrusted computers. However, some computers on the network might host sensitive data that must be additionally restricted to only those users and computers that have a business requirement to access the data.  
  
[!INCLUDE[wfas](../Token/wfas_md.md)] enables you to restrict access to computers and users that are members of domain groups authorized to access that computer. These groups are called *network access groups \(NAGs\)*. When a computer authenticates to a server, the server checks the group membership of the computer account and the user account, and grants access only if membership in the NAG is confirmed. Adding this check creates a virtual "secure zone" within the domain isolation zone. You can have multiple computers in a single secure zone, and it is likely that you will create a separate zone for each set of servers that have specific security access needs. Computers that are part of this server isolation zone are often also part of the encryption zone \(see [Require Encryption When Accessing Sensitive Network Resources](https://technet.microsoft.com/library/cc770865.aspx)\).  
  
Restricting access to only users and computers that have a business requirement can help you comply with regulatory and legislative requirements, such as those found in the Federal Information Security Management Act of 2002 \(FISMA\), the Sarbanes\-Oxley Act of 2002, the Health Insurance Portability and Accountability Act of 1996 \(HIPAA\), and other government and industry regulations.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] enable you to restrict access by specifying either computer or user credentials.  
  
The following illustration shows an isolated server, and examples of computers that can and cannot communicate with it. Computers that are outside the Woodgrove corporate network, or computers that are in the isolated domain but are not members of the required NAG, cannot communicate with the isolated server.  
  
![](../Image/WFAS-DomainNAG.gif)  
  
This goal, which corresponds to [Server Isolation Policy Design](../Topic/Server-Isolation-Policy-Design.md), provides the following features:  
  
-   Isolated servers accept unsolicited inbound network traffic only from computers or users that are members of the NAG.  
  
-   Isolated servers can be implemented as part of an isolated domain, and treated as another zone. Members of the zone group receive a GPO with rules that require authentication, and that specify that only network traffic authenticated as coming from a member of the NAG is allowed.  
  
-   Server isolation can also be configured independently of an isolated domain. To do so, configure only the computers that must communicate with the isolated server with connection security rules to implement authentication and check NAG membership.  
  
-   A server isolation zone can be simultaneously configured as an encryption zone. To do this, configure the GPO with rules that force encryption in addition to requiring authentication and restricting access to NAG members. For more information, see [Require Encryption When Accessing Sensitive Network Resources](../Topic/Require-Encryption-When-Accessing-Sensitive-Network-Resources.md).  
  
The following components are required for this deployment goal:  
  
-   **Active Directory**: Active Directory supports centralized management of connection security rules by configuring the rules in one or more GPOs that can be automatically applied to all relevant computers in the domain. For more information about Active Directory, see [Additional Resources_2](../Topic/Additional-Resources_2.md).  
  
**Next:**[Mapping Your Deployment Goals to a Windows Firewall with Advanced Security Design](../Topic/Mapping-Your-Deployment-Goals-to-a-Windows-Firewall-with-Advanced-Security-Design.md)  
  
