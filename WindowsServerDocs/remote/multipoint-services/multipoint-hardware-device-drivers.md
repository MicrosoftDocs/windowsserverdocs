---
title: Collect hardware and device drivers needed for the installation
description: Information about drivers you need to install for MultiPoint Services
ms.custom: na
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4cf5fdbe-b871-4360-b003-d65ac43b491e
author: evaseydl
manager: scottman
ms.author: evas
ms.date: 08/04/2016
---
# Collect hardware and device drivers needed for the installation
Before you start deploying your MultiPoint Services system, you will need:  
  
-   **Hardware components for the server** - Install any additional video cards or other system components at this time.  
  
-   **Hardware components for the stations** - For information about planning stations for your environment, see [Selecting Hardware for Your MultiPoint Services System](Selecting-Hardware-for-Your-MultiPoint-services-System.md).
-   **The latest drivers for your video cards** - If your OEM or device manufacturer did not supply these, you will need to download them from the device manufacturer's website.  
  
-   **The latest USB zero client drivers** - If you are using USB zero client stations, you must install the latest USB zero client drivers.  
  
    > [!IMPORTANT]  
    > For a MultiPoint Services installation, you must install the 64-bit version of any drivers.  
  
> [!TIP]  
> If you are installing MultiPoint Services on a computer with a different version of Windows already installed, you should find out the video card make and model in Device Manager before you start the Windows Server installation and ensure you can get drivers which are available for Windows Server 2016. Open Device Manager, open **Computer Management** from the **Start** screen. Then, in the console tree, click **Device Manager**.