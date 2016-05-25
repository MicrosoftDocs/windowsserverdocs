---
title: Using Windows PowerShell with IPAM
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0c606726-ae4c-45c4-b314-b38bfeb20e05
---
# Using Windows PowerShell with IPAM
This topic provides a summary of Windows PowerShell IPAM Server cmdlets available in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)]. For more information about these cmdlets, including examples and parameter descriptions, see [IPAM Server Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/jj553807.aspx) \(http:\/\/technet.microsoft.com\/library\/jj553807.aspx\).  
  
## IpamGpoProvisioning  
Use this cmdlet to create and link IPAM provisioning Group Policy Objects \(GPOs\) in the specified domain. These GPOs can be used to configure required IPAM access settings on managed domain controllers, NPS servers, DNS servers, and DHCP servers. For more information about using this cmdlet, see [Provisioning IPAM](../Topic/Getting-Started-with-IPAM.md#provision). The following IpamGpoProvisioning cmdlets are available: **Invoke\-IpamGpoProvisioning**.  
  
```  
  
Invoke-IpamGpoProvisioning [-Domain] <string> [-GpoPrefixName] <string> [-IpamServerFqdn <string>] [-DelegatedGpoUser <string[]>]  
[-DelegatedGpoGroup <string[]>] [-DomainController <string>] [-PassThru] [-Force] [-WhatIf] [-Confirm]  [<CommonParameters>]  
  
```  
  
## IpamCustomValue  
Use this cmdlet to add a new custom value to a multi\-valued, custom field in the IPAM database. For more information about custom values in IPAM, see [Custom configurations](../Topic/Managing-IP-Address-Space.md#custom_config). The following IpamCustomValue cmdlets are available: **Add\-IpamCustomValue**.  
  
```  
  
Add-IpamCustomValue [-Name] <string> [-Value] <string> [-PassThru] [-WhatIf] [-Confirm]  [<CommonParameters>]  
```  
  
## IpamAddress  
Use this cmdlet set to import and export IP address data to and from the IPAM database. Imported data must be formatted as comma separated values \(.csv\). Exported IP address data can also include an array of Windows PowerShell® objects. For more information about importing and exporting IP address data, see [Import](../Topic/Managing-IP-Address-Space.md#import) and [Export](../Topic/Managing-IP-Address-Space.md#export). The following IpamAddress cmdlets are available: **Import\-IpamAddress**, **Export\-IpamAddress**.  
  
```  
  
Import-IpamAddress [-Path] <string> [-AddressFamily] <string> {IPv4 | IPv6} [-ErrorPath <string>] [-Force] [-WhatIf] [-Confirm]  
[<CommonParameters>]  
  
Import-IpamAddress [-Path] <string> [-AddressFamily] <string> {IPv4 | IPv6} [-ManagedByService] <string> [-ServiceInstance] <string>  
[-NetworkId] <string> [-StartIPAddress <ipaddress>] [-EndIPAddress <ipaddress>] [-ErrorPath <string>] [-Force] [-WhatIf] [-Confirm]  
[<CommonParameters>]  
```  
  
```  
  
Export-IpamAddress [-AddressFamily] <string> {IPv4 | IPv6} [-Path <string>] [-PassThru] [-Force]  [<CommonParameters>]  
```  
  
## IpamCustomField  
Use this cmdlet set to display or add custom field information to the IPAM database. For more information about custom fields in IPAM, see [Custom configurations](../Topic/Managing-IP-Address-Space.md#custom_config). The following IpamCustomField cmdlets are available: **Get\-IpamCustomField**, **Add\-IpamCustomField**.  
  
```  
  
Get-IpamCustomField [[-Name] <string>]  [<CommonParameters>]  
```  
  
```  
  
Add-IpamCustomField [-Name] <string> [-Multivalue] [-PassThru] [-WhatIf] [-Confirm]  [<CommonParameters>]  
```  
  
## IpamRange  
Use this cmdlet set to import and export IP address range data to and from the IPAM database. Imported data must be formatted as comma separated values \(.csv\). Exported IP address data can also include an array of Windows PowerShell® objects. For more information about importing and exporting IP address data, see [Import](../Topic/Managing-IP-Address-Space.md#import) and [Export](../Topic/Managing-IP-Address-Space.md#export). The following IpamRange cmdlets are available: **Import\-IpamRange**, **Export\-IpamRange**.  
  
```  
  
Import-IpamRange [-Path] <string> [-AddressFamily] <string> {IPv4 | IPv6} [-ErrorPath <string>] [-Force] [-WhatIf] [-Confirm]  
[<CommonParameters>]  
  
Import-IpamRange [-Path] <string> [-AddressFamily] <string> {IPv4 | IPv6} [-ManagedByService] <string> [-ServiceInstance] <string>  
[-AddManagedByService] [-AddServiceInstance] [-DeleteMappedAddresses] [-ErrorPath <string>] [-Force] [-WhatIf] [-Confirm]  
[<CommonParameters>]  
```  
  
```  
  
Export-IpamRange [-AddressFamily] <string> {IPv4 | IPv6} [-Path <string>] [-PassThru] [-Force]  [<CommonParameters>]  
```  
  
## IpamConfiguration  
Use the cmdlet set to display or configure the TCP port number used by the IPAM server to communicate with an IPAM client running Remote Server Administration Tools \(RSAT\). The IPAM version is also displayed. For more information about IPAM client communication, see [IPAM Client](../Topic/IPAM-Architecture.md#client). The following IpamConfiguration cmdlets are available: **Get\-IpamConfiguration**, **Set\-IpamConfiguration**.  
  
```  
  
Get-IpamConfiguration  [<CommonParameters>]  
```  
  
```  
  
Set-IpamConfiguration [-Port] <uint16> [-Force] [-PassThru] [-WhatIf] [-Confirm]  [<CommonParameters>]  
```  
  
## See also  
[Importing DHCP lease data from the network](../Topic/Managing-IP-Address-Space.md#importing_ip_addresses_from_the_network)  
  
