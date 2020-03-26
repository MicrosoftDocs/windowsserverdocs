---
title: What's New in IPAM
description: This topic describes the IP Address Management (IPAM) functionality that is new or changed in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-ipam
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: f2f2f1a5-ac2f-41b7-a495-98ad0e2a9b20
ms.author: lizross
author: eross-msft
---
# What's New in IPAM

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes the IP Address Management (IPAM) functionality that is new or changed in Windows Server 2016.  
  
IPAM provides highly customizable administrative and monitoring capabilities for the IP address and DNS infrastructure on an Enterprise or Cloud Service Provider (CSP) network. You can monitor, audit, and manage servers running Dynamic Host Configuration Protocol (DHCP) and Domain Name System (DNS) by using IPAM.  
  
## <a name="BKMK_IPAM2012R2"></a>Updates in IPAM Server  
Following are the new and improved features for IPAM in  Windows Server 2016.  
  
|Feature/Functionality|New or improved|Description|  
|--------------------------|-------------------|---------------|  
|[Enhanced IP address management](../../technologies/ipam/../../technologies/ipam/../../technologies/ipam/What-s-New-in-IPAM.md#EIP)|Improved|IPAM capabilities are improved for scenarios such as handling IPv4 /32 and IPv6 /128 subnets and finding free IP address subnets and ranges in an IP address block.|  
|[Enhanced DNS service management](../../technologies/ipam/../../technologies/ipam/../../technologies/ipam/What-s-New-in-IPAM.md#EDNS)|New|IPAM supports DNS resource record, conditional forwarder, and DNS zone management for both domain-joined Active Directory-integrated and file-backed DNS servers.|  
|[Integrated DNS, DHCP, and IP address (DDI) management](../../technologies/ipam/../../technologies/ipam/../../technologies/ipam/What-s-New-in-IPAM.md#DDI)|Improved|Several new experiences and integrated lifecycle management operations are enabled, such as visualizing all DNS resource records that pertain to an IP address, automated inventory of IP addresses based on DNS resource records, and IP address lifecycle management for both DNS and DHCP operations.|  
|[Multiple Active Directory Forest support](#bkmk_ad)|New|You can use IPAM to manage the DNS and DHCP servers of multiple Active Directory forests when there is a two-way trust relationship between the forest where IPAM is installed and each of the remote forests.|  
|[Purge Utilization Data](#bkmk_purge)|New|You can now reduce the IPAM database size by purging the IP address utilization data that is older than a date that you specify.|  
|[Windows PowerShell support for Role Based Access Control](#bkmk_ps)|New|You can use Windows PowerShell to set access scopes on IPAM objects.|  
  
### <a name="EIP"></a>Enhanced IP address management  
The following features improve the IPAM address management capabilities.  
>[!NOTE]
>For the IPAM Windows PowerShell command reference, see [IP Address Management (IPAM) Server Cmdlets in Windows PowerShell](https://docs.microsoft.com/powershell/module/ipamserver/).  
  
#### Support for /31, /32, and /128 subnets  
IPAM in  Windows Server 2016 now supports /31, /32, and /128 subnets. For example, a two address subnet (/31 IPv4) may be required for a point-to-point link between switches. Also, some switches may require single loopback addresses (/32 for IPv4, /128 for IPv6).  
  
#### **Find free subnets with Find-IpamFreeSubnet**  
  
This command returns subnets that are available for allocation, given an IP block, prefix length, and number of requested subnets.   
  
If the number of available subnets is less than the number of requested subnets, the available subnets are returned with a warning indicating that the number available is less than the number requested.  
  
>[!NOTE]
>This function does not actually allocate the subnets, it only reports their availability. However, the cmdlet output can be piped to the **Add-IpamSubnet** command to create the subnet.  
  
For more information, see [Find-IpamFreeSubnet](https://docs.microsoft.com/powershell/module/ipamserver/Find-IpamFreeSubnet).  
  
#### **Find free address ranges with Find-IpamFreeRange**  
  
This new command returns available IP address ranges given an IP subnet, the number of addresses that are needed in the range, and the number of ranges requested.   
  
The command searches for a continuous series of unallocated IP addresses that match the number of requested addresses. The process is repeated until the requested number of ranges is found, or until there are no more available address ranges available.  
  
> [!NOTE]
> This function does not actually allocate the ranges, it only reports their availability. However, the cmdlet output can be piped to the **Add-IpamRange** command to create the range.  
  
For more information, see [Find-IpamFreeRange](https://docs.microsoft.com/powershell/module/ipamserver/Find-IpamFreeRange).  
  
### <a name="EDNS"></a>Enhanced DNS service management  
IPAM in  Windows Server 2016 now supports discovery of file-based, domain-joined DNS servers in an Active Directory forest in which IPAM is running.  
  
Additionally, the following DNS functions have been added:  
  
-   DNS zones and resource records collection (other than those pertaining to DNSSEC) from DNS servers running Windows Server 2008 or later.  
  
-   Configure (create, modify, and delete) properties and operations on all types of Resource Records (other than those pertaining to DNSSEC).  
  
-   Configure (create, modify, delete) properties and operations on all types of DNS zones including Primary Secondary, and Stub zones).  
  
-   Triggered tasks on secondary and stub zones, regardless if they are forward or reverse lookup zones. For example, tasks such as **Transfer from Master** or **Transfer new copy of zone from Master**.  
  
-   Role based access control for the supported DNS configuration (DNS records and DNS zones).  
  
-   Conditional forwarders collection and configuration (create, delete, edit).  
  
### <a name="DDI"></a>Integrated DNS, DHCP, and IP address (DDI) management  
When you view an IP address in the IP Address Inventory, you have the option in the Details View to see all the DNS resource records associated with the IP address.  
  
As part of DNS resource record collection, IPAM collects the PTR records for the DNS reverse look-up zones. For all the reverse lookup zones which are mapped to any IP address range, IPAM creates the IP address records for all the PTR records belonging to that zone in the corresponding mapped IP address range. If the IP address already exists, the PTR record is simply associated with that IP address. The IP addresses are not automatically created if the reverse lookup zone is not mapped to any IP address range.  
  
When a PTR record is created in a reverse lookup zone through IPAM, the IP address inventory is updated in the same way as described above. During subsequent collection, since the IP address will already exist in the system, the PTR record will be simply mapped with that IP address.  
  
### <a name="bkmk_ad"></a>Multiple Active Directory Forest support  
In  Windows Server 2012 R2 , IPAM was able to discover and manage DNS and DHCP servers belonging to the same Active Directory forest as the IPAM server. Now you can manage DNS and DHCP servers belonging to a different AD forest when it has a  two-way trust relationship with the forest where the IPAM server is installed. You can go to the **Configure Server Discovery** dialog box and add domains from the other trusted forests that you want to manage. After the servers are discovered, the management experience is the same as for the servers that belong to the same forest where IPAM is installed.  
  
For more information, see [Manage Resources in Multiple Active Directory Forests](../../technologies/ipam/Manage-Resources-in-Multiple-Active-Directory-Forests.md)  
  
### <a name="bkmk_purge"></a>Purge Utilization Data  
Purge Utilization Data allows you to reduce the IPAM database size by deleting old IP address utilization data. To perform data deletion, you specify a date, and IPAM deletes all database entries that are older than or equal to the date you provide.   
  
For more information, see [Purge Utilization Data](../../technologies/ipam/Purge-Utilization-Data.md).  
  
### <a name="bkmk_ps"></a>Windows PowerShell support for Role Based Access Control  
You can now use Windows PowerShell to configure Role Based Access Control. You can use Windows PowerShell commands to retrieve DNS and DHCP objects in IPAM and change their access scopes. Because of this, you can write Windows PowerShell scripts to assign access scopes to the following objects.  
  
-   IP address space  
  
-   IP address block  
  
-   IP address subnets  
  
-   IP address ranges  
  
-   DNS servers  
  
-   DNS zones  
  
-   DNS conditional forwarders  
  
-   DNS resource records  
  
-   DHCP servers  
  
-   DHCP superscopes  
  
-   DHCP scopes  
  
For more information, see [Manage Role Based Access Control with Windows PowerShell](../../technologies/ipam/Manage-Role-Based-Access-Control-with-Windows-PowerShell.md) and [IP Address Management (IPAM) Server Cmdlets in Windows PowerShell](https://docs.microsoft.com/powershell/module/ipamserver/).  

