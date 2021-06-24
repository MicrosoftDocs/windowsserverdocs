---
title: Configure Firewall Rules for Non-Domain Members to Allow BranchCache Traffic
description: Learn how to configure third party firewall products and to manually configure a client computer with firewall rules that allow BranchCache to run in distributed cache mode.
manager: brianlic
ms.topic: how-to
ms.assetid: da956be0-c92d-46ea-99eb-85e2bd67bf07
ms.author: jgerend
author: JasonGerend
ms.date: 01/05/2021
---
# Configure Firewall Rules for Non-Domain Members to Allow BranchCache Traffic

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use the information in this topic to configure third party firewall products and to manually configure a client computer with firewall rules that allow BranchCache to run in distributed cache mode.

> [!NOTE]
> -   If you have configured BranchCache client computers using Group Policy, the Group Policy settings override any manual configuration of client computers to which the policies are applied.
> -   If you have deployed BranchCache with DirectAccess, you can use the settings in this topic to configure IPsec rules to allow BranchCache traffic.

Membership in **Administrators**, or equivalent is the minimum required to make these configuration changes.

## [MS-PCCRD]: Peer Content Caching and Retrieval Discovery Protocol
Distributed cache clients must allow inbound and outbound MS-PCCRD traffic, which is carried in the Web Services Dynamic Discovery (WS-Discovery) protocol.

Firewall settings must allow multicast traffic in addition to inbound and outbound traffic. You can use the following settings to configure firewall exceptions for distributed cache mode.

IPv4 multicast: 239.255.255.250

IPv6 multicast: FF02::C

Inbound traffic: Local port: 3702, Remote port: ephemeral

Outbound traffic: Local port: ephemeral, Remote port: 3702

Program: %systemroot%\system32\svchost.exe (BranchCache Service [PeerDistSvc])

## [MS-PCCRR]: Peer Content Caching and Retrieval: Retrieval Protocol
Distributed cache clients must allow inbound and outbound MS-PCCRR traffic, which is carried in the HTTP 1.1 protocol as documented in request for comments (RFC) 2616.

Firewall settings must allow inbound and outbound traffic. You can use the following settings to configure firewall exceptions for distributed cache mode.

Inbound traffic: Local port: 80, Remote port: ephemeral

Outbound traffic: Local port: ephemeral, Remote port: 80



