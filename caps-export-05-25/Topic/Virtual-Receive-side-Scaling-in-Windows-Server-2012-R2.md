---
title: Virtual Receive-side Scaling in Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 63d8e647-b3bc-4c4b-acbd-16e796226ed0
author: vhorne
---
# Virtual Receive-side Scaling in Windows Server 2012 R2
Virtual Receive\-side scaling is feature in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] that allows the load from a virtual network adapter to be distributed across multiple virtual processors in a virtual machine.  
  
## Feature description  
Receive\-side network processing in multi\-core virtual machines is conventionally bottlenecked by the fact that a single virtual processor services all the interrupts from a virtual network adapter. Virtual Receive\-side scaling solves this problem by enabling a network adapter to distribute its network processing load across multiple virtual processors in multi\-core virtual machines.  
  
Virtual Receive\-side scaling coexists with the following networking technologies:  
  
-   IPv4 and IPv6  
  
-   TCP and UDP  
  
-   LBFO \(NIC Teaming\)  
  
-   Live Migration  
  
-   NVGRE  
  
Virtual Receive\-side scaling is not enabled by default. It must be enabled in the virtual machine using PowerShell cmdlets.  
  
Virtual Receive\-side scaling in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is easily enabled and managed inside the virtual machine, much like a physical host, using the same PowerShell cmdlets that are used for Receive\-side scaling in a physical host.  
  
## Practical applications  
  
### Processor load balancing  
Anthony, a network administrator, is setting up a new host for his workplace with 2 NICs that are SR\-IOV capable.  He is going to use [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to host a file server system that his workplace is purchasing and implementing.  After the hardware and software are installed, Anthony configures his VM to use 8 virtual processors and 4096 MB of memory. Unfortunately, Anthony does not have the option of turning on SR\-IOV because his VMs rely on policy enforcement through the vmSwitch. Initially, Anthony assigns 4 virtual processors through PowerShell to be available for use with vRSS. After a week, the service has become extremely popular and Anthony checks the performance. He discovers that all four virtual processors are fully utilized. Anthony changes the RSS processor and assigns two more virtual processors to be available to RSS in the virtual machine to help handle the large network load.  
  
### Software load balancing  
Sandra, a network administrator, is setting up a single large virtual machine on one of her systems for the sole purpose of being a software load balancer. Sandra has just installed [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] so that she can expand VMQ to use multiple processors per vmNIC. Since Sandra only has one vmNIC in this system she decides she will turn on RSS in the VM to get spreading for processing through the vmSwitch. Since vRSS is disabled by default, Sandra enables RSS using PowerShell cmdlets.  
  
## Software requirements  
Virtual Receive\-side scaling can be used on any computer running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. The following Windows version virtual machines support Virtual Receive\-side scaling:  
  
1.  [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]  
  
2.  [!INCLUDE[winblue_client_1](../Token/winblue_client_1_md.md)]  
  
3.  [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] with the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] integration components installed.  
  
4.  [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] with the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] integration components installed.  
  
