---
title: powershell
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
# powershell

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Windows powershell  is a task-based command-line shell and scripting language designed especially for system administration. Built on the .NET Framework, Windows powershell helps IT professionals and power users control and automate the administration of the Windows operating system and applications that run on Windows.
The **powershell.exe** command-line tool starts a Windows powershell session in a Command prompt window. When you use **powershell.exe**, you can use its optional parameters to customize the session. for example, you can start a session that uses a particular execution policy or one that excludes a Windows powershell profile. Otherwise, the session is the same as any session that is started in the Windows powershell console.
## Using powershell.exe
You can use the **powershell.exe** command-line tool to start a Windows powershell session in a Command prompt window.
1.  To start a Windows powershell session in a Command prompt window, type `powershell`. A **PS** prefix is added to the command prompt to indicate that you are in a Windows powershell session.
2.  To start a session with a particular execution policy, use the **executionPolicy** parameter.
    ```
    powershell.exe -executionPolicy Restricted
    ```
3.  To start a Windows powershell session without your Windows powershell profiles, use the **NoProfile** parameter.
    ```
    powershell.exe -NoProfile
    ```
4.  To start a session , use the **executionPolicy** parameter.
    ```
    powershell.exe -executionPolicy Restricted
    ```
5.  To see the powershell.exe help file, use the following command format.
    ```
    powershell.exe -help, -?, /?
    ```
6.  To end a Windows powershell session in a Command prompt window, type `exit`. The typical command prompt returns.
for a complete list of the **powershell.exe** command-line parameters, see [about_powershell.Exe](http://go.microsoft.com/fwlink/?LinkID=113439).
## Other Ways to start Windows powershell
for information about other ways to start Windows powershell, see [starting Windows powershell](http://go.microsoft.com/fwlink/?LinkID=135259).
## remarks
Windows powershell runs on the Server Core installation option of Windows Server operating systems. However, features that require a graphic user interface, such as the [Windows powershell Integrated Scripting Environment (ISE)](http://technet.microsoft.com/library/hh849182), and the [Out-GridView](http://go.microsoft.com/fwlink/?LinkID=113364) and [Show-Command](http://go.microsoft.com/fwlink/?LinkID=217448) cmdlets, do not run on Server Core installations.
## See Also
[about_powershell.Exe](http://go.microsoft.com/fwlink/?LinkID=113439)
[about_powershell_ise.exe](http://go.microsoft.com/fwlink/?LinkId=256512)
[Windows powershell](http://go.microsoft.com/fwlink/?LinkID=107116)
[Scripting with Windows powershell](http://technet.microsoft.com/scriptcenter/dd742419)
