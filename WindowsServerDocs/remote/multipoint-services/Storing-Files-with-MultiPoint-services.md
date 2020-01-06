---
title: Storing Files with MultiPoint Services
description: Learn about file storage in MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c9eb0461-3846-4ddc-97ff-de10f03f30cf
author: evaseydl
manager: scottman
ms.author: evas
---
# Storing Files with MultiPoint Services
MultiPoint Services supports storing user files in the following ways:  
  
-   **On the operating system partition of the hard disk drive.** By default, MultiPoint Services stores user files on the hard disk drive with the operating system.  
  
-   **On a separate partition of the hard disk drive.** When the MultiPoint Services system is set up for the first time, you can *partition* the hard disk drive. That is, you can configure a section of the drive so that it functions as if it were a separate drive. This makes it easier to restore or upgrade the operating system without affecting user files. For more information, see [Create a partition or logical drive](https://go.microsoft.com/fwlink/?LinkId=182618) in the Windows Server Technical Library.  
  
-   **On an additional internal or external hard disk drive.** You can attach additional internal or external hard disk drives to MultiPoint Services for saving and backing up data.  
  
-   **In a shared network folder.** To make user files available from any station, you can create a shared folder on the network. This requires another computer or server in addition to the computer running MultiPoint Services. This is the recommended method for storing files if there is a file server available.  
  
    For small systems of 2-3 computers running MultiPoint Services with no file server available, one of the MultiPoint Services computers can act as the file server for all of the MultiPoint Services computers. You would then create user accounts for all users on the MultiPoint Services that is acting as the file server.  
  
