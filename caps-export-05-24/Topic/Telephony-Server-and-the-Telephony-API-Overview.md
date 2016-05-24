---
title: Telephony Server and the Telephony API Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 04e25f15-35df-4c3c-92d4-23a340716dfb
author: coreyp
---
# Telephony Server and the Telephony API Overview
The Telephony service in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides distributed access to shared telephony devices. For example, a LAN\-based server may have multiple connections to a local telephone switch or private branch exchange \(PBX\). Telephony uses the Telephony Application Programming Interface \(TAPI\) to enable computer programs to communicate with the shared telephony services. TAPI operations that are invoked by a client are forwarded over the network to the server. The server can then use a non\-Microsoft call control between itself and the PBX to fulfill the client's call control requests. TAPI services in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] enable programs that effectively work the same way over intranets, the Internet, and traditional public phone networks.  
  
TAPI services in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] have not significantly changed since Windows Server 2003. The documentation for TAPI has not been updated for this version of Windows. You can find all of the documentation for TAPI at see [Telephony](http://go.microsoft.com/fwlink/p/?linkid=236090) in the Windows Server TechCenter.  
  
