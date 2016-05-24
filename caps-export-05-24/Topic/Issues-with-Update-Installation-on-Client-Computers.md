---
title: Issues with Update Installation on Client Computers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b5e15b9f-34c3-4a6c-8f15-1f6898aceec0
author: britw
---
# Issues with Update Installation on Client Computers
If WSUS client computers are not installing updates, there may be issues with the DCOM configuration. You will see event ID 10311 or 10312 in the application log if this is the case.  
  
## Troubleshooting update installation issues  
  
#### Check the DCOM configuration  
  
###### To check the DCOM configuration  
  
1.  Open a Command Prompt window.  
  
2.  Type the following command: **dcomcnfg**.  
    The **Component Services** window will appear.  
  
3.  In the left pane under Console Root, expand Component Services, expand Compoters, right\-click **My Computer**, and then click **Properties**.  
  
4.  Click the **Default Properties** tab.  
  
5.  Make sure that **EnableDistributed COM on this computer** is selected.  
  
6.  Make sure that **Default Impersonation Level** is set to **Identify**.  
  
7.  Click **OK**, and then close the **Component Services** window.  
  
#### Remove default DCOM permissions  
Default DCOM permissions can also be a source of problems.  
  
###### To remove default DCOM permissions  
  
1.  Open the **Registry Editor**.  
  
2.  Navigate to HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Ole.  
  
3.  If there is a **DefaultAccessPermission** key, delete it.  
  
