---
title: Web Application Proxy must be configured before it is used
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - web-app-proxy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e4c952f2-349f-4283-82e6-ae215d08eb5a
author: kgremban
robots: noindex,nofollow
---
# Web Application Proxy must be configured before it is used
This topic is intended to address a specific issue identified by a Best Practices Analyzer scan. You should apply the information in this topic only to computers that have had the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Best Practices Analyzer run against them and are experiencing the issue addressed by this topic. For more information about best practices and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|**Product\/Feature**|[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]|  
|**Severity**|Error|  
|**Category**|Configuration|  
  
## Issue  
  
> *[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] was installed but not configured for initial use.*  
  
## Impact  
  
> *If [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] is not configured it cannot be used to publish applications.*  
  
## Resolution  
  
> *Use ‘Remote Access Management’ in Server Manager to start the configuration wizard or use the Install\-WebApplicationProxy PowerShell command.*  
  
After installing the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] role service on a server, you must also configure [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] on the server. If you do not configure [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], you will be unable to publish applications and the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server will not provide [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] proxy functionality.  
  
[!INCLUDE[mingrp_admins](../Token/mingrp_admins_md.md)]  
  
#### To configure [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]  
  
1.  On the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, open the Remote Access Management console: [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**RAMgmtUI.exe**, and then press ENTER. [!INCLUDE[uac_confirm_action](../Token/uac_confirm_action_md.md)]  
  
2.  In the navigation pane, click **[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]**.  
  
3.  In the Remote Access Management console, in the middle pane, click **Run the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Configuration Wizard**.  
  
4.  On the **[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Configuration Wizard**, on the **Welcome** dialog, click **Next**.  
  
5.  On the **Federation Server** dialog, do the following, and then click **Next**:  
  
    -   In the **Federation service name** box, enter the fully qualified domain name \(FQDN\) of the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server; for example, fs.contoso.com.  
  
    -   In the **User name** and **Password** boxes, enter the credentials of a local administrator account on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers.  
  
6.  On the **AD FS Proxy Certificate** dialog, in the list of certificates currently installed on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, select a certificate to be used by [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] proxy functionality, and then click **Next**.  
  
7.  On the **Confirmation** dialog, review the settings. If required, you can copy the PowerShell cmdlet to automate additional installations. Click **Configure**.  
  
8.  On the **Results** dialog, verify that the configuration was successful, and then click **Close**.  
  
