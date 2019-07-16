---
title: "Create the PostIC.cmd File for Running Post Initial Configuration Tasks"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 99e258bc-0695-48c9-b694-a7f3cbe2a2d0
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Create the PostIC.cmd File for Running Post Initial Configuration Tasks

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

You can add post-initial configuration customizations by writing your own code, and then calling that code from a script file named PostIC.cmd. When using the PostIC.cmd file, you must adhere to the following guidelines:  
  
- Your customization code must run silently (it cannot display a User Interface).  
  
- Your customization code cannot initiate a restart of the server. The Initial Configuration will restart the server as the last task.  
  
- Your customization code must run in three minutes or less.  
  
  Define your PostIC.cmd file to return a 0 if the code runs successfully. If any other value is returned, the operating system looks for a file named [SetupFailure.cmd](Create-the-PostIC.cmd-File-for-Running-Post-Initial-Configuration-Tasks.md#BKMK_SetupFailure), which contains code that should be run if the code in the PostIC.cmd file does not run successfully. Both the PostIC.cmd file and the SetupFailure.cmd file must be located C:\Windows\Setup\Scripts.  
  
#### To define post-initial configuration customizations  
  
1.  Write the code that is called from the PostIC.cmd script.  
  
2.  Using Notepad, create a file called PostIC.cmd and add the call to the code that you created in step 1. Ensure that your code returns a success value.  
  
3.  Save PostIC.cmd in C:\Windows\Setup\Scripts.  
  
4.  (Optional) Create a SetupFailure.cmd file which runs code if PostIC.cmd returns anything other than 0.  
  
###  <a name="BKMK_SetupFailure"></a> SetupFailure.cmd  
 You can provide notification of problems in Initial Configuration by using the SetupFailure.cmd. The SetupFailure.cmd file contains the code that you want to run if problems occur. The SetupFailure.cmd file is placed in C:\Windows\Setup\Scripts and is run when either a problem occurs with a setup task or when the PostIC.cmd file returns a value other than 0.  
  
##### To define notifications  
  
1.  Write the code that is called from the SetupFailure.cmd script.  
  
2.  Using Notepad, create a file called SetupFailure.cmd and add the call to the code that you created in step 1. Ensure that your code returns a success value.  
  
3.  Save SetupFailure.cmd in C:\Windows\Setup\Scripts.  
  
## See Also  
 [Getting Started with the Windows Server Essentials ADK](Getting-Started-with-the-Windows-Server-Essentials-ADK.md)   
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)