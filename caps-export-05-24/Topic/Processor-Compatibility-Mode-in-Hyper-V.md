---
title: Processor Compatibility Mode in Hyper-V
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 16a161de-853f-4905-bdf4-54a01517311a
author: cwatsonmsft
---
# Processor Compatibility Mode in Hyper-V
Hyper\-V offers a feature called processor compatibility mode, which was first introduced in Windows Server 2008 R2. Processor compatibility mode allows you to move a running virtual machine or save state between virtualization hosts that use different generations of processors. This feature works by disabling a number of modern processor features, which can affect virtual machine performance. This document provides details about processor compatibility mode for HyperV.  
  
## When to use processor compatibility mode  
Processor compatibility mode is applicable to any virtual machine mobility scenario that does not involve rebooting the virtual machine. These include virtual machine live migration, save and restore, and production checkpoints.  
  
Virtual machines cannot be live migrated or saved and restored across virtualization hosts that use processors from different CPU manufacturers. For example, you cannot move running virtual machines or virtual machine saved state from a host with Intel processors to a host with AMD processors. If you must move a virtual machine in this case, the virtual machine must first be shut down, then restarted on the new host.  
  
If you plan to move virtual machines, without rebooting them, between virtualization hosts that may use different generations of processors, you should enable processor compatibility mode. For example, you would enable processor compatibility mode to ensure that you can live migrate your virtual machines between cluster nodes that use different processor feature sets. You could also use processor compatibility mode to save a virtual machine and restore it on a host computer that has a different processor feature set than the source host.  
  
## Why processor compatibility mode is needed  
Instruction set architecture \(ISA\) extensions are optimizations and features that are introduced by processor manufacturers. These features often improve performance or security by using specialized hardware for a particular task. For example, many media applications make use of processor features to speed up vector calculations. These features are rarely required for applications to run; they simply boost performance.  
  
The feature set that is available on a processor varies depending on its make, model, and age. Operating systems and application software typically enumerate the system’s processor feature set and capabilities when they are first launched. Software doesn’t expect the available processor features to change during their lifetime—and of course, this could never happen when running on a physical computer because processor features are static.  
  
However, virtual machine mobility features allow a running virtual machine to be migrated to a new virtualization host. If software in the virtual machine has detected and started using a particular processor feature, and it gets moved to a new virtualization host that lacks that capability, the software is likely to fail. This could result in the virtual machine crashing.  
  
To avoid these failures, Hyper\-V performs “pre\-flight” checks whenever a virtual machine live migration or save\/restore operation is initiated. These checks compare the set of processor features that are available to the virtual machine on the source host against the set of features that are available on the target host. If these feature sets don’t match, the migration or restore operation is cancelled.  
  
## How processor compatibility mode works  
Processor compatibility mode ensures that the set of processor features available to virtual machines across a disparate set of virtualization hosts will match by presenting only a limited set of processor features to the virtual machine. Processor compatibility mode hides newer processor instructions sets, typically those introduced within the last 10 years. However, hiding these features means that the guest operating system and application software cannot take advantage of these processor instruction set enhancements.  
  
For a complete list of features that are hidden for processor compatibility mode, refer to section 5.2.11 in the [Hypervisor Top\-Level Functional Specification](http://download.microsoft.com/download/A/B/4/AB43A34E-BDD0-4FA6-BDEF-79EEF16E880B/Hypervisor%20Top%20Level%20Functional%20Specification%20v4.0.docx).  
  
![](../Image/ProcessorCompatibilityMode_1.PNG)  
  
## Ramifications of using processor compatibility mode  
It is difficult to quantify the overall performance effects of processor compatibility mode. The performance loss is primarily dependent on the workload running in the virtual machine. Some workloads will be completely unaffected, while others will show a noticeable difference. Software that heavily relies on hardware optimizations \(such as encryption, compression, or intensive floating\-point calculations\) will be impacted the most.  
  
The following example describes how AES encryption is affected by using processor compatibility mode, and there are many more. If you are concerned about the performance impact of processor compatibility mode, it is best to compare virtual machine workload performance with processor compatibility mode enabled and with it disabled.  
  
### Example: AES encryption  
One example of an operation that is impacted by processor compatibility mode is AES encryption \(a common form of encryption\). Many new Intel and AMD processors include an ISA extension that accelerates AES by using hardware. Intel claims this optimization provides a 2\-3 fold performance gain, with some implementations providing a 10\-fold gain. \(For more information, see [Intel Advanced Encryption Standard Instructions](https://software.intel.com/articles/intel-advanced-encryption-standard-instructions-aes-ni/).\)  
  
Applications that encrypt or decrypt a large amount of data benefit from this processor feature, so turning it off by enabling processor compatibility mode will impact the performance of these specific operations.  
  
## Using processor compatibility mode  
There are important concepts to understand when using processor compatibility mode in Hyper\-V:  
  
-   Running virtual machines can only be migrated between virtualization hosts that use processors from the same manufacturer.  
  
-   You must shut down the virtual machine before you can enable or disable processor compatibility mode.  
  
-   Processor compatibility mode is not needed for virtual machines moves that involve a stop and restart of the virtual machines.  
  
-   Any time a virtual machine is restarted, the guest operating system will enumerate the processor features that are available on the new host computer.  
  
![](../Image/ProcessorCompatibilityMode_2.PNG)  
  
## Enabling processor compatibility mode  
  
#### To enable processor compatibility mode for a virtual machine  
  
1.  Click **Start**, point to **Administrative Tools**, and then click **Hyper\-V Manager**.  
  
2.  Select the server running Hyper\-V and the desired virtual machine.  
  
3.  If the virtual machine is running, you must shut down the virtual machine to change the processor compatibility mode setting.  
  
4.  In the Action pane, click **Settings**, and then click **Processor**.  
  
5.  Expand **Processor**, and click **Compatibility**.  
  
6.  Click **Migrate to a physical computer with a different processor**, and then click **OK**.  
  
