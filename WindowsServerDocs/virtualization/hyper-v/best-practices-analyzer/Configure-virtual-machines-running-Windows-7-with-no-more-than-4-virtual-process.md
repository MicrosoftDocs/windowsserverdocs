---
title: Configure virtual machines running Windows 7 with no more than 4 virtual processors
description: Learn what to do when a virtual machine running Windows 7 is configured with more than 4 virtual processors.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 8fcf0868-b543-4f94-aee7-35324346da55
ms.date: 8/16/2016
---
# Configure virtual machines running Windows 7 with no more than 4 virtual processors

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Error|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## **Issue**
*A virtual machine running Windows 7 is configured with more than 4 virtual processors.*

## **Impact**
*Microsoft does not support the configuration of the following virtual machines:*

\<list of virtual machines>

## **Resolution**
*Shut down the virtual machine and remove one or more virtual processors.*

#### To remove virtual processors

1.  Open Hyper-V Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper-V Manager**.

2.  In the results pane, under **Virtual Machines**, select the virtual machine that you want to configure. The state of the virtual machine should be listed as **Off**. If it is not, right-click the virtual machine and then click **Shut Down**.

3.  In the **Action** pane, under the virtual machine name, click **Settings**.

4.  In the navigation pane, click **Processor**.

5.  On the **Processor** page, set the number of processors to **3** or less, and then click **OK**.
