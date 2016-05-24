---
title: Quality Windows Audio Video Experience (qWave)
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7c450b13-2e1b-4e4e-96bd-0347f7f7295f
---
# Quality Windows Audio Video Experience (qWave)
qWave is a collection of QoS\-related software modules that run on qWave\-enabled devices in non\-enterprise environments, such as a home network or small\-office network. qWave supports multiple audio\/video streams \(real\-time flows requiring QoS\) and data streams \(best\-effort flows, such as e\-mail\) simultaneously over the network, while providing a high\-quality audio\/video \(A\/V\) user experience. The devices cooperate to ensure that data streams \(for which the application has requested QoS\) receive the level of quality that they were granted upon admission to the network. Because qWave is targeted for home and small\-office A\/V scenarios, it is typically disabled in other environments, such as enterprise networks.  
  
## qWave Overview  
QoS refers to the mechanisms that are implemented to provide a desired level of network service to an application on IP\-based networks. The network service parameters might include bandwidth, jitter, latency, and packet loss. The desired level of network service can be achieved by explicitly reserving bandwidth on the network for a service, or by providing preferential service to selected network traffic while providing best\-effort service to all other traffic.  
  
qWave is a collection of QoS\-related software modules—first included on computers running [!INCLUDE[firstref_vista](../Token/firstref_vista_md.md)]—in non\-enterprise environments, such as a home network or small\-office network. qWave supports multiple A\/V streams \(real\-time flows requiring QoS\), and data streams \(best\-effort flows, such as e\-mail\) simultaneously over the network, while providing a high\-quality A\/V user experience. The devices cooperate to ensure that data streams for which the application has requested QoS receive the level of quality that they were granted upon admission to the network. Because qWave is targeted for home and small\-office A\/V scenarios, it is typically disabled in other environments, such as enterprise networks.  
  
Reservation techniques\-\-such as RSVP\-\-are not implemented for home A\/V streaming. Bandwidth reservation guarantees are meaningless if the Wi\-Fi station moves out of the broadcast range of the wireless access point \(wireless AP\) or if some obstruction or interference causes a drop in link bandwidth. Additionally, for price\-sensitive home networking markets, reservation\-based QoS features might make devices cost\-prohibitive.  
  
Instead, qWave provides preferential service for traffic prioritization and other throughput, range, and stability\-enhancement mechanisms. These mechanisms are available in many wireless APs, wireless network adapters and other devices. These mechanisms include 802.1p support for switches, hubs, and network adapters, as well as Wireless Multimedia Extensions \(WME\) support in wireless APs.  
  
qWave provides the best experience when both the source and the target devices are qWave\-enabled, and when the network devices support traffic prioritization. However, qWave also provides an improved experience without priority support in either the network or legacy devices.  
  
On Windows Server platforms, qWave provides only rate\-of\-flow and prioritization services.  
  
## See Also  
[Quality of Service &#40;QoS&#41; Overview](../Topic/Quality-of-Service--QoS--Overview.md)  
  
