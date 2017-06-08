---
title: PowerShell
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 694fc970-0b6c-4046-b1b5-7eb1a0d26609
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# PowerShell

> Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Windows PowerShell™ is a task-based command-line shell and scripting language designed especially for system administration. Built on the .NET Framework, Windows PowerShell helps IT professionals and power users control and automate the administration of the Windows operating system and applications that run on Windows.

The **PowerShell.exe** command-line tool starts a Windows PowerShell session in a Command Prompt window. When you use **PowerShell.exe**, you can use its optional parameters to customize the session. For example, you can start a session that uses a particular execution policy or one that excludes a Windows PowerShell profile. Otherwise, the session is the same as any session that is started in the Windows PowerShell console.

## Using PowerShell.exe

You can use the **PowerShell.exe** command-line tool to start a Windows PowerShell session in a Command Prompt window.
1.  To start a Windows PowerShell session in a Command Prompt window, type `PowerShell`. A **PS** prefix is added to the command prompt to indicate that you are in a Windows PowerShell session.
2.  To start a session with a particular execution policy, use the **ExecutionPolicy** parameter.  
    ```
    PowerShell.exe -ExecutionPolicy Restricted
    ```  
3.  To start a Windows PowerShell session without your Windows PowerShell profiles, use the **NoProfile** parameter.  
    ```
    PowerShell.exe -NoProfile
    ```  
4.  To start a session , use the **ExecutionPolicy** parameter.  
    ```
    PowerShell.exe -ExecutionPolicy Restricted
    ```  
5.  To see the PowerShell.exe help file, use the following command format.  
    ```
    PowerShell.exe -help, -?, /?
    ```  
6.  To end a Windows PowerShell session in a Command Prompt window, type `exit`. The typical command prompt returns.

For a complete list of the **PowerShell.exe** command-line parameters, see [about_PowerShell.Exe](http://go.microsoft.com/fwlink/?LinkID=113439).

## Other Ways to Start Windows PowerShell

For information about other ways to start Windows PowerShell, see [Starting Windows PowerShell](http://go.microsoft.com/fwlink/?LinkID=135259).

## Remarks

Windows PowerShell runs on the Server Core installation option of Windows Server operating systems. However, features that require a graphic user interface, such as the [Windows PowerShell Integrated Scripting Environment (ISE)](http://technet.microsoft.com/library/hh849182), and the [Out-GridView](http://go.microsoft.com/fwlink/?LinkID=113364) and [Show-Command](http://go.microsoft.com/fwlink/?LinkID=217448) cmdlets, do not run on Server Core installations.

##

[about_PowerShell.Exe](http://go.microsoft.com/fwlink/?LinkID=113439)
[about_PowerShell_Ise.exe](http://go.microsoft.com/fwlink/?LinkId=256512)
[Windows PowerShell](http://go.microsoft.com/fwlink/?LinkID=107116)
[Scripting with Windows PowerShell](http://technet.microsoft.com/scriptcenter/dd742419)
See Also