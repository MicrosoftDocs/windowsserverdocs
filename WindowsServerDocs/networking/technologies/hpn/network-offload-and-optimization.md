---
title: Network offload and optimization technologies
description: Learn about the different network offload and optimization features available in Windows Server 2016 and discuss how they help make networking more efficient.
ms.topic: article
ms.assetid: 0cafb1cc-5798-42f5-89b6-3ffe7ac024ba
manager: dougkim
ms.author: jgerend
author: JasonGerend
ms.date: 10/26/2021
---

# Network offload and optimization technologies

>Applies to: Windows Server 2022, Windows Server 2019, Azure Stack HCI, versions 21H2 and 20H2

In this topic, we give you an overview of the different network offload and optimization features available in Windows Server 2016 and discuss how they help make networking more efficient. These technologies include Software Only (SO) features and technologies, Software and Hardware (SH) integrated features and technologies, and Hardware Only (HO) features and technologies. To learn more, see [Host network requirements for Azure Stack HCI](/azure-stack/hci/concepts/host-network-requirements).

The three categories of networking features available in Windows Server 2016 are:

1.  [Software only (SO) features and technologies](hpn-software-only-features.md): These features are implemented as part of the OS and are independent of the underlying NIC(s). Sometimes these features will require some tuning of the NIC for optimal operation. Examples of these include Hyper-V features such as vmQoS, ACLs, and non-Hyper-V features like NIC Teaming.

2.  [Software and Hardware (SH) integrated features and technologies](hpn-software-hardware-features.md): These features have both software and hardware components. The software is intimately tied to hardware capabilities that are required for the feature to work. Examples of these include VMMQ, VMQ, Send-side IPv4 Checksum Offload, and RSS.

3.  [Hardware Only (HO) features and technologies](hpn-hardware-only-features.md): These hardware accelerations improve networking performance in conjunction with the software but are not intimately part of any software feature. Examples of these include Interrupt Moderation, Flow Control, and Receive-side IPv4 Checksum Offload.

4. [NIC advanced properties](hpn-nic-advanced-properties.md): You can manage NICs and all the features via Windows PowerShell using the NetAdapter cmdlet.  You can also manage NICs and all the features using Network Control Panel (ncpa.cpl).

>[!TIP]
>- SO features and technologies are available in all hardware architectures, regardless of NIC speed or NIC capabilities.
>
>- SH and HO features are available only when your network adapter supports the features or technologies.

---
