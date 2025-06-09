---
title: Uninstall and Reinstall the Remote Desktop Connection App in Windows
description: Learn how to uninstall and reinstall the Remote Desktop Connection app in Windows 11. Follow step-by-step instructions to manage this built-in app.
ms.topic: how-to
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 06/05/2025
---

# Uninstall and reinstall the built-in Remote Desktop Connection app in Windows

Remote Desktop Connection is a built-in Windows app that allows you to connect remotely to other computers. Starting with Windows 11 version 23H2, you can uninstall this app if you no longer need it. This article provides step-by-step instructions on how to uninstall the Remote Desktop Connection app and how to reinstall it later if necessary.

Here's a screenshot of the Remote Desktop Connection app that comes preinstalled in Windows:

:::image type="content" source="../media/remote-desktop-connection-app.png" alt-text="A screenshot of the Remote Desktop Connection app comes preinstalled in Windows.":::

> [!IMPORTANT]
> When you uninstall Remote Desktop Connection, you also become unable to use the **RemoteApp and Desktop Connections** control panel.

## Prerequisites

Before you can uninstall Remote Desktop Connection, you must meet the following prerequisites:

- A computer running Windows 11 23H2 or later.

- You must use an account that has administrator privileges on the computer where you want to uninstall the app.

## Uninstall the Remote Desktop Connection app

Select one of the following tabs to see how to uninstall the Remote Desktop Connection app using either the graphical user interface (GUI) or the command prompt.

# [GUI](#tab/gui)

To uninstall the Remote Desktop Connection app using the GUI:

1. Open the Start menu, then type **Installed apps**. Select the matching system settings entry in the search results to open the **Installed apps** settings page.

1. Find or search for **Remote Desktop Connection**, select the three dots to the right-hand side, then select **Uninstall**.

1. Confirm you want to uninstall the app by selecting **Uninstall**.

1. When prompted, restart your computer to complete the installation.

# [Command Prompt](#tab/command-prompt)

To uninstall the Remote Desktop Connection app using the Command Prompt:

1. Open Command Prompt as an administrator. You can use Windows Terminal with a Command Prompt profile.

1. Run the following command to uninstall the Remote Desktop Connection app from your computer:

   ```cmd
   mstsc.exe /uninstall
   ```

   If you see an error with the code `0x800704c7`, it means that you're not running the command as an administrator. Make sure to run Command Prompt with elevated privileges.

1. When prompted, restart your computer to complete the installation.

> [!TIP]
> You can also add the parameter `/noPromptBeforeRestart` to the end of the command to restart without prompting. This extra parameter can be helpful if you use an enterprise management tool such as Microsoft Intune or Configuration Manager to uninstall the Remote Desktop Connection app at scale.

---

## Reinstall the Remote Desktop Connection app

After you uninstall the Remote Desktop Connection app, you can reinstall it by following these instructions:

# [GUI](#tab/gui)

To reinstall the Remote Desktop Connection app using the GUI:

1. Download the installer for the Remote Desktop Connection app from the following links and save it somewhere you can remember. Select the version that matches your computer's architecture:

   - [Windows 64-bit](https://go.microsoft.com/fwlink/?linkid=2247659) *(most common)*
   - [Windows 32-bit](https://go.microsoft.com/fwlink/?linkid=2247660)
   - [Windows ARM64](https://go.microsoft.com/fwlink/?linkid=2247577)

1. Open the folder where you downloaded the installer, then double-click the file to run the installer. The installer completes without any user interaction.

1. Once the installation is complete, you get the confirmation message **Remote Desktop Connection was successfully installed**.

   :::image type="content" source="../media/remote-desktop-connection-app-installed.png" alt-text="A screenshot showing the confirmation message that the Remote Desktop Connection app installed successfully.":::

1. Open the Start menu, then type **Remote Desktop Connection** to find and launch the app.

# [Command prompt](#tab/command-prompt)

To reinstall the Remote Desktop Connection app using the Command Prompt:

1. Open Command Prompt as an administrator. You can use Windows Terminal with a Command Prompt profile.

1. Change to the directory where you saved the installer for the Remote Desktop Connection app.

1. Run the following command to install the Remote Desktop Connection app:

   ```cmd
   mstsc-x64-setup.exe
   ```

1. When the installation completes, you get the confirmation message **Remote Desktop Connection was successfully installed**.

1. Run the following command to launch the Remote Desktop Connection app. Alternatively, you can open the Start menu and type **Remote Desktop Connection** to find and launch the app.

   ```cmd
   mstsc.exe
   ```

---
