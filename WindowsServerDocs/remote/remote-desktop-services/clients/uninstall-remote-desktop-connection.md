---
title: Uninstall and reinstall Remote Desktop Connection
description: Learn how to uninstall and reinstall Remote Desktop Connection.
ms.topic: article
author: heidilohr
manager: femila
ms.author: helohr
ms.date: 09/12/2023
---
# Uninstall and reinstall Remote Desktop Connection

<!--Introduction goes here-->

## Prerequisites

In order to use Remote Desktop Connection, you must use Windows 11 23H2 or later.

## Uninstall Remote Desktop Connection

To uninstall Remote Desktop Connection:

#### [Windows](#tab/windows)

1. Go to **Settings** > **Apps**.

1. Open the **Remote Desktop Connections** app.

1. Select **Options** > **Uninstall**.

1. When the prompt asking you if you want to make changes to your system appears, select **Yes**.

1. Restart your machine if the app prompts you in order to complete the installation.

When you uninstall Remote Desktop Connection, you also become unable to use the RemoteApp and Desktop Connection app in the Control Panel.

#### [Command line](#tab/command-line)

1. Open an elevated command prompt.

1. Run the following command:

  ```cmd
  mstsc /uninstall /noPromptBeforeRestart
  ```

When you run the command, it uninstalls Remote Desktop Connection from your machine, then restarts the machine if required without prompting.

> [!TIP]
> You can also run the previous command using Intune or Configuration Manager to uninstall the app at scale.

---

## Reinstall Remote Desktop Connection

After you uninstall the Remote Desktop Connection app, you can reinstall it by following these instructions:

1. Download the Remote Desktop Connection installer file. <!--Add link when available.-->

1. Open the file to run the installer, then follow all instructions in the workflow until setup is complete.
