---
title: Changes to the Nano Server in the new Windows Server release model
description: Starting with [RS3], Nano Server is a container operating system only, with certain feature changes.
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

>Applies To: Windows Server [RS3]

# Changes to the Windows Server release model


Starting with the new feature release of Windows Server (1709), we are changing the release model to support Windows Server as a service and align with similar release and servicing models for Windows 10 [LINK] and [Office 365 ProPlus](https://support.office.com/en-us/article/Overview-of-the-upcoming-changes-to-Office-365-ProPlus-update-management-78b33779-9356-4cdf-9d2c-08350ef05cca). If you've been working with Windows 10, these improvements might already be familiar to you, since the new release model for Windows Server is similar, though not identical. Microsoft has reimagined each part of the process to simplify the lives of IT pros and maintain a consistent Windows Server experience for its customers. If you've been working with Windows 10, these improvements might already be familiar to you. 

For details, see [Overview of Windows Server as a Service](https://aka.ms/wsaas).

## Changes for Nano Server
In Windows Server 2016, Nano Server is already serviced by the Current Branch for Business (CBB) model in order to support customers who are moving at a “cloud cadence," using rapid development cycles. In this model, feature update releases of Nano Server are expected two to three times per year. This release model is not changing for Nano Server.

However, **Starting with the new feature release of Windows Server (1709)** Nano Server will be available only as a **container operating system**. You must run it as a container in a container host, such as a Server Core installation of the new feature release, [OTHER VIABLE HOSTS?]. Nano Server running as a container operating system in the new feature release differs from earlier releases in these ways:

- Nano Server has been optimized for .NET Core applications.
- Nano Server is now 30% smaller.
- Windows PowerShell, .NET Core, and WMI are no longer included by default, but but you can run them in a separate container [is that explained in the related container docs?].
- There is no longer a servicing stack included in Nano Server. Microsoft publishes an updated Nano container to Docker that you redeploy.
- You troubleshooting the new Nano Container by using Docker.
- IoT Core now supports running Nano containers,


### Obtaining and installing the container version of Nano Server [RS3]

Visit [LINK] to download the container operating system. Detailed documentation for installing and configuring the container version of Nano Server is available at [LINK].

### What happens to your existing Nano Server deployments?

If you are already running Nano Server as a physical host computer or as a virtual guest computer (outside of a container), [SOMETHING HAPPENS EVENTUALLY].



## Related topics








