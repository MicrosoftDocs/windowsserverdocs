---
title: Create a VM and Connect to a Tenant Virtual Network or VLAN
description: This topic is part of the Software Defined Networking guide on how to Manage Tenant Workloads and Virtual Networks in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3c62f533-1815-4f08-96b1-dc271f5a2b36
ms.author: pashort
author: shortpatti
---
# Create a VM and Connect to a Tenant Virtual Network or VLAN

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to create a tenant virtual machine \(VM\) and connect the VM to either a Virtual Network that you created with Hyper-V Network Virtualization or to a virtual Local Area Network \(VLAN\). 

This topic contains the following sections.

- [Create a VM and connect to a Virtual Network by using the Windows PowerShell Network Controller cmdlets](#bkmk_vn)
- [Create a VM and connect to a VLAN by using NetworkControllerRESTWrappers](#bkmk_vlan)

## Requirements
Before performing the procedures in the following sections, note the following requirements.

1. You must create VM network adapters with static media access control \(MAC\) addresses so that the MAC address of the VM does not change during the VM lifetime. 
>[!NOTE]
>If the VM MAC address changes during the VM lifetime, Network Controller cannot configure the necessary policy for the network adapter. If the policy for the network adapter is not configured, the network adapter is prevented from processing network traffic, and all communication with the network fails. 

2. If the VM requires network access on startup, it is important that you do not start the VM until after the final configuration step - setting the Interface ID on the VM network adapter port. If you start the VM before you complete this step, the VM cannot communicate on the network until the network interface is created in Network Controller and the controller has applied all applicable policies - Virtual Network policy, access control lists \(ACLs\), and quality of service \(QoS\).

You can also use the processes that are described in this topic for deploying virtual appliances. With a few additional steps, you can configure appliances to process or inspect data packets that flow to or from other VMs on the Virtual Network.

>[!IMPORTANT]
>The following sections include example Windows PowerShell commands that contain example values for many parameters. Ensure that you replace example values in these commands with values that are appropriate for your deployment before you run these commands.  

## <a name="bkmk_vn"></a>Create a VM and connect to a Virtual Network by using the Windows PowerShell Network Controller cmdlets

This section includes the following topics.

1.	[Create a VM with a VM network adapter that has a static MAC address](#bkmk_create)
2.	[Get the Virtual Network that contains the subnet to which you want to connect the network adapter](#bkmk_getvn)
3.	[Create a network interface object in Network Controller](#bkmk_object)
4.	[Get the InstanceId for the network interface from Network Controller](#bkmk_getinstance)
5.	[Set the Interface ID on the Hyper-V VM network adapter port](#bkmk_setinstance)
6.	[Start the VM](#bkmk_start)

### <a name="bkmk_create"></a>Create a VM with a VM network adapter that has a static MAC address

To create a VM with a network adapter that has a static MAC address, use the following example command.

    
    New-VM -Generation 2 -Name "MyVM" -Path "C:\VMs\MyVM" -MemoryStartupBytes 4GB -VHDPath "c:\VMs\MyVM\Virtual Hard Disks\WindowsServer2016.vhdx" -SwitchName "SDNvSwitch" 
    
    Set-VM -Name "MyVM" -ProcessorCount 4
    
    Set-VMNetworkAdapter -VMName "MyVM" -StaticMacAddress "00-11-22-33-44-55" 
    

### <a name="bkmk_getvn"></a>Get the Virtual Network that contains the subnet to which you want to connect the network adapter
Ensure that you have already created a Virtual Network before using this example command. For more information, see [Create, Delete, or Update Tenant Virtual Networks](https://technet.microsoft.com/windows-server-docs/networking/sdn/manage/create%2c-delete%2c-or-update-tenant-virtual-networks).

To get the Virtual Network, use the following example command.

    
    $vnet = get-networkcontrollervirtualnetwork -connectionuri $uri -ResourceId “Contoso_WebTier”
    

>[!NOTE]
>If you require custom ACLs for this network interface, then create the ACL now by using instructions in the topic [Use Access Control Lists (ACLs) to Manage Datacenter Network Traffic Flow](../../sdn/manage/Use-Access-Control-Lists--ACLs--to-Manage-Datacenter-Network-Traffic-Flow.md)

### <a name="bkmk_object"></a>Create a network interface object in Network Controller

To create a network interface object in Network Controller, use the following example command.

>[!NOTE]
>If you created a custom ACL after the previous step, you can use it now.

    
    $vmnicproperties = new-object Microsoft.Windows.NetworkController.NetworkInterfaceProperties
    $vmnicproperties.PrivateMacAddress = "001122334455" 
    $vmnicproperties.PrivateMacAllocationMethod = "Static" 
    $vmnicproperties.IsPrimary = $true 

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
    

### <a name="bkmk_getinstance"></a>Get the InstanceId for the network interface from Network Controller
To get the InstanceId for the network interface from Network Controller, use the following example command.

    
    $nic = Get-NetworkControllerNetworkInterface -ConnectionUri $uri -ResourceId "MyVM-Ethernet1"
    

### <a name="bkmk_setinstance"></a>Set the Interface ID on the Hyper-V VM network adapter port
To set the Interface ID on the Hyper-V VM network adapter port, use the following example command.

>[!NOTE]
>You must run these commands on the Hyper-V host where the VM is installed.

    
    #Do not change the hardcoded IDs in this section, because they are fixed values and must not change.
    
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
    

### <a name="bkmk_start"></a>Start the VM
To start the VM, use the following example command.

    
    Get-VM -Name “MyVM” | Start-VM 
    
You have now successfully created a VM, connected the VM to a tenant Virtual Network, and started the VM so that it can process tenant workloads.

## <a name="bkmk_vlan"></a>Create a VM and connect to a VLAN by using NetworkControllerRESTWrappers

This section includes the following topics.

1. [Create the VM and assign a static MAC address](#bkmk_mac)
2. [Set the VLAN ID on the VM network adapter](#bkmk_vid)
3. [Get the logical network subnet and create the network interface](#bkmk_subnet)
4. [Set the InstanceId on the Hyper-V port](#bkmk_instance)
5. [Start the VM](#bkmk_startvlan)


###<a name="bkmk_mac"></a>Create the VM and assign a static MAC address
To create a VM and assign a static media access control \(MAC\) address to the VM, you can use the following example commands.

    New-VM -Generation 2 -Name "MyVM" -Path "C:\VMs\MyVM" -MemoryStartupBytes 4GB -VHDPath "c:\VMs\MyVM\Virtual Hard Disks\WindowsServer2016.vhdx" -SwitchName "SDNvSwitch" 

    Set-VM -Name "MyVM" -ProcessorCount 4

    Set-VMNetworkAdapter -VMName "MyVM" -StaticMacAddress "00-11-22-33-44-55" 

###<a name="bkmk_vid"></a>Set the VLAN ID on the VM network adapter
To set the VLAN ID on the network adapter, you can use the following example command.


    Set-VMNetworkAdapterIsolation –VMName “MyVM” -AllowUntaggedTraffic $true -IsolationMode VLAN -DefaultIsolationId 123


###<a name="bkmk_subnet"></a>Get the logical network subnet and create the network interface

To obtain the logical network subnet and create the network interface using the logical network subnet, you can use the following example commands.


    $logicalnet = get-networkcontrollerLogicalNetwork -connectionuri $uri -ResourceId "00000000-2222-1111-9999-000000000002"

    $vmnicproperties = new-object Microsoft.Windows.NetworkController.NetworkInterfaceProperties
    $vmnicproperties.PrivateMacAddress = "00-1D-C8-B7-01-02"
    $vmnicproperties.PrivateMacAllocationMethod = "Static"
    $vmnicproperties.IsPrimary = $true 
    
    $vmnicproperties.DnsSettings = new-object Microsoft.Windows.NetworkController.NetworkInterfaceDnsSettings
    $vmnicproperties.DnsSettings.DnsServers = $logicalnet.Properties.Subnets[0].DNSServers

    $ipconfiguration = new-object Microsoft.Windows.NetworkController.NetworkInterfaceIpConfiguration
    $ipconfiguration.resourceid = "MyVM_Ip1"
    $ipconfiguration.properties = new-object Microsoft.Windows.NetworkController.NetworkInterfaceIpConfigurationProperties
    $ipconfiguration.properties.PrivateIPAddress = “10.127.132.177”
    $ipconfiguration.properties.PrivateIPAllocationMethod = "Static"

    $ipconfiguration.properties.Subnet = new-object Microsoft.Windows.NetworkController.Subnet
    $ipconfiguration.properties.subnet.ResourceRef = $logicalnet.Properties.Subnets[0].ResourceRef

    $vmnicproperties.IpConfigurations = @($ipconfiguration)
    $vnic = New-NetworkControllerNetworkInterface –ResourceID “MyVM_Ethernet1” –Properties $vmnicproperties –ConnectionUri $uri

    $vnic.InstanceId
    

###<a name="bkmk_instance"></a>Set the InstanceId on the Hyper-V port
To set the InstanceId on the Hyper-V port, you can use the following example commands on the Hyper-V host where the VM is located.

  
    #The hardcoded Ids in this section are fixed values and must not change.
    $FeatureId = "9940cd46-8b06-43bb-b9d5-93d50381fd56"

    $vmNics = Get-VMNetworkAdapter -VMName “MyVM”

    $CurrentFeature = Get-VMSwitchExtensionPortFeature -FeatureId $FeatureId -VMNetworkAdapter $vmNic
        
    if ($CurrentFeature -eq $null)
    {
        $Feature = Get-VMSystemSwitchExtensionFeature -FeatureId $FeatureId
        
        $Feature.SettingData.ProfileId = "{$InstanceId}"
        $Feature.SettingData.NetCfgInstanceId = "{56785678-a0e5-4a26-bc9b-c0cba27311a3}"
        $Feature.SettingData.CdnLabelString = "TestCdn"
        $Feature.SettingData.CdnLabelId = 1111
        $Feature.SettingData.ProfileName = "Testprofile"
        $Feature.SettingData.VendorId = "{1FA41B39-B444-4E43-B35A-E1F7985FD548}"
        $Feature.SettingData.VendorName = "NetworkController"
        $Feature.SettingData.ProfileData = 1
                
        Add-VMSwitchExtensionFeature -VMSwitchExtensionFeature  $Feature -VMNetworkAdapter $vmNic
    }        
    else
    {
        $CurrentFeature.SettingData.ProfileId = "{$InstanceId}"
        $CurrentFeature.SettingData.ProfileData = 1

        Set-VMSwitchExtensionPortFeature -VMSwitchExtensionFeature $CurrentFeature  -VMNetworkAdapter $vmNic
    }


###<a name="bkmk_startvlan"></a>Start the VM
To start the VM, you can use the following example command.


    Get-VM -Name “MyVM” | Start-VM 

You have now successfully created a VM, connected the VM to a VLAN, and started the VM so that it can process tenant workloads.

  

