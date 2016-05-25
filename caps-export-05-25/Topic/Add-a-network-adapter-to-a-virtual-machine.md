---
title: Add a network adapter to a virtual machine
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d3ea8a83-1ca1-457e-bada-3126067ce6f9
author: cwatsonmsft
---
# Add a network adapter to a virtual machine
After a virtual machine is created, you can add one or more network adapter in the settings of the virtual machine.  
  
> [!NOTE]  
> To add or remove a network adapter from a virtual machine, the virtual machine must be turned off. Once a network adapter has been added to a virtual machine you can modify some of the setting of the network adapter when the virtual machine is running or in a saved state.  
  
1.  Open **Hyper\-V Manager**.  
  
2.  In the results pane, under **Virtual Machines**, select the virtual machine that you want to configure.  
  
3.  In the **Action** pane, under the virtual machine name, click **Settings**.  
  
4.  In the navigation pane, click **Add Hardware**.  
  
5.  On the **Add Hardware** page, select **Network Adapter** or **Legacy Network Adapter** \(only for generation 1 virtual machines\) and then click **Add**. The Network Adapter or Legacy Network Adapter page appears.  
  
6.  Under **Network**, select the virtual switch you want to connect to.  
  
7.  You can configure additional network adapter settings, such as VLAN ID and MAC address.  
  
8.  Click **OK**.  
  
> [!NOTE]  
> You can also use Windows PowerShell.  
  
## Additional considerations  
  
-   Generation 2 virtual machines do not support legacy network adapters. For more information about generation 2 virtual machines see, [Generation 2 Virtual Machine Overview](../Topic/Generation-2-Virtual-Machine-Overview.md). Network adapters in generation 2 virtual machines support Pre\-Boot Execution Environment \(PXE\).  
  
-   A legacy network adapter works without installing a virtual machine driver because the driver is already available on most operating systems. The legacy network adapter emulates a physical network adapter, multiport DEC 21140 10\/100TX 100 MB. A legacy network adapter also supports network\-based installations because it includes the ability to boot to the Pre\-Boot Execution Environment \(PXE\). The legacy network adapter is not supported in the 64\-bit edition of Windows Server 2003 or the Windows XP Professional x64 Edition. If you use a legacy network adapter to install the initial operating system, you should change to another legacy adapter once the installation is complete.  
  
## See Also  
[Hyper\-V Virtual Switch Overview](assetId:///e6ec46af-6ef4-49b3-b1f1-5268dc03f05b)  
[Create a virtual switch](assetId:///d7ac0931-326d-4ded-ab13-cfc92e9f9e71)  
  
