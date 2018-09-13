---
title: NIC Teaming and Virtual Local Area Networks (VLANs)
description: In this topic, we provide you information about using NIC Teaming with virtual local area networks (VLANs) on both host computers and VMs.
manager: elizapo
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - networking-nict
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a8ca82f6-a543-4430-98b9-06ba383b610d
ms.author: pashort
author: shortpatti
ms.date: 09/12/2018
---
# NIC Teaming and Virtual Local Area Networks (VLANs)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

In this topic, we provide you information about using NIC Teaming with virtual local area networks (VLANs) on both host computers and VMs.  
  
## Team interfaces and VLANs  
When you use NIC Teaming, creating multiple team interfaces allows a host to connect to different VLANs at the same time. 
Configure your environment using the following guidelines:
  
- Before you enable NIC Teaming, configure the physical switch ports connected to the teaming host to use trunk (promiscuous) mode. The physical switch should pass all traffic to the host for filtering without modifying the traffic.  

- Do not configure VLAN filters on the NICs by using the NIC advanced properties settings. Let the NIC Teaming software or the Hyper-V Virtual Switch (if present) perform VLAN filtering.  
  
## Use VLANs with NIC Teaming in a VM  
When a team connects to a Hyper-V Virtual Switch, all VLAN segregation must be done in the Hyper-V Virtual Switch rather than in NIC Teaming.  

Plan to use VLANs in a VM configured with a NIC Team using the following guidelines:
  
-	The preferred method of supporting multiple VLANs in a VM is to configure the VM with multiple ports on the Hyper-V Virtual Switch and associate each port with a VLAN. Never team these ports in the VM because doing so causes network communication problems.  

-	If the VM has multiple SR-IOV Virtual Functions (VFs), ensure that they are on the same VLAN before teaming them in the VM. It's easily possible to configure the different VFs to be on different VLANs and doing so causes network communication problems.  
 
  
## Managing network interfaces and VLANs  
If you must have more than one VLAN exposed into a guest operating system, consider renaming the Ethernet interfaces to clarify which VLAN is assigned to the interface. For example, if the **Ethernet** interface is associated with VLAN 12 and the **Ethernet 2** interface is associated with VLAN 48, rename the interface Ethernet to **EthernetVLAN12** and the other to **EthernetVLAN48**. You can rename interfaces by using the Windows PowerShell command **Rename-NetAdapter** or by performing the following procedure.  
  
**Rename a network adapter**  
  
1.  In Server Manager, in the **Properties** pane for the server whose network adapters you want to rename, click the link to the right of the network adapter name. For example, if the network adapter is named **Ethernet**, click either the IP address or other blue text to the right of the name Ethernet. The **Network Connections** folder opens.  
  
2.  Right-click the network adapter that you want to rename, and select  **Rename**.  
  
3.  Type the new name for the network adapter and press ENTER.  
  
## See Also  
[NIC Teaming MAC Address Use and Management](NIC-Teaming-MAC-Address-Use-and-Management.md)  
[NIC Teaming](NIC-Teaming.md)  
  

