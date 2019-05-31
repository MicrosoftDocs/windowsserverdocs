---
title: PowerShell_ise
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 32c41b5b-a210-47d9-bd8c-91eb9830b4f0
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# PowerShell_ise



Windows PowerShell Integrated Scripting Environment (ISE) is a graphical host application that enables you to read, write, run, debug, and test scripts and modules in a graphic-assisted environment. Key features such as IntelliSense, Show-Command, snippets, tab completion, syntax-coloring, visual debugging, and context-sensitive Help provide a rich scripting experience.

The **PowerShell_ISE.exe** tool starts a Windows PowerShell ISE session. When you use **PowerShell_ISE.exe**, you can use its optional parameters to open files in Windows PowerShell ISE or to start a Windows PowerShell ISE session with no profile or with a multithreaded apartment.

**PowerShell_ISE.exe** was introduced in Windows PowerShell 2.0 and expanded significantly in Windows PowerShell 3.0.

## Using PowerShell_ISE.exe

You can use **PowerShell_ISE.exe** to start and end a Windows PowerShell session as follows:
- To start a Windows PowerShell ISE session, in a Command Prompt window, in Windows PowerShell, or at the Start menu, type:  
  ```
  PowerShell_Ise
  ```  
- To open a script (.ps1), script module (.psm1), module manifest (.psd1), XML file, or any other supported file in Windows PowerShell ISE, use the following command format:  
  ```
  PowerShell_Ise <FilePath>
  ```  
  In Windows PowerShell 3.0, you can use the optional **File** parameter as follows:  
  ```
  PowerShell_Ise -File <FilePath>
  ```  
- To start a Windows PowerShell ISE session without your Windows PowerShell profiles, use the **NoProfile** parameter. (The **NoProfile** parameter is introduced in Windows PowerShell 3.0.)  
  ```
  PowerShell_Ise -NoProfile
  ```  
- To see the **PowerShell_ISE.exe** Help file in a Command Prompt window, use the following command format:  
  ```
  PowerShell_Ise -help, -?, /?
  ```  
  For a complete list of the **PowerShell_ISE.exe** command-line parameters, see [about_PowerShell_Ise.exe](https://go.microsoft.com/fwlink/?LinkId=256512).

## Start Windows PowerShell ISE in other ways

For information about other ways to start Windows PowerShell ISE, see [Starting Windows PowerShell](https://go.microsoft.com/fwlink/?LinkID=135259).

## Remarks

Windows PowerShell runs on the Server Core installation option of Windows Server operating systems. However, because Windows PowerShell ISE requires a graphic user interface, it does not run on Server Core installations.

## Additional references

[about_PowerShell_Ise.exe](https://go.microsoft.com/fwlink/?LinkId=256512)
[about_PowerShell.exe](https://go.microsoft.com/fwlink/?LinkID=113439)
[Windows PowerShell](https://go.microsoft.com/fwlink/?LinkID=107116)
[Scripting with Windows PowerShell](https://technet.microsoft.com/scriptcenter/dd742419)
See Also