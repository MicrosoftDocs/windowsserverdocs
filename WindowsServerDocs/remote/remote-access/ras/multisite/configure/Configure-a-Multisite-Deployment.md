---
title: Configure a Multisite Deployment
description: Learn about the configuration steps required to deploy a single Windows Server 2016 or Windows Server 2012 Remote Access multisite deployment.
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 08/07/2020
---
# Configure a Multisite Deployment

 Windows Server 2016 combines DirectAccess and Remote Access Service (RAS) VPN into a single Remote Access role. This overview provides an introduction to the configuration steps required in order to deploy a single Windows Server 2016 or Windows Server 2012 Remote Access multisite deployment.

-   Step 1: [Deploy a Single DirectAccess Server with Advanced Settings](../../../directaccess/single-server-advanced/deploy-a-single-directaccess-server-with-advanced-settings.md). Install and configure a single Remote Access server. The multisite deployment requires you to install a single server before configuring a multisite deployment.

-   [Step 2: Configure the multisite infrastructure](Step-2-Configure-the-Multisite-Infrastructure.md). For a multisite deployment you must configure additional Active Directory sites and domain controllers. Additional security groups and Group Policy Objects (GPOs) are also required if you are not using automatically configured GPOs.

-   [Step 3: Configure the multisite deployment](Step-3-Configure-the-Multisite-Deployment.md)-Install the Remote Access role on additional Remote Access servers, enable the multisite deployment, and configure the additional servers as entry points for the deployment.

-   [Step 4: Verify the multisite deployment](Step-4-Verify-the-Multisite-Deployment.md)

