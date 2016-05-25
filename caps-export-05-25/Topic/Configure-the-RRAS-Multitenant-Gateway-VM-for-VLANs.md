---
title: Configure the RRAS Multitenant Gateway VM for VLANs
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0d3fd28a-ea77-42f1-a93a-982f24023e2d
author: vhorne
---
# Configure the RRAS Multitenant Gateway VM for VLANs
You can use this topic to configure the virtual machine \(VM\) named MTCloudGW on the Hyper\-V Multitenant Gateway host.  
  
This topic contains the following sections.  
  
-   [To configure the MTCloudGW VM](#bkmk_configure)  
  
-   [RRAS installation Windows PowerShell script](#bkmk_RRAS)  
  
-   [MTGW Configuration Windows PowerShell script](#bkmk_mtgw)  
  
-   [Windows PowerShell command reference links](#bkmk_links)  
  
> [!IMPORTANT]  
> The Windows PowerShell scripts that are provided in this topic must be run from within the VM named MTCloudGW. Do not run these scripts on the Hyper\-V host. In addition, you must replace variable values in the script with values that are appropriate for your deployment.  
  
## <a name="bkmk_configure"></a>To configure the MTCloudGW VM  
  
1.  On the HNV host, open Hyper\-V Manager, and then double\-click the VM named MTCloudGW. The VM opens in a new window. Start the VM.  
  
2.  During the operating system installation on the VM, create an Administrator password and provide other information as required.  
  
3.  After operating system installation is complete, log on to the VM.  
  
4.  Rename the computer and restart the VM by running the following Windows PowerShell commands.  
  
    ```  
    Rename-Computer MTCloudGW  
    Restart-Computer  
    ```  
  
5.  After the computer is restarted, log on to the VM.  
  
6.  Copy the [RRAS installation Windows PowerShell script](#bkmk_RRAS) below to the VM.  
  
7.  On the VM, open Windows PowerShell with Administrator privileges. Run the script by typing the folder location and file name of the script. For example, if the file name of the script is RRASinstall.ps1 and the folder location is C:\\Users\\Administrator\\Documents, type **C:\\Users\\Administrator\\Documents\\ RRASinstall.ps1**, and then press ENTER.  
  
8.  Copy the [MTGW Configuration Windows PowerShell script](#bkmk_MTGW) below to the VM.  
  
9. On the VM, open Windows PowerShell with Administrator privileges. Run the script by typing the folder location and file name of the script. For example, if the file name of the script is MTGWConfig.ps1 and the folder location is C:\\Users\\Administrator\\Documents, type **C:\\Users\\Administrator\\Documents\\ MTGWConfig.ps1**, and then press ENTER.  
  
## <a name="bkmk_RRAS"></a>RRAS installation Windows PowerShell script  
Following is the full script that you can run on the VM MTCloudGW. This script installs RRAS on the MTGW VM.  
  
> [!IMPORTANT]  
> This installation script specifies the Remote Access features for each tenant by using the **Enable\-RemoteAccessRoutingDomain** command. The **–Type** parameter specifies the remote access features that are allowed for the tenant. Following are the possible values you can use for this parameter.  
>   
> -   **Vpn**. If you specify this value, the Multitenant Gateway is configured to allow the tenant to connect to datacenter resources with a VPN dial\-in connection. If you select this option, you must design and implement a solution to authorize and authenticate VPN connection requests.  
> -   **VpnS2S**. If you specify this value, the Multitenant Gateway is configured to allow the tenant to establish site\-to\-site VPN connections between the tenant resources in your datacenter and their remote sites across the Internet. In addition, the Multitenant Gateway can be configured with Border Gateway Protocol \(BGP\).  
> -   **All**. If you specify this value, the Multitenant Gateway is configured to allow the tenant to use the gateway for site\-to\-site VPN connections, to allow configuration of BGP, and to allow dial\-in VPN connections.  
  
```  
##### Macros for RRAS Configuration on MTCloudGW VM #####  
  
$Contoso_RoutingDomain = "ContosoTenant"  
$Contoso_IPv4Range = "11.11.11.1, 11.11.11.200"  
  
$Fabrikam_RoutingDomain = "FabrikamTenant"  
$Fabrikam_IPv4Range = "11.11.11.1, 11.11.11.200"  
  
##### Install S2S VPN on MTCloudGW #####  
  
Add-WindowsFeature -Name RemoteAccess -IncludeAllSubFeature -IncludeManagementTools  
  
ipmo remoteaccess  
  
#Install-RemoteAccess   
Install-RemoteAccess -MultiTenancy  
  
Enable-RemoteAccessRoutingDomain -Name $Contoso_RoutingDomain -Type All -PassThru  
Enable-RemoteAccessRoutingDomain -Name $Fabrikam_RoutingDomain -Type All -PassThru  
  
Set-RemoteAccessRoutingDomain –Name $Contoso_RoutingDomain –IPAddressRange 11.11.11.1, 11.11.11.200 –TenantName “Contoso”  
Set-RemoteAccessRoutingDomain –Name $Fabrikam_RoutingDomain –IPAddressRange 11.11.11.1, 11.11.11.200 –TenantName “Fabrikam”  
```  
  
## <a name="bkmk_mtgw"></a>MTGW Configuration Windows PowerShell script  
Following is the full script that you can run on the VM MTCloudGW. This script configures the VM with tenant routing information.  
  
```  
##### Macros for MT Cloud GW VM #####  
  
$Contoso_CloudGW_Address = "10.0.2.2"  
$Fabrikam_CloudGW_Address = "10.0.2.2"  
$Contoso_CloudVM_Subnet = "10.0.1.0/24"  
$Fabrikam_CloudVM_Subnet = "10.0.1.0/24"  
  
$Contoso_CloudVM_NextHop = "10.0.2.1"  
$Fabrikam_CloudVM_NextHop = "10.0.2.1"  
  
##### Configure Cloud GW VM #####  
  
New-NetIPAddress $Contoso_CloudGW_Address -InterfaceAlias "ContosoGWSubnet"   
New-NetIPAddress $Fabrikam_CloudGW_Address -InterfaceAlias "FabrikamGWSubnet"   
  
New-NetRoute -InterfaceAlias "ContosoGWSubnet" -AddressFamily IPv4 -DestinationPrefix $Contoso_CloudVM_Subnet -NextHop $Contoso_CloudVM_NextHop   
New-NetRoute -InterfaceAlias "FabrikamGWSubnet" -AddressFamily IPv4 -DestinationPrefix $Fabrikam_CloudVM_Subnet -NextHop $Fabrikam_CloudVM_NextHop   
  
## End Cloud GW VM Config ##  
  
```  
  
You can also perform the additional steps of configuring Site\-to\-Site VPN connections, Network Address Translation \(NAT\), and configuring the gateway as a Border Gateway Protocol \(BGP\) router. For more information, see the following sections.  
  
-   [Configure the RRAS Multitenant Gateway for Site-to-Site VPN Connections_1](../Topic/Configure-the-RRAS-Multitenant-Gateway-for-Site-to-Site-VPN-Connections_1.md)  
  
-   [Configure the RRAS Multitenant Gateway to Perform Network Address Translation for Tenant Computers_1](../Topic/Configure-the-RRAS-Multitenant-Gateway-to-Perform-Network-Address-Translation-for-Tenant-Computers_1.md)  
  
-   [Configure the RRAS Multitenant Gateway for Dynamic Routing with BGP_1](../Topic/Configure-the-RRAS-Multitenant-Gateway-for-Dynamic-Routing-with-BGP_1.md)  
  
## <a name="bkmk_links"></a>Windows PowerShell command reference links  
The scripts in this topic use the following Windows PowerShell commands. Click a link to open the help topic for the command.  
  
-   [Add\-WindowsFeature](http://technet.microsoft.com/library/cc732757.aspx#BKMK_addcmdlet)  
  
-   [Install\-RemoteAccess](http://technet.microsoft.com/library/hh918408.aspx)  
  
-   [Enable\-RemoteAccessRoutingDomain](http://technet.microsoft.com/library/dn262655.aspx)  
  
-   [Set\-RemoteAccessRoutingDomain](http://technet.microsoft.com/library/dn262668.aspx)  
  
-   [New\-NetIPAddress](http://technet.microsoft.com/library/hh826150.aspx)  
  
-   [New\-NetRoute](http://technet.microsoft.com/library/hh826148.aspx)  
  
## See Also  
[Additional Resources_1](../Topic/Additional-Resources_1.md)  
  
