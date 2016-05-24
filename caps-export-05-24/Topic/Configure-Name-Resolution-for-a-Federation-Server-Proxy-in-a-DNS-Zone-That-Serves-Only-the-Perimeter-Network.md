---
title: Configure Name Resolution for a Federation Server Proxy in a DNS Zone That Serves Only the Perimeter Network
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3f7466ac-f12f-4083-9262-a680a2e4649d
author: billmath
---
# Configure Name Resolution for a Federation Server Proxy in a DNS Zone That Serves Only the Perimeter Network
So that name resolution can work successfully for a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in an [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] scenario in which one or more Domain Name System \(DNS\) zones serve only the perimeter network, the following tasks must be completed:  
  
-   The hosts file on the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] must be updated to add the IP address of a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)].  
  
-   DNS in the perimeter network must be configured to resolve all client requests for the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] host name to the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)]. To do this, you add a host \(A\) resource record to perimeter DNS for the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)].  
  
> [!NOTE]  
> These procedures assume that a host \(A\) resource record for the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] has already been created in the corporate network DNS. If this record does not yet exist, create this record, and then perform these procedures. For more information about how to create the host \(A\) resource record for the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)], see [Add a Host &#40;A&#41; Resource Record to Corporate DNS for a Federation Server](../Topic/Add-a-Host--A--Resource-Record-to-Corporate-DNS-for-a-Federation-Server.md).  
  
## Add the IP address of a federation server to the hosts file  
So that a [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] can work as expected in the perimeter network of an account partner, you must add an entry to the hosts file on that [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] that points to a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]'s DNS host name \(for example, fs.fabrikam.com\) and IP address \(for example, 192.168.1.4\) in the corporate network of the account partner. Adding this entry to the hosts file prevents the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] from contacting itself to resolve a client\-initiated call to a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in the account partner.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To add the IP address of a federation server to the hosts file  
  
1.  Navigate to the %systemroot%\\Winnt\\System32\\Drivers directory folder and locate the **hosts** file.  
  
2.  Start Notepad, and then open the **hosts** file.  
  
3.  Add the IP address and the host name of a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in the account partner to the **hosts** file, as shown in the following example:  
  
    **192.168.1.4fs.fabrikam.com**  
  
4.  Save and close the file.  
  
## Add a host \(A\) resource record to perimeter DNS for a federation server proxy  
So that clients on the Internet can successfully access a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] through a newly deployed [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)], you must first create a host \(A\) resource record in the perimeter DNS. This resource record resolves the host name of the account [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] \(for example, fs.fabrikam.com\) to the IP address of the account [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] \(for example, 131.107.27.68\) in the perimeter network.  
  
> [!NOTE]  
> It is assumed that you are using a DNS server, running Windows 2000 Server, Windows Server 2003, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] with the DNS Server service, to control the perimeter DNS zone.  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To add a host \(A\) resource record to perimeter DNS for a federation server proxy  
  
1.  On a DNS server for the perimeter network, open the DNS snap\-in. Click **Start**, point to **Administrative Tools**, and then click **DNS**.  
  
2.  In the console tree, right\-click the applicable forward lookup zone, and then click **New Host \(A or AAAA\)**.  
  
3.  In **Name**, type only the computer name of the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]. For example, for the fully qualified domain name \(FQDN\) fs.fabrikam.com, type **fs**.  
  
4.  In **IP address**, type the IP address for the new [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)], for example, **131.107.27.68**.  
  
5.  Click **Add Host**.  
  
## Additional references  
[Checklist: Setting Up a Federation Server Proxy](../Topic/Checklist--Setting-Up-a-Federation-Server-Proxy.md)  
  
[Name Resolution Requirements for Federation Server Proxies](../Topic/Name-Resolution-Requirements-for-Federation-Server-Proxies.md)  
  
