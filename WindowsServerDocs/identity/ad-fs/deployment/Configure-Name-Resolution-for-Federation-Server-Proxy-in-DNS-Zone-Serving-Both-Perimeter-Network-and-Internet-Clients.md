---
ms.assetid: 1a6740e6-5b6d-41f8-9ec4-32cdbee3e1bb
title: Configure Name Resolution for a Federation Server Proxy in a DNS Zone That Serves Both the Perimeter Network and Internet Clients
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
ms.author: billmath
---

# Configure Name Resolution for a Federation Server Proxy in a DNS Zone That Serves Both the Perimeter Network and Internet Clients


So that name resolution can work successfully for a federation server proxy in an Active Directory Federation Services \(AD FS\) scenario in which one or more Domain Name System \(DNS\) zones serve both the perimeter network and Internet clients, the following tasks must be completed:  
  
-   DNS in the Internet zone that you control must be configured to resolve all Internet client requests for the AD FS host name to the federation server proxy. To accomplish this, you add a host \(A\) resource record to the Internet DNS zone for the federation server proxy.  
  
-   DNS in the perimeter network must be configured to resolve all incoming client requests for the AD FS host name to the federation server. To accomplish this, you add a host \(A\) resource record to the perimeter DNS zone for the federation server proxy.  
  
> [!NOTE]  
> It is assumed that a host \(A\) resource record for the federation server has already been created in the corporate network DNS. If this record does not yet exist, create this record and then perform these procedures. For more information about how to create a host \(A\) resource record for the federation server, see [Add a Host &#40;A&#41; Resource Record to Corporate DNS for a Federation Server](Add-a-Host--A--Resource-Record-to-Corporate-DNS-for-a-Federation-Server.md).  
  
## Add a host \(A\) resource record to the Internet DNS zone for a federation server proxy  
So that client computers on the Internet can successfully access a federation server through a newly deployed federation server proxy, you must first create a host \(A\) resource record in the Internet DNS zone that you control. This resource record resolves the host name of the account federation server \(for example, fs.fabrikam.com\) to the IP address of the account federation server proxy \(for example, 131.107.27.68\) in the perimeter network.  
  
> [!NOTE]  
> It is assumed that you are using a DNS server running Windows 2000 Server, Windows Server 2003, or  Windows Server 2008  with the DNS Server service to control the Internet DNS zone.  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
#### To add a host \(A\) resource record to the Internet DNS zone for a federation server proxy  
  
1.  On a DNS server for the Internet DNS zone, open the DNS snap\-in.  
  
2.  In the console tree, right\-click the applicable forward lookup zone, and then click **New Host \(A or AAAA\)**.  
  
3.  In **Name**, type only the computer name of the federation server. For example, for the fully qualified domain name \(FQDN\) fs.fabrikam.com, type **fs**.  
  
4.  In **IP address**, type the IP address for the new federation server proxy, for example, 131.107.27.68.  
  
5.  Click **Add Host**.  
  
## Add a host \(A\) resource record to the perimeter DNS zone for a federation server proxy  
So that Internet client requests can be processed successfully by the federation server proxy and reach the federation server after they are resolved by the Internet DNS zone, you must create a host \(A\) resource record in the perimeter DNS zone. This resource record resolves the host name of the account federation server \(for example, fs. fabrikam.com\) to the IP address of the account federation server \(for example, 192.168.1.4\) in the corporate network.  
  
> [!NOTE]  
> It is assumed that you are using a DNS server running Windows 2000 Server, Windows Server 2003,  Windows Server 2008 , or Windows Server® 2012 with the DNS Server service to control the perimeter DNS zone.  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
#### To add a host \(A\) resource record to the perimeter DNS zone for a federation server proxy  
  
1.  On a DNS server for the perimeter network, open the **DNS snap\-in**.  
  
2.  In the console tree, right\-click the applicable forward lookup zone, and then click **New Host \(A or AAAA\)**.  
  
3.  In **Name**, type only the computer name of the federation server. For example, for the FQDN fs.fabrikam.com, type **fs**.  
  
4.  In the **IP address** text box, type the IP address for the federation server in the corporate network, for example, 192.168.1.4.  
  
5.  Click **Add Host**.  
  
## Additional references  
[Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md)  
  
[Name Resolution Requirements for Federation Server Proxies](https://technet.microsoft.com/library/dd807055.aspx)  
  

