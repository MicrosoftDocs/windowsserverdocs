---
title: Configure the RRAS Multitenant Gateway for Site-to-Site VPN Connections_1
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 172dee23-ba52-4498-a127-1e9f36e96ff1
author: vhorne
---
# Configure the RRAS Multitenant Gateway for Site-to-Site VPN Connections_1
You can use this topic to configure site\-to\-site VPN connections for each tenant.  
  
This topic contains the following sections.  
  
-   [Windows PowerShell script explanation](#bkmk_exp)  
  
-   [Full Windows PowerShell script](#bkmk_script)  
  
-   [Windows PowerShell command reference links](#bkmk_links)  
  
## <a name="bkmk_exp"></a>Windows PowerShell script explanation  
The first section of this script, named “Macros for Multitenant \(MT\) Cloud Gateway \(GW\) Hyper\-V Host Configuration,” provides values for macros that are used in the script.  
  
The second section of this script, named “Configure S2S VPN on MTCloudGW,” creates two site\-to\-site VPN interfaces, one each for the Contoso and Fabrikam tenants. The script then connects the site\-to\-site VPN interfaces and retrieves connection information, which is displayed in the Windows PowerShell window.  
  
## <a name="bkmk_script"></a>Full Windows PowerShell script  
Following is the full script that you can run on the Hyper\-V host to configure the host with Network Virtualization and two VM networks with two VMS per VM network.  
  
#### To run this script on a Hyper\-V host  
  
1.  Change the example company names, Contoso and Fabrikam, to names of your actual tenants.  
  
2.  Change other parameter values or fill in blank values to match your deployment requirements and environment. For example, add the valid IP address of a remote router for the $Contoso\_S2SDestination and $Fabrikam\_S2SDestination macros in the first section of the script.  
  
3.  Copy the Windows PowerShell script below to the RRAS Multitenant Gateway Hyper\-V host.  
  
4.  On the Hyper\-V host, open Windows PowerShell with Administrator privileges. Run the script by typing the folder location and file name of the script. For example, if the file name of the script is AddVPNS2S.ps1 and the folder location is C:\\Users\\Administrator\\Documents, type **C:\\Users\\Administrator\\Documents\\AddVPNS2S.ps1**, and then press ENTER.  
  
```  
##### Macros for Multitenant (MT) Cloud Gateway (GW) Hyper-V Host Configuration #####  
$Contoso_RoutingDomain = ContosoTenant  
$Contoso_S2SDestination = ContosoDestinationIPAddress  
$Contoso_IPv4Subnet = ContosoSubnetIPAddress  
  
$Fabrikam_RoutingDomain = FabrikamTenant  
$Fabrikam_S2SDestination = FabrikamDestinationIPAddress  
$Fabrikam_IPv4Subnet = FabrikamSubnetIPAddress  
  
##### Configure S2S VPN on MTCloudGW #####  
  
Add-VpnS2SInterface -RoutingDomain  $Contoso_RoutingDomain -Name "ContosoSite1" -Protocol IKEv2 -Destination $Contoso_S2SDestination -AuthenticationMethod PSKOnly -SharedSecret "111_aaa" -Persistent -IPv4Subnet $Contoso_IPv4Subnet -NumberOfTries 0  
  
Add-VpnS2SInterface -RoutingDomain  $Fabrikam_RoutingDomain -Name "FabrikamSite1" -Protocol IKEv2 -Destination $Fabrikam_S2SDestination -AuthenticationMethod PSKOnly -SharedSecret "111_aaa" -Persistent -IPv4Subnet $Fabrikam_IPv4Subnet -NumberOfTries 0  
  
Connect-VpnS2SInterface -Name "ContosoSite1"   
Connect-VpnS2SInterface -Name "FabrikamSite1"   
  
Get-VpnS2SInterface -Name "ContosoSite1"   
Get-VpnS2SInterface -Name "FabrikamSite1"  
  
```  
  
## <a name="bkmk_links"></a>Windows PowerShell command reference links  
The script in this topic uses the following Windows PowerShell commands. Click a link to open the help topic for the command.  
  
-   [Add\-VpnS2SInterface](http://technet.microsoft.com/library/hh918397.aspx). Creates a site\-to\-site \(S2S\) interface with the specified parameters.  
  
-   [Connect\-VpnS2SInterface](http://technet.microsoft.com/library/hh918440.aspx). Connects a site\-to\-site \(S2S\) interface that is currently not connected.  
  
-   [Get\-VpnS2SInterface](http://technet.microsoft.com/library/hh918403.aspx). Retrieves configuration details for a site\-to\-site \(S2S\) interface.  
  
## See Also  
[Additional Resources_1](../Topic/Additional-Resources_1.md)  
  
