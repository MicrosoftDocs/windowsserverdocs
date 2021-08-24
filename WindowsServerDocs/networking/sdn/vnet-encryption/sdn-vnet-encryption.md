---
title: Virtual Network Encryption
description: Learn about the requirements of virtual network encryption.
manager: grcusanz
ms.topic: how-to
ms.assetid: 7da0f509-7b02-4a0f-90fb-d97c83a2bc4e
ms.author: anpaul
author: AnirbanPaul
ms.date: 08/08/2018
---
# Virtual Network Encryption

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server

Virtual network encryption allows encryption of virtual network traffic between virtual machines that communicate with each other within subnets marked as ‘Encryption Enabled.' It also utilizes Datagram Transport Layer Security (DTLS) on the virtual subnet to encrypt packets. DTLS protects against eavesdropping, tampering, and forgery by anyone with access to the physical network.

Virtual network encryption requires:
- Encryption certificates installed on each of the SDN-enabled Hyper-V hosts.
- A credential object in the Network Controller referencing the thumbprint of that certificate.
- Configuration on each of the Virtual Networks contain subnets that require encryption.

Once you enable encryption on a subnet, all network traffic within that subnet is encrypted automatically, in addition to any application-level encryption that may also take place.  Traffic that crosses between subnets, even if marked as encrypted, is sent unencrypted automatically. Any traffic that crosses the virtual network boundary also gets sent unencrypted.

>[!TIP]
>If you must restrict applications to only communicate on the encrypted subnet, you can use Access Control Lists (ACLs) only to allow communication within the current subnet. For more information, see [Use Access Control Lists (ACLs) to Manage Datacenter Network Traffic Flow](/azure-stack/hci/manage/use-datacenter-firewall-powershell).

### Next steps

[Configure encryption for a virtual network](./sdn-config-vnet-encryption.md)
