---
title: Create a VM and connect to a tenant virtual network or VLAN
description: In this topic, we show you how to create a tenant VM and connect it to either a virtual network that you created with Hyper-V Network Virtualization or to a virtual Local Area Network (VLAN).
manager: grcusanz
ms.topic: article
ms.assetid: 3c62f533-1815-4f08-96b1-dc271f5a2b36
ms.author: anpaul
author: AnirbanPaul
ms.date: 11/02/2021
---
# Create a VM and connect to a tenant virtual network or VLAN

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Azure Stack HCI, versions 21H2 and 20H2

In this topic, you create a tenant VM and connect it to either a virtual network that you created with Hyper-V Network Virtualization or to a virtual Local Area Network (VLAN). You can use Windows PowerShell Network Controller cmdlets to connect to a virtual network or NetworkControllerRESTWrappers to connect to a VLAN.

Use the processes described in this topic to deploy virtual appliances. With a few additional steps, you can configure appliances to process or inspect data packets that flow to or from other VMs on the Virtual Network.

The sections in this topic include example Windows PowerShell commands that contain example values for many parameters. Ensure that you replace example values in these commands with values that are appropriate for your deployment before you run these commands.

## Prerequisites

1. VM network adapters created with static MAC addresses for the lifetime of the VM.<p>If the MAC address changes during the VM lifetime, Network Controller cannot configure the necessary policy for the network adapter. Not configuring the policy for the network prevents the network adapter from processing network traffic, and all communication with the network fails.

2. If the VM requires network access on startup, do not start the VM until after setting the interface ID on the VM network adapter port. If you start the VM before setting the interface ID, and the network interface does not exist, the VM cannot communicate on the network in the Network Controller, and all policies applied.

3. If you require custom ACLs for this network interface, then create the ACL now by using instructions in the topic [Use Access Control Lists (ACLs) to Manage Datacenter Network Traffic Flow](/azure-stack/hci/manage/use-datacenter-firewall-powershell)

Ensure that you have already created a Virtual Network before using this example command. For more information, see [Create, Delete, or Update Tenant Virtual Networks](./create,-delete,-or-update-tenant-virtual-networks.md).

## Create a VM and connect to a Virtual Network by using the Windows PowerShell Network Controller cmdlets

1. Create a VM with a VM network adapter that has a static MAC address.

   ```PowerShell
   New-VM -Generation 2 -Name "MyVM" -Path "C:\VMs\MyVM" -MemoryStartupBytes 4GB -VHDPath "C:\VMs\MyVM\Virtual Hard Disks\WindowsServer2016.vhdx" -SwitchName "SDNvSwitch"

   Set-VM -Name "MyVM" -ProcessorCount 4

   Set-VMNetworkAdapter -VMName "MyVM" -StaticMacAddress "00-11-22-33-44-55"
   ```

2. Get the virtual network that contains the subnet to which you want to connect the network adapter.

   ```Powershell
   $vnet = Get-NetworkControllerVirtualNetwork -ConnectionUri $uri -ResourceId "Contoso_WebTier"
   ```

3. Create a network interface object in Network Controller.

   >[!TIP]
   >In this step, you use the custom ACL.

   ```PowerShell
   $vmnicproperties = New-Object Microsoft.Windows.NetworkController.NetworkInterfaceProperties
   $vmnicproperties.PrivateMacAddress = "001122334455"
   $vmnicproperties.PrivateMacAllocationMethod = "Static"
   $vmnicproperties.IsPrimary = $true

   $vmnicproperties.DnsSettings = New-Object Microsoft.Windows.NetworkController.NetworkInterfaceDnsSettings
   $vmnicproperties.DnsSettings.DnsServers = @("24.30.1.11", "24.30.1.12")

   $ipconfiguration = New-Object Microsoft.Windows.NetworkController.NetworkInterfaceIpConfiguration
   $ipconfiguration.resourceid = "MyVM_IP1"
   $ipconfiguration.properties = New-Object Microsoft.Windows.NetworkController.NetworkInterfaceIpConfigurationProperties
   $ipconfiguration.properties.PrivateIPAddress = "24.30.1.101"
   $ipconfiguration.properties.PrivateIPAllocationMethod = "Static"

   $ipconfiguration.properties.Subnet = New-Object Microsoft.Windows.NetworkController.Subnet
   $ipconfiguration.properties.subnet.ResourceRef = $vnet.Properties.Subnets[0].ResourceRef

   $vmnicproperties.IpConfigurations = @($ipconfiguration)
   New-NetworkControllerNetworkInterface –ResourceID "MyVM_Ethernet1" –Properties $vmnicproperties –ConnectionUri $uri
   ```

4. Get the InstanceId for the network interface from Network Controller.

   ```PowerShell
    $nic = Get-NetworkControllerNetworkInterface -ConnectionUri $uri -ResourceId "MyVM_Ethernet1"
   ```

