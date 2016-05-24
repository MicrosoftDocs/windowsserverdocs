---
title: Configuring virtual local area networks (VLANs)
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8510a709-001c-4eee-b6d6-c451e8a8a836
author: cwatsonmsft
---
# Configuring virtual local area networks (VLANs)
Virtual local area networks \(VLANs\) are configured in switches and routers that support 802.1q. Network administrators use VLANs to create separate network broadcast domains that share the same network switch ports. A router or device that is connected to both VLANs is required to enable communications between VLANs. If you are using VLANs configured in your environment you will want to make sure that you create virtual switches that support VLANs and properly configure your virtual machines. You will need the following to configure VLANs:  
  
-   A physical network adapter and driver that supports 802.1q VLAN tagging.  
  
-   A physical network switch that supports 802.1q VLAN tagging.  
  
On the host, you will need to configure the virtual switch to allow network traffic on the physical switch port. This is for the VLAN IDs that you want to use internally with virtual machines. Next, you configure the virtual machine to specify the virtual LAN that the virtual machine will use for all network communications.  
  
#### To allow Hyper\-V to use  VLANs  
  
1.  Open Hyper\-V Manager.  
  
2.  From the Actions menu, click **Virtual Switch Manager**.  
  
3.  Select the virtual switch you want to edit, and, in the right pane, check to select **Enable virtual LAN identification**.  
  
4.  Enter a number for the VLAN ID. All traffic for the host operating system that goes through the network adapter will be tagged with the VLAN ID you set.  
  
#### To allow a virtual machine to use a VLAN  
  
1.  Open Hyper\-V Manager.  
  
2.  In the results pane, under **Virtual Machines**, select the virtual machine that you want to configure to use a VLAN.  
  
3.  In the **Action** pane, under the virtual machine name, click **Settings**.  
  
4.  Under **Hardware**, select the virtual switch connected to the external virtual network.  
  
5.  In the right pane, select **Enable virtual LAN identification**, and then enter the VLAN ID you plan to use.  
  
If you need the virtual machine to communicate using additional VLANs you can do one of the following:  
  
-   Connect additional network adapters to the appropriate virtual switch and assign the VLAN ID. Make sure to configure the IP addresses correctly and that the traffic you want to move across the VLAN is also using the correct IP address.  
  
-   Configure the virtual network word adapter in trunk mode using the Set\-VMNetworkAdapterVlan [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlt.  
  
## See Also  
[Set\-VMNetworkAdapterVlan](http://technet.microsoft.com/library/hh848475.aspx)  
[Hyper\-V Virtual Switch Overview](assetId:///e6ec46af-6ef4-49b3-b1f1-5268dc03f05b)  
  
