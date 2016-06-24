---
title: Name Resolution Requirements for Federation Server Proxies
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5c2f2c1a-d0b4-4644-bab1-76a0a7dd60a1
author: billmath
---
# Name Resolution Requirements for Federation Server Proxies
When client computers on the Internet attempt to access an application that is secured by [!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)], they must first authenticate to the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]. In most cases, the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] is usually not directly accessible from the Internet. Therefore, Internet client computers must be redirected to the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] instead. You can accomplish successful redirection by adding the appropriate Domain Name System (DNS) records to your DNS zone or zones that face the Internet.  
  
The method that you use to redirect Internet clients to the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] depends on how you configure the DNS zone in your perimeter network or how you configure a DNS zone that you control on the Internet. Federation server proxies are intended for use in a perimeter network. They redirect Internet client requests to [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]s successfully only when DNS has been configured properly in all the Internet-facing zones that you control. Therefore, the configuration of your Internet-facing zones—whether you have a DNS zone serving only the perimeter network or a DNS zone serving both the perimeter network and Internet clients—is important.  
  
This topic describes the steps that you can take to configure name resolution when you place a [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] in your perimeter network. To determine which steps to follow, first determine which of the following DNS scenarios most closely matches the DNS infrastructure in the perimeter network of your organization. Then, follow the steps for that scenario.  
  
## DNS zone serving only the perimeter network  
In this scenario, your organization has one or two DNS zones in the perimeter network, and your organization does not control any DNS zones on the Internet. Successful name resolution for a [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] in the DNS zone that serves only the perimeter network scenario depends on the following conditions:  
  
-   The [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] must have a setting in the hosts file to resolve the fully qualified domain name (FQDN) of the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] endpoint URL to an IP address of a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] or a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] cluster.  
  
-   DNS in the perimeter network of the account partner must be configured so that the FQDN of the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] endpoint URL resolves to the IP address of the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)].  
  
The following illustration and corresponding steps show how each of these conditions is achieved for a given example. In this illustration, Microsoft Network Load Balancing (NLB) technology provides a single, cluster FQDN and a single, cluster IP address for an existing [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] farm.  
  
![](media/adfs2_deploy_single_fs.gif)  
  
For more information about configuring a cluster IP address or a cluster FQDN using NLB, see Specifying the Cluster Parameters ([http://go.microsoft.com/fwlink/?LinkId=75282](http://go.microsoft.com/fwlink/?LinkId=75282)).  
  
### 1. Configure the hosts file on the federation server proxy  
Because DNS in the perimeter network is configured to resolve all requests for fs.fabrikam.com to the account [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)], the account partner [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] has an entry in its local hosts file to resolve fs.fabrikam.com to the IP address of the actual account [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] (or cluster DNS name for the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] farm) that is connected to the corporate network. This makes it possible for the account [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] to resolve the host name fs.fabrikam.com to the account [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] rather than to itself—as would occur if it attempted to look up fs.fabrikam.com using perimeter DNS—so that the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] can communicate with the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)].  
  
### 2. Configure perimeter DNS  
Because there is only a single [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] host name that client computers are directed to—whether they are on an intranet or on the Internet—client computers on the Internet that use the perimeter DNS server must resolve the FQDN for the account [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] (fs.fabrikam.com) to the IP address of the account [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] on the perimeter network. So that it can forward clients on to the account [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] when they attempt to resolve fs.fabrikam.com, perimeter DNS contains a limited corp.fabrikam.com DNS zone with a single host (A) resource record for fs (fs.fabrikam.com) and the IP address of the account [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] on the perimeter network.  
  
For more information about how to modify the hosts file of the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] and configure DNS in the perimeter network, see [Configure Name Resolution for a Federation Server Proxy in a DNS Zone That Serves Only the Perimeter Network](Configure-Name-Resolution-for-a-Federation-Server-Proxy-in-a-DNS-Zone-That-Serves-Only-the-Perimeter-Network.md).  
  
## DNS zone serving both the perimeter network and Internet clients  
In this scenario, your organization controls the DNS zone in the perimeter network and at least one DNS zone on the Internet. Successful name resolution for a [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] in this scenario depends on the following conditions:  
  
-   DNS in the Internet zone of the account partner must be configured so that the FQDN of the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] host name resolves to the IP address of the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] in the perimeter network.  
  
-   DNS in the perimeter network of the account partner must be configured so that the FQDN of the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] host name resolves to the IP address of the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] in the corporate network.  
  
The following illustration and corresponding steps show how each of these conditions is achieved for a given example.  
  
![](media/adfs2_deploy_fsp_3DNS.gif)  
  
### 1. Configure perimeter DNS  
For this scenario, because it is assumed that you will configure the Internet DNS zone that you control to resolve requests that are made for a specific endpoint URL (that is, fs.fabrikam.com) to the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] in the perimeter network, you must also configure the zone in the perimeter DNS to forward these requests to the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] in the corporate network.  
  
So that clients can be forwarded to the account [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] when they attempt to resolve fs.fabrikam.com, perimeter DNS is configured with a single host (A) resource record for fs (fs.fabrikam.com) and the IP address of the account [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] on the corporate network. This makes it possible for the account [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] to resolve the host name fs.fabrikam.com to the account [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] rather than to itself—as would occur if it attempted to look up fs.fabrikam.com using Internet DNS—so that the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] can communicate with the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)].  
  
### 2. Configure Internet DNS  
For name resolution to be successful in this scenario, all requests from client computers on the Internet to fs.fabrikam.com must be resolved by the Internet DNS zone that you control. Consequently, you must configure your Internet DNS zone to forward client requests for fs.fabrikam.com to the IP address of the account [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] in the perimeter network.  
  
For more information about how to modify the perimeter network and Internet DNS zones, see [Configure Name Resolution for a Federation Server Proxy in a DNS Zone That Serves Both the Perimeter Network and Internet Clients](Configure-Name-Resolution-for-a-Federation-Server-Proxy-in-a-DNS-Zone-That-Serves-Both-the-Perimeter-Network-and-Internet-Clients.md).  
  