5. Set the Interface ID on the Hyper-V VM network adapter port.

   >[!NOTE]
   >You must run these commands on the Hyper-V host where the VM is installed.

   ```PowerShell
   #Do not change the hardcoded IDs in this section, because they are fixed values and must not change.

   $FeatureId = "9940cd46-8b06-43bb-b9d5-93d50381fd56"

   $vmNics = Get-VMNetworkAdapter -VMName "MyVM"

   $CurrentFeature = Get-VMSwitchExtensionPortFeature -FeatureId $FeatureId -VMNetworkAdapter $vmNics

   if ($CurrentFeature -eq $null) {
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
   } else {
       $CurrentFeature.SettingData.ProfileId = "{$($nic.InstanceId)}"
       $CurrentFeature.SettingData.ProfileData = 1
    
       Set-VMSwitchExtensionPortFeature -VMSwitchExtensionFeature $CurrentFeature  -VMNetworkAdapter $vmNics
   }
   ```

6. Start the VM.

   ```PowerShell
    Get-VM -Name "MyVM" | Start-VM
   ```

You have successfully created a VM, connected the VM to a tenant Virtual Network, and started the VM so that it can process tenant workloads.

## Create a VM and connect to a VLAN by using NetworkControllerRESTWrappers

1. Create the VM and assign a static MAC address to the VM.

   ```PowerShell
   New-VM -Generation 2 -Name "MyVM" -Path "C:\VMs\MyVM" -MemoryStartupBytes 4GB -VHDPath "C:\VMs\MyVM\Virtual Hard Disks\WindowsServer2016.vhdx" -SwitchName "SDNvSwitch"

   Set-VM -Name "MyVM" -ProcessorCount 4

   Set-VMNetworkAdapter -VMName "MyVM" -StaticMacAddress "00-11-22-33-44-55"
   ```

2. Set the VLAN ID on the VM network adapter.

   ```PowerShell
   Set-VMNetworkAdapterIsolation –VMName "MyVM" -AllowUntaggedTraffic $true -IsolationMode VLAN -DefaultIsolationId 123
   ```

3. Get the logical network subnet and create the network interface.

   ```PowerShell
    $logicalnet = Get-NetworkControllerLogicalNetwork -ConnectionUri $uri -ResourceId "00000000-2222-1111-9999-000000000002"

    $vmnicproperties = New-Object Microsoft.Windows.NetworkController.NetworkInterfaceProperties
    $vmnicproperties.PrivateMacAddress = "00-1D-C8-B7-01-02"
    $vmnicproperties.PrivateMacAllocationMethod = "Static"
    $vmnicproperties.IsPrimary = $true

    $vmnicproperties.DnsSettings = New-Object Microsoft.Windows.NetworkController.NetworkInterfaceDnsSettings
    $vmnicproperties.DnsSettings.DnsServers = $logicalnet.Properties.Subnets[0].DNSServers

    $ipconfiguration = New-Object Microsoft.Windows.NetworkController.NetworkInterfaceIpConfiguration
    $ipconfiguration.resourceid = "MyVM_Ip1"
    $ipconfiguration.properties = New-Object Microsoft.Windows.NetworkController.NetworkInterfaceIpConfigurationProperties
    $ipconfiguration.properties.PrivateIPAddress = "10.127.132.177"
    $ipconfiguration.properties.PrivateIPAllocationMethod = "Static"

    $ipconfiguration.properties.Subnet = New-Object Microsoft.Windows.NetworkController.Subnet
    $ipconfiguration.properties.subnet.ResourceRef = $logicalnet.Properties.Subnets[0].ResourceRef

    $vmnicproperties.IpConfigurations = @($ipconfiguration)
    $vnic = New-NetworkControllerNetworkInterface –ResourceID "MyVM_Ethernet1" –Properties $vmnicproperties –ConnectionUri $uri

    $vnic.InstanceId
   ```

4. Set the InstanceId on the Hyper-V port.

   ```PowerShell
   #The hardcoded Ids in this section are fixed values and must not change.
   $FeatureId = "9940cd46-8b06-43bb-b9d5-93d50381fd56"

   $vmNics = Get-VMNetworkAdapter -VMName "MyVM"

   $CurrentFeature = Get-VMSwitchExtensionPortFeature -FeatureId $FeatureId -VMNetworkAdapter $vmNics

   if ($CurrentFeature -eq $null) {
       $Feature = Get-VMSystemSwitchExtensionFeature -FeatureId $FeatureId

       $Feature.SettingData.ProfileId = "{$InstanceId}"
       $Feature.SettingData.NetCfgInstanceId = "{56785678-a0e5-4a26-bc9b-c0cba27311a3}"
       $Feature.SettingData.CdnLabelString = "TestCdn"
       $Feature.SettingData.CdnLabelId = 1111
       $Feature.SettingData.ProfileName = "Testprofile"
       $Feature.SettingData.VendorId = "{1FA41B39-B444-4E43-B35A-E1F7985FD548}"
       $Feature.SettingData.VendorName = "NetworkController"
       $Feature.SettingData.ProfileData = 1

       Add-VMSwitchExtensionFeature -VMSwitchExtensionFeature  $Feature -VMNetworkAdapter $vmNics
   } else {
       $CurrentFeature.SettingData.ProfileId = "{$InstanceId}"
       $CurrentFeature.SettingData.ProfileData = 1

       Set-VMSwitchExtensionPortFeature -VMSwitchExtensionFeature $CurrentFeature  -VMNetworkAdapter $vmNics
   }
   ```

5. Start the VM.

   ```PowerShell
   Get-VM -Name "MyVM" | Start-VM
   ```

You have successfully created a VM, connected the VM to a VLAN, and started the VM so that it can process tenant workloads.
