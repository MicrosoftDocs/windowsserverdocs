---
title: Audit IPsec Driver
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 61b2ab37-0aee-4f8c-a755-dcfcac84647b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit IPsec Driver

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit IPsec Driver**, which determines whether the operating system generates audit events for the activities of the IPsec driver.

The IPsec driver, using the IP Filter List from the active IPsec policy, watches for outbound IP packets that must be secured and inbound IP packets that must be verified and decrypted. This security policy setting reports on the following activities of the IPsec driver:

-   Startup and shutdown of IPsec services.

-   Packets dropped due to integrity-check failure.

-   Packets dropped due to replay-check failure.

-   Packets dropped due to being in plaintext.

-   Packets received with an incorrect Security Parameter Index (SPI). (This can indicate malfunctioning hardware or interoperability problems.)

-   Failure to process IPsec filters.

A high rate of packet drops by the IPsec filter driver may indicate attempts to gain access to the network by unauthorized systems.

Failure to process IPsec filters poses a potential security risk because some network interfaces may not get the protection that is provided by the IPsec filter.

Event volume: Medium

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------|---------|
|4960|IPsec dropped an inbound packet that failed an integrity check. If this problem persists, it could indicate a network issue or that packets are being modified in transit to this computer. Verify that the packets sent from the remote computer are the same as those received by this computer. This error might also indicate interoperability problems with other IPsec implementations.|
|4961|IPsec dropped an inbound packet that failed a replay check. If this problem persists, it could indicate a replay attack against this computer.|
|4962|IPsec dropped an inbound packet that failed a replay check. The inbound packet had too low a sequence number to ensure it was not a replay.|
|4963|IPsec dropped an inbound clear text packet that should have been secured. This is usually due to the remote computer changing its IPsec policy without informing this computer. This could also be a spoofing attack attempt.|
|4965|IPsec received a packet from a remote computer with an incorrect Security Parameter Index (SPI). This is usually caused by malfunctioning hardware that is corrupting packets. If these errors persist, verify that the packets sent from the remote computer are the same as those received by this computer. This error may also indicate interoperability problems with other IPsec implementations. In that case, if connectivity is not impeded, then these events can be ignored.|
|5478|IPsec Services has started successfully.|
|5479|IPsec Services has been shut down successfully. The shutdown of IPsec Services can put the computer at greater risk of network attack or expose the computer to potential security risks.|
|5480|IPsec Services failed to get the complete list of network interfaces on the computer. This poses a potential security risk because some of the network interfaces may not get the protection provided by the applied IPsec filters. Use the IP Security Monitor snap-in to diagnose the problem.|
|5483|IPsec Services failed to initialize RPC server. IPsec Services could not be started.|
|5484|IPsec Services has experienced a critical failure and has been shut down. The shutdown of IPsec Services can put the computer at greater risk of network attack or expose the computer to potential security risks.|
|5485|IPsec Services failed to process some IPsec filters on a plug-and-play event for network interfaces. This poses a potential security risk because some of the network interfaces may not get the protection provided by the applied IPsec filters. Use the IP Security Monitor snap-in to diagnose the problem.|

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)


