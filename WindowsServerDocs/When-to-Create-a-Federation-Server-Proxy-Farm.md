---
title: When to Create a Federation Server Proxy Farm
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 96b44390-0429-4bc5-af77-e94f12dcec34
---
# When to Create a Federation Server Proxy Farm
Consider installing additional [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies when you have a large [!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)] deployment and you want to provide fault tolerance, load\-balancing, and scalability for your proxy deployment. The act of creating two or more [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies in the same perimeter network and configuring each of them to protect the same [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] Federation Service creates a [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] farm.

You can create a federation server proxy farm or install additional federation server proxies to an existing farm by using the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] Federation Server Proxy Configuration Wizard. For more information, see [When to Create a Federation Server Proxy](When-to-Create-a-Federation-Server-Proxy.md).

Before all the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies can function together as a farm, you must first cluster them under one IP address and one Domain Name System \(DNS\) fully qualified domain name \(FQDN\). You can cluster the servers by deploying Microsoft Network Load Balancing \(NLB\) inside the perimeter network. The tasks in the following table require NLB to be configured appropriately to cluster the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies in the farm.

For more information about how to configure an FQDN for a cluster using Microsoft NLB technology, see Specifying the Cluster Parameters \([http:\/\/go.microsoft.com\/fwlink\/?linkid\=74651](http://go.microsoft.com/fwlink/?linkid=74651)\).

## Configuring federation server proxies for a farm
The following table describes the tasks that must be completed so that each [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] can participate in a farm.

|Task|Description|
|--------|---------------|
|Point all proxies in the farm to the same [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] Federation Service name|When you create the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies, you must type the same Federation Service name in the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] Federation Server Proxy Configuration Wizard for all the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies that will participate in the farm. The [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] uses the URL that makes up this DNS host name to determine which [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] Federation Service instance it contacts.<br /><br />For more information, see [Configure a Computer for the Federation Server Proxy Role](Configure-a-Computer-for-the-Federation-Server-Proxy-Role.md).|
|Obtain and share certificates|You can obtain a server authentication certificate from a public certification authority \(CA\)—for example, VeriSign—and then configure the certificate so that all [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies share the same private key portion of the same certificate on the default Web site for each [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)]. To share the certificate, you must install the same server authentication certificate on the default Web site for each [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)]. For more information, see [Import a Server Authentication Certificate to the Default Web Site](Import-a-Server-Authentication-Certificate-to-the-Default-Web-Site.md).<br /><br />For more information, see [Certificate Requirements for Federation Server Proxies](Certificate-Requirements-for-Federation-Server-Proxies.md).|

For more information about adding new [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies to create a [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] farm, see [Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md).


