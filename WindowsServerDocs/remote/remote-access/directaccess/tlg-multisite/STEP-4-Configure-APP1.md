---
title: STEP 4 Configure APP1
description: This topic is part of the Test Lab Guide - Demonstrate a DirectAccess Multisite Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7000e80f-31b1-43c5-b51e-1469d26909e5
ms.author: pashort
author: shortpatti
---
# STEP 4 Configure APP1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Configure static IPv6 addressing and gateway settings to enable APP1 access to the 2-Corpnet subnet.  
  
- To configure the default gateway and DNS server. The multisite configuration uses the ROUTER1 computer as a default gateway. Configure the default gateway on APP1.  
  
## To configure the default gateway and DNS server  
  
1.  In the Server Manager console, click **Local Server**, and then in the **Properties** area, next to **Wired Ethernet Connection**, click the link.  
  
2.  In the **Network Connections** window, right-click **Wired Ethernet Connection**, and then click **Properties**.  
  
3.  On the **Wired Ethernet Connection Properties** dialog box, click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.  
  
4.  In **Default gateway**, type **10.0.0.254**, and in **Alternate DNS server**, type **10.2.0.1**, and then click **OK**.  
  
5.  On the **Wired Ethernet Connection Properties** dialog box, click **Internet Protocol Version 6 (TCP/IPv6)**, and then click **Properties**.  
  
6.  In **Default gateway**, type **2001:db8:1::fe**. In **Alternate DNS server**, type **2001:db8:2::1**, and then click **OK**.  
  
7.  On the **Wired Ethernet Connection Properties** dialog box, click **Close**, and then close the **Network Connections** window.  
  


