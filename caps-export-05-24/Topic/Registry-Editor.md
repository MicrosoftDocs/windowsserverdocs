---
title: Registry Editor
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3165c505-893b-4c3f-852a-848d070dd6ad
author: jaimeo
---
# Registry Editor
System configuration information is stored centrally in a hierarchical database called the registry. You can use Registry Editor to add and edit registry keys and values, restore the registry from a backup or to default values, and to import or export keys for reference or backup. You can also print the registry and control which accounts have permission to edit the registry.  
  
> [!NOTE]  
> Over time, the registry may contain many entries for devices that will never be used again. To remove this information from the registry, download [Microsoft DevNodeClean](http://www.microsoft.com/download/details.aspx?id=42286). For more information, see [How to remove registry information for devices that will never be used again on a computer that's running Windows Server 2003 or a later version](http://support.microsoft.com/kb/934234).  
  
> [!CAUTION]  
> Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on your computer and export the existing registry so that you can restore it if you make a mistake that results in your computer not starting properly.  
  
This topic explains how to import and export registry files. [!INCLUDE[whymshelpnotonbox](../Token/whymshelpnotonbox_md.md)] Much more information about the registry and using Registry Editor is available. [!INCLUDE[helpnotonbox](../Token/helpnotonbox_md.md)]  
  
[http:\/\/go.microsoft.com\/fwlink\/p\/?linkid\=221024](http://go.microsoft.com/fwlink/p/?linkid=221024)  
  
## Exporting registry files  
To export all or part of the registry remotely, use Registry Editor. Once you have opened Registry Editor, you can export the registry to a text file or to a hive file.  
  
You can save registry files in the Windows format as registration files, as binary hive files, or as text files. Registry files are saved with .reg extensions, and text files are saved with .txt extensions.  
  
#### Export all or part of the registry  
  
1.  Open Registry Editor. If you want to save only a particular branch, select it.  
  
2.  On the **File** menu, click **Export…**.  
  
3.  In **File name**, enter a name for the registry file.  
  
4.  In **Save as type**, select the file type you wish to use for the saved file \(registration file, registry hive file, text file, Windows 98\/NT4.0 registration file\).  
  
5.  In **Export Range**, use the radio buttons to select whether you want to export the entire registry or only the selected branch.  
  
6.  Click **Save**.  
  
> [!NOTE]  
> Certain parts of the registry are reserved and are not accessible to Regedit.exe. The option to export or import “all” of the registry applies to all of the registry that is accessible to Regedit.exe.  
  
## Importing registry files  
The **Import…** command in Registry Editor can import registry files of all types, including text files and hive files.  
  
#### Import some or all of the registry  
  
1.  Open Registry Editor.  
  
2.  On the **File** menu, click **Import…**.  
  
3.  Find the file you want to import, click the file to select it, and then click **Open**.  
  
> [!NOTE]  
> Certain parts of the registry are reserved and are not accessible to Regedit.exe. The option to export or import “all” of the registry applies to all of the registry that is accessible to Regedit.exe.  
  
> [!NOTE]  
> In File Explorer, double\-clicking a file with the .reg extension imports the file into the computer's registry.  
  
> [!CAUTION]  
> A restored hive overwrites an existing registry key and becomes a permanent part of your configuration. For example, to perform maintenance on part of your system, you can use **Export…** to save a hive to a disk. When you are ready, you can then use **Import…** on the **File** menu to restore the saved key to your system  
  
