---
title: Deploy SMB Direct with RoCE Network Adapters
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 17e0f41b-3652-4fe3-995d-4d0b6ef647bc
---
# Deploy SMB Direct with RoCE Network Adapters
This topic explains how to deploy SMB Direct with RoCE network adapters.  
  
## Overview  
When you deploy SMB Direct with an RDMA\-capable network adapter, the network adapter functions at full speed with very low latency, while using very little CPU. You can use the RoCE series of networks adapters to take full advantage of the capabilities of SMB Direct.  
  
**Hardware and software requirements**  
  
Use the following requirements to implement and test this deployment:  
  
-   Two or more computers running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
-   One or more RoCE network adapters for each server  
  
-   One or more 10 gigabit or 40 gigabit Ethernet switches with the Priority Flow Control \(PFC\) capability  
  
-   Two or more network cables as required for the RoCE network adapters that you select. These are typically enhanced small form\-factor pluggable \(SFP\+\) connectors for 10 gigabit switches or QSFP connectors 40 gigabit switches.  
  
**Example RoCE configurations**  
  
There are many options available for RoCE network adapters, cables, and switches. The following are some examples of configurations that you can use with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]:  
  
-   **Two computers using 10 gigabit RoCE network adapters**.  In this deployment, the minimum configuration is two network adapters and a network cable. You can use this deployment for testing a single file server with a server running Hyper\-V. For 10 gigabit Ethernet, use network adapters with SFP\+ connectors.  
  
-   **Eight computers using dual 10 gigabit RoCE network adapters**.  In this deployment, you can configure a two\-node file server cluster, in addition to a six\-node Hyper\-V cluster. In this configuration, you need eight computers with a dual port RoCE network adapter on each computer. In addition, you need a 10 gigabit switch with at least 16 ports \(using 10 gigabit and SFP\+ connectors\). The network adapters you select must support Priority Flow Control \(PFC\).  
  
-   **Two computers using 40 gigabit RoCE network adapters**.  FDR RoCE has a 54 Gbps data rate. In this deployment, the minimum configuration is two network adapters and a network cable \(you should use a QSFP connector for 40 gigabit\). You will need a system with PCIe Gen3 slots to achieve the 54 Gbps data rate. PCIe Gen3 slots are available on newer computer systems. If you use an older system, the network adapter will be limited by the speed of the older PCIe Gen2 host bus adapter.  
  
-   **Ten computers using dual 40 gigabit RoCE network adapters**.  To increase throughput in a private cloud deployment, you can configure a two\-node file server cluster, in addition to an eight\-node Hyper\-V cluster. For added performance and fault tolerance, use two 40 gigabit RoCE network adapters for each system. In this configuration, you need 20 RoCE network adapters and a 20\-port switch. You will need a system with PCIe Gen3 slots to achieve the rate speed of the network adapter. PCIe Gen3 slots are available on newer computer systems. If you use an older system, the network adapter will be limited by the speed of the older PCIe Gen2 host bus adapter.  
  
