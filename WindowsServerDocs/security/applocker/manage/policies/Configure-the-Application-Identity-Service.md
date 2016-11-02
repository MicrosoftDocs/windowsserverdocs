---
title: Configure the Application Identity Service
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bb0a6a83-56e7-46e5-a57d-7d64c5d5f945
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Configure the Application Identity Service

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic shows how to configure the Application Identity service to start automatically or manually in  Windows Server 2012  and Windows 8.

The Application Identity service determines and verifies the identity of an application. Stopping this service will prevent AppLocker policies from being enforced.

> [!IMPORTANT]
> When using Group Policy, you must configure it to start automatically in at least one Group Policy Object (GPO) that applies AppLocker rules. This is because AppLocker uses this service to verify the attributes of a file.

#### To start the Application Identity service automatically using Group Policy

1.  On the **Start** screen, type**gpmc.msc** to open the Group Policy Management Console (GPMC).

2.  Locate the GPO to edit, right-click the GPO, and click **Edit**.

3.  In the console tree under **Computer Configuration\Windows Settings\Security Settings**, click **System Services**.

4.  In the details pane, double-click **Application Identity**.

5.  In **Application Identity Properties**, configure the service to start automatically.

Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure.

#### To start the Application Identity service manually

1.  Right-click the taskbar, and click **Start Task Manager**.

2.  Click the **Services** tab, right-click **AppIDSvc**, and then click **Start Service**.

3.  Verify that the status for the Application Identity service is **Running**.


