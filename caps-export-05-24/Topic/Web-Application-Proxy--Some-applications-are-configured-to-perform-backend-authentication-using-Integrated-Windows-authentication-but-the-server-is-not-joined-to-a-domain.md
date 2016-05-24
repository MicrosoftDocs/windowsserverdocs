---
title: Web Application Proxy: Some applications are configured to perform backend authentication using Integrated Windows authentication but the server is not joined to a domain
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - web-app-proxy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4e6bd8e6-f77e-4b58-9b45-2fcb386e3a4f
author: kgremban
robots: noindex,nofollow
---
# Web Application Proxy: Some applications are configured to perform backend authentication using Integrated Windows authentication but the server is not joined to a domain
This topic is intended to address a specific issue identified by a Best Practices Analyzer scan. You should apply the information in this topic only to computers that have had the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Best Practices Analyzer run against them and are experiencing the issue addressed by this topic. For more information about best practices and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|**Product\/Feature**|[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]|  
|**Severity**|Error|  
|**Category**|Configuration|  
  
## Issue  
  
> *[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] can perform backend authentication using Integrated Windows authentication only when it is running on a server that is joined to a domain.*  
  
## Impact  
  
> *Users will not be able to access this application from the current server.*  
  
## Resolution  
  
> *Join this server to a domain.*  
  
When publishing applications that use Integrated Windows authentication, the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server uses Kerberos constrained delegation to authenticate users to the published application.  
  
To use Integrated Windows authentication, the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server must be joined to an [!INCLUDE[ad_adds_3](../Token/ad_adds_3_md.md)] domain. The following lists the domain and forest requirements for a deployment using Integrated Windows authentication with Kerberos constrained delegation.  
  
-   Deployments where users, resources, and [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers are all in the same forest are supported.  
  
-   In deployments with multiple forests where there is a user forest, a resource forest, and a [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] forest, the following deployments are supported:  
  
    -   Users, resources, and [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers are all in different forests.  
  
    -   Users and [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers are in the same forest, but resources are in a different forest.  
  
    -   Resources and [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers are in the same forest, but users are in a different forest.  
  
    -   Users and resources are in the same forest, but [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers are in a different forest.  
  
In multi\-forest deployments:  
  
1.  The user forest must trust the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] forest, and the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] forest must trust the resource forest.  
  
2.  All of the Active Directory domains in a multi\-forest deployment must have at least one [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] or higher domain controller. For more information, see [Kerberos Constrained Delegation across Domains](http://go.microsoft.com/fwlink/?LinkId=389630)  
  
[!INCLUDE[mingrp_admins](../Token/mingrp_admins_md.md)]  
  
#### To join the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server to a domain  
  
1.  In [!INCLUDE[sm](../Token/sm_md.md)], click **Local Server**. In the details pane, click the link next to **Computer name**.  
  
2.  On the **System Properties** dialog box, click the **Computer Name** tab. On the **Computer Name** tab, click **Change**.  
  
3.  In **Computer Name**, type the name of the computer if you are also changing the computer name when joining the server to the domain. Under **Member of**, click **Domain**, and then type the name of the domain to which you want to join the server; for example, corp.contoso.com, and then click **OK**.  
  
4.  When you are prompted for a user name and password, enter the user name and password of a user with rights to join computers to the domain, and then click **OK**.  
  
5.  When you see a dialog box welcoming you to the domain, click **OK**.  
  
6.  When you are prompted that you must restart the computer, click **OK**.  
  
7.  On the **System Properties** dialog box, click **Close**.  
  
8.  When you are prompted to restart the computer, click **Restart Now**.  
  
