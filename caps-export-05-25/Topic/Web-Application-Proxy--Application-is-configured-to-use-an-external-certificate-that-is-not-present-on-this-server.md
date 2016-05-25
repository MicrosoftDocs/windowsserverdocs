---
title: Web Application Proxy: Application is configured to use an external certificate that is not present on this server
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - web-app-proxy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e0ca461b-0342-4052-b276-8d7ca28750ab
author: kgremban
robots: noindex,nofollow
---
# Web Application Proxy: Application is configured to use an external certificate that is not present on this server
This topic is intended to address a specific issue identified by a Best Practices Analyzer scan. You should apply the information in this topic only to computers that have had the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Best Practices Analyzer run against them and are experiencing the issue addressed by this topic. For more information about best practices and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|**Product\/Feature**|[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]|  
|**Severity**|Error|  
|**Category**|Configuration|  
  
## Issue  
  
> *Application <application\_name> that is published by [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] is using an external certificate that is not present on this server.*  
  
## Impact  
  
> *If an application uses a certificate that is not present on this server, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] will not publish the application and users will not have access.*  
  
## Resolution  
  
> *Obtain the configured external certificate from another server and copy it to this server with its private key.*  
  
For every application that you publish through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], each [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server in a multi\-server deployment must have a copy of the certificate used for authentication for the website with the private key.  
  
#### To export the application certificate  
  
1.  On an [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server that has the required certificate, open an MMC console: [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**mmc.exe**, and then press ENTER. [!INCLUDE[uac_confirm_action](../Token/uac_confirm_action_md.md)]  
  
2.  In the Console window, on the **File** menu, click **Add\/Remove Snap\-in**.  
  
3.  On the **Add or Remove Snap\-ins** dialog, double\-click **Certificates**.  
  
4.  On the **Certificates snap\-in** dialog, click **Computer account**, and then click **Next**.  
  
5.  On the **Select Computer** dialog, click **Local computer**, click **Finish**, and then click **OK**.  
  
6.  In the Console window, open **Certificates\/Personal\/Certificates**.  
  
7.  In the details pane, right\-click the required certificate, click **All Tasks**, and then click **Export**.  
  
8.  On the **Certificate Export Wizard**, click **Next**.  
  
9. On the **Export Private Key** page, click **Yes, export the private key**, and then click **Next**.  
  
10. On the **Export File Format** page, make sure **Personal Information Exchange** is selected, select the **Include all certificates in the certification path if possible** and **Export all extended properties** check boxes, and then click **Next**.  
  
11. On the **Security** page, decide how to protect this certificate, and then click **Next**.  
  
12. On the **File to Export** page, save the certificate in a location that can be accessed by the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server that requires this certificate, and then click **Next**, and then click **Finish**.  
  
13. If the export is successful, click **OK**.  
  
After exporting the application certificate, you must import it on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server that requires the certificate.  
  
#### To import the application certificate  
  
1.  On the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server that requires the certificate, open an MMC console as described above.  
  
2.  In the Console window, open **Certificates\/Personal\/Certificates**.  
  
3.  Right\-click in the details pane, click **All Tasks**, and then click **Import**.  
  
4.  On the **Certificate Import Wizard**, click **Next**.  
  
5.  On the **File to Import** page, locate the certificate that you exported previously, and then click **Next**.  
  
6.  On the **Private key protection** page, enter the password if required, and then click **Next**.  
  
7.  On the **Certificate Store** page, click **Next**, and then click **Finish**.  
  
8.  If the import is successful, click **OK**.  
  
