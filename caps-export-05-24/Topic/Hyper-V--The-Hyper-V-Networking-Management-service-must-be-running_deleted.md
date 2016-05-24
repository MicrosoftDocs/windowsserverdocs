---
title: Hyper-V: The Hyper-V Networking Management service must be running_deleted
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2ab4444c-8d4e-4229-ba9a-7403ea751c43
author: KBDAzure
---
# Hyper-V: The Hyper-V Networking Management service must be running_deleted
*\[This information is preliminary and subject to change.\]*  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or <br />              [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Error|  
|**Category**|Prerequisites|  
  
## Issue  
  
> *The service required to manage virtual networks is not running.*  
  
## Impact  
  
> *No virtual network management operations can be performed.*  
  
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
  
