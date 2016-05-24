---
title: QoS Common Configurations
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 891c6ec4-deb9-447b-afc1-3b01151d9e4b
---
# QoS Common Configurations
When you configure Quality of Service \(QoS\), you must consider the following variables.  
  
-   The number of network interface cards \(NICs\) that are installed on the server computer.  
  
-   Whether or not each NIC is dedicated to a specific workload or is shared by multiple workloads.  
  
-   Whether NICs are teamed with the NIC teaming feature.  
  
-   The number of NIC teams that you configure on the server.  
  
-   Whether you plan on using offload technologies like Single Root Input\-Output Virtualization \(SR\-IOV\) or Remote Direct Memory Access \(RDMA\).  
  
The following sections examine a few common server configurations and illustrate where QoS can be enforced.  
  
-   [2 NICs without NIC Teaming](#bkmk_1)  
  
-   [2 NICs with NIC Teaming](#bkmk_2)  
  
-   [4 NICs in two NIC teams](#bkmk_3)  
  
-   [4 NICs with a standard NIC team and two RDMA NICs](#bkmk_4)  
  
-   [Alternate configuration of 4 NICs with a standard NIC team and two RDMA NICs](#bkmk_alt)  
  
## <a name="bkmk_1"></a>2 NICs without NIC Teaming  
This configuration prioritizes the separation of the host traffic from the guest traffic.  
  
> [!NOTE]  
> In this document, the term *management operating system* refers to the operating system of the computer upon which you are running Hyper\-V.  
  
The following illustration depicts this configuration.  
  
![](../Image/qos_config1.jpg)  
  
With this configuration, you can apply all QoS features, including Bandwidth Management, Classification and Tagging, and Priority\-based Flow Control, as long as the feature is supported by the NIC.  
  
The following code, which is run in the management operating system Windows PowerShell environment, provides an example of creating this configuration by using Windows PowerShell. In this code sample, the lines that begin with a number or pound sign \(\#\) are remarks that explain the code in the subsequent line.  
  
```  
# Use the inbox filter for Live Migration  
New-NetQosPolicy “Live Migration” –LiveMigration –MinBandwidthWeight 30 –Priority 5  
# Use the inbox filter for SMB  
New-NetQosPolicy “SMB” –SMB –MinBandwidthWeight 50 –Priority 3  
# Create a policy for the cluster heartbeat traffic sent on port 3343  
New-NetQosPolicy “Cluster”-IPDstPort 3343 –MinBandwidthWeight 10 –Priority 6  
# Use the inbox filter to capture all the rest of the traffic.  
New-NetQosPolicy “Management” –Default –MinBandwidthWeight 10  
  
# Note that the management traffic is deliberately configured not to be  
# tagged.  
  
```  
  
You can also enable Bandwidth Management on the Hyper\-V Virtual Switch for each individual virtual network adapter. The following code presents an example of how to create this configuration.  
  
```  
# Create a Hyper-V Virtual Switch that supports Minimum Bandwidth by weight  
New-VMSwitch “10GbE switch” –NetAdapterName “XYZ’s 10GbE” –MinimumBandwidthMode Weight –AllowManagementOS $false  
# Assign an even weight to all the VMs here as well as a hard cap at 1Gbps  
Set-VMNetworkAdapter –VMName * -MinimumBandwidthWeight 1 –MaximumBandwidth 1000000000  
  
```  
  
Optionally, if a VM is trusted – such as in an enterprise environment where you can trust the Administrator of the VM \- you can enable QoS classification and tagging from within the VM. The following code, which is run in the Windows PowerShell environment on a VM, presents an example of how to create this configuration.  
  
```  
# Create a QoS policy to tag (in the IP header) a critical application   
# running on this VM  
New-NetQosPolicy “Line of Business app” –ApplicationName “%ProgramFiles%\crm.exe” –DSCP 46  
  
```  
  
## <a name="bkmk_2"></a>2 NICs with NIC Teaming  
This configuration prioritizes high availability for all of the workloads on a computer that is running the Hyper\-V server role.  
  
![](../Image/qos_config2.jpg)  
  
You can enable Bandwidth Management on the Hyper\-V Virtual Switch for both the VMs and the workloads in the management operating system. The following example commands are run in the Windows PowerShell environment in the management operating system.  
  
```  
# Create a NIC team that consists of two 10GbE NICs  
New-NetLbfoTeam “2x10GbE Team” –TeamMembers “10GbE NIC1”,”10GbE NIC2” –TeamNicName “2x10GbE”  
# Create a Hyper-V Virtual Switch that binds to the NIC team  
New-VMSwitch “20GbE switch” –NetAdapterName “2x10GbE” –MinimumBandwidthMode Weight –AllowManagementOS $false  
# Create a virtual NIC in the management operating system for SMB (storage)  
Add-VMNetworkAdapter –ManagementOS –Name “SMB” –SwitchName “20GbE switch”  
# Create a virtual NIC in the management operating system for Live Migration  
Add-VMNetworkAdapter –ManagementOS –Name “LM” –SwitchName “20GbE switch”  
# Create a virtual NIC in the management operating system for Cluster  
Add-VMNetworkAdapter –ManagementOS –Name “Cluster” –SwitchName “20GbE switch”  
# Create a virtual NIC in the management operating system for Management  
Add-VMNetworkAdapter –ManagementOS –Name “Management” –SwitchName “20GbE switch”  
  
# Assign a weight to SMB  
Set-VMNetworkAdapter –ManagementOS –Name “SMB” –MinimumBandwidthWeight 40  
# Assign a weight to Live Migration  
Set-VMNetworkAdapter –ManagementOS –Name “LM” –MinimumBandwidthWeight 20  
# Assign a weight to Cluster  
Set-VMNetworkAdapter –ManagementOS –Name “Cluster” –MinimumBandwidthWeight 5  
# Assign a weight to Management  
Set-VMNetworkAdapter –ManagementOS –Name “Management” –MinimumBandwidthWeight 5  
  
# Assign a weight to each VM  
Set-VMNetworkAdapter –VMName * -MinimumBandwidthWeight 1  
  
# Usually the workloads in the management operating system are put in different IP subnets  
# and VLANs, to assign a VLAN to a virtual network adapter in the Management  
# OS  
Set-VMNetworkAdapterVlan –ManagementOS –VMNetworkAdapterName SMB –Access –VlanId 100  
Set-VMNetworkAdapterVlan –ManagementOS –VMNetworkAdapterName LM –Access –VlanId 200  
Set-VMNetworkAdapterVlan –ManagementOS –VMNetworkAdapterName Cluster –Access –VlanId 300  
Set-VMNetworkAdapterVlan –ManagementOS –VMNetworkAdapterName Management –Access –VlanId 400  
  
```  
  
Optionally, you can classify and tag traffic from within the management operating system and, in a trusted environment, from within the VMs.  
  
```  
# Use the inbox filter for Live Migration  
New-NetQosPolicy “Live Migration” –LiveMigration –Priority 5  
# Use the inbox filter for SMB  
New-NetQosPolicy “SMB” –SMB –Priority 3  
# Create a policy for the cluster heartbeat traffic sent on port 3343  
New-NetQosPolicy “Cluster”-IPDstPort 3343 –Priority 6  
  
# Alternatively, if these workloads are in different IP subnets they can  
# be classified based on their IP subnet address  
# Assume Live Migration is on 10.1.0.0/16  
New-NetQosPolicy “Live Migration” –IPDstPrefix 10.1.0.0/16 –Priority 5  
# Assume SMB is on 10.2.0.0/16  
New-NetQosPolicy “SMB” –IPDstPrefix 10.2.0.0/16 –Priority 3  
# Assume Cluster is on 10.3.0.0/16  
New-NetQosPolicy “Cluster”-IPDssPrefix 10.3.0.0/16 –Priority 6  
  
# Note that no explicit policy is created for the Management traffic, if it  
# doesn’t require to be tagged.  
  
```  
  
```  
# Enable priority tagged traffic to go through the Hyper-V Virtual Switch  
Set-VMNetworkAdapter –ManagementOS –IeeePriorityTag On  
  
# Note that the name of the virtual network adapter in the management operating system  
# is deliberately omitted in the above command so that the configuration applies  
# to all virtual network adapters in the management operating system  
  
# Also note that if workloads are tagged in the IP header like the example  
# shown in “ REF _Ref328648339 \h 2 NICs without NIC Teaming,” no additional configuration is required  
# to let the Hyper-V Virtual Switch pass such DSCP tagged traffic.  
  
```  
  
## <a name="bkmk_3"></a>4 NICs in two NIC teams  
This configuration provides separation of the host traffic and the guest traffic, as well as high availability for all the workloads. This configuration doubles the required number of NICs to four, but they do not need to all be 10 GbE NICs. For example, if a server has a dual port 10GbE NIC and two 1GbE LOM ports, you can team the two 10GbE NICs for the management operating system and the two 1GbE LOM ports for the VMs.  
  
![](../Image/qos_config3.jpg)  
  
For this configuration, you can use the same Windows PowerShell commands as those provided in the section [2 NICs without NIC Teaming](#bkmk_1).  
  
## <a name="bkmk_4"></a>4 NICs with a standard NIC team and two RDMA NICs  
This configuration emphasizes the use of RDMA. To converge other workloads such as Live Migration, Cluster and Management on the same RDMA NICs, the NICs must also support Data Center Bridging \(DCB\). To provide high availability to Storage, you can enable Microsoft Multipath I\/O \(MPIO\).  
  
![](../Image/qos_config4.jpg)  
  
With this configuration, you can apply all QoS features, including Bandwidth Management, Classification and Tagging, and PFC in the management operating system.  
  
```  
# Use the inbox filter for Live Migration  
New-NetQosPolicy “Live Migration” –LiveMigration –Priority 5  
# Create a policy for SMB Direct traffic sent on port 445  
New-NetQosPolicy “SMB Direct” –NetDirectPort 445 –Priority 3  
# Create a policy for the cluster heartbeat traffic sent on port 3343  
New-NetQosPolicy “Cluster”-IPDstPort 3343 –Priority 6  
  
# Install DCB on the server  
Install-WindowsFeature Data-Center-Bridging  
# Create a traffic class on Data Center Bridging (DCB) NICs for Live Migration  
New-NetQosTrafficClass “Live Migration” –Priority 5 –Algorithm ETS –Bandwidth 30  
# Create a traffic class on DCB NICs for SMB Direct (ROCE)  
New-NetQosTrafficClass “SMB Direct” –Priority 3 –Algorithm ETS –Bandwidth 50  
# Create a traffic class on DCB NICs for Cluster  
New-NetQosTrafficClass “Cluster” –Priority 6 –Algorithm ETS –Bandwidth 10  
  
# Note that there’s a default traffic class, which owns 100% of the total  
# bandwidth. As bandwidth is allocated to user-created traffic classes, the  
# default traffic class owns whatever is left. In this example, it has 10%   
# left for all the rest of traffic in the management operating system.  
  
# Enable PFC for ROCE  
Enable-NetQosFlowControl –Priority 3  
  
# Note that PFC should be enabled for priority 3 from end (e.g. a computer running   
# Hyper-V) to end (e.g. a File Server) at both ends (i.e. switch ports and  
# NICs) of all the links.  
  
# Enable DCB settings on the NICs  
Set-NetQosDcbxSetting –Willing $false  
  
Enable-NetAdapterQos “DCB-capable 10Gbe NIC1”  
Enable-NetAdapterQos “DCB-capable 10Gbe NIC2”  
  
```  
  
You can enable Bandwidth Management on the Hyper\-V Virtual Switch for the VMs and enable Classification and Tagging on the VMs, if they are trusted.  
  
## <a name="bkmk_alt"></a>Alternate configuration of 4 NICs with a standard NIC team and two RDMA NICs  
MPIO provides redundancy to Storage only. If you want to provide redundancy for Management, Live Migration, and Cluster you can modify the previous configuration slightly as follows.  
  
![](../Image/qos_config5.jpg)  
  
Because the RDMA NICs are dedicated to Storage, no Bandwidth Management is required in the management operating system. Minimum Bandwidth and Maximum Bandwidth are instead configured on the Hyper\-V Virtual Switch because Management, Live Migration, and Cluster each have their own virtual network adapter that is connected to the switch.  
  
You can enable Classification and Tagging and PFC in the management operating system. You can also enable Classification and Tagging from within the VMs, if they are trusted.  
  
