---
title: PowerShell
description: Reference article for the PowerShell command, which opens the PowerShell console from a command prompt.
ms.topic: reference
ms.assetid: 694fc970-0b6c-4046-b1b5-7eb1a0d26609
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/11/2018
---

# PowerShell

Windows PowerShell is a task-based command-line shell and scripting language designed especially for system administration. Built on the .NET Framework, Windows PowerShell helps IT professionals and power users control and automate the administration of the Windows operating system and applications that run on Windows.

## Using PowerShell.exe

The **PowerShell.exe** command-line tool starts a Windows PowerShell session in a Command Prompt window. When you use **PowerShell.exe**, you can use its optional parameters to customize the session. For example, you can start a session that uses a particular execution policy or one that excludes a Windows PowerShell profile. Otherwise, the session is the same as any session that is started in the Windows PowerShell console.

- To start a Windows PowerShell session in a Command Prompt window, type `PowerShell`. A **PS** prefix is added to the command prompt to indicate that you are in a Windows PowerShell session.

- To start a session with a particular execution policy, use the **ExecutionPolicy** parameter, and type:

    ```powershell
    PowerShell.exe -ExecutionPolicy Restricted
    ```

- To start a Windows PowerShell session without your Windows PowerShell profiles, use the **NoProfile** parameter, and type:

    ```powershell
    PowerShell.exe -NoProfile
    ```

- To start a session , use the **ExecutionPolicy** parameter, and type:

    ```powershell
    PowerShell.exe -ExecutionPolicy Restricted
    ```

- To see the PowerShell.exe help file, type:

    ```powershell
    PowerShell.exe -help
    PowerShell.exe -?
    PowerShell.exe /?
    ```

- To end a Windows PowerShell session in a Command Prompt window, type `exit`. The typical command prompt returns.

### Remarks

- For a complete list of the **PowerShell.exe** command-line parameters, see [about_PowerShell.Exe](/powershell/module/microsoft.powershell.core/about/about_powershell_exe).

- For information about other ways to start Windows PowerShell, see [Starting Windows PowerShell](/powershell/scripting/windows-powershell/starting-windows-powershell).

- Windows PowerShell runs on the Server Core installation option of Windows Server operating systems. However, features that require a graphic user interface, such as the [Windows PowerShell Integrated Scripting Environment (ISE)](/previous-versions/hh849182(v=technet.10)), and the [Out-GridView](/powershell/module/microsoft.powershell.utility/out-gridview) and [Show-Command](/powershell/module/microsoft.powershell.utility/show-command) cmdlets, don't run on Server Core installations.

## Related links

- [about_PowerShell.Exe](/powershell/module/microsoft.powershell.core/about/about_powershell_exe)

- [about_PowerShell_Ise.exe](/powershell/module/microsoft.powershell.core/about/about_powershell_ise_exe)

- [Windows PowerShell](/powershell/)
