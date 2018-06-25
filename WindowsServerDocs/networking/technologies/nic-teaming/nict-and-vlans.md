---
title: NIC Teaming and Virtual Local Area Networks (VLANs)
description: This topic provides information about using NIC Teaming with virtual Local Area Networks (VLANs) on both host computers and VMs in Windows Server 2016.
manager: brianlic
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
---
# NIC Teaming and Virtual Local Area Networks (VLANs)

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic provides information about using NIC Teaming with virtual Local Area Networks (VLANs) on both host computers and VMs, and includes the following sections.  
  
-   [Team interfaces and VLANs](#bkmk_team)  
  
-   [Using VLANs with NIC Teaming in a VM](#bkmk_vm)  
  
-   [Managing network interfaces and VLANs](#bkmk_managing)  
  
## <a name="bkmk_team"></a>Team interfaces and VLANs  
When you use NIC Teaming, the only reason to create multiple team interfaces is to logically divide inbound traffic by virtual LAN (VLAN). Creating multiple team interfaces allows a host to be connected to different VLANs at the same time.  
  
When you use NIC Teaming with VLANs, ensure that you configure your environment using the following guidelines.  
  
1.  Before you enable NIC Teaming, configure the physical switch ports connected to the teaming host to use trunk (promiscuous) mode. The physical switch should pass all traffic to the host for filtering without modifying the traffic.  
  
2.  Do not configure VLAN filters on the NICs by using the NIC advanced properties settings. Let the NIC Teaming software or the Hyper-V Virtual Switch (if present) perform VLAN filtering.  
  
## <a name="bkmk_vm"></a>Using VLANs with NIC Teaming in a VM  
When a team is connected to a Hyper-V Virtual Switch, all VLAN segregation must be done in the Hyper-V Virtual Switch rather than in NIC Teaming.  
  
You can use the following guidelines when planning to use VLANs in a VM that is configured with a NIC Team.  
  
-   The preferred method of supporting multiple VLANs in a VM is to configure the VM with multiple ports on the Hyper-V Virtual Switch and associate each port with a VLAN. Never team these ports in the VM because doing so will cause network communication problems.  
  
-   If the VM has multiple SR-IOV Virtual Functions (VFs), ensure that they are on the same VLAN before teaming them in the VM. It's easily possible to configure the different VFs to be on different VLANs and doing so will cause network communication problems.  
  
## <a name="bkmk_managing"></a>Managing network interfaces and VLANs  
If you must have more than one VLAN exposed into a guest operating system, consider renaming the Ethernet interfaces to clarify which VLAN is assigned to the interface. For example, if the **Ethernet** interface is associated with VLAN 12 and the **Ethernet 2** interface is associated with VLAN 48, rename the interface Ethernet to **EthernetVLAN12** and the other to **EthernetVLAN48**. You can rename interfaces by using the Windows PowerShell command **Rename-NetAdapter** or by performing the following procedure.  
  
#### To rename a network adapter  
  
1.  In Server Manager, in the **Properties** pane for the server whose network adapters you want to rename, click the link to the right of the network adapter name. For example, if the network adapter is named **Ethernet**, click either the IP address or other blue text to the right of the name Ethernet. The **Network Connections** folder opens.  
  
2.  Right-click the network adapter that you want to rename, and select  **Rename**.  
  
3.  Type the new name for the network adapter and press ENTER.  
  
## See Also  
[NIC Teaming MAC Address Use and Management](NIC-Teaming-MAC-Address-Use-and-Management.md)  
[NIC Teaming](NIC-Teaming.md)  
  

