---
ms.assetid: 026747c7-4c34-41c7-b7ea-27f9a7f64a35
title: Add a Host (A) Resource Record to Corporate DNS for a Federation Server
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---

# Add a Host (A) Resource Record to Corporate DNS for a Federation Server



For clients on the corporate network to successfully access a federation server using Windows Integrated authentication, a host \(A\) resource record must first be created in the corporate Domain Name System \(DNS\) that resolves the host name of the account federation server \(for example, fs.fabrikam.com\) to the IP address of the federation server or federation server cluster. You can use the following procedure to add a host \(A\) resource record to corporate DNS for a federation server.  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
### To add a host \(A\) resource record to corporate DNS for a federation server  
  
1.  On a DNS server for the corporate network, open the DNS snap\-in.  
  
2.  In the console tree, right\-click the applicable forward lookup zone, and then click **New Host \(A or AAAA\)**.  
  
3.  In **Name**, type only the computer name of the federation server or federation server cluster; for example, for the fully qualified domain name \(FQDN\) fs.fabrikam.com, type **fs**.  
  
4.  In **IP address**, type the IP address for the federation server or federation server cluster, for example, 192.168.1.4.  
  
5.  Click **Add Host**.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)  
  
[Name Resolution Requirements for Federation Servers](https://technet.microsoft.com/library/dd807055.aspx)  
  

