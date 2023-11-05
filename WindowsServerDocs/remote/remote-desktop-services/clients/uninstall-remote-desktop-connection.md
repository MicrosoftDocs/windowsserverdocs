---
title: Uninstall and reinstall Remote Desktop Connection
description: Learn how to uninstall and reinstall Remote Desktop Connection.
ms.topic: article
author: heidilohr
manager: femila
ms.author: helohr
ms.date: 09/21/2023
---
# Uninstall and reinstall Remote Desktop Connection

You can now uninstall the built-in Remote Desktop Connection app from the Windows operating system. This article shows not only how to uninstall the app, but also how to reinstall it should you change your mind about removing it later.

> [!IMPORTANT]
> When you uninstall Remote Desktop Connection, you also become unable to use the *RemoteApp and Desktop Connections* control panel.

## Prerequisites

In order to uninstall and reinstall Remote Desktop Connection, you must use Windows 11 23H2 or later.

## Uninstall Remote Desktop Connection

To uninstall Remote Desktop Connection:

#### [GUI](#tab/gui)

1. From the Start menu, search for the **Settings** app and open it.

1. Select **Apps**, then select **Installed apps**.

1. Find or search for **Remote Desktop Connection**, select the three dots to the right-hand side, then select **Uninstall**.

1. Confirm you want to uninstall the app by selecting **Uninstall**.

1. Restart your machine if the app prompts you in order to complete the installation.

#### [Command prompt](#tab/command-prompt)

1. Open an elevated command prompt.

1. Run the following command:

   ```cmd
   mstsc /uninstall /noPromptBeforeRestart
   ```

When you run the command, it uninstalls Remote Desktop Connection from your machine, then restarts the machine if necessary without prompting.

>[!IMPORTANT]
>Because this command doesn't prompt you before restarting your machine, make sure you've saved your work before you run it.

> [!TIP]
> You can also run the previous command using Intune or Configuration Manager to uninstall the app at scale.

---

## Reinstall Remote Desktop Connection

After you uninstall the Remote Desktop Connection app, you can reinstall it by following these instructions:

1. Download the Remote Desktop Connection installer file.

   - [Windows 64-bit](https://go.microsoft.com/fwlink/?linkid=2247659) *(most common)*
   - [Windows 32-bit](https://go.microsoft.com/fwlink/?linkid=2247660)
   - [Windows ARM64](https://go.microsoft.com/fwlink/?linkid=2247577)

1. Open the file to run the installer, then follow all instructions in the workflow until setup is complete.
