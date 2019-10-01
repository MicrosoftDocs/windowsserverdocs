---
title: mmc
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7bfa4030-ce42-40fb-922f-2f5145a80872
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# mmc

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Using mmc command-line options, you can open a specific **mmc** console, open **mmc** in author mode, or specify that the 32-bit or 64-bit version of **mmc** is opened.
## Syntax
```
mmc <path>\<filename>.msc [/a] [/64] [/32]
```
### Parameters

|       Parameter        |                                                                                                 Description                                                                                                 |
|------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <path>\\<filename>.msc |        starts **mmc** and opens a saved console. You need to specify the complete path and file name for the saved console file. If you do not specify a console file, **mmc** opens a new console.         |
|           /a           |                                                               Opens a saved console in author mode.  Used to make changes to saved consoles.                                                                |
|          /64           |                         Opens the 64-bit version of **mmc** (mmc64). Use this option only if you are running a Microsoft 64-bit operating system and want to use a 64-bit snap-in.                          |
|          /32           | Opens the 32-bit version of **mmc** (mmc32). When running a Microsoft 64-bit operating system, you can run 32-bit snap-ins by opening mmc with this command-line option when you have 32-bit only snap-ins. |
|           /?           |                                                                                    Displays help at the command prompt.                                                                                     |

## Remarks
- Using the <path>**\\**<filename>**.msc** command-line option
  You can use environment variables to create command lines or shortcuts that do not depend on the explicit location of console files. For instance, if the path to a console file is in the system folder (for example, **mmc c:\winnt\system32\console_name.msc**), you can use the expandable data string **%systemroot%** to specify the location (**mmc%systemroot%\system32\console_name.msc**). This may be useful if you are delegating tasks to people in your organization who are working on different computers.
- Using the **/a** command-line option
  When consoles are opened with this option, they are opened in author mode, regardless of their default mode. This does not permanently change the default mode setting for files; when you omit this option, mmc opens console files according to their default mode settings.
- After you open **mmc** or a console file in author mode, you can open any existing console by clicking **Open** on the **Console** menu.
- You can use the command line to create shortcuts for opening **mmc** and saved consoles. A command-line command works with the **Run** command on the **start** menu, in any command-prompt window, in shortcuts, or in any batch file or program that calls the command.
  ## additional references
- [Command-Line Syntax Key](command-line-syntax-key.md)

