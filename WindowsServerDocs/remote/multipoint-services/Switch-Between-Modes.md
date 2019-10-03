---
title: Switch Between Modes
description: Learn how to switch between station and console mode in MultiPoint Services
ms.custom: na
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5f1b2324-c1b0-4b61-ab51-39af15e7792a
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 08/04/2016
---
# Switch Between Modes
MultiPoint Manager includes the following modes to help you perform different types of MultiPoint Services system management:  
  
-   *Station mode*: By default, the MultiPoint Services system starts in station mode. While in station mode, the MultiPoint Services stations behave as if each station is a separate computer that is running Windows, and multiple users can use the system at the same time. You and your users can share files and perform the work that you must do.  
  
-   *Console mode*: When the MultiPoint Services system is in console mode, you can install and update software and drivers or perform other maintenance tasks. When the system is in console mode, no *stations* are available for use by other computer users. Such stations are not displayed in MultiPoint Manager. All monitors directly connected to the server are treated as displays of this computer system.   
  
> [!NOTE]
> You can enforce the system starting in Console mode by changing the default in the settings for the server.  
> ## To switch from station mode to console mode  
  
1.  Open MultiPoint Manager in station mode, and then click the **Home** tab.  
  
2.  In the **Computer** column, click the computer for which you want to change modes.  
  
3.  Under *computer name* **Tasks**, click **Switch to console mode**. The computer restarts and all stations become unavailable.  
  
## To switch from console mode to station mode  
  
1.  Open MultiPoint Manager in console mode, and then click the **Home** tab.  
  
2.  In the **Computer** column, click the computer for which you want to change modes.  
  
3.  Under *computer name* **Tasks**, click **Switch to station mode**. The computer restarts and all stations become available.  
  
## See Also  
[Manage System Tasks Using MultiPoint Manager](Manage-System-Tasks-Using-MultiPoint-Manager.md)