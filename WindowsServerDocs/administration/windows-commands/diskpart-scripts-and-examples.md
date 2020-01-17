---
title: Diskpart Scripts and Examples
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 319c0795-11df-47c8-b203-eadb0577ee0d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Diskpart Scripts and Examples

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Use Diskpart `/s` to run scripts that automate disk\-related tasks, such as creating volumes or converting disks to dynamic disks. Scripting these tasks is useful if you deploy Windows by using unattended Setup or the Sysprep tool, which do not support creating volumes other than the boot volume.  
  
-   To create a Diskpart script, create a text file that contains the Diskpart commands that you want to run, with one command per line, and no empty lines. You can start a line with `rem` to make the line a comment.  
  
    for example, here s a script that wipes a disk and then creates a 300 MB partition for the Windows recovery Environment:  
  
    ```  
    select disk 0  
    clean  
    convert gpt  
    create partition primary size=300  
    format quick fs=ntfs label="Windows RE tools"  
    assign letter="T"  
    ```  
  
-   To run a DiskPart script, at the command prompt, type the following command, where *scriptname* is the name of the text file that contains your script.  
  
    ```  
    diskpart /s scriptname.txt  
    ```  
  
-   To redirect DiskPart's scripting output to a file, type the following command, where *logfile* is the name of the text file where DiskPart writes its output.  
  
    ```  
    diskpart /s scriptname.txt > logfile.txt  
    ```  
  
> [!IMPORTANT]  
> When using the **DiskPart** command as a part of a script, we recommend that you complete all of the DiskPart operations together as part of a single DiskPart script. You can run consecutive DiskPart scripts, but you must allow at least 15 seconds between each script for a complete shutdown of the previous execution before running the **DiskPart** command again in successive scripts. Otherwise, the successive scripts might fail. You can add a pause between consecutive DiskPart scripts by adding the `timeout /t 15` command to your batch file along with your DiskPart scripts.  
  
When DiskPart starts, the DiskPart version and computer name display at the command prompt. By default, if DiskPart encounters an error while attempting to perform a scripted task, DiskPart stops processing the script and displays an error code \(unless you specified the **noerr** parameter\). However, DiskPart always returns errors when it encounters syntax errors, regardless of whether you used the **noerr** parameter. The **noerr** parameter enables you to perform useful tasks such as using a single script to delete all partitions on all disks regardless of the total number of disks.  
  
## See Also  
[Sample: Configure UEFI\/gpt\-Based Hard Drive Partitions by Using Windows PE and DiskPart](https://technet.microsoft.com/library/hh825686.aspx)  
[Sample: Configure BIOS\/MBR\-Based Hard Disk Partitions by Using Windows PE and DiskPart](https://technet.microsoft.com/library/hh825677.aspx)  
[Storage Cmdlets in Windows PowerShell](https://technet.microsoft.com/library/hh848705.aspx)  
  

