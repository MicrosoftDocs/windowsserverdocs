---
title: Mmc
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7bfa4030-ce42-40fb-922f-2f5145a80872
author: jaimeo
---
# Mmc
Using MMC command\-line options, you can open a specific **MMC** console, open **MMC** in author mode, or specify that the 32\-bit or 64\-bit version of **MMC** is opened.  
  
## Syntax  
  
```  
mmc <path>\<filename>.msc [/a] [/64] [/32]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<path>\\<filename>.msc|Starts **MMC** and opens a saved console. You need to specify the complete path and file name for the saved console file. If you do not specify a console file, **MMC** opens a new console.|  
|\/a|Opens a saved console in author mode.  Used to make changes to saved consoles.|  
|\/64|Opens the 64\-bit version of **MMC** \(MMC64\). Use this option only if you are running a Microsoft 64\-bit operating system and want to use a 64\-bit snap\-in.|  
|\/32|Opens the 32\-bit version of **MMC** \(MMC32\). When running a Microsoft 64\-bit operating system, you can run 32\-bit snap\-ins by opening MMC with this command\-line option when you have 32\-bit only snap\-ins.|  
|\/?|Displays Help at the command prompt.|  
  
## Remarks  
  
-   Using the <path>**\\**<filename>**.msc** command\-line option  
  
    You can use environment variables to create command lines or shortcuts that do not depend on the explicit location of console files. For instance, if the path to a console file is in the system folder \(for example, **mmc c:\\winnt\\system32\\console\_name.msc**\), you can use the expandable data string **%systemroot%** to specify the location \(**mmc%systemroot%\\system32\\console\_name.msc**\). This may be useful if you are delegating tasks to people in your organization who are working on different computers.  
  
-   Using the **\/a** command\-line option  
  
    When consoles are opened with this option, they are opened in author mode, regardless of their default mode. This does not permanently change the default mode setting for files; when you omit this option, MMC opens console files according to their default mode settings.  
  
-   After you open **MMC** or a console file in author mode, you can open any existing console by clicking **Open** on the **Console** menu.  
  
-   You can use the command line to create shortcuts for opening **MMC** and saved consoles. A command\-line command works with the **Run** command on the **Start** menu, in any command\-prompt window, in shortcuts, or in any batch file or program that calls the command.  
  
## Additional references  
  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
-   [Command-Line Reference_1](Command-Line-Reference_1.md)  
  

