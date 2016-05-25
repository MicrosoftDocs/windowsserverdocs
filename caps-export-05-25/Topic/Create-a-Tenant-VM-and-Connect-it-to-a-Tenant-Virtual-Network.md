---
title: Create a Tenant VM and Connect it to a Tenant Virtual Network
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f6eb7035-1949-42d2-a141-d061d0e0f4ce
author: vhorne
---
# Create a Tenant VM and Connect it to a Tenant Virtual Network
You can use this topic to perform the following tasks by using Windows PowerShell and the NetworkControllerRESTWrappers.

1. Create a virtual machine \(VM\)
2. Configure settings to enable communication on the Virtual Network
3. Configure settings to  connect to the required network functions
4. Secure the VM by using the available security mechanisms

This topic contains the following sections.

- [Create a VM and connect it to a Virtual Network by using the Network Controller cmdlets for Windows PowerShell](#bkmk_vn)
- [Create a VM and attach it to a VLAN by using the NetworkControllerRESTWrappers](#bkmk_vlan)

## Requirements
Before performing the procedures in the following sections, note the following requirements.

1. You must create VM network adapters with static media access control \(MAC\) addresses so that the MAC address of the VM does not change during the VM lifetime. 
>[!NOTE]If the VM MAC address changes during the VM lifetime, Network Controller cannot configure the necessary policy for the network adapter. If the policy for the network adapter is not configured, the network adapter is prevented from processing network traffic, and all communication with the network fails. 

2. If the VM requires network access on startup, it is important that you do not start the VM until after the final configuration step - setting the Interface ID on the VM network adapter port. If you start the VM before you complete this step, the VM cannot communicate on the network until the network interface is created in Network Controller and the controller has applied all applicable policies - Virtual Network policy, access control lists \(ACLs\), and quality of service \(QoS\).

You can also use the processes that are described in this topic for deploying virtual appliances. With a few additional steps, you can configure appliances to process or inspect data packets that flow to or from other VMs on the Virtual Network.

>[!IMPORTANT]  
>The following sections include example Windows PowerShell commands that contain example values for many parameters. Ensure that you replace example values in these commands with values that are appropriate for your deployment before you run these commands.  

## <a name="bkmk_vn"></a>Create a VM and connect it to a Virtual Network by using the Network Controller cmdlets for Windows PowerShell

This section includes the following topics.

1.	[Create a VM with a VM network adapter that has a static MAC address](#bkmk_create)
2.	[Get the Virtual Network that contains the subnet to which you want to connect the network adapter](#bkmk_getvn)
3.	[Create a network interface object in Network Controller](#bkmk_object)
4.	[Get the InstanceId for the network interface from Network Controller](#bkmk_getinstance)
5.	[Set the Interface ID on the Hyper-V VM network adapter port](#bkmk_setinstance)
6.	[Start the VM](#bkmk_start)

### <a name="bkmk_create"></a>Create a VM with a VM network adapter that has a static MAC address

To create a VM with a network adapter that has a static MAC address, use the following example command.

```
New-VM -Generation 2 -Name "MyVM" -Path "C:\VMs\MyVM" -MemoryStartupBytes 4GB -VHDPath "c:\VMs\MyVM\Virtual Hard Disks\WindowsServer2016.vhdx" -SwitchName "SDNvSwitch" 

Set-VM -Name "MyVM" -ProcessorCount 4

Set-VMNetworkAdapter -VMName "MyVM" -StaticMacAddress "00-11-22-33-44-55" 
```

### <a name="bkmk_getvn"></a>Get the Virtual Network that contains the subnet to which you want to connect the network adapter
To get the Virtual Network, use the following example command.

```
$vnet = get-networkcontrollervirtualnetwork -connectionuri $uri -ResourceId “Contoso_WebTier”
```

>[!NOTE]If you require custom ACLs for this network interface, then create the ACL now by using instructions in the topic [Use Access Control Lists (ACLs) to Manage Datacenter Network Traffic Flow](https://technet.microsoft.com/library/mt703756.aspx)

### <a name="bkmk_object"></a>Create a network interface object in Network Controller

To create a network interface object in Network Controller, use the following example command.

>[!NOTE]If you created a custom ACL after the previous step, you can use it now.

```
$vmnicproperties = new-object Microsoft.Windows.NetworkController.NetworkInterfaceProperties
$vmnicproperties.PrivateMacAddress = "00-11-22-33-44-55" 

$vmnicproperties.DnsSettings = new-object Microsoft.Windows.NetworkController.NetworkInterfaceDnsSettings
$vmnicproperties.DnsSettings.DnsServers = @("24.30.1.11", "24.30.1.12")

$ipconfiguration = new-object Microsoft.Windows.NetworkController.NetworkInterfaceIpConfiguration
$ipconfiguration.resourceid = "MyVM_IP1"
$ipconfiguration.properties = new-object Microsoft.Windows.NetworkController.NetworkInterfaceIpConfigurationProperties
$ipconfiguration.properties.PrivateIPAddress = “24.30.1.101”
$ipconfiguration.properties.PrivateIPAllocationMethod = "Static"

$ipconfiguration.properties.Subnet = new-object Microsoft.Windows.NetworkController.Subnet
$ipconfiguration.properties.subnet.ResourceRef = $vnet.Properties.Subnets[0].ResourceRef

$vmnicproperties.IpConfigurations = @($ipconfiguration)
New-NetworkControllerNetworkInterface –ResourceID “MyVM_Ethernet1” –Properties $vmnicproperties –ConnectionUri $uri
```

### <a name="bkmk_getinstance"></a>Get the InstanceId for the network interface from Network Controller
To get the InstanceId for the network interface from Network Controller, use the following example command.

```
$nic = Get-NetworkControllerNetworkInterface -ConnectionUri $uri -ResourceId "MyVM-Ethernet1"
```

### <a name="bkmk_setinstance"></a>Set the Interface ID on the Hyper-V VM network adapter port
To set the Interface ID on the Hyper-V VM network adapter port, use the following example command.
>[!NOTE]You must run these commands on the Hyper-V host where the VM is installed.

```
#The hardcoded Ids in this section are fixed values and must not change.

$FeatureId = "9940cd46-8b06-43bb-b9d5-93d50381fd56"

$vmNics = Get-VMNetworkAdapter -VMName “MyVM”

$CurrentFeature = Get-VMSwitchExtensionPortFeature -FeatureId $FeatureId -VMNetworkAdapter $vmNics

if ($CurrentFeature -eq $null)
{
    $Feature = Get-VMSystemSwitchExtensionPortFeature -FeatureId $FeatureId

    $Feature.SettingData.ProfileId = "{$($nic.InstanceId)}"
    $Feature.SettingData.NetCfgInstanceId = "{56785678-a0e5-4a26-bc9b-c0cba27311a3}"
    $Feature.SettingData.CdnLabelString = "TestCdn"
    $Feature.SettingData.CdnLabelId = 1111
    $Feature.SettingData.ProfileName = "Testprofile"
    $Feature.SettingData.VendorId = "{1FA41B39-B444-4E43-B35A-E1F7985FD548}"
    $Feature.SettingData.VendorName = "NetworkController"
    $Feature.SettingData.ProfileData = 1

    Add-VMSwitchExtensionPortFeature -VMSwitchExtensionFeature  $Feature -VMNetworkAdapter $vmNics
}        
else
{
    $CurrentFeature.SettingData.ProfileId = "{$($nic.InstanceId)}"
    $CurrentFeature.SettingData.ProfileData = 1

    Set-VMSwitchExtensionPortFeature -VMSwitchExtensionFeature $CurrentFeature  -VMNetworkAdapter $vmNic
}
```

### <a name="bkmk_start"></a>Start the VM
To start the VM, use the following example command.

```
Get-VM -Name “MyVM” | Start-VM 
```


## <a name="bkmk_vlan"></a>Create a VM and attach it to a VLAN by using the NetworkControllerRESTWrappers

This section includes the following topics.


  