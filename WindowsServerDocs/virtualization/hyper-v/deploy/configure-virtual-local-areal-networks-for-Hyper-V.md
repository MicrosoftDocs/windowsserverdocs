---
title: Configure virtual local area networks for Hyper-V
description: "Gives instructions for configuring a virtual local area network (VLAN) for use by virtual machines on a Hyper-V host."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8510a709-001c-4eee-b6d6-c451e8a8a836
author: KBDAzure
ms.author: kathydav
ms.date: 10/11/2016
---
# Configure virtual local area networks for Hyper-V
Virtual local area networks \(VLANs\) offer one way to isolate network traffic. VLANs are configured in switches and routers that support 802.1q. If you configure multiple VLANs and want communication to occur between them, you'll need to configure the network devices to allow that.

You will need the following to configure VLANs:

- A physical network adapter and driver that supports 802.1q VLAN tagging.
- A physical network switch that supports 802.1q VLAN tagging.

On the host, you'll configure the virtual switch to allow network traffic on the physical switch port. This is for the VLAN IDs that you want to use internally with virtual machines. Next, you configure the virtual machine to specify the VLAN that the virtual machine will use for all network communications.

#### To allow a virtual switch to use a VLAN

1. Open Hyper\-V Manager.

2. From the Actions menu, click **Virtual Switch Manager**.

3. Under **Virtual Switches**, select a virtual switch connected to a physical network adapter that supports VLANs.

4. In the right pane, under VLAN ID, select **Enable virtual LAN identification** and then type a number for the VLAN ID.

    All traffic that goes through the physical network adapter connected to the virtual switch will be tagged with the VLAN ID you set.

#### To allow a virtual machine to use a VLAN

1. Open Hyper\-V Manager.

2. In the results pane, under **Virtual Machines**, select the appropriate virtual machine and then right-click **Settings**.

3. Under **Hardware**, select an virtual switch that's set up with a VLAN.

4. In the right pane, select **Enable virtual LAN identification**, and then type the same VLAN ID as the one you specified for the virtual switch.

If the virtual machine needs to use more VLANs, do one of the following:

- Connect more virtual network adapters to appropriate virtual switches and assign the VLAN IDs. Make sure to configure the IP addresses correctly and that the traffic you want to route through the VLAN also uses the correct IP address.

- Configure the virtual network adapter in trunk mode using the [Set\-VMNetworkAdapterVlan](https://technet.microsoft.com/library/hh848475.aspx) cmdlet.

## See Also

[Hyper\-V Virtual Switch](https://technet.microsoft.com/windows-server-docs/networking/technologies/hyper-v-virtual-switch/hyper-v-virtual-switch)
