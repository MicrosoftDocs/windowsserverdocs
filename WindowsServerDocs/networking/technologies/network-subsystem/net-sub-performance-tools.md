---
title: Performance Tools for Network Workloads
description: Learn about performance tools including the Client to Server Traffic tool and TCP/IP Window Size. 
ms.topic: article
ms.assetid: c7789781-87e8-464e-981b-af887d01badd
manager: dcscontentpm
ms.author: wscontent
author: Teresa-Motiv
ms.date: 10/27/2021
---

# Performance Tools for Network Workloads

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Azure Stack HCI, versions 21H2 and 20H2

You can use this topic to learn about performance tools.

This topic contains sections about the Client to Server Traffic tool and TCP/IP Window Size.

##  <a name="bkmk_tuning"></a> Client to Server Traffic tool

The Client to Server Traffic \(ctsTraffic\) tool provides you with the ability to create and verify network traffic.

For more information, and to download the tool, see [ctsTraffic (Client-To-Server Traffic)](https://github.com/Microsoft/ctsTraffic).

##  <a name="bkmk_size"></a> TCP/IP Window Size

For 1 GB adapters, the settings shown in the previous table should provide good throughput because NTttcp sets the default TCP window size to 64 K through a specific logical processor option \(SO_RCVBUF\) for the connection. This provides good performance on a low-latency network.

In contrast, for high-latency networks or for 10 GB adapters, the default TCP window size value for NTttcp yields less than optimal performance. In both cases, you must adjust the TCP window size to allow for the larger bandwidth delay product.

You can statically set the TCP window size to a large value by using the **-rb** option. This option disables TCP Window Auto-Tuning, and we recommend using it only if the user fully understands the resultant change in TCP/IP behavior. By default, the TCP window size is set at a sufficient value and adjusts only under heavy load or over high-latency links.

For more information, see [Network Subsystem Performance Tuning](net-sub-performance-top.md).
