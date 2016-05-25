---
title: Web Application Proxy: The external and backend server URLs are different and URL translation is disabled
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - web-app-proxy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ec8635a3-0147-4c38-b785-dee20c5d6bc6
author: kgremban
robots: noindex,nofollow
---
# Web Application Proxy: The external and backend server URLs are different and URL translation is disabled
This topic is intended to address a specific issue identified by a Best Practices Analyzer scan. You should apply the information in this topic only to computers that have had the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Best Practices Analyzer run against them and are experiencing the issue addressed by this topic. For more information about best practices and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|**Product\/Feature**|[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
## Issue  
  
> *The external and backend server URLs are different and URL translation is disabled.*  
  
## Impact  
  
> *The published application might reject requests from the client.*  
  
## Resolution  
  
> *Consider changing the application publishing settings.*  
  
By default, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] translates the host portion of requests to a backend server. For example, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] will translate the URLs successfully if the external URL is https:\/\/apps.contoso.com\/ and the backend server URL is https:\/\/appsinternal.contoso.com\/. However, URL translation is currently disabled, which might cause client requests to be rejected. You can manually enable the translation of host headers by using the DisableTranslateUrlInRequestHeaders parameter.  
  
You may need to remove the published application and republish it to resolve this issue.  
  
[!INCLUDE[mingrp_admins](../Token/mingrp_admins_md.md)]  
  
#### To remove a published application  
  
1.  On the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, open the Remote Access Management console: [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**RAMgmtUI.exe**, and then press ENTER. [!INCLUDE[uac_confirm_action](../Token/uac_confirm_action_md.md)]  
  
2.  In the Remote Access Management console, in the navigation pane, click **[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]**.  
  
3.  In the details pane, select the application identified in the BPA, and then in the **Tasks** pane, click **Remove**.  
  
4.  On the **Remove Applications** dialog box, click **Yes**.  
  
After removing the application, you can republish it.  
  
#### To publish an application  
  
1.  In the Remote Access Management console, in the Navigation pane, click **[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]**, and then in the **Tasks** pane, click **Publish**.  
  
2.  On the **Publish New Application Wizard**, on the **Welcome** page, click **Next**.  
  
3.  On the **Preauthentication** page, select the required preauthentication, and then click **Next**.  
  
4.  If you selected [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], on the **Relying Party** page, in the list of relying parties select the relying party for the application that you want to publish, and then click **Next**.  
  
5.  On the **Publishing Settings** page, do the following, and then click **Next**:  
  
    -   In the **Name** box, enter a friendly name for the application.  
  
    -   In the **External URL** box, enter the external URL for this application; for example, https:\/\/apps.contoso.com\/.  
  
    -   In the **External certificate** list, select a certificate whose subject covers the external URL.  
  
    -   In the **Backend server URL** box, enter the URL of the backend server. Note that this value is automatically entered when you enter the external URL and you should change it only if the backend server URL is different; for example, http:\/\/apps\/.  
  
        > [!NOTE]  
        > [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] can translate host names in URLs, but cannot translate path names. Therefore, you can enter different host names, but you must enter the same path name. For example, you can enter an external URL of https:\/\/apps.contoso.com\/app1\/ and a backend server URL of https:\/\/app\-server\/app1\/. However, you cannot enter an external URL of https:\/\/apps.contoso.com\/app1\/ and a backend server URL of https:\/\/apps.contoso.com\/internal\-app1\/.  
  
    -   In the **Backend server SPN** box, enter the service principal name for the backend server; for example, HTTP\/apps.contoso.com.  
  
6.  On the **Confirmation** page, review the settings, and then click **Publish**. You can copy the PowerShell command set up additional published applications.  
  
7.  On the **Results** page, make sure that the application published successfully, and then click **Close**.  
  
You can view the settings of a published application and enable URL translation, if required.  
  
#### To enable URL translation using PowerShell  
  
1.  To obtain the application ID of an application, use the following PowerShell command to show the ID, name, and external URL of all applications published by [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], and locate the application ID of the required application in the command output:  
  
    ```  
    Get-WebApplicationProxyApplication | Format-Table ID, Name, ExternalURL  
    ```  
  
2.  Use the following PowerShell command to enable URL translation for a specific published application:  
  
    ```  
    Set-WebApplicationProxyApplication –ID <application_ID> -DisableTranslateUrlInRequestHeaders:$false  
    ```  
  
