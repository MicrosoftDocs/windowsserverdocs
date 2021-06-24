---
title: Plan a Multisite Deployment
description: Learn about the planning steps required in order to deploy  Windows Server 2016 or  Windows Server 2012  Remote Access in a multisite configuration.
manager: brianlic
ms.topic: article
ms.assetid: 8387eabe-7363-4367-b5b1-03c67baa2933
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---
# Plan a Multisite Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

 Windows Server 2016, Windows Server 2012 combine DirectAccess and Routing and Remote Access Service (RRAS) VPN into a single Remote Access role. This overview provides an introduction to the planning steps required in order to deploy  Windows Server 2016 or  Windows Server 2012  Remote Access in a multisite configuration.

1.  [Deploy a Single DirectAccess Server with Advanced Settings](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831436(v=ws.11)). This step includes planning for the infrastructure required to deploy a single server. It includes planning for network and server settings, certificate requirements, DNS settings, network location server deployment, DirectAccess management servers, Active Directory settings, and Group Policy objects (GPOs).

2.  [Step 2 Plan the multisite infrastructure](Step-2-Plan-the-Multisite-Infrastructure.md). This step includes Active Directory and GPO planning, and DNS configuration.

3.  [Step 3 Plan the Multisite Deployment](Step-3-Plan-the-Multisite-Deployment.md). This step includes planning certificate settings, network location server configuration, client entry point settings, IPv6 prefix settings, and optionally global load balancing settings.

> [!NOTE]
> Record your planning decisions for Remote Access advanced deployment. This record can be used as a job aid for everyone involved in completing the deployment steps.

After you have completed these planning steps, see [Configuring a multisite deployment](../configure/Configure-a-Multisite-Deployment.md).

