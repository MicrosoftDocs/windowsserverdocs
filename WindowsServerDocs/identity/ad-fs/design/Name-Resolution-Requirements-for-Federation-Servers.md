---
ms.assetid: 74ef34c8-e13f-499b-b2bb-952ad7036622
title: Name Resolution Requirements for Federation Servers
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Name Resolution Requirements for Federation Servers

When client computers on the corporate network attempt to access an application or Web service that is protected by Active Directory Federation Services \(AD FS\), they must first authenticate to a federation server. One way to authenticate is to have the corporate network clients access a local federation server through Windows Integrated Authentication.  
  
## Configure corporate DNS  
So that successful name resolution through Windows Integrated Authentication on local federation servers can occur, Domain Name System \(DNS\) in the corporate network of the account partner must be configured for a new host \(A\) resource record that will resolve the fully qualified domain name \(FQDN\) host name of the federation server to the IP address of the federation server cluster.  
  
In the following illustration, you can see how this task is accomplished for a given scenario. In this scenario, Microsoft Network Load Balancing \(NLB\) provides a single cluster FQDN name and a single cluster IP address for an existing federation server farm.  
  
![name requirements](media/adfs2_deploy_single_fs.gif)  
  
For information about how to configure a cluster IP address or cluster FQDN using NLB, see [Specifying the Cluster Parameters](https://go.microsoft.com/fwlink/?LinkId=75282).  
  
For information about how to configure corporate DNS for a federation server, see [Add a Host &#40;A&#41; Resource Record to Corporate DNS for a Federation Server](../../ad-fs/deployment/Add-a-Host--A--Resource-Record-to-Corporate-DNS-for-a-Federation-Server.md).  
  
For information about how to configure federation server proxies in the perimeter network, see [Name Resolution Requirements for Federation Server Proxies](Name-Resolution-Requirements-for-Federation-Server-Proxies.md).  
  

## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
