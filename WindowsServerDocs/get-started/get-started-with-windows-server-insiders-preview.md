---
title: Get started with Windows Server Insiders Preview
description: This article describes how users can become Windows Server Insiders and test Windows Server Insiders Preview.
ms.topic: article
author: xelu86
ms.author: wscontent
ms.contributor: stacycl
ms.date: 12/08/2023
ms.prod: windows-server
---

# Get started with Windows Server Insiders Preview

Join the Windows Insider Program for Windows Server and gain exclusive access to Windows Server Insider Previews and Remote Server Administration tools. By becoming a part of this community, you'll have the opportunity to help shape the future of Windows Server and be at the forefront of innovation!

## Where to get Windows Server Insiders Preview

If you're a registered Insider, you can access the [Windows Insider Preview Downloads](https://www.microsoft.com/software-download/windowsinsiderpreviewserver) page directly to view available Window Server Preview builds. If you'd like to participate as an Insider, you can refer to the [Getting started with the Windows Insider Program for Windows Server](https://www.microsoft.com/windowsinsider/for-business-getting-started-server).

The following keys are valid only for preview builds and expire on September 15, 2024:

|Windows Server Version|Key|
|-|-|
|Standard|MFY9F-XBN2F-TYFMP-CCV49-RMYVH|
|Datacenter|2KNJJ-33Y9H-2GXGX-KMQWH-G6H67|
|Azure Edition|Keys aren't accepted|

> [!NOTE]
> Downloads may be restricted in certain countries. To learn more, see [Microsoft suspends new sales in Russia](https://blogs.microsoft.com/on-the-issues/2022/03/04/microsoft-suspends-russia-sales-ukraine-conflict/).

### Insiders Preview known issues

- The new **Feedback Hub** and **Terminal** apps aren't functioning properly in this release and will be addressed in a future build.

- We advise against using this build to validate upgrades from Windows Server 2019 or 2022 due to identified intermittent upgrade failures.

- Using the `wevtutil al` command to archive event logs causes the Windows Event Log service to crash and archive operation to fail. To resolve this issue, the service must be restarted by running the following in an elevated PowerShell prompt:

  ```powershell
  Start-Service EventLog
  ```

- If you have the Secure Launch or Dynamic Root of Trust for Measurement (DRTM) code path enabled, we recommend avoiding installing this build.
