---
title: Web Application Proxy: The AD FS Proxy service is not configured to run automatically
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - web-app-proxy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f43f39ef-7dd5-4710-9be4-127a7b3000a9
author: kgremban
robots: noindex,nofollow
---
# Web Application Proxy: The AD FS Proxy service is not configured to run automatically
This topic is intended to address a specific issue identified by a Best Practices Analyzer scan. You should apply the information in this topic only to computers that have had the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Best Practices Analyzer run against them and are experiencing the issue addressed by this topic. For more information about best practices and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|**Product\/Feature**|[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
## Issue  
  
> *Active Directory Federation Services service \(adfssrv\) settings were changed and it is not configured to run automatically.*  
  
## Impact  
  
> *After the server restarts, the service will not start and users will not be able to authenticate and will not be able to access published applications.*  
  
## Resolution  
  
> *Consider changing the Active Directory Federation Services service startup type to Automatic.*  
  
In order for [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] to work correctly, the adfssrv service must be running. It is recommended that this service is set to automatic to ensure that whenever the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server restarts, the service will restart without any user action.  
  
[!INCLUDE[mingrp_admins](../Token/mingrp_admins_md.md)]  
  
#### To set the adfssrv service startup type to automatic  
  
1.  On the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, open the Services console: [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**services.msc**, and then press ENTER. [!INCLUDE[uac_confirm_action](../Token/uac_confirm_action_md.md)]  
  
2.  In the details pane, right\-click **Active Directory Federation Services**, and then click **Properties**.  
  
3.  On the **Active Directory Federation Services** dialog, on the **General** tab, in **Startup type**, click **Automatic**, and then click **OK**.  
  
