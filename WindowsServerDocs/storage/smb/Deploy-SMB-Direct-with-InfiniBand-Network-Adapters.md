---
title: Deploy SMB Direct with InfiniBand Network Adapters
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a383b9c9-5362-42a0-8b2b-fb45fdea6ae2
author: JasonGerend
---
# Deploy SMB Direct with InfiniBand Network Adapters
This topic explains how to deploy SMB Direct with InfiniBand network adapters.  
  
## Overview  
When you deploy SMB Direct with an RDMA\-capable network adapter, the network adapter functions at full speed with very low latency, while using very little CPU. You can use the InfiniBand series of networks adapters to take full advantage of the capabilities of SMB Direct.  
  
**Hardware and software requirements**  
  
Use the following requirements to implement and test this deployment:  
  
-   Two or more computers running  Windows Server 2012 R2  or  Windows Server 2012   
  
-   One or more InfiniBand network adapters for each server  
  
-   One or more InfiniBand switches  
  
-   Two or more network cables as required for the InfiniBand network adapters that you select. These are typically enhanced small form\-factor pluggable \(SFP\+\), QSFP, or QSFP\+ connectors.  
  
**Example InfiniBand configurations**  
  
There are many options available for InfiniBand network adapters, cables, and switches. The following are some examples of configurations that you can use with  Windows Server 2012 R2  or  Windows Server 2012 :  
  
1.  **Two computers using FDR \(Fourteen Data Rate\) InfiniBand network adapters**.  FDR InfiniBand has a 54 Gbps data rate. In this deployment, the minimum configuration is two network adapters and a network cable. You will need a system with PCIe Gen3 slots to achieve the 54 Gbps data rate. PCIe Gen3 slots are available on newer computer systems. If you use an older system, the network adapter will be limited by the speed of the older PCIe Gen2 host bus adapter.  
  
2.  **Ten computers using dual FDR InfiniBand network adapters**.  To increase throughput in a private cloud deployment, you can configure a two\-node file server cluster, in addition to an eight\-node Hyper\-V cluster. For added performance and fault tolerance, use two InfiniBand network adapters for each system. In this configuration, you need 20 FDR InfiniBand network adapters and a 20\-port FDR switch.  
  
For additional information about the InfiniBand network adapters \(and part numbers\) that support SMB Direct, see the following blog post: [Deploying Windows Server 2012 with SMB Direct \(SMB over RDMA\) and the Mellanox ConnectX\-2\/ConnectX\-3 using InfiniBand – Step by Step](http://blogs.technet.com/b/josebda/archive/2012/07/31/deploying-windows-server-2012-with-smb-direct-smb-over-rdma-and-the-mellanox-connectx-2-connectx-3-using-infiniband-step-by-step.aspx).  
  
**Download and update the latest drivers**  
  
Although  Windows Server 2012 R2  and  Windows Server 2012  might include drivers for the network adapter, you should always verify that you have the latest version of the driver from the manufacturer of the network adapter. Follow the manufacturer's installation instructions to install the driver.  
  
## Configure a subnet manager  
When you use an InfiniBand switch, you are required to have a subnet manager running. The best option is to use a managed InfiniBand switch \(which runs a subnet manager\), but you can also install a subnet manager on a computer that is connected to an unmanaged switch. This section discusses the options that are available for configuring a subnet manager.  
  
### Use a managed switch with a built\-in subnet manager.  
Many InfiniBand switches have an internal subnet manager that runs by default when the switch is powered on or runs when it is enabled by using the switch’s web interface.  
  
### Use OpenSM with an unmanaged switch \(recommended only for test environments\)  
If a managed switch is not available, you can use one of the computers running  Windows Server 2012 R2  or  Windows Server 2012  to run your subnet manager. You can use the OpenSM application that is provided by the OpenFabrics Alliance, which is available with some InfiniBand device driver distributions. The executable file for the OpenSM application is opensm.exe. Make sure that you install the tool as a service that starts automatically.  
  
> [!IMPORTANT]  
> We recommend that you do not use OpenSM with an unmanaged switch in production environments.  
  
For additional fault tolerance, make sure that you have two computers on your network configured to run OpenSM. Do not run OpenSM on more than two computers that are connected to an InfiniBand switch.  
  
## Configure the IP address  
After you have installed the latest version of the drivers, you should configure the IP address for the network adapters. If you are using a DHCP server, the network adapters are automatically configured, and you can move ahead to the following section.  
  
To assign an IP address to your network adapter, you can use **IP Address Management**  or the Net TCP\/IP cmdlets in Windows PowerShell. For more information, see [Net TCP\/IP Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/hh826123.aspx).  
  
The following Windows PowerShell example shows how to assign an IP address to a network adapter called `RDMA1`, with an IP address of `192.168.1.10`, and a DNS server at `192.168.1.2`.  
  
```  
Set-NetIPInterface -InterfaceAlias RDMA1 -DHCP Disabled   
Remove-NetIPAddress -InterfaceAlias RDMA1 -AddressFamily IPv4 -Confirm:$false   
New-NetIPAddress -InterfaceAlias RDMA1 -IPAddress 192.168.1.10 -PrefixLength 24 -Type Unicast   
Set-DnsClientServerAddress -InterfaceAlias RDMA1 -ServerAddresses 192.168.1.2  
```  
  
## Verify the configuration  
To verify that the configuration is working correctly, you can review configuration information about the network adapter and the SMB connection. For more information, see the [Verify the configuration](../smb/../smb/../smb/../smb/Deploy-SMB-Direct-with-Ethernet--iWARP--Network-Adapters.md#BKMK_verify_config) section.  
  
## Review the performance counters  
There are several performance counters that you can use to verify that the RDMA\-capable network adapters are being used and that the SMB Direct connections are established. For more information, see the [Review the performance counters](../smb/../smb/../smb/../smb/Deploy-SMB-Direct-with-Ethernet--iWARP--Network-Adapters.md#BKMK_SMBperfcounters) section.  
  
## Review the event logs for RDMA network adapters  
You can use several events in the Windows event log to verify that the RDMA\-capable network adapters are operational, and the SMB Direct connections are accessible. For more information, see the [Review the event logs for RDMA network adapters](../smb/../smb/../smb/../smb/Deploy-SMB-Direct-with-Ethernet--iWARP--Network-Adapters.md#BKMK_eventsRDMA) section.  
  
## See also  
  
-   [Improve Performance of a File Server with SMB Direct](../smb/Improve-Performance-of-a-File-Server-with-SMB-Direct.md)  
  
-   [Deploy SMB Direct with Ethernet &#40;iWARP&#41; Network Adapters](../smb/../smb/../smb/../smb/Deploy-SMB-Direct-with-Ethernet--iWARP--Network-Adapters.md)  
  
-   [Server Message Block Overview](../smb/Server-Message-Block-Overview.md)  
  
-   [Increasing Server, Storage, and Network Availability: scenario overview](assetId:///22c42d93-e045-4491-8906-4273569d160f)  
  
-   [Deploy Hyper\-V over SMB](assetId:///5a169fa2-f5c8-4c0d-a122-79ecdbdebc98)  
  

