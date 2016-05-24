---
title: Configure virtual machines running Windows Vista with 1 or 2 virtual processors
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e562bce3-fd68-42c9-821c-12022ae4746c
author: KBDAzure
---
# Configure virtual machines running Windows Vista with 1 or 2 virtual processors
\[This information is preliminary and subject to change.\]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2_md](/Token/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Configuration|  
|**Category**|Error|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
  
*A virtual machine running Windows Vista is configured with more than 2 virtual processors.*  
  
## Impact  
  
*Microsoft does not support the configuration of the following virtual machines:*  
  
\<list of virtual machine names>  
  
## Resolution  
  
*Shut down the virtual machine and remove one or more virtual processors.*  
  
### To remove virtual processors  
  
1.  Open [!INCLUDE[nextref_virtualname](../Token/nextref_virtualname_md.md)] Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper\-V Manager**.  
  
2.  In the results pane, under **Virtual Machines**, select the virtual machine that you want to configure. The state of the virtual machine should be listed as **Off**. If it is not, right\-click the virtual machine and then click **Shut Down**.  
  
3.  In the **Action** pane, under the virtual machine name, click **Settings**.  
  
4.  In the navigation pane, click **Processor**.  
  
5.  On the **Processor** page, set the number of processors to **1** or **2** and then click **OK**.  
  
