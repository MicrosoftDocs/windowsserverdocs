---
title: The Hyper-V Virtual Machine Management service should be configured to start automatically
description: "Gives instructions to resolve the issue reported by this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 222bbe76-c514-4a3f-b61b-860a4dc2826a
author: KBDAzure
ms.date: 8/16/2016
---
# The Hyper-V Virtual Machine Management service should be configured to start automatically

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Best Practices Analyzer](https://go.microsoft.com/fwlink/?LinkId=122786).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue  
  
*The Hyper-V Virtual Machine Management Service is not configured to start automatically.*  
  
## Impact  
  
*Virtual machines cannot be managed until the service is started.*  
  
Virtual machines that are running will continue to run. However, you won't be able to manage virtual machines, or create or delete them until the service is running.  
  
## Resolution  
  
*Use the Services snap-in or sc config command-line tool to reconfigure the service to start automatically.*  
  
> [!TIP]  
> If you can't find the service in the desktop app or the command-line tool reports that the service doesn't exist, the Hyper-V Management tools probably aren't installed. To install them:  
>   
> - On Windows Server, open Server Manager and use the Add Roles and Features wizard. For more details, see [Install the Hyper-V role on Windows Server 2016](../get-started/Install-the-Hyper-V-role-on-Windows-Server.md).  
> - On Windows, from the Desktop, begin typing **programs**, click **Programs and Features** (Control panel) > **Turn Windows features on or off** > **Hyper-V** > **Hyper-V Management Tools**. Then, click **OK**.  
  
#### To reconfigure the service to start automatically using the Services desktop app  
  
1.  Open the Services desktop app. (Click **Start**, click in the search box, start typing **Services**, and then click Services in the list of results.  
  
2.  In the details pane, right-click **Hyper-V Virtual Machine Management**, and then click **Properties**.  
  
3.  On the **General** tab, in **Startup** type, click **Automatic**.  
  
#### To reconfigure the service to start automatically using the SC Config command  
  
1.  Open Windows PowerShell.  
  
2.  Type:  
  
    ```  
    set-service  vmms -startuptype automatic  
    ```  
  
3.  If the service isn't already running, type:  
  
    ```  
    start-service -name vmms  
    ```  
  


