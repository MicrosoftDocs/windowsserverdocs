---
title: Configure Dynamic Memory
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cfffa9db-754b-46d6-bf97-7846ea76f345
author: cwatsonmsft
---
# Configure Dynamic Memory
With dynamic memory, the amount of memory allocated to the virtual machine changes in response to demand.  
  
-   [Configure Dynamic Memory using Hyper\-V Manager](../Topic/Configure-Dynamic-Memory.md#BKMK_config)  
  
-   [Enable Dynamic Memory using Windows Powershell](../Topic/Configure-Dynamic-Memory.md#BKMK_PSH)  
  
-   [Review changes in real time in Hyper\-V Manager](../Topic/Configure-Dynamic-Memory.md#BKMK_review)  
  
## <a name="BKMK_config"></a>Configure Dynamic Memory using Hyper\-V Manager  
  
1.  Shut down the virtual machine.  
  
2.  In Hyper\-V Manager, right\-click the virtual machine and click **Settings**.  
  
3.  In the left pane, under **Hardware**, click **Memory**.  
  
4.  On the Memory page, under **Memory Management**, select **Enable Dynamic Memory**.  
  
5.  Set the amount of memory for **Minimum RAM** and **Maximum RAM**.  
  
6.  If you want to adjust the memory buffer for the virtual machine, use the up and down arrows to change the percentage.  
  
7.  If you want to give this virtual machine a higher or lower priority for memory allocation compared to other virtual machines running on this server, use the slider to set the relative weight.  
  
8.  Turn on the virtual machine.  
  
## <a name="BKMK_PSH"></a>Enable Dynamic Memory using Windows Powershell  
To enable and configure Dynamic memory using Windows Powershell, use the [Set\-VMMemory](http://technet.microsoft.com/library/hh848572.aspx)cmdlet. For example, to enable dynamic memory on virtual machine and sets its minimum memory to 64 MB, startup memory to 256 MB, and maximum memory to 2 GB and set it’s priority to 80 and buffer to 25%, type the following:  
  
```  
Set-VMMemory vm_name -DynamicMemoryEnabled $true -MinimumBytes 64MB -StartupBytes 256MB -MaximumBytes 2GB -Priority 80 -Buffer 25  
```  
  
## <a name="BKMK_review"></a>Review changes in real time in Hyper\-V Manager  
In the Virtual Machines pane of Hyper\-V Manager there is a Memory tab. You can use this tab to view settings, as well as watch to see how the values change.  
  
-   **Assigned Memory** shows how much physical memory is allocated to the virtual machine at this time.  
  
-   **Memory Demand** shows how much memory the virtual machine needs at this time to meet the requirements of the active processes running in the virtual machine.  
  
-   **Memory Status** shows how much of the buffer amount specified for the virtual machine is available to the virtual machine at this time. Status is reported as one of the following:  
  
    -   **OK** indicates that there is enough physical memory available to give the virtual machine the full amount of memory buffer.  
  
    -   **Low** indicates that the current amount of memory assigned to the virtual machine as a buffer is lower than amount that Hyper\-V determines should be available as a buffer.  
  
    -   **Warning** indicates that there is not enough physical memory available to assign any memory buffer to the virtual machine.  
  
## See also  
  
-   [Troubleshooting Dynamic Memory](assetId:///84018073-3b5d-49a1-9e4a-35be7f60dd23)  
  
-   [Hyper-V Dynamic Memory Overview](../Topic/Hyper-V-Dynamic-Memory-Overview.md)  
  
-   [Dynamic Memory \/ Hyper\-V Memory Management FAQs](../Topic/Hyper-V-Dynamic-Memory-Overview.md#BKMK_faq)  
  
-   [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](../Topic/Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)  
  
-   [Hyper\-V Component Architecture Posters](assetId:///8973b5b3-93d2-4bd1-b644-f4ec60813202)  
  
