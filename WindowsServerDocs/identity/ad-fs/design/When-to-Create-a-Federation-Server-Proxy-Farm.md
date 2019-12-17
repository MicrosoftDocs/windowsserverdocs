---
ms.assetid: ad0bf21d-2ace-4565-b1f5-ce57c8eb2689
title: When to Create a Federation Server Proxy Farm
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# When to Create a Federation Server Proxy Farm

Consider installing additional federation server proxies when you have a large Active Directory Federation Services \(AD FS\) deployment and you want to provide fault tolerance, load\-balancing, and scalability for your proxy deployment. The act of creating two or more federation server proxies in the same perimeter network and configuring each of them to protect the same AD FS Federation Service creates a federation server proxy farm.  
  
You can create a federation server proxy farm or install additional federation server proxies to an existing farm by using the AD FS Federation Server Proxy Configuration Wizard. For more information, see [When to Create a Federation Server Proxy](When-to-Create-a-Federation-Server-Proxy.md).  
  
Before all the federation server proxies can function together as a farm, you must first cluster them under one IP address and one Domain Name System \(DNS\) fully qualified domain name \(FQDN\). You can cluster the servers by deploying Microsoft Network Load Balancing \(NLB\) inside the perimeter network. The tasks in the following table require NLB to be configured appropriately to cluster the federation server proxies in the farm.  
  
For more information about how to configure an FQDN for a cluster using Microsoft NLB technology, see [Specifying the Cluster Parameters](https://go.microsoft.com/fwlink/?linkid=74651).  
  
## Configuring federation server proxies for a farm  
The following table describes the tasks that must be completed so that each federation server proxy can participate in a farm.  
  
|Task|Description|  
|--------|---------------|  
|Point all proxies in the farm to the same AD FS Federation Service name|When you create the federation server proxies, you must type the same Federation Service name in the AD FS Federation Server Proxy Configuration Wizard for all the federation server proxies that will participate in the farm. The federation server proxy uses the URL that makes up this DNS host name to determine which AD FS Federation Service instance it contacts.<br /><br />For more information, see [Configure a Computer for the Federation Server Proxy Role](../../ad-fs/deployment/Configure-a-Computer-for-the-Federation-Server-Proxy-Role.md).|  
|Obtain and share certificates|You can obtain a server authentication certificate from a public certification authority \(CA\)—for example, VeriSign—and then configure the certificate so that all federation server proxies share the same private key portion of the same certificate on the default Web site for each federation server proxy. To share the certificate, you must install the same server authentication certificate on the default Web site for each federation server proxy. For more information, see [Import a Server Authentication Certificate to the Default Web Site](../../ad-fs/deployment/Import-a-Server-Authentication-Certificate-to-the-Default-Web-Site.md).<br /><br />For more information, see [Certificate Requirements for Federation Server Proxies](Certificate-Requirements-for-Federation-Server-Proxies.md).|  
  
For more information about adding new federation server proxies to create a federation server proxy farm, see [Checklist: Setting Up a Federation Server Proxy](../../ad-fs/deployment/Checklist--Setting-Up-a-Federation-Server-Proxy.md).  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
