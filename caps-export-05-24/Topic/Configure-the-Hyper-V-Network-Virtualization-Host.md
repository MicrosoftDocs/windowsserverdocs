---
title: Configure the Hyper-V Network Virtualization Host
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b7947a42-4fb9-4230-937e-f157ddc2a560
---
# Configure the Hyper-V Network Virtualization Host
You can use this topic to configure a Hyper\-V host with Network Virtualization, including two tenant VM networks with two VMs per network.  
  
This topic contains the following sections.  
  
-   [Windows PowerShell script explanation](#bkmk_exp)  
  
-   [Full Windows PowerShell script](#bkmk_script)  
  
-   [Windows PowerShell command reference links](#bkmk_links)  
  
> [!IMPORTANT]  
> Before you run the script that is provided in this topic, you must install the Hyper\-V server role on the host computer. To install Hyper\-V and restart the computer, open Windows PowerShell with Administrator privileges and run the following commands.  
  
```  
## Install Hyper-V ##  
Get-WindowsFeature *hyper* | Install-WindowsFeature  
  
## Restart the computer immediately ##  
shutdown /r /t 0  
```  
  
## <a name="bkmk_exp"></a>Windows PowerShell script explanation  
In the first section of the script, named “Macros for Multitenant \(MT\) Cloud Gateway \(GW\),” macros are used to define variables that are used throughout the script within the Windows PowerShell commands. For example, the following macro defines a VM name:  
  
```  
$CloudVM_ContosoVM1_Name = "ContosoApp1"  
  
```  
  
In script commands, the actual VM name of “ContosoApp1” is not used; instead the macro name is used, “$CloudVM\_ContosoVM1\_Name.” If needed, this allows you to change the values of macros one time rather than changing actual values throughout an entire script.  
  
Ensure that you review all of the macro values in this section so that they are appropriate for your deployment.  
  
In the second section of the script, “Create a virtual switch and create tenant VMs,” the Hyper\-V host network adapter named “Ethernet” is renamed to “CloudNic,” and a new virtual switch is created. Next, four VMs are created – ContosoApp1, ContosoApp2, FabrikamApp1, and FabrikamApp2. All four VMs are allocated 2 GB of Random Access Memory \(RAM\) for a total of 8 GB. Ensure that your host computer has sufficient RAM to support this configuration.  
  
In this same section, the VM network adapters are renamed and assigned Virtual Subnet IDs, or VSIDs.  
  
In the third section of the script, named “Cleanup Cloud\-VM Host,” any existing Network Virtualization settings are removed from the Hyper\-V host, including Network Virtualization Lookup Records, Network Virtualization Customer Routes, and Network Virtualization Provider Addresses. Cleanup is verified by using the Get commands.  
  
In the fourth section of the script, named “Configure Cloud\-VM Host,” Network Virtualization Lookup Records, Network Virtualization Customer Routes, and Network Virtualization Provider Addresses are created for both tenants.  
  
In the final section of the script, named “Retrieve Cloud VM Network Adapter configuration to verify correct settings,” Network Virtualization Lookup Records, Network Virtualization Customer Routes, and Network Virtualization Provider Addresses are obtained and displayed to verify that they are correctly configured.  
  
## <a name="bkmk_script"></a>Full Windows PowerShell script  
Following is the full script that you can run on the Hyper\-V host to configure the host with Network Virtualization and two VM networks with two VMS per VM network. Before you run the script, perform the following steps.  
  
#### To run this script on a Hyper\-V host  
  
1.  Ensure that you replace all variables in the macro section at the beginning of the script with values that are appropriate for your deployment. For example, if you have a tenant named Woodgrove but do not have a tenant named Contoso, replace all instances of the company name Contoso with the name Woodgrove.  
  
2.  This script creates two VMs per tenant. If your tenants need more than two VMs, add the necessary code to create and configure additional VMs.  
  
3.  If you have more than two tenants, add the necessary code to configure additional tenant VMs and VM networks.  
  
4.  Ensure that the value for the macro **$CloudNIC** matches the name of a network adapter on the Hyper\-V host. If it doesn’t, creation of the virtual switch and VM will fail when you run this script. If you want to change the name of an existing network adapter to the new name CloudNic to match the script, you can run the following Windows PowerShell command after adding values that match your network adapter configuration.  
  
    ```  
    Rename-NetAdapter [-Name] <String[]> [-NewName] CloudNic  
    ```  
  
5.  Determine the Provider Addresses, Customer Addresses, Virtual Subnet ID’s, and other values that you prefer to use. You can keep the values in the script or you can change them to suit your deployment.  
  
6.  If you change any values in this script or the other scripts provided in this document, ensure that the values are changed in all of the scripts. For example, if you want to change the tenant name Contoso to the name Woodgrove \(or to the name of one of your actual tenants\), ensure that you change Contoso to Woodgrove in all scripts before running them.  
  
7.  Copy the Windows PowerShell script below to the Multitenant Gateway Hyper\-V host.  
  
8.  On the Hyper\-V host, open Windows PowerShell with Administrator privileges. Run the script by typing the folder location and file name of the script. For example, if the file name of the script is HNVHostConfig.ps1 and the folder location is C:\\Users\\Administrator\\Documents, type **C:\\Users\\Administrator\\Documents\\HNVHostConfig.ps1**, and then press ENTER.  
  
```  
##### Macros for Multitenant (MT) Cloud Gateway (GW) #####  
  
$CloudVM_ContosoVM1_Name = "ContosoApp1"  
$ContosoVM1_VHDPath = "C:\VMs\ContosoApp1\ContosoApp1.vhd"  
  
$CloudVM_ContosoVM2_Name = "ContosoApp2"  
$ContosoVM2_VHDPath = "C:\VMs\ContosoApp2\ContosoApp2.vhd "  
  
$CloudVM_FabrikamVM1_Name = "FabrikamApp1"  
$FabrikamVM1_VHDPath = "C:\VMs\FabrikamApp1\ FabrikamApp1.vhd"  
  
$CloudVM_FabrikamVM2_Name = "FabrikamApp2"  
$FabrikamVM2_VHDPath = "C:\VMs\FabrikamApp1\ FabrikamApp1.vhd"  
  
$SwitchName = "CloudSwitch"  
$CloudNIC = "CloudNic"  
$MTNicMac = "00155DE20A00"  
  
$Tenant1VM1Name = “ContosoVM1”  
$Tenant1VM2Name = “ContosoVM2”  
$Tenant2VM1Name = “FabrikamVM1”  
$Tenant2VM2Name = “FabrikamVM2”  
  
$Cloud_GW_ProviderAddress = "192.168.0.11"  
$Cloud_VM_ProviderAddress = "192.168.0.22"  
  
$Contoso_CloudGW_IP = "10.0.2.2"  
$Contoso_CloudGW_DefaultGW = "10.0.2.1"  
$Contoso_CloudGW_Subnet = "10.0.2.0/24"  
  
$Contoso_CloudVM_IP = "10.0.1.101"  
$Contoso_CloudVM2_IP = "10.0.1.111"  
$Contoso_CloudVM_DefaultGW = "10.0.1.1"  
$Contoso_CloudVM_Subnet = "10.0.1.0/24"  
  
$ContosoVMNicMac = "00155DE2AB00"   
$ContosoVM2NicMac = "00155DE2AB01"   
$ContosoDefaultNicMac = "001122334455"  
$ContosoRoutinGDomainGuid = "{12345678-1000-2000-3000-123456780001}"  
$ContosoVSID_GW = "6001"  
$ContosoVSID_VM = "6000"  
  
$Fabrikam_CloudGW_IP = "10.0.2.2"  
$Fabrikam_CloudGW_DefaultGW = "10.0.2.1"  
$Fabrikam_CloudGW_Subnet = "10.0.2.0/24"  
  
$Fabrikam_CloudVM_IP = "10.0.1.101"  
$Fabrikam_CloudVM2_IP = "10.0.1.111"  
$Fabrikam_CloudVM_DefaultGW = "10.0.1.1"  
$Fabrikam_CloudVM_Subnet = "10.0.1.0/24"  
  
$FabrikamVMNicMac = "00155DE2AB02"   
$FabrikamVM2NicMac = "00155DE2AB03"   
$FabrikamDefaultNicMac = "001122334466"  
$FabrikamRoutinGDomainGuid = "{12345678-1000-2000-3000-123456780002}"  
$FabrikamVSID_GW = "7001"  
$FabrikamVSID_VM = "7000"  
  
## Start on Cloud VM Host ##  
  
##### Create a virtual switch and create tenant VMs #####  
  
Rename-NetAdapter -Name Ethernet -NewName $CloudNic  
  
New-VMSwitch "CloudSwitch" -NetAdapterName $CloudNic -AllowManagementOS $false  
  
New-VM $CloudVM_ContosoVM1_Name -MemoryStartupBytes 2GB -VHDPath $ContosoVM1_VHDPath -SwitchName $SwitchName  
New-VM $CloudVM_ContosoVM2_Name -MemoryStartupBytes 2GB -VHDPath $ContosoVM2_VHDPath -SwitchName $SwitchName  
New-VM $CloudVM_FabrikamVM1_Name -MemoryStartupBytes 2GB -VHDPath $FabrikamVM1_VHDPath -SwitchName $SwitchName  
New-VM $CloudVM_FabrikamVM2_Name -MemoryStartupBytes 2GB -VHDPath $FabrikamVM2_VHDPath -SwitchName $SwitchName  
  
Rename-VMNetworkAdapter -VMName $CloudVM_ContosoVM1_Name -Name "Network Adapter" -NewName $CloudNic  
Rename-VMNetworkAdapter -VMName $CloudVM_ContosoVM2_Name -Name "Network Adapter" -NewName $CloudNic  
Rename-VMNetworkAdapter -VMName $CloudVM_FabrikamVM1_Name -Name "Network Adapter" -NewName $CloudNic  
Rename-VMNetworkAdapter -VMName $CloudVM_FabrikamVM2_Name -Name "Network Adapter" -NewName $CloudNic  
  
Set-VMNetworkAdapter -VMName $CloudVM_ContosoVM1_Name -VirtualSubnetId $ContosoVSID_VM   
Set-VMNetworkAdapter -VMName $CloudVM_ContosoVM2_Name -VirtualSubnetId $ContosoVSID_VM   
Set-VMNetworkAdapter -VMName $CloudVM_FabrikamVM1_Name -VirtualSubnetId $FabrikamVSID_VM   
Set-VMNetworkAdapter -VMName $CloudVM_FabrikamVM2_Name -VirtualSubnetId $FabrikamVSID_VM   
  
##### Cleanup Cloud-VM Host #####  
  
Remove-NetVirtualizationCustomerRoute  
Remove-NetVirtualizationLookupRecord  
Remove-NetVirtualizationProviderAddress  
  
Get-NetVirtualizationCustomerRoute  
Get-NetVirtualizationLookupRecord  
Get-NetVirtualizationProviderAddress  
  
##### Configure Cloud-VM Host #####  
  
#### Provider Address Configuration ####  
  
$MTNic = Get-NetAdapter $CloudNIC  
New-NetVirtualizationProviderAddress -ProviderAddress $Cloud_VM_ProviderAddress -InterfaceIndex $MTNic.InterfaceIndex -PrefixLength 24  
  
#### Lookup and Customer Records Configuration ####  
  
## Contoso Tenant ##  
  
New-NetVirtualizationLookupRecord -CustomerAddress $Contoso_CloudVM_IP -VirtualSubnetID $ContosoVSID_VM -MACAddress $ContosoVMNicMac -ProviderAddress $Cloud_VM_ProviderAddress -Rule "TranslationMethodEncap" -Context $Tenant1VM1Name  
New-NetVirtualizationLookupRecord -CustomerAddress $Contoso_CloudVM2_IP -VirtualSubnetID $ContosoVSID_VM -MACAddress $ContosoVM2NicMac -ProviderAddress $Cloud_VM_ProviderAddress -Rule "TranslationMethodEncap" -Context $Tenant1VM2Name  
New-NetVirtualizationLookupRecord -CustomerAddress $Contoso_CloudVM_DefaultGW -VirtualSubnetID $ContosoVSID_VM -MACAddress $ContosoDefaultNicMac -ProviderAddress $Cloud_VM_ProviderAddress -Rule "TranslationMethodEncap" -Context "ContosoDefaultGW"  
New-NetVirtualizationLookupRecord -CustomerAddress $Contoso_CloudGW_IP -VirtualSubnetID $ContosoVSID_GW -MACAddress $MTNicMac -ProviderAddress $Cloud_GW_ProviderAddress -Rule "TranslationMethodEncap" -Context "ContosoGWSubnet"  
  
New-NetVirtualizationCustomerRoute -RoutingDomainID $ContosoRoutinGDomainGuid -VirtualSubnetID $ContosoVSID_VM -DestinationPrefix $Contoso_CloudVM_Subnet -NextHop 0.0.0.0  
New-NetVirtualizationCustomerRoute -RoutingDomainID $ContosoRoutinGDomainGuid -VirtualSubnetID $ContosoVSID_GW -DestinationPrefix $Contoso_CloudGW_Subnet -NextHop 0.0.0.0  
New-NetVirtualizationCustomerRoute -RoutingDomainID $ContosoRoutinGDomainGuid -VirtualSubnetID $ContosoVSID_GW -DestinationPrefix 0.0.0.0/0 -NextHop $Contoso_CloudGW_IP   
  
## Fabrikam Tenant ##  
  
New-NetVirtualizationLookupRecord -CustomerAddress $Fabrikam_CloudVM_IP -VirtualSubnetID $FabrikamVSID_VM -MACAddress $FabrikamVMNicMac -ProviderAddress $Cloud_VM_ProviderAddress -Rule "TranslationMethodEncap" -Context $Tenant2VM1Name  
New-NetVirtualizationLookupRecord -CustomerAddress $Fabrikam_CloudVM2_IP -VirtualSubnetID $FabrikamVSID_VM -MACAddress $FabrikamVM2NicMac -ProviderAddress $Cloud_VM_ProviderAddress -Rule "TranslationMethodEncap" -Context $Tenant2VM2Name  
New-NetVirtualizationLookupRecord -CustomerAddress $Fabrikam_CloudVM_DefaultGW -VirtualSubnetID $FabrikamVSID_VM -MACAddress $FabrikamDefaultNicMac -ProviderAddress $Cloud_VM_ProviderAddress -Rule "TranslationMethodEncap" -Context "FabrikamDefaultGW"  
New-NetVirtualizationLookupRecord -CustomerAddress $Fabrikam_CloudGW_IP -VirtualSubnetID $FabrikamVSID_GW -MACAddress $MTNicMac -ProviderAddress $Cloud_GW_ProviderAddress -Rule "TranslationMethodEncap" -Context "FabrikamGWSubnet"  
  
New-NetVirtualizationCustomerRoute -RoutingDomainID $FabrikamRoutinGDomainGuid -VirtualSubnetID $FabrikamVSID_VM -DestinationPrefix $Fabrikam_CloudVM_Subnet -NextHop 0.0.0.0  
New-NetVirtualizationCustomerRoute -RoutingDomainID $FabrikamRoutinGDomainGuid -VirtualSubnetID $FabrikamVSID_GW -DestinationPrefix $Fabrikam_CloudGW_Subnet -NextHop 0.0.0.0  
New-NetVirtualizationCustomerRoute -RoutingDomainID $FabrikamRoutinGDomainGuid -VirtualSubnetID $FabrikamVSID_GW -DestinationPrefix 0.0.0.0/0 -NextHop $Fabrikam_CloudGW_IP   
  
## End of Cloud VM Host configuration ##  
  
## Retrieve Cloud VM Network Adapter configuration to verify correct settings ##  
  
Get-VMNetworkAdapter -VMName $CloudVM_ContosoVM1_Name, $CloudVM_ContosoVM2_Name, $CloudVM_FabrikamVM1_Name, $CloudVM_FabrikamVM2_Name | fl  
  
Get-NetVirtualizationCustomerRoute  
Get-NetVirtualizationLookupRecord  
Get-NetVirtualizationProviderAddress  
```  
  
## <a name="bkmk_links"></a>Windows PowerShell command reference links  
The script in this topic uses the following Windows PowerShell commands. Click a link to open the help topic for the command.  
  
-   [New\-VMSwitch](http://technet.microsoft.com/library/hh848455.aspx). Creates a new virtual switch on one or more virtual machine hosts.  
  
-   [New\-VM](http://technet.microsoft.com/library/hh848537.aspx). Creates a new virtual machine.  
  
-   [Rename\-NetAdapter](http://technet.microsoft.com/library/jj130868.aspx). Renames a network adapter.  
  
-   [Rename\-VMNetworkAdapter](http://technet.microsoft.com/library/hh848517.aspx). Renames a virtual network adapter on a virtual machine or on the management operating system.  
  
-   [Set\-VMNetworkAdapter](http://technet.microsoft.com/library/hh848457.aspx). Configures features of the virtual network adapter in a virtual machine or the management operating system.  
  
-   [Remove\-NetVirtualizationLookupRecord](http://technet.microsoft.com/library/jj884251.aspx). Removes policy entries for IP addresses in a virtual network.  
  
-   [Remove\-NetVirtualizationProviderAddress](http://technet.microsoft.com/library/jj884257.aspx). Deletes Provider Addresses.  
  
-   [Get\-NetVirtualizationCustomerRoute](http://technet.microsoft.com/library/jj884255.aspx). Gets virtual network routes.  
  
-   [Get\-NetVirtualizationLookupRecord](http://technet.microsoft.com/library/jj884256.aspx). Gets policy entries for VMs in a virtual network.  
  
-   [Get\-NetVirtualizationProviderAddress](http://technet.microsoft.com/library/jj884245.aspx) Gets Provider Addresses.  
  
-   [New\-NetVirtualizationProviderAddress](http://technet.microsoft.com/library/jj884259.aspx). Assigns a Provider Address to a network interface.  
  
-   [New\-NetVirtualizationLookupRecord](http://technet.microsoft.com/library/jj884243.aspx). Creates a policy entry for an IP address in a virtual network.  
  
-   [New\-NetVirtualizationCustomerRoute](http://technet.microsoft.com/library/jj884249.aspx). Creates a virtual network route.  
  
-   [Get\-VMNetworkAdapter](http://technet.microsoft.com/library/hh848526.aspx). Gets the virtual network adapters of a virtual machine, snapshot, management OS, or of a virtual machine and management OS.  
  
## See Also  
[Additional Resources_1](../Topic/Additional-Resources_1.md)  
  
