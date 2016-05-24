---
title: Configure Name Resolution for a Federation Server Proxy in a DNS Zone That Serves Both the Perimeter Network and Internet Clients
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d37395cc-75e4-4071-bc13-d1f5102c57e5
author: billmath
---
# Configure Name Resolution for a Federation Server Proxy in a DNS Zone That Serves Both the Perimeter Network and Internet Clients
So that name resolution can work successfully for a [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] in an [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] scenario in which one or more Domain Name System \(DNS\) zones serve both the perimeter network and Internet clients, the following tasks must be completed:  
  
-   DNS in the Internet zone that you control must be configured to resolve all Internet client requests for the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] host name to the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)]. To accomplish this, you add a host \(A\) resource record to the Internet DNS zone for the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)].  
  
-   DNS in the perimeter network must be configured to resolve all incoming client requests for the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] host name to the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]. To accomplish this, you add a host \(A\) resource record to the perimeter DNS zone for the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)].  
  
> [!NOTE]  
> It is assumed that a host \(A\) resource record for the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] has already been created in the corporate network DNS. If this record does not yet exist, create this record and then perform these procedures. For more information about how to create a host \(A\) resource record for the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)], see [Add a Host &#40;A&#41; Resource Record to Corporate DNS for a Federation Server](../Topic/Add-a-Host--A--Resource-Record-to-Corporate-DNS-for-a-Federation-Server.md).  
  
## Add a host \(A\) resource record to the Internet DNS zone for a federation server proxy  
So that client computers on the Internet can successfully access a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] through a newly deployed [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)], you must first create a host \(A\) resource record in the Internet DNS zone that you control. This resource record resolves the host name of the account [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] \(for example, fs.fabrikam.com\) to the IP address of the account [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] \(for example, 131.107.27.68\) in the perimeter network.  
  
> [!NOTE]  
> It is assumed that you are using a DNS server running Windows 2000 Server, Windows Server 2003, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] with the DNS Server service to control the Internet DNS zone.  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To add a host \(A\) resource record to the Internet DNS zone for a federation server proxy  
  
1.  On a DNS server for the Internet DNS zone, open the DNS snap\-in.  
  
2.  In the console tree, right\-click the applicable forward lookup zone, and then click **New Host \(A or AAAA\)**.  
  
3.  In **Name**, type only the computer name of the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]. For example, for the fully qualified domain name \(FQDN\) fs.fabrikam.com, type **fs**.  
  
4.  In **IP address**, type the IP address for the new [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)], for example, 131.107.27.68.  
  
5.  Click **Add Host**.  
  
## Add a host \(A\) resource record to the perimeter DNS zone for a federation server proxy  
So that Internet client requests can be processed successfully by the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] and reach the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] after they are resolved by the Internet DNS zone, you must create a host \(A\) resource record in the perimeter DNS zone. This resource record resolves the host name of the account [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] \(for example, fs. fabrikam.com\) to the IP address of the account [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] \(for example, 192.168.1.4\) in the corporate network.  
  
> [!NOTE]  
> It is assumed that you are using a DNS server running Windows 2000 Server, Windows Server 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] with the DNS Server service to control the perimeter DNS zone.  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To add a host \(A\) resource record to the perimeter DNS zone for a federation server proxy  
  
1.  On a DNS server for the perimeter network, open the **DNS snap\-in**.  
  
2.  In the console tree, right\-click the applicable forward lookup zone, and then click **New Host \(A or AAAA\)**.  
  
3.  In **Name**, type only the computer name of the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]. For example, for the FQDN fs.fabrikam.com, type **fs**.  
  
4.  In the **IP address** text box, type the IP address for the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in the corporate network, for example, 192.168.1.4.  
  
5.  Click **Add Host**.  
  
## Additional references  
[Checklist: Setting Up a Federation Server Proxy](../Topic/Checklist--Setting-Up-a-Federation-Server-Proxy.md)  
  
[Name Resolution Requirements for Federation Server Proxies](../Topic/Name-Resolution-Requirements-for-Federation-Server-Proxies.md)  
  
