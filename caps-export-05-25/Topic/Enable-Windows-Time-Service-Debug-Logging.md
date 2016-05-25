---
title: Enable Windows Time Service Debug Logging
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b7662537-d996-4168-8b45-69a86f6a1b45
author: Femila
---
# Enable Windows Time Service Debug Logging
  You can use this procedure to enable Windows Time service \(W32time\) debug logging when you need more information to solve a problem with Windows Time service configuration.  
  
 Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure locally. Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure remotely. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To enable Windows Time Service debug logging  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  Create a folder to receive the Windows Time service log file. For example, in the command prompt window, type `md c:\W32Time`, and then press ENTER. This command creates a directory named W32Time on the C: drive.  
  
3.  To enable Windows Time service debug logging, at the command prompt, type the following command, and then press ENTER:  
  
    ```  
    w32tm /debug /enable /file:c:\W32Time\w32time.log /size:10000000 /entries:0-116  
    ```  
  
  