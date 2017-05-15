---
title: vRSS Frequently Asked Questions
description: You can use this topic for commonly asked questions and answers about vRSS in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 61ae242e-82a8-430d-b07d-52b86c01e686
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# vRSS Frequently Asked Questions

Following are some commonly asked questions and answers about using vRSS.

### Does vRSS work with hyper\-threaded processor cores?

No. Both vRSS and VMQ ignore hyper\-threaded processor cores.

### vRSS is enabled, but how do I know if it is working? 

You’ll be able to tell vRSS is working by opening the task manager in your virtual machine \(VM\) and viewing the virtual processor utilization. If there are multiple connections established to the virtual machine, you can see more than one core above 0% utilization.

The same holds true for the Hyper\-V host. vRSS changes the VMQ algorithm to expand VM processing to more than 1 core for Hyper\-V Virtual Switch processing. If a single core reaches 80% utilization, you can see the traffic start to extend to multiple cores.
  
### Are there any Performance Monitor counters I can check?

In Performance Monitor, there are three counters that can help you evaluate vRSS performance. Open Performance Monitor, right\-click on the graph, and then click **Add Counters**. 

Click the **Hyper-V Virtual Switch Processor** category and the counters are under the following items.

1. **Number of VMQs** – The number of VMQ processors on affinitized to that processor

2. **Packets from External** – Packets indicated to a processor from any external NIC

3. **Packets from Internal** – Packets indicated to a processor from any internal interfaces, ie vNIC (Host NIC), vmNIC.

### I’m looking at the host and not all of the processors are being used. It looks like every other one is being skipped.  
  
Check to see if hyper threading is enabled. Both VMQ and vRSS are designed to skip hyper\-threaded cores.

### Are there different Windows PowerShell commands for RSS and vRSS?

No, you can use the same commands for both RSS and vRSS. For more information, see [Windows PowerShell Commands for RSS and vRSS](vrss-wps.md).


