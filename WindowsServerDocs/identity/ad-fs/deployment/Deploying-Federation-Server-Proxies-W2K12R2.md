---
description: "Learn more about: Deploying Federation Server Proxies"
ms.assetid: 222e9f93-7c41-4527-8a98-8f7fbc7a58af
title: Deploying Federation Server Proxies in AD FS for Windows Server 2012 R2
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
---

# Deploying Federation Server Proxies

In Active Directory Federation Services \(AD FS\) in  Windows Server 2012 R2 , the role of a federation server proxy is handled by a new Remote Access role service called Web Application Proxy. To enable your AD FS for accessibility from outside the corporate network, which was the purpose of deploying a federation server proxy in legacy versions of AD FS, such as AD FS 2.0 and AD FS in  Windows Server 2012 , you can deploy one or more web application proxies for AD FS in  Windows Server 2012 R2 .

In the context of AD FS, Web Application Proxy functions as an AD FS federation server proxy. In addition to this, Web Application Proxy provides reverse proxy functionality for web applications inside your corporate network to enable users on any device to access them from outside the corporate network. For more information, about the Web Application Proxy role service, see Web Application Proxy Overview.

To plan the deployment of Web Application proxy, you can review the information in the following topics:

-   [Plan the Web Application Proxy Infrastructure (WAP)](/previous-versions/orphan-topics/ws.11/dn383648(v=ws.11))

-   [Plan the Web Application Proxy Server](/previous-versions/orphan-topics/ws.11/dn383647(v=ws.11))

To deploy Web Application proxy, you can follow the procedures in the following topics:

-   [Configure the Web Application Proxy Infrastructure](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn383644(v=ws.11))

-   [Install and Configure the Web Application Proxy Server](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn383662(v=ws.11))


## See Also

[AD FS Deployment](../../ad-fs/AD-FS-Deployment.md)

[Windows Server 2012 R2 AD FS Deployment Guide](../../ad-fs/deployment/Windows-Server-2012-R2-AD-FS-Deployment-Guide.md)

[Deploying a Federation Server Farm](../../ad-fs/deployment/Deploying-a-Federation-Server-Farm.md)

