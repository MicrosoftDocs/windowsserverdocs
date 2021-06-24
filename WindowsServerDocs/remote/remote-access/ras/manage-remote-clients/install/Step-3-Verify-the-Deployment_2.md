---
title: Step 3 Verify the Deployment
description: Learn how to verify that you have correctly configured your deployment for remote management of DirectAccess clients.
manager: brianlic
ms.topic: article
ms.assetid: 6a78a078-d2e7-4cbd-b8d5-20cfb6d1524b
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---
# Step 3 Verify the Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes how to verify that you have correctly configured your deployment for remote management of DirectAccess clients .

### To verify proper deployment

1.  Connect a DirectAccess client computer to the corporate network and obtain the Group Policy Object.

2.  On the client computer, click the **Network connections** icon in the notification area to access the DirectAccess Media Manager.

3.  Click **DirectAccess Connection**, and you will see that the status is **Locally Connected**.

4.  Remove the computer from the corporate network and connect it to a public network.

5.  At a command prompt, type **nltest /dsgetdc: [fully qualified domain name]**. This command will verify that the corporate network is accessible to the client. If the domain controller is not accessible, the following error message will display reporting that the domain does not exist: ERROR_NO_SUCH_DOMAIN.



