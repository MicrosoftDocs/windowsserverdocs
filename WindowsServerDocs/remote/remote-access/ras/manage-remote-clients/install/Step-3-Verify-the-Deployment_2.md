---
title: Step 3 Verify the Deployment
description: Learn how to verify that you've correctly configured your deployment for remote management of DirectAccess clients.
ms.topic: article
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---
# Step 3 Verify the Deployment

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This article describes how to verify that you've correctly configured your deployment for remote management of DirectAccess clients.

## To verify proper deployment

1. Connect a DirectAccess client computer to the corporate network and obtain the Group Policy Object.

1. On the client computer, select the **Network connections** icon in the notification area to access the DirectAccess Media Manager.

1. Select **DirectAccess Connection**. You'll see that the status is **Locally Connected**.

1. Remove the computer from the corporate network and connect it to a public network.

1. In the command prompt, type **nltest /dsgetdc: [fully qualified domain name]**. This command verifies that the corporate network is accessible to the client. If the domain controller isn't accessible, the error message ERROR_NO_SUCH_DOMAIN will display, reporting that the domain doesn't exist.