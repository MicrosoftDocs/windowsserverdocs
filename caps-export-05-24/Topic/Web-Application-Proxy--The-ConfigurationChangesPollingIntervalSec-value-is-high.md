---
title: Web Application Proxy: The ConfigurationChangesPollingIntervalSec value is high
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - web-app-proxy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 80de6225-e768-45e5-ae01-1d61b5ed476c
author: kgremban
robots: noindex,nofollow
---
# Web Application Proxy: The ConfigurationChangesPollingIntervalSec value is high
This topic is intended to address a specific issue identified by a Best Practices Analyzer scan. You should apply the information in this topic only to computers that have had the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Best Practices Analyzer run against them and are experiencing the issue addressed by this topic. For more information about best practices and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|**Product\/Feature**|[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
## Issue  
  
> *When the ConfigurationChangesPollingIntervalSec value is high, any changes that you make are not propagated in a timely manner, or changes are only partially propagated until the next time the server checks for updates.*  
  
## Impact  
  
> *Applications might not be published as expected until the next time the server checks for updates.*  
  
## Resolution  
  
> *Consider changing ConfigurationChangesPollingIntervalSec to a lower value using the Set\-WebApplicationProxyConfiguration cmdlet.*  
  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers must periodically check if there have been any configuration changes made to the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] configuration that is stored on the [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] servers. The time between these checks is set by the ConfigurationChangesPollingIntervalSec parameter. If the value is low, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] checks for changes more frequently, but does increase internal network traffic. However, if the value is high, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] may operate for a significant period of time before starting to use the new configuration. The default value for this parameter is 30 seconds.  
  
[!INCLUDE[mingrp_admins](../Token/mingrp_admins_md.md)]  
  
#### To change how frequently Web Application Proxy checks for configuration changes  
  
1.  On the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] window.  
  
2.  Use the following command to view the current ConfigurationChangesPollingIntervalSec value:  
  
    ```  
    Get-WebApplicationProxyConfiguration  
    ```  
  
3.  Run the following command to change the ConfigurationChangesPollingIntervalSec value to 15 seconds:  
  
    ```  
    Set-WebApplicationProxyConfiguration –ConfigurationChangesPollingIntervalSec 15  
    ```  
  
