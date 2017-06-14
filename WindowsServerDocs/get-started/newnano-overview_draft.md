---
title: Changes to the Nano Server in the new Windows Server servicing model
description: In the new Windows Server servicing model, Nano Server is a container operating system only, with certain feature changes.
ms.prod: Windows Server
ms.mktglfcycl: manage
ms.sitesec: library
author: jaimeo
localizationpriority: high
ms.date: 
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: a270334d-42a7-46ff-8eed-d8656a276544
---

>Applies To: Windows Server, Semi-annual Channel

# Nano Server in the new Windows Server servicing model


The Windows Server release model is offering a new option in order to align with similar release and servicing models for [Windows 10](https://docs.microsoft.com/windows/deployment/update/waas-overview) and [Office 365 ProPlus](https://support.office.com/article/Overview-of-the-upcoming-changes-to-Office-365-ProPlus-update-management-78b33779-9356-4cdf-9d2c-08350ef05cca?ui=en-US&rs=en-US&ad=US). If you've been working with Windows 10 or Office 365 ProPlus, these improvements might already be familiar to you.

For details, see [Overview of Windows Server as a Service](https://aka.ms/wsaas).

## Changes for Nano Server
In Windows Server 2016, Nano Server is already serviced by the Current Branch for Business (CBB) model in order to support customers who are moving at a “cloud cadence," using rapid development cycles. In this model, feature update releases of Nano Server are expected two to three times per year.

In the new servicing model, called the **semi-annual channel**, this pattern is not changing for Nano Server.

However, **starting with the new feature release of Windows Server, version 1709** Nano Server will be available only as a **container operating system**. You must run it as a container in a container host, such as a Server Core installation of Windows Server, version 1709. Nano Server running as a container operating system in the new feature release differs from earlier releases in these ways:

- Nano Server has been optimized for .NET Core applications.
- Nano Server is now 77% smaller.
- Windows PowerShell, .NET Core, and WMI are no longer included by default, but but you can run them in a separate container [LINK TO XUMIN DOCS].
- There is no longer a servicing stack included in Nano Server. Microsoft publishes an updated Nano container to Docker that you redeploy.
- You troubleshoot the new Nano Container by using Docker.
- You can now run Nano containers on IoT Core.



## Related topics
[LINK TO OTHER NEW CONTAINER TOPICS]








