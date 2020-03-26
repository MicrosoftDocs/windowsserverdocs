---
title: Performance Tools for Network Workloads
description: This topic is part of the Network Subsystem Performance Tuning guide for Windows Server 2016.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: c7789781-87e8-464e-981b-af887d01badd
manager: dougkim
ms.author: lizross
author: eross-msft
ms.date: 07/16/2018
---

# Performance Tools for Network Workloads

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn about performance tools.

This topic contains sections about the Client to Server Traffic tool, TCP/IP Window Size, and Microsoft Server Performance Advisor.

##  <a name="bkmk_tuning"></a> Client to Server Traffic tool

The Client to Server Traffic \(ctsTraffic\) tool provides you with the ability to create and verify network traffic.

For more information, and to download the tool, see [ctsTraffic (Client-To-Server Traffic)](https://github.com/Microsoft/ctsTraffic).
  
##  <a name="bkmk_size"></a> TCP/IP Window Size

For 1 GB adapters, the settings shown in the previous table should provide good throughput because NTttcp sets the default TCP window size to 64 K through a specific logical processor option \(SO_RCVBUF\) for the connection. This provides good performance on a low-latency network.  

In contrast, for high-latency networks or for 10 GB adapters, the default TCP window size value for NTttcp yields less than optimal performance. In both cases, you must adjust the TCP window size to allow for the larger bandwidth delay product.  

You can statically set the TCP window size to a large value by using the **-rb** option. This option disables TCP Window Auto-Tuning, and we recommend using it only if the user fully understands the resultant change in TCP/IP behavior. By default, the TCP window size is set at a sufficient value and adjusts only under heavy load or over high-latency links.  

##  <a name="bkmk_advisor"></a> Microsoft Server Performance Advisor

Microsoft Server Performance Advisor \(SPA\) helps IT administrators collect metrics to identify, compare, and diagnose potential performance issues in a Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008 deployment. 

SPA generates comprehensive diagnostic reports and charts, and it provides recommendations to help you quickly analyze issues and develop corrective actions.  
  
 For more information and to download the advisor, see [Microsoft Server Performance Advisor](https://msdn.microsoft.com/library/windows/hardware/dn481522.aspx) in the Windows Hardware Dev Center.

For links to all topics in this guide, see [Network Subsystem Performance Tuning](net-sub-performance-top.md).