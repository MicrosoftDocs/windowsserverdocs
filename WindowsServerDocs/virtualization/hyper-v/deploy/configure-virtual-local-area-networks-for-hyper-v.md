---
title: Configure virtual local area networks for Hyper-V
description: Learn how to configure a virtual local area network (VLAN) for use by virtual machines on a Hyper-V host.
ms.topic: how-to
ms.author: roharwoo
author: robinharwood
ms.date: 08/18/2025
---
# Configure virtual local area networks for Hyper-V

Virtual local area networks (VLANs) offer one way to isolate network traffic. VLANs are configured in switches and routers that support 802.1q. If you configure multiple VLANs and want communication to occur between them, you need to configure the network devices to allow that.

To set up VLANs, make sure you have:

- A physical network adapter and driver that supports 802.1q VLAN tagging.
- A physical network switch that supports 802.1q VLAN tagging.

On the host, set up the virtual switch to let network traffic on the physical switch port for the VLAN IDs you use with virtual machines. Then, set up the virtual machine to specify the VLAN it uses for all network communications.

## Allow a virtual switch to use a VLAN

1. In Hyper-V Manager, select **Virtual Switch Manager** from the **Actions** pane on the right.

1. In **Virtual Switch Manager**, under **Virtual Switches** on the left, select a virtual switch connected to a physical network adapter that supports VLANs.

1. Under **VLAN ID** in the right pane, select **Enable virtual LAN identification for management operating system** and then type a number for the VLAN ID.

1. Select **OK**.

All traffic that goes through the physical network adapter connected to the virtual switch is tagged with the VLAN ID you set on the virtual switch and virtual machines.

## Allow a virtual machine to use a VLAN

1. In Hyper-V Manager, under **Virtual Machines**, right-click the appropriate virtual machine and select **Settings**. Or, select the machine and then select **Settings** under the machine name in the right pane.

1. On the **Settings** screen, under **Hardware** in the left pane, select a **Network Adapter** that has a virtual switch that's set up with a VLAN.

1. Under **VLAN ID** in the right pane, select **Enable virtual LAN identification**, and then type the same VLAN ID as the one you specified for the virtual switch.

1. Select **OK**.

If the virtual machine needs to use more VLANs, do one of the following:

- Connect more virtual network adapters to appropriate virtual switches and assign the VLAN IDs. Make sure to configure the IP addresses correctly, and that the traffic you want to route through the VLAN also uses the correct IP address.

- Configure the virtual network adapter in trunk mode by using the [Set-VMNetworkAdapterVlan](/powershell/module/hyper-v/set-vmnetworkadaptervlan) cmdlet.

## Related content

[Hyper-V virtual switch](../../hyper-v/virtual-switch.md)

