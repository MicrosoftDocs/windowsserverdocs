---
title: Plan Remote Access with OTP Authentication
description: Learn about the configuration steps required in order to deploy a single Windows Server 2016 or Windows Server 2012  Remote Access multisite deployment.
manager: brianlic
ms.topic: article
ms.assetid: 762bc463-eead-46ac-8b90-32355743c27c
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---
# Plan Remote Access with OTP Authentication

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

 Windows Server 2016 and Windows Server 2012 combine DirectAccess and Routing and Remote Access Service (RRAS) VPN into a single Remote Access role. This overview provides an introduction to the configuration steps required in order to deploy a single  Windows Server 2016 or  Windows Server 2012  Remote Access multisite deployment.


-  Step 1: [Deploy a Single DirectAccess Server with Advanced Settings](../../../directaccess/single-server-advanced/deploy-a-single-directaccess-server-with-advanced-settings.md). This step includes planning for the infrastructure required to deploy a single server. It includes planning for network and server settings, certificate requirements, DNS settings, network location server deployment, DirectAccess management servers, Active Directory settings, and Group Policy objects (GPOs).

-   [Step 2: Plan the RADIUS server deployment](Step-2-Plan-the-RADIUS-Server-Deployment.md)

-   [Step 3: Plan OTP certificate deployment](Step-3-Plan-OTP-Certificate-Deployment.md)

-   [Step 4: Plan for OTP on the Remote Access server](Step-4-Plan-for-OTP-on-the-Remote-Access-Server.md)

After you have completed these planning steps, see [Configure Remote Access with OTP Authentication](../configure/configure-ra-with-otp-authentication.md). For information on configuring a multisite deployment as a proof of concept in a lab environment, see [Test Lab Guide: Demonstrate DirectAccess with OTP Authentication and RSA SecurID](../../../directaccess/tlg-otp-securid/test-lab-guide-demonstrate-directaccess-with-otp-authentication-and-rsa-securid.md).

