---
title: Add a Host (A) Resource Record to Corporate DNS for a Federation Server
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d0297cb6-d970-45a4-8c41-7323fd98c06a
author: billmath
---
# Add a Host (A) Resource Record to Corporate DNS for a Federation Server
For clients on the corporate network to successfully access a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] using Windows Integrated authentication, a host \(A\) resource record must first be created in the corporate Domain Name System \(DNS\) that resolves the host name of the account [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] \(for example, fs.fabrikam.com\) to the IP address of the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] or [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] cluster. You can use the following procedure to add a host \(A\) resource record to corporate DNS for a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)].  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To add a host \(A\) resource record to corporate DNS for a federation server  
  
1.  On a DNS server for the corporate network, open the DNS snap\-in.  
  
2.  In the console tree, right\-click the applicable forward lookup zone, and then click **New Host \(A or AAAA\)**.  
  
3.  In **Name**, type only the computer name of the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] or [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] cluster; for example, for the fully qualified domain name \(FQDN\) fs.fabrikam.com, type **fs**.  
  
4.  In **IP address**, type the IP address for the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] or [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] cluster, for example, 192.168.1.4.  
  
5.  Click **Add Host**.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](../Topic/Checklist--Setting-Up-a-Federation-Server.md)  
  
[Name Resolution Requirements for Federation Servers](../Topic/Name-Resolution-Requirements-for-Federation-Servers.md)  
  
