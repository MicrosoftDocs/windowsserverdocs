---
title: Web Application Proxy: This server is not included in the ConnectedServersName list
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - web-app-proxy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1bd92151-7c55-48c2-9e4d-7f8b0228f74b
author: kgremban
robots: noindex,nofollow
---
# Web Application Proxy: This server is not included in the ConnectedServersName list
This topic is intended to address a specific issue identified by a Best Practices Analyzer scan. You should apply the information in this topic only to computers that have had the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Best Practices Analyzer run against them and are experiencing the issue addressed by this topic. For more information about best practices and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|**Product\/Feature**|[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
## Issue  
  
> *This server is not included in the ConnectedServersName list.*  
  
## Impact  
  
> *The Remote Access Management console may not work as expected.*  
  
## Resolution  
  
> *Use the Set\-WebApplicationProxyConfiguration cmdlet to add this server to the ConnectedServersName list.*  
  
All [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers must be included in the ConnectedServersName list, otherwise they will not appear in the Remote Access Management console and attempts to change or configure published applications may result in unexpected behavior. You can manually configure the ConnectedServersName list only using [!INCLUDE[wps_2](../Token/wps_2_md.md)].  
  
[!INCLUDE[mingrp_admins](../Token/mingrp_admins_md.md)]  
  
#### To add a server to the ConnectedServersName list  
  
1.  On the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] window.  
  
2.  Use the following command to view the current ConnectedServersName list:  
  
    ```  
    Get-WebApplicationProxyConfiguration  
    ```  
  
3.  Copy the current ConnectedServersName list to the clipboard.  
  
4.  Run the following command to add a server to the ConnectedServersName list:  
  
    ```  
    Set-WebApplicationProxyConfiguration –ConnectedServersName <paste-existing-list-here>,<new_server_name>.<domain_name>  
    ```  
  
    > [!NOTE]  
    > You must provide the existing list of connected servers, and then add each new server as a comma\-separated list for this command to be effective.  
  