For detailed information on the RoCE network adapters that support SMB Direct, see this [blog post](http://blogs.technet.com/b/josebda/archive/2012/07/31/deploying-windows-server-2012-with-smb-direct-smb-over-rdma-and-the-mellanox-connectx-3-using-10gbe-40gbe-roce-step-by-step.aspx).  
  
**Download and update the latest drivers**  
  
Although [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] might include drivers for the network adapter, you should always verify that you have the latest version of the driver from the manufacturer of the network adapter. Follow the manufacturer's installation instructions to install the driver.  
  
## Configuring Priority Flow Control  
For RoCE to function reliably, you need to configure Priority Flow Control \(PFC\) on all cluster nodes and on all switches in the flow path.  
  
### Configure PFC on cluster nodes  
To configure PFC on the cluster nodes, perform the following steps:  
  
-   If applicable, clear all previous configurations  
  
-   Enable Data Center Bridging \(DCB\) on both client and server  
  
-   Create a Quality of Service \(QoS\) policy to identify RoCE traffic on both client and server  
  
-   Enable PFC on a specific priority \(the example shown below uses **Priority 3**\)  
  
-   Enable the DCB settings for the network adapters \(the example shown below assumes the network adapter is named **Ethernet 4**\)  
  
-   Optionally, you can limit the bandwidth used by the SMB traffic \(the example shown elow has a bandwidth limit of 60%\)  
  
The following example shows how to configure PFC using Windows PowerShell. To perform the steps listed above, type the following in Windows PowerShell:  
  
```  
# Clear previous configurations  
Remove-NetQosTrafficClass  
Remove-NetQosPolicy -Confirm:$False  
  
# Enable DCB  
Install-WindowsFeature Data-Center-Bridging  
  
# Disable the DCBx setting:  
Set-NetQosDcbxSetting -Willing 0  
  
# Create QoS policies and tag each type of traffic with the relevant priority  
New-NetQosPolicy "SMB" -NetDirectPortMatchCondition 445 -PriorityValue8021Action 3  
New-NetQosPolicy "DEFAULT" -Default -PriorityValue8021Action 3  
New-NetQosPolicy "TCP" -IPProtocolMatchCondition TCP -PriorityValue8021Action 1   
New-NetQosPolicy "UDP" -IPProtocolMatchCondition UDP -PriorityValue8021Action 1  
  
# If VLANs are used, mark the egress traffic with the relevant VlanID:  
Set-NetAdapterAdvancedProperty -Name <Network Adapter Name> -RegistryKeyword "VlanID" -RegistryValue <ID>  
  
# Enable Priority Flow Control (PFC) on a specific priority. Disable for others  
Enable-NetQosFlowControl -Priority 3  
Disable-NetQosFlowControl 0,1,2,4,5,6,7  
  
# Enable QoS on the relevant interface  
Enable-NetAdapterQos -InterfaceAlias "Ethernet 4"  
  
# Optionally, limit the bandwidth used by the SMB traffic to 60%  
New-NetQoSTrafficClass "SMB" -Priority 3 -Bandwidth 60 -Algorithm ETS  
```  
  
If you have a Kernel Debugger attached to the computer \(which is typically applicable just for developers\), flow control is always disabled. In this case, you need to run the following script in Windows PowerShell to disable this behavior:  
  
```  
Set-ItemProperty HKLM:"\SYSTEM\CurrentControlSet\Services\NDIS\Parameters" AllowFlowControlUnderDebugger -Type DWORD -Value 1 –Force  
```  
  
### Configure PFC on a switch  
For RoCE to perform reliably, you must enable PFC on the switch. Configuring PFC on switches varies according to the type of switch you select. Refer to the hardware documentation for the switch for details on how to perform this step.  
  
> [!IMPORTANT]  
> This is not an optional step. If you do not configure PFC on the switch, your RoCE\-capable network adapters will perform poorly.  
  
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
To verify that the configuration is working correctly, you can review configuration information about the network adapter and the SMB connection. For more information, see the [Verify the configuration](../Topic/Deploy-SMB-Direct-with-Ethernet--iWARP--Network-Adapters.md#BKMK_verify_config) section.  
  
## Review the performance counters  
There are several performance counters that you can use to verify that the RDMA\-capable network adapters are being used and that the SMB Direct connections are established. For more information, see the [Review the performance counters](../Topic/Deploy-SMB-Direct-with-Ethernet--iWARP--Network-Adapters.md#BKMK_SMBperfcounters) section.  
  
## Review the event logs for RDMA network adapters  
You can use several events in the Windows event log to verify that the RDMA\-capable network adapters are operational, and the SMB Direct connections are accessible. For more information, see the [Review the event logs for RDMA network adapters](../Topic/Deploy-SMB-Direct-with-Ethernet--iWARP--Network-Adapters.md#BKMK_eventsRDMA) section.  
  
## See also  
  
-   [Improve Performance of a File Server with SMB Direct](../Topic/Improve-Performance-of-a-File-Server-with-SMB-Direct.md)  
  
-   [Deploy SMB Direct with InfiniBand Network Adapters](../Topic/Deploy-SMB-Direct-with-InfiniBand-Network-Adapters.md)  
  
-   [Deploy SMB Direct with Ethernet &#40;iWARP&#41; Network Adapters](../Topic/Deploy-SMB-Direct-with-Ethernet--iWARP--Network-Adapters.md)  
  
-   [Server Message Block Overview](../Topic/Server-Message-Block-Overview.md)  
  
-   [Increasing Server, Storage, and Network Availability: scenario overview](assetId:///22c42d93-e045-4491-8906-4273569d160f)  
  
-   [Deploy Hyper\-V over SMB](assetId:///5a169fa2-f5c8-4c0d-a122-79ecdbdebc98)  
  
