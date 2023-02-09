---
title: PowerShell_ise
description: Reference article for the PowerShell_ise command, which starts a Windows PowerShell Integrated Scripting Environment (ISE) session.
ms.topic: reference
ms.assetid: 32c41b5b-a210-47d9-bd8c-91eb9830b4f0
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# PowerShell_ise

Windows PowerShell Integrated Scripting Environment (ISE) is a graphical host application that enables you to read, write, run, debug, and test scripts and modules in a graphic-assisted environment. Key features such as IntelliSense, Show-Command, snippets, tab completion, syntax-coloring, visual debugging, and context-sensitive Help provide a rich scripting experience.

## Using PowerShell.exe

The **PowerShell_ISE.exe** tool starts a Windows PowerShell ISE session. When you use **PowerShell_ISE.exe**, you can use its optional parameters to open files in Windows PowerShell ISE or to start a Windows PowerShell ISE session with no profile or with a multithreaded apartment.

- To start a Windows PowerShell ISE session in a Command Prompt window, in Windows PowerShell, or at the **Start** menu, type:

  ```powershell
  PowerShell_Ise.exe
  ```

- To open a script (.ps1), script module (.psm1), module manifest (.psd1), XML file, or any other supported file in Windows PowerShell ISE, type:

  ```powershell
  PowerShell_Ise.exe <filepath>
  ```

  In Windows PowerShell 3.0, you can use the optional **File** parameter as follows:

  ```powershell
  PowerShell_Ise.exe -file <filepath>
  ```

- To start a Windows PowerShell ISE session without your Windows PowerShell profiles, use the **NoProfile** parameter. (The **NoProfile** parameter is introduced in Windows PowerShell 3.0.), type:

  ```powershell
  PowerShell_Ise.exe -NoProfile
  ```

- To see the PowerShell_ISE.exe help file, type:

    ```powershell
    PowerShell_Ise.exe -help
    PowerShell_Ise.exe -?
    PowerShell_Ise.exe /?
    ```

### Remarks

- For a complete list of the **PowerShell_ISE.exe** command-line parameters, see [about_PowerShell_Ise.Exe](/powershell/module/microsoft.powershell.core/about/about_powershell_ise_exe).

- For information about other ways to start Windows PowerShell, see [Starting Windows PowerShell](/powershell/scripting/windows-powershell/starting-windows-powershell).

- Windows PowerShell runs on the Server Core installation option of Windows Server operating systems. However, because Windows PowerShell ISE requires a graphic user interface, it does not run on Server Core installations.

## Related links

- [about_PowerShell_Ise.exe](/powershell/module/microsoft.powershell.core/about/about_powershell_exe)
