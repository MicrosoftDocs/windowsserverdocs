---
title: Web Application Proxy: A cluster of Web Application Proxy servers is deployed and DirectAccess is also installed
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - web-app-proxy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 85f85383-e166-466f-8d91-07641b00ec60
author: kgremban
robots: noindex,nofollow
---
# Web Application Proxy: A cluster of Web Application Proxy servers is deployed and DirectAccess is also installed
This topic is intended to address a specific issue identified by a Best Practices Analyzer scan. You should apply the information in this topic only to computers that have had the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Best Practices Analyzer run against them and are experiencing the issue addressed by this topic. For more information about best practices and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|**Product\/Feature**|[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
## Issue  
  
> *A cluster of [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers is deployed and DirectAccess is also installed on this server.*  
  
## Impact  
  
> *[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] does not support this configuration and might not work as expected.*  
  
## Resolution  
  
> *Consider uninstalling DirectAccess from this server.*  
  
When [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] is deployed in a multiple server deployment, it cannot be deployed on a server that also has DirectAccess installed. You must uninstall either DirectAccess, or [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]. The following table shows the supported deployments:  
  
|DirectAccess|VPN|[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]|  
|----------------|-------|-----------------------------------------------------------|  
|Single server deployment|Single server deployment|Single server deployment|  
|Multisite deployment|Multiple server deployment|Not supported on the same server|  
|Not supported on the same server|Multiple server deployment|Multiple server deployment|  
|Cluster deployment<sup>1</sup>|Multiple server deployment|Multiple server deployment<sup>2</sup>|  
  
> [!NOTE]  
> 1—In a pre\-existing DirectAccess cluster deployment, you can install [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] only using [!INCLUDE[wps_2](../Token/wps_2_md.md)].  
>   
> 2—In a pre\-existing multiple server [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] deployment, you can install DirectAccess only using [!INCLUDE[wps_2](../Token/wps_2_md.md)].  
  
[!INCLUDE[mingrp_admins](../Token/mingrp_admins_md.md)]  
  
#### To uninstall DirectAccess  
  
1.  On the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, open the Remote Access Management console: [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**RAMgmtUI.exe**, and then press ENTER. [!INCLUDE[uac_confirm_action](../Token/uac_confirm_action_md.md)]  
  
2.  In the Remote Access Management console, in the navigation pane, click **DirectAccess and VPN**.  
  
3.  In the **Tasks** pane, click **Remove Configuration Settings**.  
  
4.  On the **Confirm Remove Configuration** dialog, click **OK**.  
  
5.  On the **Removing Configuration Settings** dialog, make sure the configuration was removed, and then click **Close**.  
  
