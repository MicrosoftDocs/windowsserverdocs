---
title: Basic Firewall Policy Design
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8e491805-f26f-4ee7-8415-12839c2bdb9c
---
# Basic Firewall Policy Design
Many organizations have a network perimeter firewall that is designed to prevent the entry of malicious traffic in to the organization's network, but do not have a host\-based firewall enabled on each computer in the organization.

The Basic Firewall Policy Design helps you to protect the computers in your organization from unwanted network traffic that gets through the perimeter defenses, or that originates from inside your network. In this design, you deploy firewall rules to each computer in your organization to allow traffic that is required by the programs that are used. Traffic that does not match the rules is dropped.

Traffic can be blocked or permitted based on the characteristics of each network packet: its source or destination IP address, its source or destination port numbers, the program on the computer that receives the inbound packet, and so on. This design can also be deployed together with one or more of the other designs that add IPsec protection to the network traffic permitted.

Many network administrators do not want to tackle the difficult task of determining all the appropriate rules for every program that is used by the organization, and then maintaining that list over time. In fact, most programs do not require specific firewall rules. The default behavior of Windows and most contemporary applications makes this task easy:

-   On client computers, the default firewall behavior already supports typical client programs. Programs designed for [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)], and [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)] create any required rules for you as part of the installation process. You only have to create a rule if the client program must be able to receive unsolicited inbound network traffic from another computer.

-   When you install a server program that must accept unsolicited inbound network traffic, the installation program likely creates or enables the appropriate rules on the server for you.

    For example, when you install a server role in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], the appropriate firewall rules are created and enabled automatically.

-   For other standard network behavior, the predefined rules that are built into [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)], and [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)] can easily be configured in a GPO and deployed to the computers in your organization.

    For example, by using the predefined groups for Core Networking and File and Printer Sharing you can easily configure GPOs with rules for those frequently used networking protocols.

With few exceptions, the firewall can be enabled on all configurations of [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)], and [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)]. Therefore, we recommended that you enable the firewall on every computer in your organization. This includes servers in your perimeter network, on mobile and remote clients that connect to the network, and on all servers and clients in your internal network.

> [!CAUTION]
> **Stopping the service associated with Windows Firewall with Advanced Security is not supported by Microsoft**.
> 
> By default, in new installations, Windows Firewall is turned on in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)], and [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)].
> 
> If you turn off the [!INCLUDE[wfas](includes/wfas_md.md)] service you lose other benefits provided by the service, such as the ability to use IPsec connection security rules, Windows Service Hardening, and network protection from forms of attacks that use network fingerprinting. For more information about Windows Service Hardening, see [http:\/\/go.microsoft.com\/fwlink\/?linkid\=104976](http://go.microsoft.com/fwlink/?linkid=104976).
> 
> Third\-party firewall software that is compatible with [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)], and [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)] can programmatically disable only the parts of [!INCLUDE[wfas](includes/wfas_md.md)] that might need to be disabled for compatibility. This is the recommended approach for third\-party firewalls to coexist with the Windows Firewall; third\-party party firewalls that comply with this recommendation have the certified logo from Microsoft.

An organization typically uses this design as a first step toward a more comprehensive [!INCLUDE[wfas](includes/wfas_md.md)] design that adds server isolation and domain isolation.

After implementing this design, your administrative team will have centralized management of the firewall rules applied to all computers that are running Windows in your organization.

> [!IMPORTANT]
> If you also intend to deploy the [Domain Isolation Policy Design](Domain-Isolation-Policy-Design.md), or the [Server Isolation Policy Design](Server-Isolation-Policy-Design.md), we recommend that you do the design work for all three designs together, and then deploy in layers that correspond with each design.

The basic firewall design can be applied to computers that are part of an Active Directory forest. Active Directory is required to provide the centralized management and deployment of Group Policy objects that contain the firewall settings and rules.

For more information about this design:

-   This design coincides with the deployment goal to [Protect Computers from Unwanted Network Traffic](Protect-Computers-from-Unwanted-Network-Traffic.md).

-   To learn more about this design, see [Firewall Policy Design Example](Firewall-Policy-Design-Example.md).

-   Before completing the design, gather the information described in [Designing a Windows Firewall with Advanced Security Strategy](Designing-a-Windows-Firewall-with-Advanced-Security-Strategy.md).

-   To help you make the decisions required in this design, see [Planning Settings for a Basic Firewall Policy](Planning-Settings-for-a-Basic-Firewall-Policy.md).

-   For a list of detailed tasks that you can use to deploy your basic firewall policy design, see "Checklist: Implementing a Basic Firewall Policy Design" in the [Windows Firewall with Advanced Security Deployment Guide](http://go.microsoft.com/fwlink/?linkid=98308) at http:\/\/go.microsoft.com\/fwlink\/?linkid\=98308.

**Next:**[Domain Isolation Policy Design](Domain-Isolation-Policy-Design.md)


