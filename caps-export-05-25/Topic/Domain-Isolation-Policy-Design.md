---
title: Domain Isolation Policy Design
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 29636ab6-db16-4126-ac04-7269667599fc
author: vhorne
---
# Domain Isolation Policy Design
In the domain isolation policy design, you configure the computers on your network to accept only connections coming from computers that are authenticated as members of the same isolated domain.  
  
This design typically begins with a network configured as described in the [Basic Firewall Policy Design](../Topic/Basic-Firewall-Policy-Design.md) section. For this design, you then add connection security and IPsec rules to configure computers in the isolated domain to accept only network traffic from other computers that can authenticate as a member of the isolated domain. After implementing the new rules, your computers reject unsolicited network traffic from computers that are not members of the isolated domain.  
  
The isolated domain might not be a single Active Directory domain. It can consist of all the domains in a forest, or domains in separate forests that have two\-way trust relationships configured between them.  
  
By using connection security rules based on IPsec, you provide a logical barrier between computers even if they are connected to the same physical network segment.  
  
The design is shown in the following illustration, with the arrows that show the permitted communication paths.  
  
![](../Image/WFASDomainISOBoundary.gif)  
  
Characteristics of this design, as shown in the diagram, include the following:  
  
-   Isolated domain \(area A\) \- Computers in the isolated domain receive unsolicited inbound traffic only from other members of the isolated domain or from computers referenced in authentication exemption rules. Computers in the isolated domain can send traffic to any computer. This includes unauthenticated traffic to computers that are not in the isolated domain. Computers that cannot join an Active Directory domain, but that can use certificates for authentication, can be part of the isolated domain. For more information, see the [Certificate-based Isolation Policy Design](../Topic/Certificate-based-Isolation-Policy-Design.md).  
  
-   Boundary zone \(area B\) \- Computers in the boundary zone are part of the isolated domain but are allowed to accept inbound connections from untrusted computers, such as clients on the Internet.  
  
    Computers in the boundary zone request but do not require authentication to communicate. When a member of the isolated domain communicates with a boundary zone member the traffic is authenticated. When a computer that is not part of the isolated domain communicates with a boundary zone member the traffic is not authenticated.  
  
    Because boundary zone computers are exposed to network traffic from untrusted and potentially hostile computers, they must be carefully managed and secured. Put only the computers that must be accessed by external computers in this zone. Use firewall rules to ensure that network traffic is accepted only for services that you want exposed to non\-domain member computers.  
  
-   Trusted non\-domain members \(area C\) \- Computers on the network that are not domain members or that cannot use IPsec authentication are allowed to communicate by configuring authentication exemption rules. These rules enable computers in the isolated domain to accept inbound connections from these trusted non\-domain member computers.  
  
-   Untrusted non\-domain members \(area D\) \- Computers that are not managed by your organization and have an unknown security configuration must have access only to those computers required for your organization to correctly conduct its business. Domain isolation exists to put a logical barrier between these untrusted computers and your organization's computers.  
  
After implementing this design, your administrative team will have centralized management of the firewall and connection security rules applied to the computers that are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] in your organization.  
  
> [!IMPORTANT]  
> This design builds on the [Basic Firewall Policy Design](../Topic/Basic-Firewall-Policy-Design.md), and in turn serves as the foundation for the [Server Isolation Policy Design](../Topic/Server-Isolation-Policy-Design.md). If you plan to deploy all three, we recommend that you do the design work for all three together, and then deploy in the sequence presented.  
  
This design can be applied to computers that are part of an Active Directory forest. Active Directory is required to provide the centralized management and deployment of Group Policy objects that contain the connection security rules.  
  
In order to expand the isolated domain to include computers that cannot be part of an Active Directory domain, see the [Certificate-based Isolation Policy Design](../Topic/Certificate-based-Isolation-Policy-Design.md).  
  
For more information about this design:  
  
-   This design coincides with the deployment goals to [Protect Computers from Unwanted Network Traffic](../Topic/Protect-Computers-from-Unwanted-Network-Traffic.md), [Restrict Access to Only Trusted Computers](../Topic/Restrict-Access-to-Only-Trusted-Computers.md), and optionally [Require Encryption When Accessing Sensitive Network Resources](../Topic/Require-Encryption-When-Accessing-Sensitive-Network-Resources.md).  
  
-   To learn more about this design, see the [Domain Isolation Policy Design Example](../Topic/Domain-Isolation-Policy-Design-Example.md).  
  
-   Before completing the design, gather the information described in [Designing a Windows Firewall with Advanced Security Strategy](../Topic/Designing-a-Windows-Firewall-with-Advanced-Security-Strategy.md).  
  
-   To help you make the decisions required in this design, see [Planning Domain Isolation Zones](../Topic/Planning-Domain-Isolation-Zones.md) and [Planning Group Policy Deployment for Your Isolation Zones](../Topic/Planning-Group-Policy-Deployment-for-Your-Isolation-Zones.md).  
  
-   For a list of tasks that you can use to deploy your domain isolation policy design, see "Checklist: Implementing a Domain Isolation Policy Design" in the [Windows Firewall with Advanced Security Deployment Guide](http://go.microsoft.com/fwlink/?linkid=xxxxx) at http:\/\/go.microsoft.com\/fwlink\/?linkid\=xxxxx.  
  
**Next:** [Server Isolation Policy Design](../Topic/Server-Isolation-Policy-Design.md)  
  
