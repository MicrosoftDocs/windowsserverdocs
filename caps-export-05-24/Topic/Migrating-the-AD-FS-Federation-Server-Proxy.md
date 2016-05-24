---
title: Migrating the AD FS Federation Server Proxy
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 618cbd9a-a874-419f-b00a-5619f109f461
author: Femila
---
# Migrating the AD FS Federation Server Proxy
In Active Directory Federation Services \(AD FS\) in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the role of a federation server proxy is handled by a new Remote Access role service called Web Application Proxy. In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], to enable your AD FS for accessibility from outside of the corporate network, you can deploy one or more Web Application Proxies. However, you cannot migrate a federation server proxy running on Windows Server 2008 R2 or Windows Server 2012 to a Web Application Proxy running on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
> [!IMPORTANT]  
> The migration of a federation server proxy running on Windows Server 2008, Windows Server 2008 R2, or Windows Server 2012 to a Web Application Proxy running on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is NOT supported.  
  
If you want to configure AD FS in a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] migrated farm for extranet access, you must perform a fresh deployment of one or more Web Application Proxy computers as part of your AD FS infrastructure.  
  
To plan Web Application Proxy deployment, you can review the information in the following topics:  
  
-   [Plan the Web Application Proxy Infrastructure \[WAP\]](assetId:///8dfd483f-faf5-4a99-a590-0081623cad08)  
  
-   [Plan the Web Application Proxy Server](assetId:///9020ad26-2952-4ef2-a746-d564376d2b93)  
  
To deploy Web Application proxy, you can follow the procedures in the following topics:  
  
-   [Configure the Web Application Proxy Infrastructure](../Topic/Configure-the-Web-Application-Proxy-Infrastructure.md)  
  
-   [Install and Configure the Web Application Proxy Server](../Topic/Install-and-Configure-the-Web-Application-Proxy-Server.md)  
  
## See Also  
[Migrating Active Directory Federation Services Role Service to Windows Server 2012 R2](../Topic/Migrating-Active-Directory-Federation-Services-Role-Service-to-Windows-Server-2012-R2.md)  
  
