---
title: Enable file sharing
description: Learn about file sharing in MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 508ad056-8e0c-4d59-a4fa-05775a54125d
author: evaseydl
ms.author: evas    
manager: Scottman
---
# Enable file sharing in MultiPoint Services
You can allow users on your MultiPoint stations to share files in two ways:  
  
-   **If you have a file server on the network,** it is recommended that you create a shared folder on the file server.  
  
-   **If you have a small network of 2-3 MultiPoint servers, with no dedicated file server,** one of the MultiPoint servers can act as the file server for all the remaining computers running MultiPoint services. Create a shared folder on that server, and then create local user accounts for all users on that server. The shared folder can be on the original internal drive, or you can attach additional internal or external drives to the computer.  
  
