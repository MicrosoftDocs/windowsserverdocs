---
title: Customize Sign Up for Microsoft Online Backup Service task
ms.custom: na
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a7eafbb3-7728-487e-b287-90bbd6fee7f0
---
# Customize Sign Up for Microsoft Online Backup Service task
By default, the **Sign up for Microsoft Online Backup Service** task on the **DEVICES** tab of the Dashboard opens the Microsoft Online Backup Service website. The website provides information about the service, and helps you subscribe to the service and download the required software.  
  
You can customize the **Sign up for Microsoft Online Backup Service** task in two ways:  
  
-   You can replace the URL for the default website with a URL that represents a custom user experience. To replace the default URL, open Registry Editor, create the registry key: **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows Server\\OnlineBackup\\LinkUrl**, and then assign the custom URL as the value for the key.  
  
-   You can hide the task. To hide the task, open Registry Editor and create the registry key: **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows Server\\OnlineBackup\\OnlineBackupInstalled**.  
  
## See Also  
[Creating and Customizing the Image](../Topic/Creating-and-Customizing-the-Image.md)  
[Additional Customizations](../Topic/Additional-Customizations.md)  
[Preparing the Image for Deployment](../Topic/Preparing-the-Image-for-Deployment.md)  
[Testing the Customer Experience](../Topic/Testing-the-Customer-Experience.md)  
  
