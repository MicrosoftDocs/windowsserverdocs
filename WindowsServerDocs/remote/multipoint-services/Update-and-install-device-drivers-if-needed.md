---
title: Update and install device drivers if needed
description: Learn how to check and update device drivers in MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 16be3ef9-a05b-4621-a431-5806b567e997
author: evaseydl
manager: scottman
ms.author: evas
---
# Update and install device drivers if needed
If you are using USB zero clients or peripherals that require drivers, you should install the drivers at this time. It's a good idea also to check **Device Manager** for any driver alerts, and install drivers for those devices.  
  
Generally, the most current drivers are required for following types of devices:  
  
-   USB zero clients  
  
-   USB-over-Ethernet zero clients  
  
-   Disk controllers  
  
-   Network adapters  
  
-   Sound controllers  
  
-   USB host controllers

-   Graphic Cards


## To check for driver alerts in Device Manager  
  
1.  Open the Start screen.  
  
2.  Type **computer management**, and then click **Computer Management** in the results.  
  
3.  In the Computer Management console tree, click **Device Manager**.  
  
4.  In the system devices on the right, check for driver alerts that might affect MultiPoint Server.  
  
## To install device drivers in MultiPoint Manager  
  
1.  To open MultiPoint Manager, search for "MultiPoint Manager," and then click **MultiPoint Manager** in the results.  
  
2.  In MultiPoint Manager, click the **Home** tab, and then click **Switch to console mode**.  
  
3.  To install a device driver, double click the driver file, and follow the instructions to install the driver.  
  
4.  Repeat the preceding step to install all required drivers.  
  
    > [!NOTE]  
    > If an installation requires a computer restart, you will need to switch back to console mode before you install the next driver. MultiPoint server always starts in station mode. To switch to console mode go to the **Home** tab in the MultiPoint Manager and click **Switch to console mode**.