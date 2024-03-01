---
title: Get started with Windows Server Insiders Preview
description: This article describes how users can become Windows Server Insiders members and test Windows Server Insiders Preview release builds.
ms.topic: article
author: xelu86
ms.author: wscontent
ms.contributor: stacycl
ms.date: 01/23/2024
---

# Get started with Windows Server Insiders Preview

Join the Windows Insider Program for Windows Server and gain exclusive access to Windows Server Insider Previews and Remote Server Administration tools. By becoming a part of this community, you'll have the opportunity to help shape the future of Windows Server and be at the forefront of innovation!

## Where to get Windows Server Insiders Preview

If you're a registered Insider, you can access the [Windows Insider Preview Downloads](https://www.microsoft.com/en-us/software-download/windowsinsiderpreviewserver) page directly to view available Window Server Preview builds. If you'd like to participate as an Insider, you can refer to the [Getting started with the Windows Insider Program for Windows Server](https://www.microsoft.com/windowsinsider/for-business-getting-started-server).

The following keys are valid only for preview builds and expire on September 15, 2024:

|Windows Server Version|Key|
|-|-|
|Standard|MFY9F-XBN2F-TYFMP-CCV49-RMYVH|
|Datacenter|2KNJJ-33Y9H-2GXGX-KMQWH-G6H67|
|Azure Edition|Keys aren't accepted|

> [!NOTE]
> Downloads may be restricted in certain countries. To learn more, see [Microsoft suspends new sales in Russia](https://blogs.microsoft.com/on-the-issues/2022/03/04/microsoft-suspends-russia-sales-ukraine-conflict/).

## Insiders Preview known issues

- During the OOBE install process, some users notice overlapping windows or graphics anomalies when using the mouse to proceed to the next step.

- First sign-in user privacy settings are limited where all features aren't available nor function as desired.

- Installing the **WinPE-Powershell** optional component via any method doesn't install properly and related cmdlets fail. Customers who are dependent on PowerShell in WinPE shouldn't use this build.

- The new **Feedback Hub** and **Terminal** apps aren't functioning properly in this release.

- We advise against using this build to validate upgrades from Windows Server 2019 or 2022 due to identified intermittent upgrade failures.

- Using the `wevtutil al` command to archive event logs causes the Windows Event Log service to crash and archive operation to fail. To resolve this issue, the service must be restarted by running the following in an elevated PowerShell prompt:

  ```powershell
  Start-Service EventLog
  ```

- If you have the Secure Launch or Dynamic Root of Trust for Measurement (DRTM) code path enabled, we recommend avoiding installing this build.

## How to provide feedback for Insiders Preview

Your feedback is valuable to us as it provides insight to what is currently working, capturing bugs, and suggestions of where improvements can be made. To learn how to provide feedback, see [Deeper look at feedback](/windows-insider/feedback).

Use your registered Windows 10 or Windows 11 device and open the [Feedback Hub](https://aka.ms/WIPFeedbackHub) app. In the Feedback Hub app, provide us:

1. A title about the issue with the preview build number. Example, _Server Manager Issue in Windows Server Standard 25997_.
1. A detailed explanation of what is occurring.
1. For the **Category**, select **Windows Server**.
1. Attaching a screenshot of the issue is optional.
1. Complete submitting your feedback.

## See also

- [What's new in Windows Server Insiders Preview](whats-new-windows-server-insiders-preview.md)
- [Explore the Feedback Hub](/windows-insider/feedback-hub/feedback-hub-app)