For information about vRSS support for virtual machines running Linux as a guest operating system on Hyper\-V, see [Linux Virtual Machines on Hyper\-V](http://technet.microsoft.com/en-us/library/dn531030.aspx).  
  
## Hardware requirements  
Virtual Receive\-side scaling requires Virtual Machine Queue \(VMQ\) support from the physical adapter. If VMQ is disabled or is not supported, then Virtual Receive\-side scaling is disabled for the host.  
  
## Enable and Configure Virtual Receive\-side scaling  
Virtual Receive\-side scaling requires Virtual Machine Queue \(VMQ\) support from the physical adapter. If VMQ is disabled, or is not supported then Virtual Receive\-side scaling is disabled.  
  
### Before enabling Virtual Receive\-side scaling  
There are 4 steps you should take before implementing Virtual Receive\-side scaling:  
  
1.  Verify that the network adapter is VMQ capable and has a link speed of >\= 10G.  If the link speed is less than 10G, VMQ is disabled by default by the vmSwitch even though it will still show as enabled in the PowerShell cmdlet, **Get\-NetAdapterVmq**.  One way to verify that VMQ is disabled is to use the cmdlet, **Get\-NetAdapterVmqQueue**.  This will show that there is not a QueueID assigned to the VM or host vNIC  
  
2.  Verify that VMQ is enabled on the host machine. Virtual Receive\-side scaling will not work if the host does not support VMQ.  You can check this by running **Get\-VMSwitch** and finding the adapter that the vmSwitch is using. Next, run **Get\-NetAdapterVmq** and ensure that the adapter is shown in the results and has VMQ enabled.  
  
3.  Verify that an SRIOV Virtual Function \(VF\) driver is not attached to the VM network interface. This can be done using the **Get\-NetAdapterSriov** cmdlet. If a VF driver is loaded, Receive\-side scaling will use the scaling settings from this driver instead of those configured by Virtual Receive\-side scaling. If the VF driver does not support Receive\-side scaling then Virtual Receive\-side scaling is disabled.  
  
4.  If you are using LBFO \(NIC Teaming\), it is essential that VMQ be properly configured to work with the LBFO settings. For detailed information about LBFO deployment and management, see [NIC Teaming Configuration and Management](http://www.microsoft.com/en-us/download/confirmation.aspx?id=30160).  
  
## Enabling Virtual Receive\-side scaling  
Virtual Receive\-side scaling can be enabled using PowerShell or with Device Manager:  
  
#### To enable Virtual Receive\-side scaling using Device Manager  
  
1.  On the virtual machine, open **Device Manager** \(In **Settings** click **Control Panel**, and then click **Device Manager**\).  
  
2.  Expand **Network adapters**, right\-click the network adapter you want to work with, and then click **Properties**.  
  
3.  On the **Advanced** tab in the network adapter properties, locate the setting for **Receive\-side scaling** and make sure it is enabled.  
  
> [!NOTE]  
> Some network adapters advertise the number of receive\-side scaling queues they support on the **Advanced** tab.  
  
#### To enable Virtual Receive\-side scaling using PowerShell  
  
1.  On the virtual machine, open **PowerShell**.  
  
2.  At the command line, type  
  
    ```  
    Enable-NetAdapterRSS -Name "AdapterName"  
  
    ```  
  
    replacing “AdapterName” with the name of the vmNIC adapter that Virtual Receive\-side scaling should be enabled on.  
  
    Alternately, the following command will also enable Virtual Receive\-side scaling:  
  
    ```  
    Set-NetAdapterRSS -Name "AdapterName" -Enabled $True  
    ```  
  
## Configuring Virtual Receive\-side scaling  
Virtual Receive\-side scaling settings in the virtual machine are configured using **Set\-NetAdapterRss**, which is the same command used for native RSS. You can view and configure the settings of the virtual machine by using the cmdlet, **Get\-NetAdapterRSS**. A portion of the PowerShell help for the cmdlet is below, and a full description of the cmdlets that lists all the configurable settings and expected types can be found on TechNet at **Set\-NetAdapterRss**.  
  
> [!NOTE]  
> Setting the profile inside the virtual machine will not impact the scheduling of the work. The hypervisor makes all the scheduling decisions and ignores the profile inside the virtual machine.  
  
Inside the VM:  
  
```  
get-help Set-NetAdapterRss  
NAME  
    Set-NetAdapterRss  
  
SYNOPSIS  
    Sets the receive side scaling (RSS) properties on the network adapter.  
  
SYNTAX  
    Set-NetAdapterRss [-Name] <String[]> [-AsJob [<SwitchParameter>]] [-BaseProcessorGroup <UInt16>] [-BaseProcessorNumber <Byte>] [-CimSession <CimSession[]>] [-Enabled <Boolean>] [-IncludeHidden [<SwitchParameter>]] [-MaxProcessorGroup <UInt16>] [-MaxProcessorNumber <Byte>] [-MaxProcessors <UInt32>][-NoRestart [<SwitchParameter>]] [-NumaNode <UInt16>] [-NumberOfReceiveQueues <UInt32>] [-PassThru [<SwitchParameter>]] [-Profile <Profile>] [-ThrottleLimit <Int32>] [-Confirm [<SwitchParameter>]] [-WhatIf [<SwitchParameter>]] [<CommonParameters>]  
  
```  
  
Inside the host, you will need to use the keywords that control the VMQ processors. You can view the current settings inside the VM by using the cmdlet, **Get\-NetAdapterVmq**. To configure the settings you will use the **Set\-NetAdapterVmq** cmdlet. The output for this cmdlet is slightly different than that of native Receive\-side scaling, so a snipped portion of **get\-help** for the cmdlet is below.  A detailed description of the cmdlet can be found on TechNet at **Set\-NetAdapterVmq**.  
  
### Inside the Host:  
  
```  
get-help set-netadaptervmq  
NAMEv  
    Set-NetAdapterVmq  
  
SYNOPSIS  
    Sets the virtual machine queue (VMQ) properties of the network adapter.  
  
SYNTAX  
    Set-NetAdapterVmq [-Name] <String[]> [-AsJob [<SwitchParameter>]] [-BaseProcessorGroup <UInt16>] [-BaseProcessorNumber <Byte>] [-CimSession <CimSession[]>] [-Enabled <Boolean>] [-IncludeHidden [<SwitchParameter>]] [-MaxProcessorNumber <Byte>] [-MaxProcessors <UInt32>] [-NoRestart [<SwitchParameter>]] [-NumaNode <UInt16>] [-PassThru [<SwitchParameter>]] [-ThrottleLimit <Int32>] [-Confirm [<SwitchParameter>]] [-WhatIf [<SwitchParameter>]] [<CommonParameters>]  
  
```  
  
## Disabling Virtual Receive\-side scaling  
Virtual Receive\-side scaling can be disabled using PowerShell or with Device Manager:  
  
#### To disable Virtual Receive\-side scaling using Device Manager  
  
1.  On the virtual machine, open **Device Manager** \(In **Settings** click **Control Panel**, and then click **Device Manager**\).  
  
2.  Expand **Network adapters**, right\-click the network adapter you want to work with, and then click **Properties**.  
  
3.  On the **Advanced** tab in the network adapter properties, locate the setting for **Receive\-side scaling** and make sure it is disabled.  
  
#### To disable Virtual Receive\-side scaling using PowerShell  
  
1.  On the virtual machine, open **PowerShell**.  
  
2.  At the command line, type  
  
    ```  
    Disable-NetAdapterRSS -Name "AdapterName"  
  
    ```  
  
    replacing “AdapterName” with the name of the vmNIC adapter that Virtual Receive\-side scaling should be enabled on.  
  
    Alternately, the following command will also enable Virtual Receive\-side scaling:  
  
    ```  
    Set-NetAdapterRSS -Name "AdapterName" -Enabled $False  
    ```  
  
## Managing Virtual Receive\-side scaling FAQ  
  
1.  **Virtual Receive\-side scaling is on, but how do I know if it is working?**  
  
    You’ll be able to tell Virtual Receive\-side scaling is working by opening the task manager in your virtual machine and viewing the virtual processor utilization. If there are multiple connections established to the virtual machine, you will see more than one core above 0% utilization.  
  
    The same holds true for the host. Virtual Receive\-side scaling made changes to the VMQ algorithm to expand virtual machine processing to more than 1 core for vmSwitch processing.  If a single core reaches 80% utilization, you should see the traffic start to expand to multiple cores.  
  
2.  **Are there any perfmon counters I can check?**  
  
    In **Perfmon**, there are three counters that can help you evaluate Virtual Receive\-side scaling.  Once in **Perfmon**, right click on the graph and click **Add Counters**…. Click the **Hyper\-V Virtual Switch Processor** category and the counters are under:  
  
    1.  **Number of VMQs** – The number of VMQ processors on affinitized to that processor  
  
    2.  **Packets from External** – Packets indicated to a processor from any external NIC  
  
    3.  **Packets from Internal** – Packets indicated to a processor from any internal interfaces, ie vNIC \(Host NIC\), vmNIC.  
  
3.  **I’m looking at the host and not all of the processors are being used. It looks like every other one is being skipped.**  
  
    Check to see if hyper threading is enabled.  VMQ and Virtual Receive\-side scaling are both designed to skip hyper threaded cores.  
  
