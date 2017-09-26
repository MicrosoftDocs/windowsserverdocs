---
title: Virtual Network Encryption
description: This topic provides information on Virtual Network Encryption for Software Defined Networking in Windows Server, version 1709
manager: brianlic
ms.prod: windows-server-threshold
ms.technology: networking-hv-switch
ms.topic: get-started-article
ms.assetid: 7da0f509-7b02-4a0f-90fb-d97c83a2bc4e
ms.author: jamesmci
author: 
---
# Virtual Network Encryption

Virtual Network Encryption provides the ability for the virtual network traffic to be encrypted between Virtual Machines that communicate with each other within subnets that are marked as "Encryption Enabled".

This feature utilizes Datagram Transport Layer Security (DTLS) on the virtual subnet to encrypt the packets.  DTLS provides protection against eavesdropping, tampering and forgery by anyone with access to the physical network.

Virtual Network encryption requries an encryption certificate to be installed on each of the SDN enabled Hyper-V hosts, a credential object in the Network Controller referencing the thumbprint of that certificate, and configuration on each of the Virtual Networks that contain subnets requiring encryption.

Once encryption is enabled on a subnet, all network traffic within that subnet is encrypted automatically.  This will be in addition to any application level encryption that may also take place.  Traffic that crosses between subnets, even if both of the subnets are marked as encrypted is automatically sent unencrypted.  Any traffic that crosses the virtual network boundary is also sent unencrypted.

For information on configuring Virtual Network Encryption, see [Configure Encryption for a Virtual Network](./sdn-1709-config-encryption.md).

If you must restrict applications to only communicate on the encrypted subnet.  You can use Access Control Lists (ACLs) to only allow communication within the current subnet.  

For information on configuring Access Control Lists, see [Use Access Control Lists (ACLs) to Manage Datacenter Network Traffic Flow](../manage/use-acls-for-traffic-flow.md).