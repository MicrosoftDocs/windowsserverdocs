---
title: Configure the RRAS MTGW Hyper-V Host for VLANs_1
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f6245950-c60d-42ed-8fac-7d17a70fc54b
author: vhorne
---
# Configure the RRAS MTGW Hyper-V Host for VLANs_1
You can use this topic to configure a Hyper\-V host with virtual network settings and a virtual machine \(VM\) that will be the Remote Access Multitenant Gateway.  
  
> [!IMPORTANT]  
> Before you run the script that is provided in this topic, you must install Hyper\-V on the host computer. To install Hyper\-V and restart the computer, open Windows PowerShell with Administrator privileges and run the following commands.  
  
```  
## Install Hyper-V ##  
get-windowsfeature *hyper* | install-windowsfeature  
  
## Restart the computer immediately ##  
shutdown /r /t 0  
```  
  
This topic contains the following sections.  
  
-   [Windows PowerShell script explanation](#bkmk_exp)  
  
-   [Full Windows PowerShell script](#bkmk_script)  
  
-   [Windows PowerShell command reference links](#bkmk_links)  
  
## <a name="bkmk_exp"></a>Windows PowerShell script explanation  
In the first section of the script, named “Macros for Multitenant \(MT\) Cloud Gateway \(GW\),” macros are used to define variables that are used throughout the script within the Windows PowerShell commands. For example, the following macro defines the name of the VM MTCloudGW:  
  
```  
$CloudGW_VM_Name = "MTCloudGW"  
  
```  
  
In script commands, the actual VM name of “MTCloudGW” is not used; instead the macro name is used, “$CloudGW\_VM\_Name.” If needed, this allows you to change the values of macros one time rather than changing actual values throughout an entire script.  
  
Ensure that you review all of the macro values in this section so that they are appropriate for your deployment.  
  
In the second section of the script, “Create virtual switch, VM, and routing domain mappings,” a new virtual switch is created, and the MT GW VM is created with 4 GB RAM and connected to the virtual switch. In addition, routing domain mappings for the Contoso and Fabrikam tenants are defined.  
  
In the third section of the script, named “Cleanup Cloud\-VM Host,” any existing Network Virtualization settings are removed from the Hyper\-V host, including Network Virtualization Lookup Records, Network Virtualization Customer Routes, and Network Virtualization Provider Addresses. Cleanup is verified by using the Get commands.  
  
In the fourth section of the script, named “Configure MTCloudGW Hyper\-V Host,” Network Virtualization Lookup Records, Network Virtualization Customer Routes, and Network Virtualization Provider Addresses are created for both tenants.  
  
## <a name="bkmk_script"></a>Full Windows PowerShell script  
Following is the full script that you can run on the Hyper\-V host to configure the host with Network Virtualization and two VM networks with two VMS per VM network.  
  
#### To run this script on a Hyper\-V host  
  
1.  Change the example company names, Contoso and Fabrikam, to names of your actual tenants.  
  
2.  Change other parameter values to match your deployment requirements and environment.  
  
3.  Ensure that the value for the macro **$CloudNIC** matches the name of a network adapter on the Hyper\-V host. If it doesn’t, creation of the virtual switch and VM will fail when you run this script. If you want to change the name of an existing network adapter to the new name CloudNic to match the script, you can run the following Windows PowerShell command after adding values that match your network adapter configuration.  
  
    ```  
    Rename-NetAdapter [-Name] <String[]> [-NewName] CloudNic  
    ```  
  
4.  Determine the Provider Addresses, Customer Addresses, Virtual Subnet ID’s, and other values that you prefer to use. You can keep the values in the script or you can change them to suit your deployment.  
  
5.  If you change any values in this script or the other scripts provided in this document, ensure that the values are changed in all of the scripts. For example, if you want to change the tenant name Contoso to the name Woodgrove \(or to the name of one of your actual tenants\), ensure that you change Contoso to Woodgrove in all scripts before running them.  
  
6.  Copy the Windows PowerShell script below to the Multitenant Gateway Hyper\-V host.  
  
7.  On the Hyper\-V host, open Windows PowerShell with Administrator privileges. Run the script by typing the folder location and file name of the script. For example, if the file name of the script is MTGWHostConfig.ps1 and the folder location is C:\\Users\\Administrator\\Documents, type **C:\\Users\\Administrator\\Documents\\MTGWHostConfig.ps1**, and then press ENTER.  
  
```  
##### Macros for Multitenant (MT) Cloud Gateway (GW) Hyper-V Host Configuration #####  
  
$CloudGW_VM_Name = "MTCloudGW"  
$VHDPath = "C:\VMs\MTCloudGW\MTCloudGW.vhd"  
$SwitchName = "CloudSwitch"  
  
$CloudNIC = "CloudNic"  
  
$Cloud_GW_ProviderAddress = "192.168.0.11"  
$Cloud_VM_ProviderAddress = "192.168.0.22"  
  
$Contoso_CloudGW_IP = "10.0.2.2"  
$Fabrikam_CloudGW_IP = "10.0.2.2"  
$Contoso_CloudGW_DefaultGW = "10.0.2.1"  
$Fabrikam_CloudGW_DefaultGW = "10.0.2.1"  
  
$Contoso_CloudGW_Subnet = "10.0.2.0/24"  
$Fabrikam_CloudGW_Subnet = "10.0.2.0/24"  
  
$Contoso_CloudVM_IP = "10.0.1.101"  
$Contoso_CloudVM2_IP = "10.0.1.111"  
$Fabrikam_CloudVM_IP = "10.0.1.101"  
$Fabrikam_CloudVM2_IP = "10.0.1.111"  
$Contoso_CloudVM_DefaultGW = "10.0.1.1"  
$Fabrikam_CloudVM_DefaultGW = "10.0.1.1"  
  
$Contoso_CloudVM_Subnet = "10.0.1.0/24"  
$Fabrikam_CloudVM_Subnet = "10.0.1.0/24"  
  
$ContosoVMNicMac = "00155DE2AB00"   
$ContosoVM2NicMac = "00155DE2AB01"   
$ContosoDefaultNicMac = "001122334455"  
$ContosoRoutinGDomainGuid = "{12345678-1000-2000-3000-123456780001}"  
$ContosoVSID_GW = "3001"  
$ContosoVSID_VM = "3000"  
  
$FabrikamVMNicMac = "00155DE2AB02"   
$FabrikamVM2NicMac = "00155DE2AB03"   
$FabrikamDefaultNicMac = "001122334466"  
$FabrikamRoutinGDomainGuid = "{12345678-1000-2000-3000-123456780002}"  
$FabrikamVSID_GW = "4001"  
$FabrikamVSID_VM = "4000"  
  
##### Create virtual switch, VM, and routing domain mappings #####  
  
New-VMSwitch $SwitchName -NetAdapterName $CloudNIC -AllowManagementOS $false  
  
New-VM $CloudGW_VM_Name -MemoryStartupBytes 4GB -VHDPath $VHDPath -SwitchName $SwitchName  
  
Rename-VMNetworkAdapter -VMName $CloudGW_VM_Name -Name "Network Adapter" -NewName "CloudNic"  
Set-VmNetworkAdapterIsolation –VMName $CloudGW_VM_Name –VMNetworkAdapterName “CloudNic” –MultiTenantStack on –IsolationMode VLAN  
  
Add-VmNetworkAdapterRoutingDomainMapping -VMName $CloudGW_VM_Name -VMNetworkAdapterName "CloudNic" -RoutingDomainId $ContosoRoutinGDomainGuid  -RoutingDomainName "ContosoTenant" -IsolationId $ContosoVSID_GW -IsolationName "ContosoGWSubnet"  
Add-VmNetworkAdapterRoutingDomainMapping -VMName $CloudGW_VM_Name -VMNetworkAdapterName "CloudNic" -RoutingDomainId $FabrikamRoutinGDomainGuid  -RoutingDomainName "FabrikamTenant" -IsolationId $FabrikamVSID_GW -IsolationName "FabrikamGWSubnet"  
  
##### Cleanup MTCloudGW Hyper-V Host #####  
  
Remove-NetVirtualizationCustomerRoute  
Remove-NetVirtualizationLookupRecord  
Remove-NetVirtualizationProviderAddress  
  
Get-NetVirtualizationCustomerRoute  
Get-NetVirtualizationLookupRecord  
Get-NetVirtualizationProviderAddress  
  
##### Configure MTCloudGW Hyper-V Host #####  
  
#### Provider Address Configuration ####  
  
$MTNic = Get-NetAdapter $CloudNIC  
New-NetVirtualizationProviderAddress -ProviderAddress $Cloud_GW_ProviderAddress -InterfaceIndex $MTNic.InterfaceIndex -PrefixLength 24  
  
#### Lookup and Customer Records Configuration ####  
  
$MTVMNic = Get-VMNetworkAdapter -VMName "MTCloudGW" -Name "CloudNic"  
$MTNicMac = $MTVMNic.MacAddress  
  
## Contoso Tenant lookup record configuration ##  
  
New-NetVirtualizationLookupRecord -CustomerAddress $Contoso_CloudGW_IP -VirtualSubnetID $ContosoVSID_GW -MACAddress $MTNicMac -ProviderAddress $Cloud_GW_ProviderAddress -Rule "TranslationMethodEncap" -Context "ContosoSubnet"  
New-NetVirtualizationLookupRecord -CustomerAddress $Contoso_CloudGW_DefaultGW -VirtualSubnetID $ContosoVSID_GW -MACAddress $ContosoDefaultNicMac -ProviderAddress $Cloud_GW_ProviderAddress -Rule "TranslationMethodEncap" -Context "ContosoDefaultGW"  
New-NetVirtualizationLookupRecord -CustomerAddress 0.0.0.0 -VirtualSubnetID $ContosoVSID_GW -MACAddress $MTNicMac -ProviderAddress $Cloud_GW_ProviderAddress -Rule "TranslationMethodEncap" -Context "ContosoWildcard" -Type "GatewayWildcard"  
New-NetVirtualizationLookupRecord -CustomerAddress $Contoso_CloudVM_IP -VirtualSubnetID $ContosoVSID_VM -MACAddress $ContosoVMNicMac -ProviderAddress $Cloud_VM_ProviderAddress -Rule "TranslationMethodEncap" -Context "ContosoVM1"  
New-NetVirtualizationLookupRecord -CustomerAddress $Contoso_CloudVM2_IP -VirtualSubnetID $ContosoVSID_VM -MACAddress $ContosoVM2NicMac -ProviderAddress $Cloud_VM_ProviderAddress -Rule "TranslationMethodEncap" -Context "ContosoVM2"  
  
New-NetVirtualizationCustomerRoute -RoutingDomainID $ContosoRoutinGDomainGuid -VirtualSubnetID $ContosoVSID_GW -DestinationPrefix $Contoso_CloudGW_Subnet -NextHop 0.0.0.0  
New-NetVirtualizationCustomerRoute -RoutingDomainID $ContosoRoutinGDomainGuid -VirtualSubnetID $ContosoVSID_VM -DestinationPrefix $Contoso_CloudVM_Subnet -NextHop 0.0.0.0  
  
## Fabrikam Tenant lookup record configuration ##  
  
New-NetVirtualizationLookupRecord -CustomerAddress $Fabrikam_CloudGW_IP -VirtualSubnetID $FabrikamVSID_GW -MACAddress $MTNicMac -ProviderAddress $Cloud_GW_ProviderAddress -Rule "TranslationMethodEncap" -Context "FabrikamSubnet"  
New-NetVirtualizationLookupRecord -CustomerAddress $Fabrikam_CloudGW_DefaultGW -VirtualSubnetID $FabrikamVSID_GW -MACAddress $FabrikamDefaultNicMac -ProviderAddress $Cloud_GW_ProviderAddress -Rule "TranslationMethodEncap" -Context "FabrikamDefaultGW"  
New-NetVirtualizationLookupRecord -CustomerAddress 0.0.0.0 -VirtualSubnetID $FabrikamVSID_GW -MACAddress $MTNicMac -ProviderAddress $Cloud_GW_ProviderAddress -Rule "TranslationMethodEncap" -Context "FabrikamWildcard" -Type "GatewayWildcard"  
New-NetVirtualizationLookupRecord -CustomerAddress $Fabrikam_CloudVM_IP -VirtualSubnetID $FabrikamVSID_VM -MACAddress $FabrikamVMNicMac -ProviderAddress $Cloud_VM_ProviderAddress -Rule "TranslationMethodEncap" -Context "FabrikamVM1"  
New-NetVirtualizationLookupRecord -CustomerAddress $Fabrikam_CloudVM2_IP -VirtualSubnetID $FabrikamVSID_VM -MACAddress $FabrikamVM2NicMac -ProviderAddress $Cloud_VM_ProviderAddress -Rule "TranslationMethodEncap" -Context "FabrikamVM2"  
  
New-NetVirtualizationCustomerRoute -RoutingDomainID $FabrikamRoutinGDomainGuid -VirtualSubnetID $FabrikamVSID_GW -DestinationPrefix $Fabrikam_CloudGW_Subnet -NextHop 0.0.0.0  
New-NetVirtualizationCustomerRoute -RoutingDomainID $FabrikamRoutinGDomainGuid -VirtualSubnetID $FabrikamVSID_VM -DestinationPrefix $Fabrikam_CloudVM_Subnet -NextHop 0.0.0.0  
  
```  
  
## <a name="bkmk_links"></a>Windows PowerShell command reference links  
The script in this topic uses the following Windows PowerShell commands. Click a link to open the help topic for the command.  
  
-   [New\-VMSwitch](http://technet.microsoft.com/library/hh848455.aspx). Creates a new virtual switch on one or more virtual machine hosts.  
  
-   [New\-VM](http://technet.microsoft.com/library/hh848537.aspx). Creates a new virtual machine.  
  
-   [Rename\-VMNetworkAdapter](http://technet.microsoft.com/library/hh848517.aspx). Renames a virtual network adapter on a virtual machine or on the management operating system.  
  
-   [Set\-VmNetworkAdapterIsolation](http://technet.microsoft.com/library/dn464283.aspx). Modifies isolation settings for a virtual network adapter.  
  
-   [Add\-VmNetworkAdapterRoutingDomainMapping](http://technet.microsoft.com/library/dn464285.aspx). Adds a routing domain and virtual subnets to a virtual network adapter.  
  
-   [Remove\-NetVirtualizationCustomerRoute](http://technet.microsoft.com/library/jj884261.aspx). Removes virtual network routes.  
  
-   [Remove\-NetVirtualizationLookupRecord](http://technet.microsoft.com/library/jj884251.aspx). Removes policy entries for IP addresses in a virtual network.  
  
-   [Remove\-NetVirtualizationProviderAddress](http://technet.microsoft.com/library/jj884257.aspx). Deletes Provider Addresses.  
  
-   [Get\-NetVirtualizationCustomerRoute](http://technet.microsoft.com/library/jj884255.aspx). Gets virtual network routes.  
  
-   [Get\-NetVirtualizationLookupRecord](http://technet.microsoft.com/library/jj884256.aspx). Gets policy entries for VMs in a virtual network.  
  
-   [Get\-NetVirtualizationProviderAddress](http://technet.microsoft.com/library/jj884245.aspx) Gets Provider Addresses.  
  
-   [New\-NetVirtualizationProviderAddress](http://technet.microsoft.com/library/jj884259.aspx). Assigns a Provider Address to a network interface.  
  
-   [New\-NetVirtualizationLookupRecord](http://technet.microsoft.com/library/jj884243.aspx). Creates a policy entry for an IP address in a virtual network.  
  
-   [New\-NetVirtualizationCustomerRoute](http://technet.microsoft.com/library/jj884249.aspx). Creates a virtual network route.  
  
## See Also  
[Additional Resources_1](../Topic/Additional-Resources_1.md)  
  
