---
title: Increase Concurrent Authentications Processed by NPS
description: This topic provides instructions on configuring Network Policy Server concurrent authentications in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 2d9cdada-0625-41c8-8248-a32259b03e47
ms.author: lizross 
author: eross-msft
---

# Increase Concurrent Authentications Processed by NPS

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic for instructions on configuring Network Policy Server concurrent authentications.

If you installed Network Policy Server \(NPS\) on a computer other than a domain controller and the NPS is receiving a large number of authentication requests per second, you can improve NPS performance by increasing the number of concurrent authentications allowed between the NPS and the domain controller.

To do this, you must edit the following registry key: 

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`

Add a new value named **MaxConcurrentApi** and assign to it a value from 2 through 5. 

>[!CAUTION]
>If you assign a value to **MaxConcurrentApi** that is too high, your NPS might place an excessive load on your domain controller.

For more information about managing NPS, see [Manage Network Policy Server](nps-manage-top.md).

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).