---
title: Enable all integration services in virtual machines
description: Learn what to do when one or more integration services are disabled or not working in a virtual machine.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 16e202ad-3795-40c9-8176-7ca319e56d26
ms.date: 8/16/2016
---
# Enable all integration services in virtual machines

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Best Practices Analyzer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759260(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue

*One or more integration services are disabled or not working in a virtual machine.*

## Impact

*The service or integration feature may not operate correctly for the following virtual machines:*

\<list of virtual machine names>

## Resolution

*Use the Services snap-in or sc config command-line tool to verify that the service is configured to start automatically and is not stopped.*

#### To configure how a service is started using the Services snap-in

1.  Use Remote Desktop Services or Virtual Machine Connection to connect to the virtual machine and log on to the guest operating system.

2.  Open Services. (Click **Start**, click in the **Start Search** box, type **services.msc**, and then press ENTER.)

3.  In the details pane, right-click the service that you want to configure, and then click **Properties**.

4.  On the **General** tab, in **Startup** type, click **Automatic**.

#### To configure how a service is started using SC Config

1.  Open Windows PowerShell. (From the desktop, click **Start** and start typing **Windows PowerShell**.)

2.  Right-click **Windows PowerShell** and click **Run as administrator**.

3.  Replace \<service-name> with the name of the service, then type:

    ```
    sc config <service-name> start=auto
    ```
