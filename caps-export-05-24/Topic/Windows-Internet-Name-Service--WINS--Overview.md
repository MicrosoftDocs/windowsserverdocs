---
title: Windows Internet Name Service (WINS) Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ac15802a-bfa3-4190-ba8c-455163872825
author: coreyp
---
# Windows Internet Name Service (WINS) Overview
Windows Internet Name Service \(WINS\) provides a dynamic replicated database service that can register and resolve NetBIOS names to IP addresses that are used on your network. The WINS service on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] enables a server to act as a NetBIOS name server that registers and resolves names for WINS\-enabled client computers on your network as described in the NetBIOS over TCP\/IP standards.  
  
WINS primarily supports clients that run early versions of the Windows operating system and applications that require NetBIOS. Later versions of Windows including Windows 2000 Server, Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Windows 2000, Windows XP, Windows Vista, Windows 7, [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] use Domain Name System \(DNS\) names in addition to NetBIOS names. Environments that include older computers that continue to use NetBIOS names on the same network as computers that use DNS names must use WINS servers in addition to the DNS servers.  
  
If all of your network computers are running one of these later versions of Windows, and you are not supporting any applications that require NetBIOS names, we recommend that you establish DNS as your only method of name resolution. However, before you consider decommissioning WINS servers, identify any computers or applications that rely on NetBIOS, and determine the impact of removing NetBIOS name support from the network. You might find that a critical application relies on NetBIOS \(with no alternative currently available\) in which case, you must continue to use WINS. For example, older versions of certain applications, such as Microsoft Systems Management Server \(SMS\) or Microsoft BackOffice Server client\/server mail configurations might require NetBIOS naming.  
  
The documentation for WINS has not been updated for this version of Windows. Aside from some software engineering changes that make WINS less vulnerable to malicious attack, WINS functionality has not changed from that available in Windows Server 2003.  
  
You can find all of the documentation for WINS at [Windows Internet Name Service](http://go.microsoft.com/fwlink/p/?linkid=49770) in the Windows Server TechCenter.  
  
