---
ms.assetid: b7109e46-b66e-4c5c-8b87-a6611d68415a
title: Configure Name Resolution for a Federation Server Proxy in a DNS Zone That Serves Only the Perimeter Network
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
ms.author: billmath
---

# Configure Name Resolution for a Federation Server Proxy in a DNS Zone That Serves Only the Perimeter Network


So that name resolution can work successfully for a federation server in an Active Directory Federation Services \(AD FS\) scenario in which one or more Domain Name System \(DNS\) zones serve only the perimeter network, the following tasks must be completed:  
  
-   The hosts file on the federation server proxy must be updated to add the IP address of a federation server.  
  
-   DNS in the perimeter network must be configured to resolve all client requests for the AD FS host name to the federation server proxy. To do this, you add a host \(A\) resource record to perimeter DNS for the federation server proxy.  
  
> [!NOTE]  
> These procedures assume that a host \(A\) resource record for the federation server has already been created in the corporate network DNS. If this record does not yet exist, create this record, and then perform these procedures. For more information about how to create the host \(A\) resource record for the federation server, see [Add a Host &#40;A&#41; Resource Record to Corporate DNS for a Federation Server](Add-a-Host--A--Resource-Record-to-Corporate-DNS-for-a-Federation-Server.md).  
  
## Add the IP address of a federation server to the hosts file  
So that a federation server proxy can work as expected in the perimeter network of an account partner, you must add an entry to the hosts file on that federation server proxy that points to a federation server's DNS host name \(for example, fs.fabrikam.com\) and IP address \(for example, 192.168.1.4\) in the corporate network of the account partner. Adding this entry to the hosts file prevents the federation server proxy from contacting itself to resolve a client\-initiated call to a federation server in the account partner.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
#### To add the IP address of a federation server to the hosts file  
  
1.  Navigate to the %systemroot%\\Winnt\\System32\\Drivers directory folder and locate the **hosts** file.  
  
2.  Start Notepad, and then open the **hosts** file.  
  
3.  Add the IP address and the host name of a federation server in the account partner to the **hosts** file, as shown in the following example:  
  
    **192.168.1.4fs.fabrikam.com**  
  
4.  Save and close the file.  
  
## Add a host \(A\) resource record to perimeter DNS for a federation server proxy  
So that clients on the Internet can successfully access a federation server through a newly deployed federation server proxy, you must first create a host \(A\) resource record in the perimeter DNS. This resource record resolves the host name of the account federation server \(for example, fs.fabrikam.com\) to the IP address of the account federation server proxy \(for example, 131.107.27.68\) in the perimeter network.  
  
> [!NOTE]  
> It is assumed that you are using a DNS server, running Windows 2000 Server, Windows Server 2003, or  Windows Server 2008  with the DNS Server service, to control the perimeter DNS zone.  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
#### To add a host \(A\) resource record to perimeter DNS for a federation server proxy  
  
1.  On a DNS server for the perimeter network, open the DNS snap\-in. Click **Start**, point to **Administrative Tools**, and then click **DNS**.  
  
2.  In the console tree, right\-click the applicable forward lookup zone, and then click **New Host \(A or AAAA\)**.  
  
3.  In **Name**, type only the computer name of the federation server. For example, for the fully qualified domain name \(FQDN\) fs.fabrikam.com, type **fs**.  
  
4.  In **IP address**, type the IP address for the new federation server proxy, for example, **131.107.27.68**.  
  
5.  Click **Add Host**.  
  
## Additional references  
[Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md)  
  
[Name Resolution Requirements for Federation Server Proxies](https://technet.microsoft.com/library/dd807055.aspx)  
  

