---
title: powershell-ise
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 32c41b5b-a210-47d9-bd8c-91eb9830b4f0
---
# powershell-ise
Windows powershell Integrated Scripting Environment \(ISE\) is a graphical host application that enables you to read, write, run, debug, and test scripts and modules in a graphic\-assisted environment. Key features such as IntelliSense, Show\-Command, snippets, tab completion, syntax\-coloring, visual debugging, and context\-sensitive help provide a rich scripting experience.

The **powershell\_ISE.exe** tool starts a Windows powershell ISE session. When you use **powershell\_ISE.exe**, you can use its optional parameters to open files in Windows powershell ISE or to start a Windows powershell ISE session with no profile or with a multithreaded apartment.

**powershell\_ISE.exe** was introduced in Windows powershell 2.0 and expanded significantly in Windows powershell 3.0.

## Using powershell\_ISE.exe
You can use **powershell\_ISE.exe** to start and end a Windows powershell session as follows:

-   To start a Windows powershell ISE session, in a Command prompt window, in Windows powershell, or at the start menu, type:

    ```
    powershell-ise
    ```

-   To open a script \(.ps1\), script module \(.psm1\), module manifest \(.psd1\), XML file, or any other supported file in Windows powershell ISE, use the following command format:

    ```
    powershell-ise <Filepath>
    ```

    In Windows powershell 3.0, you can use the optional **File** parameter as follows:

    ```
    powershell-ise -File <Filepath>
    ```

-   To start a Windows powershell ISE session without your Windows powershell profiles, use the **NoProfile** parameter. \(The **NoProfile** parameter is introduced in Windows powershell 3.0.\)

    ```
    powershell-ise -NoProfile
    ```

-   To see the **powershell\_ISE.exe** help file in a Command prompt window, use the following command format:

    ```
    powershell-ise -help, -?, /?
    ```

for a complete list of the **powershell\_ISE.exe** command\-line parameters, see [about\_powershell\_Ise.exe](http://go.microsoft.com/fwlink/?LinkId=256512).

## start Windows powershell ISE in other ways
for information about other ways to start Windows powershell ISE, see [starting Windows powershell](http://go.microsoft.com/fwlink/?LinkID=135259).

## remarks
Windows powershell runs on the Server Core installation option of Windows Server operating systems. However, because Windows powershell ISE requires a graphic user interface, it does not run on Server Core installations.

## See Also
[about\_powershell\_Ise.exe](http://go.microsoft.com/fwlink/?LinkId=256512)
[about\_powershell.exe](http://go.microsoft.com/fwlink/?LinkID=113439)
[Windows powershell](http://go.microsoft.com/fwlink/?LinkID=107116)
[Scripting with Windows powershell](http://technet.microsoft.com/scriptcenter/dd742419)


