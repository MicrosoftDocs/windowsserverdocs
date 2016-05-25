---
title: Hyper-V: The Hyper-V Networking Management service should be configured to start automatically_deleted
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1b08a73c-b29d-4691-9046-4a68fff705f2
author: KBDAzure
---
# Hyper-V: The Hyper-V Networking Management service should be configured to start automatically_deleted
\[This information is preliminary and subject to change.\]  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
## Issue  
  
> *The Hyper\-V Networking Management Service is not configured to start automatically.*  
  
## Impact  
  
> *Virtual networks cannot be managed until the service is started.*  
  
When the service is not running, you cannot add, delete, or modify virtual networks. You also cannot modify the networking properties of any virtual machines on this server.  
  
## Resolution  
  
> *Use the Services snap\-in or sc config command\-line tool to reconfigure the service to start automatically.*  
  
By default, membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure.  
  
#### To reconfigure the service to start automatically using the Windows interface  
  
1.  Open the Services snap\-in. \(Click **Start**, click in the **Start Search** box, type **services.msc**, and then press ENTER.\)  
  
2.  In the details pane, right\-click **Hyper\-V Networking Management Service**, and then click **Properties**.  
  
3.  On the **General** tab, in **Startup** type, click **Automatic**. To start the service, click **Start**.  
  
#### To reconfigure the service to start automatically using the command line  
  
1.  Open Command Prompt.  
  
2.  Type:  
  
    ```  
    sc config nvspwmi start=auto  
    ```  
  
3.  To start the service, type:  
  
    ```  
    sc start nvspwmi  
    ```  
  
