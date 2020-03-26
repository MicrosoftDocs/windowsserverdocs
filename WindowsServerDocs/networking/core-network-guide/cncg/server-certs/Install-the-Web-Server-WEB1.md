---
title: Install the Web Server WEB1
description: This topic is part of the guide Deploy Server Certificates for 802.1X Wired and Wireless Deployments
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: f51c9e38-98bb-49c1-9d39-427d07021499
ms.prod: windows-server
ms.technology: networking
ms.author: lizross
author: eross-msft
---
# Install the Web Server WEB1

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

The Web Server (IIS) role in Windows Server 2016 provides a secure, easy-to-manage, modular and extensible platform for reliably hosting websites, services, and applications. With IIS, you can share information with users on the Internet, an intranet, or an extranet. IIS is a unified web platform that integrates IIS, ASP.NET, FTP services, PHP, and Windows Communication Foundation (WCF).  

When you deploy server certificates, your Web server provides you with a location where you can publish the certificate revocation list (CRL) for your certification authority (CA). After publication, the CRL is accessible to all computers on your network so that they can use this list during the authentication process to verify that certificates presented by other computers are not revoked.   

If a certificate is on the CRL as revoked, the authentication effort fails and your computer is protected from trusting an entity that has a certificate that is no longer valid.  

Before you install the Web Server (IIS) role, ensure that you have configured the server name and IP address and have joined the computer to the domain.  

## To install the Web Server (IIS) server role  
To complete this procedure, you must be a member of the **Administrators** group.  

>[!NOTE]  
>To perform this procedure by using Windows PowerShell, open PowerShell, type the following command, and then press ENTER.  
`Install-WindowsFeature Web-Server -IncludeManagementTools`  

1.  In Server Manager, click **Manage**, and then click **Add Roles and Features**. The Add Roles and Features Wizard opens.  
2.  In **Before You Begin**, click **Next**.  

**Note**   
The **Before You Begin** page of the Add Roles and Features Wizard is not displayed if you have previously run the Add Roles and Features Wizard and you selected **Skip this page by default** at that time.  

3. On the **Installation Type** page, click **Next**.  
4. On the **Server selection** page, click **Next**.  
5. On the **Server roles** page, select **Web Server (IIS)**, and then click **Next**.  
6. Click **Next** until you have accepted all of the default web server settings, and then click **Install**.  
7. Verify that all installations were successful, and then click **Close**.
