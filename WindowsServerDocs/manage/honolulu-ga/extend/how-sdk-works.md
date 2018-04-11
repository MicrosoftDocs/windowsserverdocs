---
title: How Extensibility and SDK works in Windows Admin Center
description: How Extensibility and SDK works in Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/05/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---
# How Extensibility and SDK works in Windows Admin Center

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

Windows Admin Center comes with a diverse set of management tools built in, and it can be extended to even more management scenarios via extensions. 

Extensions are authored by both Microsoft and (in the future) third parties, and will be available to download from the Windows Admin Center Extension Store. By authoring an extension with the Windows Admin Center SDK and submitting it to the Windows Admin Center team for approval and display in the Windows Admin Center Extension Store, customers will be able to download and install extensions into their locally deployed instances of Windows Admin Center.

Windows Admin Center contains three main extensibility points: 
- Tools
- Solutions
- Gateway API extensions

Building a tool extension allows you to plug your functionality into existing solutions. Building a solution extension allows you to customize the connection type and tool list. Building a gateway API extension allows you to build additional capability at the gateway, such as custom REST endpoints.