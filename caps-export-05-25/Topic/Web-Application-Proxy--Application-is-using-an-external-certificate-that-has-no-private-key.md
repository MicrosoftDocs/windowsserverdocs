---
title: Web Application Proxy: Application is using an external certificate that has no private key
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - web-app-proxy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d32d287b-91ff-49bc-96a3-dc75d2f9af5d
author: kgremban
robots: noindex,nofollow
---
# Web Application Proxy: Application is using an external certificate that has no private key
This topic is intended to address a specific issue identified by a Best Practices Analyzer scan. You should apply the information in this topic only to computers that have had the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Best Practices Analyzer run against them and are experiencing the issue addressed by this topic. For more information about best practices and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|**Product\/Feature**|[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]|  
|**Severity**|Error|  
|**Category**|Configuration|  
  
## Issue  
  
> *Application <application\_name> that is published by [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] is using a certificate that has no private key.*  
  
## Impact  
  
> *If an application is using a certificate that has no private key, users will not be able to secure their access to the application and sensitive data will not be encrypted. Some browsers might block access to such sites.*  
  
## Resolution  
  
> *Publish this application again with a valid certificate.*  
  
When you publish an application through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], a valid certificate with the private key is required to be stored in the Personal certificates store on each [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server. If the certificate used by an application has no private key, users will not be able to secure their access to the application and sensitive data will not be encrypted. Some browsers might block access to such sites. To resolve this issue, you must obtain a new certificate for this application. After obtaining the new certificate, you can either change the certificate using the Set\-WebApplicationProxyApplication cmdlet with the ExternalCertificateThumbprint parameter, or remove the application and republish it using the new certificate.  
  
[!INCLUDE[mingrp_admins](../Token/mingrp_admins_md.md)]  
  
#### To request a certificate for the published application from an internal certification authority  
  
1.  On the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, open an MMC console: [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**mmc.exe**, and then press ENTER. [!INCLUDE[uac_confirm_action](../Token/uac_confirm_action_md.md)]  
  
2.  In the Console window, on the **File** menu, click **Add\/Remove Snap\-in**.  
  
3.  On the **Add or Remove Snap\-ins** dialog, double\-click **Certificates**.  
  
4.  On the **Certificates snap\-in** dialog, click **Computer account**, and then click **Next**.  
  
5.  On the **Select Computer** dialog, click **Local computer**, click **Finish**, and then click **OK**.  
  
6.  In the Console window, open **Certificates\/Personal\/Certificates**.  
  
7.  Right\-click in the details pane, click **All Tasks**, and then click **Request New Certificate**.  
  
8.  On the **Certificate Enrollment** dialog, click **Next** twice.  
  
9. On the **Request Certificates** page, select the certificate template that has been configured for website authentication, and click **More information is required to enroll for this certificate**.  
  
10. On the **Certificate Properties** dialog, on the **Subject** tab, in **Subject name**, in the **Type** list, click **Common name**, and in the **Value** box, enter a value for this certificate that covers the application that you are attempting to publish, click **Add**, click **OK**, and then click **Enroll**.  
  
11. After successfully enrolling for this certificate, click **Finish**.  
  
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
  
    -   In the **Backend server SPN** box, enter the service principal name for the backend server; for example, HTTP\/apps.contoso.com.  
  
6.  On the **Confirmation** page, review the settings, and then click **Publish**. You can copy the PowerShell command set up additional published applications.  
  
7.  On the **Results** page, make sure that the application published successfully, and then click **Close**.  
  
#### To change the certificate using PowerShell  
  
1.  Obtain a new certificate for the application as described above.  
  
2.  To obtain the application ID of the required application, use the following PowerShell command to show the ID and externalURL of all applications whose name matches the application name. Locate the application ID in the command output of the relevant application:  
  
    ```  
    Get-WebApplicationProxyApplication –Name <application_name> | Format-Table ID, ExternalURL  
    ```  
  
3.  Use the following PowerShell command to change the certificate used for the published application:  
  
    ```  
    Set-WebApplicationProxyApplication –ID <application_ID> -ExternalCertificateThumbprint <New_certificate_thumbprint>  
    ```  
  
