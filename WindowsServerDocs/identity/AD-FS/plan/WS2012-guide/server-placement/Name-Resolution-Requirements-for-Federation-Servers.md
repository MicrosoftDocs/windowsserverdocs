---
title: Name Resolution Requirements for Federation Servers
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 367cb26b-956e-4649-a065-f1c464c3931b
author: billmath
---
# Name Resolution Requirements for Federation Servers
When client computers on the corporate network attempt to access an application or Web service that is protected by [!INCLUDE[firstref_adfs2]()], they must first authenticate to a [!INCLUDE[adfs2_fs]()]. One way to authenticate is to have the corporate network clients access a local [!INCLUDE[adfs2_fs]()] through Windows Integrated Authentication.  
  
## Configure corporate DNS  
So that successful name resolution through Windows Integrated Authentication on local [!INCLUDE[adfs2_fs]()]s can occur, Domain Name System \(DNS\) in the corporate network of the account partner must be configured for a new host \(A\) resource record that will resolve the fully qualified domain name \(FQDN\) host name of the [!INCLUDE[adfs2_fs]()] to the IP address of the [!INCLUDE[adfs2_fs]()] cluster.  
  
In the following illustration, you can see how this task is accomplished for a given scenario. In this scenario, Microsoft Network Load Balancing \(NLB\) provides a single cluster FQDN name and a single cluster IP address for an existing [!INCLUDE[adfs2_fs]()] farm.  
  
![](../../../../media/Name-Resolution-Requirements-for-Federation-Servers/adfs2_deploy_single_fs.gif)  
  
For information about how to configure a cluster IP address or cluster FQDN using NLB, see Specifying the Cluster Parameters \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=75282](http://go.microsoft.com/fwlink/?LinkId=75282)\).  
  
For information about how to configure corporate DNS for a [!INCLUDE[adfs2_fs]()], see [Add a Host &#40;A&#41; Resource Record to Corporate DNS for a Federation Server](Add-a-Host--A--Resource-Record-to-Corporate-DNS-for-a-Federation-Server.md).  
  
For information about how to configure [!INCLUDE[adfs2_fs]()] proxies in the perimeter network, see [Name Resolution Requirements for Federation Server Proxies]().  
  

