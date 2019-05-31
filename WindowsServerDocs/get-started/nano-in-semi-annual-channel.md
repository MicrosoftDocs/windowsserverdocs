---
title: Changes to Nano Server in Windows Server Semi-Annual Channel
description: In the new Windows Server servicing model, Nano Server is a container operating system only, with certain feature changes.
ms.prod: Windows Server
ms.mktglfcycl: manage
ms.sitesec: library
author: jasongerend
ms.author: jgerend
ms.localizationpriority: medium
ms.date: 05/21/2019
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: a270334d-42a7-46ff-8eed-d8656a276544
---
# Changes to Nano Server in Windows Server Semi-Annual Channel

>Applies To: Windows Server, Semi-Annual Channel

If you're already running Nano Server, the [Window Server Semi-Annual Channel](../get-started-19/servicing-channels-19.md) servicing model will be familiar, since it was formerly serviced by the Current Branch for Business (CBB) model. Windows Server Semi-Annual Channel is just a new name for the same model. In this model, feature update releases of Nano Server are expected two to three times per year.

However, starting with Windows Server, version 1803, Nano Server is available only as a **container base OS image**. You must run it as a container in a container host, such as a Server Core installation of Windows Server. Running a container based on Nano Server in this release differs from earlier releases in these ways:

- Nano Server has been optimized for .NET Core applications.
- Nano Server is even smaller than the Windows Server 2016 version.
- PowerShell Core, .NET Core, and WMI are no longer included by default, but you can include [PowerShell Core](https://hub.docker.com/r/microsoft/powershell/) and [.NET Core](https://hub.docker.com/r/microsoft/dotnet/) container packages when building your container.
- There is no longer a servicing stack included in Nano Server. Microsoft publishes an updated Nano container to Docker Hub that you redeploy.
- You troubleshoot the new Nano Container by using Docker.
- You can now run Nano containers on IoT Core.

## Related topics

- [Windows Container Documentation](http://aka.ms/windowscontainers)
- [Window Server Semi-Annual Channel Overview](../get-started-19/servicing-channels-19.md)
