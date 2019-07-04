---
title: Troubleshooting NIC Teaming
description: This topic provides information about troubleshooting NIC Teaming in Windows Server 2016.
manager: dougkim
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-nict
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fdee02ec-3a7e-473e-9784-2889dc1b6dbb
ms.author: pashort
author: shortpatti
ms.date: 09/13/2018
---
# Troubleshooting NIC Teaming

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

In this topic, we discuss ways to troubleshoot NIC Teaming, such as hardware and physical switch securities.  When hardware implementations of standard protocols don't conform to specifications, NIC Teaming performance might be affected. Also, depending on the configuration, NIC Teaming may send packets from the same IP address with multiple MAC addresses tripping up security features on the physical switch.

  
## Hardware that doesn't conform to specification  
  
During normal operation, NIC Teaming may send packets from the same IP address, yet with multiple MAC addresses. According to protocol standards, the receivers of these packets must resolve the IP address of the host or VM to a specific MAC address rather than responding to the MAC address from the receiving packet.  Clients that correctly implement the address resolution protocols (ARP and NDP) send packets with the correct destination MAC addresses—that is, the MAC address of the VM or host that owns that IP address. 
  
Some embedded hardware does not correctly implement the address resolution protocols, and also might not explicitly resolve an IP address to a MAC address using ARP or NDP.  For example, a storage area network (SAN) controller might perform in this manner. Non-conforming devices copy the source MAC address from a received packet and then use it as the destination MAC address in the corresponding outgoing packets, resulting in packets being sent to the wrong destination MAC address. Because of this, the packets are dropped by the Hyper-V Virtual Switch because they don't match any known destination.  
  
If you are having trouble connecting to SAN controllers or other embedded hardware, you should take packet captures to determine if your hardware is correctly implementing ARP or NDP, and contact your hardware vendor for support.  

  
## Physical switch security features  
Depending on the configuration, NIC Teaming may send packets from the same IP address with multiple source MAC addresses tripping up security features on the physical switch. For example, Dynamic ARP inspection or IP source guard, especially if the physical switch is not aware that the ports are part of a team, which occurs when you configure NIC Teaming in Switch Independent mode. Inspect the switch logs to determine if switch security features are causing connectivity problems. 
  
## Disabling and enabling network adapters by using Windows PowerShell  

A common reason for a NIC Team to fail is that the team interface is disabled, and in many cases, by accident when running a sequence of commands.  This particular sequence of commands does not enable all of the NetAdapters disabled because disabling all of the underlying physical members of NICs removes the NIC team interface. 

In this case, the NIC team interface no longer shows in Get-NetAdapter, and because of this, **Enable-NetAdapter \\*** does not enable the NIC Team. The **Enable-NetAdapter \\*** command does, however, enable the member NICs, which then (after a short time) recreates the team interface. The team interface remains in the "disabled" state until re-enabled, allowing network traffic to begin flowing. 

The following Windows PowerShell sequence of commands may disable the team interface by accident:  
  
```PowerShell 
Disable-NetAdapter *  
Enable-NetAdapter *  
```  
  

  
## Related topics  
- [NIC Teaming](NIC-Teaming.md): In this topic, we give you an overview of Network Interface Card (NIC) Teaming in Windows Server 2016. NIC Teaming allows you to group between one and 32 physical Ethernet network adapters into one or more software-based virtual network adapters. These virtual network adapters provide fast performance and fault tolerance in the event of a network adapter failure.   

- [NIC Teaming MAC address use and management](NIC-Teaming-MAC-Address-Use-and-Management.md): When you configure a NIC Team with switch independent mode and either address hash or dynamic load distribution, the team uses the media access control (MAC) address of the primary NIC Team member on outbound traffic. The primary NIC Team member is a network adapter selected by the operating system from the initial set of team members.

- [NIC Teaming settings](nic-teaming-settings.md): In this topic, we give you an overview of the NIC Team properties such as teaming and load balancing modes. We also give you details about the Standby adapter setting and the Primary team interface property. If you have at least two network adapters in a NIC Team, you do not need to designate a Standby adapter for fault tolerance.
  


