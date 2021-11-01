---
title: Configure Quality of Service (QoS) for a VM network adapter
description: You can configure SDN QoS for a VM network adapter to limit bandwidth on a virtual interface to prevent a high-traffic VM from blocking other users.
manager: grcusanz
ms.topic: article
ms.assetid: 6d783ff6-7dd5-496c-9ed9-5c36612c6859
ms.author: anpaul
author: AnirbanPaul
ms.date: 11/02/2021
ms.custom: contperf-fy22q1
---
# Configure Quality of Service (QoS) for a VM network adapter

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Azure Stack HCI, versions 21H2 and 20H2

You can configure Software Defined Networking (SDN) Quality of Service (QoS) for a virtual machine (VM) network adapter to limit bandwidth on a virtual interface to prevent a high-traffic VM from contending with other VM network traffic. You can also configure SDN QoS to reserve a specific amount of bandwidth for a VM to ensure that the VM can send traffic regardless of other traffic on the network. This can be applied to VMs attached to traditional VLAN networks as well as VMs attached to SDN overlay networks.

You can also configure ***QoS Offload*** to enforce QoS rules at the physical network adapter rather than at the virtual switch, resulting in lower CPU utilization and improved enforcement. QoS Offload is an optional capability found in Windows Server 2022 certified NICs that have achieved the Windows Server Software-Defined Data Center (SDDC) Premium Additional Qualification (AQ). For more information, see [Select a network adapter](/azure-stack/hci/concepts/host-network-requirements#select-a-network-adapter).

## SDN QoS bandwidth limits

SDN QoS provides configuration of maximum permitted send-side or receive-side bandwidth for VMs. This is supported for VMs connected to a traditional VLAN network as well as VMs connected to an SDN virtual network. Once set, your VM will not be able to send or receive traffic above the configured maximum limits. For a VM, you can choose to configure either a send-side limit, a receive-side limit, or both.

The settings that can be configured through SDN QoS are:

- **OutboundReservedValue** - If `outboundReservedMode` mode is "absolute", then the value indicates the bandwidth, in Mbps, guaranteed to the virtual port for transmission (egress). If `outboundReservedMode` mode is "weight", then the value indicates the weighted portion of the bandwidth guaranteed.

- **OutboundMaximumMbps** - Indicates the maximum permitted send-side bandwidth, in Mbps, for the virtual port (egress).

- **InboundMaximumMbps** - Indicates the maximum permitted receive-side bandwidth for the virtual port (ingress) in Mbps.

## SDN QoS policies

Once Network Controller for SDN is setup, you can go ahead and deploy your QoS policies. Today, you can do this using [Network Controller](/powershell/module/networkcontroller/?view=windowsserver2019-ps&preserve-view=true) PowerShell cmdlets.

For all example scripts used below, `-ConnectionUri` is the REST URI of the Network Controller. For example: https://nc.contoso.com.

### Step 1: Configure global QoS settings

Run the following PowerShell command on a Network Controller computer or a management client of Network Controller. This will enable the global settings to configure QoS policies through Network Controller:

~~~powershell
$vswitchConfig=[Microsoft.Windows.NetworkController.VirtualSwitchManagerProperties]::new()
$qos=[Microsoft.Windows.NetworkController.VirtualSwitchQosSettings]::new()
$qos.EnableSoftwareReservations=$true
$vswitchConfig.QosSettings =$qos
Set-NetworkControllerVirtualSwitchConfiguration -ConnectionUri $uri -Properties $vswitchConfig
~~~

### Step 2: Configure QoS policies

First, you will need to identify the workload VM network interface where you want to apply the policy:

~~~powershell
$NwInterface=Get-NetworkControllerNetworkInterface -ConnectionUri $uri -ResourceId Vnet-VM2_Net_Adapter_0
~~~

Next, configure the inbound and outbound maximum throughput allowed on the network interface:

~~~powershell
$NwInterface.Properties.PortSettings.QosSettings= [Microsoft.Windows.NetworkController.VirtualNetworkInterfaceQosSettings]::new()
$NwInterface.Properties.PortSettings.QosSettings.InboundMaximumMbps ="1000"
New-NetworkControllerNetworkInterface -ConnectionUri $uri -ResourceId $NwInterface.ResourceId -Properties $NwInterface.Properties
~~~

## QoS Offload (optional)

You can configure the physical NIC to use QoS Offload. If your adapter supports QoS offload, ensure it is enabled using one of two methods:

- Network ATC (recommended)
- Manual enablement using the adapter properties

### Use Network ATC

QoS Offload is automatically enabled on all adapters with the `Compute` intent type. For more information, see [Simplify host networking with Network ATC](/azure-stack/hci/deploy/network-atc).

>[!NOTE]
>This option is only available to Azure Stack HCI subscribers.

### Use manual enablement

Manual enablement is done through the built-in cmdlets used to manage the physical adapter properties.

>[!IMPORTANT]
>You must ensure that `QosOffload` is enabled on every physical NIC in the team across every host. Without this, the QoS rule will be enforced via the virtual switch and result in lower efficiency.

Use the following cmdlets to check if your adapters support `QosOffload` and then modify the adapter properties:

~~~powershell
Get-NetAdapterAdvancedProperty -Name <physical NIC Name> -RegistryKeyword *QosOffload
Enable QosOffload for your adapters:
Set-NetAdapterAdvancedProperty -Name  <physical NIC Name> -RegistryKeyword *QosOffload -RegistryValue 1
~~~

## Configure hardware QoS

You can configure hardware QoS using settings and policies.

### Step 1 - Configure global QoS settings

Perform the below steps on a Network Controller computer or a management client of Network Controller. This will enable the global setting to configure QoS policies through Network Controller.

~~~powershell
$vswitchConfig=[Microsoft.Windows.NetworkController.VirtualSwitchManagerProperties]::new()
$qos=[Microsoft.Windows.NetworkController.VirtualSwitchQosSettings]::new()
$qos.EnableHardwareLimits=$true
$vswitchConfig.QosSettings =$qos
Set-NetworkControllerVirtualSwitchConfiguration -ConnectionUri $uri -Properties $vswitchConfig
~~~

### Step 2 - Configure QoS policies

First, identify the workload VM network interface where you want to apply the policy:

~~~powershell
$NwInterface=Get-NetworkControllerNetworkInterface -ConnectionUri $uri -ResourceId Vnet-VM2_Net_Adapter_0
~~~

Next, configure the outbound maximum throughput allowed on the network interface. The following example creates a QoS rule limiting the outbound traffic from a VM interface to 1 Gbps.

>[!IMPORTANT]
>Qos Offload only supports **OutboundMaximumMbps**. You cannot use **OutboundReservedValue** or **InboundMaximumMbps** with Qos Offload.

~~~powershell
$NwInterface.Properties.PortSettings.QosSettings= [Microsoft.Windows.NetworkController.VirtualNetworkInterfaceQosSettings]::new()
$NwInterface.Properties.PortSettings.QosSettings. EnableHardwareLimits=$true
$NwInterface.Properties.PortSettings.QosSettings.OutboundMaximumMbps ="1000"
New-NetworkControllerNetworkInterface -ConnectionUri $uri -ResourceId $NwInterface.ResourceId -Properties $NwInterface.Properties
~~~

>[!NOTE]
>During live migration, it is possible that a VM moves to a host that does not support QoS Offload. In this scenario, live migration will succeed, but QoS will fallback to SDN QoS.