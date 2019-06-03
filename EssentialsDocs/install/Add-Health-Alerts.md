---
title: "Add Health Alerts"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 270e0aac-dc42-46f3-a20b-a68ffbded06d
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Add Health Alerts

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

A health add-in provides definitions for alerts, health checks, and repairs for network problems. A health add-in consists of xml files that annotate code or data that is used to evaluate health information for a specific feature. Health add-ins are created by developers and installed on the server and client computers by the administrator.  
  
 Please refer to the [Windows Server Solutions SDK](https://go.microsoft.com/fwlink/?LinkID=248648) for details about creating a health add-in.  
  
## Installing health add-in files  
 After the developer has created the xml files, you must place a copy of the files in the appropriate location on the server and client computers.  
  
#### To install the xml files on the server  
  
1. In the **%ProgramFiles%\Windows Server\Bin\Feature Definitions** folder, create a new folder named **MyHealthAddIn**. You can give this folder any name. It is suggested that the name of the folder be the same as the feature name.  
  
2. Copy the Definition.xml and the Definition.xml.config files to the new folder.  
  
3. If you created binary files for conditions or actions, you should also copy those files to **%ProgramFiles%\Windows Server\Bin**.  
  
   Client computers run a scheduled task every 6 hours that pulls the XML files to the appropriate location. You can force the synchronization between the client computer and the server by manually running the task.  
  
#### To install the xml files on the client computer  
  
1.  Open Task Scheduler.  
  
2.  Run the **HealthDefintionUpdateTask** in Task Scheduler.  
  
    > [!NOTE]
    >  This task does not install binary files. You must manually copy the binary files to the **%ProgramFiles%\Windows Server\Bin** folder on the client computer.  
  
## See Also  
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)