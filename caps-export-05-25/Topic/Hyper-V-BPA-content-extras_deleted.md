---
title: Hyper-V BPA content extras_deleted
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cfacc5fd-73fc-4d49-b1e2-b5a96dbc74db
author: KBDAzure
---
# Hyper-V BPA content extras_deleted
*This topic is intended to address a specific issue identified by a Best Practices Analyzer scan. You should apply the information in this topic only to computers that have had the Hyper\-V Best Practices Analyzer run against them and are experiencing the issue addressed by this topic. For more information about best practices and scans, see* [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
## Issue  
  
> *The Hyper\-V Image Management Service is not configured to start automatically.*  
  
## Impact  
  
> *Virtual storage cannot be managed until the service is started.*  
  
When the service is not running, you cannot create, edit, or inspect virtual hard disks. However, you can add or remove existing virtual hard disks from virtual machines.  
  
## Resolution  
  
> *Use the Services snap\-in or sc config command\-line tool to reconfigure the service to start automatically.*  
  
By default, membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure.  
  
#### To reconfigure the service to start automatically using the Windows interface  
  
1.  Open the Services snap\-in. \(Click **Start**, click in the **Start Search** box, type **services.msc**, and then press ENTER.\)  
  
2.  In the details pane, right\-click **Hyper\-V Image Management Service**, and then click **Properties**.  
  
3.  On the **General** tab, in **Startup** type, click **Automatic**. To start the service, click **Start**.  
  
#### To reconfigure the service to start automatically using the command line  
  
1.  Open Command Prompt.  
  
2.  Type:  
  
    ```  
    sc config vhdsvc start=auto  
    ```  
  
3.  To start the service, type:  
  
    ```  
    sc start vhdsvc  
    ```  
  
