---
title: What's New in SDN for Windows Server
description: This topic provides information on new Software Defined Networking features for Windows Server 1709
manager: dougkim
ms.prod: windows-server-threshold
ms.technology: networking-hv-switch
ms.topic: get-started-article
ms.assetid: efad919b-e9e7-4a0c-b373-e68a092f93b5
ms.author: pashort
author: shortpatti
ms.date: 10/02/2018
---
# What's New in SDN for Windows Server 2019

>Applies to: Windows Server (Semi-Annual Channel)


|                         **Feature**                          |                                                                                                                                                                                         **Description**                                                                                                                                                                                         | **New/updated** |
|--------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------|
| [Encrypted networks](vnet-encryption/sdn-vnet-encryption.md) | Virtual network encryption allows encryption of virtual network traffic between virtual machines that communicate with each other within subnets marked as ‘Encryption Enabled.’ It also utilizes Datagram Transport Layer Security (DTLS) on the virtual subnet to encrypt packets. DTLS protects against eavesdropping, tampering, and forgery by anyone with access to the physical network. |       New       |
|    [Firewall auditing](security/sdn-firewall-auditing.md)    |                                                                                            Firewall auditing is a new capability for the SDN firewall in Windows Server 2019. When you enable SDN firewall, any flow processed by SDN firewall rules (ACLs) that have logging enabled gets recorded.                                                                                            |       New       |
| [Virtual network peering](vnet-peering/sdn-vnet-peering.md)  |                                                                                                                      Virtual network peering lets you connect two virtual networks seamlessly. Once peered, for connectivity purposes, the virtual networks appear as one.                                                                                                                      |       New       |
|           [Egress metering](manage/sdn-egress.md)            |                  This new feature in Windows Server 2019 enables SDN to offer usage meters for outbound data transfers. With this feature added, Network Controller keeps a whitelist per Virtual Network of all IP ranges used within SDN, and consider any packet bound for a destination that is not included in one of these ranges to be billed outbound data transfers.                   |       New       |

---



