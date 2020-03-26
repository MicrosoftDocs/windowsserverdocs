---
ms.assetid: 
title: Insider Preview for HPN features in Windows Server 2019
description: Learn about the new High-Performance Networking features in Windows Server 2019.
manager: dougkim
author: eross-msft
ms.author: lizross
ms.date: 09/12/2018
ms.topic: article
ms.prod: windows-server
ms.technology: networking
---

# New HPN Features in Windows Server 2019


## Dynamic vRSS and VMMQ

>Applies to: Windows Server 2019

In the past, Virtual Machine Queues and Virtual Machine Multi-Queues enabled much higher throughput to individual VMs as network throughputs first reached the 10GbE mark and beyond. Unfortunately, the planning, baselining, tuning, and monitoring required for success became a large undertaking; often more than the IT administrator intended to spend. 

Windows Server 2019 improves these optimizations by dynamically spreading and tuning the processing of network workloads as required. Windows Server 2019 ensures peak efficiency and removes the configuration burden for IT administrators.

For more information, see:

-   [Announcement blog](https://blogs.technet.microsoft.com/networking/2018/08/22/netperf4vw/)

-   [Validation Guide for the IT Pro](https://aka.ms/DVMMQ-Validation)

## Receive Segment Coalescing (RSC) in the vSwitch

>Applies to: Windows Server 2019 and Windows 10, version 1809

Receive Segment Coalescing (RSC) in the vSwitch is an enhancement that coalesces multiple TCP segments into a larger segment before data traversing the vSwitch. The large segment improves networking performance for virtual workloads.

Previously, this was an offload implemented by the NIC. Unfortunately, this was disabled the moment you attached the adapter to a virtual switch. RSC in the vSwitch on Windows Server 2019 and Windows 10 October 2018 Update removes this limitation.

By default, RSC in the vSwitch is enabled on external virtual switches.

For more information, see:

-  [Announcement blog](https://blogs.technet.microsoft.com/networking/2018/08/22/netperf4vw/)

-  [Validation Guide for the IT Pro](https://aka.ms/RSC-Validation)
