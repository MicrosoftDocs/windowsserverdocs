---
title: Troubleshooting NIC Teaming
description: This topic provides information about troubleshooting NIC Teaming in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - networking-nict
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fdee02ec-3a7e-473e-9784-2889dc1b6dbb
ms.author: jamesmci
author: jamesmci
---
# Troubleshooting NIC Teaming

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic provides information about troubleshooting NIC Teaming, and contains the following sections, which describe possible causes of issues with NIC Teaming.  
  
-   [Hardware that doesn't conform to specification](#bkmk_hardware)  
  
-   [Physical switch security features](#bkmk_switch)  
  
-   [Disabling and Enabling with Windows PowerShell](#bkmk_ps)  
  
## <a name="bkmk_hardware"></a>Hardware that doesn't conform to specification  
When hardware implementations of standard protocols do not conform to specification, NIC Teaming performance might be affected.  
  
During normal operation, NIC Teaming may send packets from the same IP address, yet with multiple different source media access control (MAC) addresses. According to protocol standards, the receivers of these packets must resolve the IP address of the host or VM to a specific MAC address rather than responding to the MAC address from which the packet was received.  Clients that correctly implement the address resolution protocols, IPv4's Address Resolution Protocol (ARP) or IPv6's neighbor discovery protocol (NDP), will send packets with the correct destination MAC address (the MAC address of the VM or host that owns that IP address).  
  
Some embedded hardware, however, does not correctly implement the address resolution protocols, and also might not explicitly resolve an IP address to a MAC address using ARP or NDP.  A storage area network (SAN) controller is an example of a device that might perform in this manner. Non-conforming devices copy the source MAC address that is contained in a received packet and use that as the destination MAC address in the corresponding outgoing packets.  
  
This results in packets being sent to the wrong destination MAC address. Because of this, the packets are dropped by the Hyper-V Virtual Switch because they don't match any known destination.  
  
If you are having trouble connecting to SAN controllers or other embedded hardware, you should take packet captures and determine whether your hardware is correctly implementing ARP or NDP, and contact your hardware vendor for support.  
  
## <a name="bkmk_switch"></a>Physical switch security features  
Depending on configuration, NIC Teaming may send packets from the same IP address with multiple different source MAC addresses.  This can trip up security features on the physical switch such as dynamic ARP inspection or IP source guard, especially if the physical switch is not aware that the ports are part of a team. This can occur if you configure NIC Teaming in Switch Independent mode.  You should inspect the switch logs to determine whether switch security features are causing connectivity problems with NIC Teaming.  
  
## <a name="bkmk_ps"></a>Disabling and enabling network adapters by using Windows PowerShell  
A common reason for a NIC Team to fail is that the team interface is disabled. In many cases, the interface is disabled by accident when the following Windows PowerShell sequence of commands is run:  
  
```  
Disable-NetAdapter *  
Enable-NetAdapter *  
```  
  
This sequence of commands does not enable all of the NetAdapters that it disabled.  
  
This is because disabling all of the underlying physical member NICs causes the NIC team interface to be removed and no longer show up in Get-NetAdapter. Because of this, the **Enable-NetAdapter \*** command does not enable the NIC Team, because that adapter is removed.  
  
The **Enable-NetAdapter \*** command does, however, enable the member NICs, which then (after a short time) causes the team interface to be recreated. In this circumstance, the team interface is still in a "disabled" state because it has not been re-enabled. Enabling the team interface after it is recreated will allow network traffic to begin to flow again.  
  
## See Also  
[NIC Teaming](NIC-Teaming.md)  
  


