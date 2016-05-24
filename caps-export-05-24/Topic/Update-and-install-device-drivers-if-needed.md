---
title: Update and install device drivers if needed
ms.custom: na
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 16be3ef9-a05b-4621-a431-5806b567e997
---
# Update and install device drivers if needed
If you are using USB zero clients or peripherals that require drivers, you should install the drivers at this time. It’s a good idea also to check **Device Manager** for any driver alerts, and install drivers for those devices.  
  
Generally, the most current drivers are required for following types of devices:  
  
-   USB zero clients  
  
-   USB\-over\-Ethernet zero clients  
  
-   Disk controllers  
  
-   Network adapters  
  
-   Sound controllers  
  
-   USB host controllers  
  
> [!TIP]  
> If you are new to Windows Server 2012 \(or Windows 8\), see [Common Management Tasks and Navigation in Windows](../Topic/Common-Management-Tasks-and-Navigation-in-Windows.md) \(http:\/\/technet.microsoft.com\/library\/hh831491.aspx\) to find out how to open the **Start** screen and perform other common tasks.  
  
### To check for driver alerts in Device Manager  
  
1.  [Open the Start screen](http://technet.microsoft.com/library/hh831491.aspx#BKMK_start).  
  
2.  Type **computer management**, and then click **Computer Management** in the results.  
  
3.  In the Computer Management console tree, click **Device Manager**.  
  
4.  In the system devices on the right, check for driver alerts that might affect MultiPoint Server.  
  
### To install device drivers in MultiPoint Manager  
  
1.  To open MultiPoint Manager, [open the Start screen](http://technet.microsoft.com/library/hh831491.aspx#BKMK_start), type **MultiPoint Manager**, and then click **MultiPoint Manager** in the results.  
  
2.  In MultiPoint Manager, click the **Home** tab, and then click **Switch to console mode**.  
  
3.  To install a device driver, double click the driver file, and follow the instructions to install the driver.  
  
4.  Repeat the preceding step to install all required drivers.  
  
    > [!NOTE]  
    > If an installation requires a computer restart, you will need to switch back to console mode before you install the next driver. MultiPoint Server always starts in station mode. To switch to console mode, on the **Home** tab, click **Switch to console mode**.  
  
