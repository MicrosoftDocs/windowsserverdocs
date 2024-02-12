---
title: diskpart scripts and examples
description: Reference article for diskpart scripts and examples about how to automate disk-related tasks, such as creating volumes or converting disks to dynamic disks.
ms.topic: reference
ms.assetid: 319c0795-11df-47c8-b203-eadb0577ee0d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# diskpart scripts and examples

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Use `diskpart /s` to run scripts that automate disk-related tasks, such as creating volumes or converting disks to dynamic disks. Scripting these tasks is useful if you deploy Windows by using unattended Setup or the Sysprep tool, which do not support creating volumes other than the boot volume.

To create a diskpart script, create a text file that contains the Diskpart commands that you want to run, with one command per line, and no empty lines. You can start a line with `rem` to make the line a comment. For example, here's a script that wipes a disk and then creates a 300 MB partition for the Windows Recovery Environment:

```
select disk 0
clean
convert gpt
create partition primary size=300
format quick fs=ntfs label=Windows RE tools
assign letter=T
```

## Examples

- To run a diskpart script, at the command prompt, type the following command, where *scriptname* is the name of the text file that contains your script:

```
diskpart /s scriptname.txt
```

- To redirect diskpart's scripting output to a file, type the following command, where *logfile* is the name of the text file where diskpart writes its output:

```
diskpart /s scriptname.txt > logfile.txt
```

### Remarks

- When using the **diskpart** command as a part of a script, we recommend that you complete all of the diskpart operations together as part of a single diskpart script. You can run consecutive diskpart scripts, but you must allow at least 15 seconds between each script for a complete shutdown of the previous execution before running the **diskpart** command again in successive scripts. Otherwise, the successive scripts might fail. You can add a pause between consecutive diskpart scripts by adding the `timeout /t 15` command to your batch file along with your diskpart scripts.

- When diskpart starts, the diskpart version and computer name display at the command prompt. By default, if diskpart encounters an error while attempting to perform a scripted task, diskpart stops processing the script and displays an error code (unless you specified the **noerr** parameter). However, diskpart always returns errors when it encounters syntax errors, regardless of whether you used the **noerr** parameter. The **noerr** parameter enables you to perform useful tasks such as using a single script to delete all partitions on all disks regardless of the total number of disks.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Sample: Configure UEFI/GPT-Based Hard Drive Partitions by Using Windows PE and DiskPart](/previous-versions/windows/it-pro/windows-8.1-and-8/hh825686(v=win.10))

- [Sample: Configure BIOS/MBR-Based Hard Disk Partitions by Using Windows PE and DiskPart](/previous-versions/windows/it-pro/windows-8.1-and-8/hh825677(v=win.10))

- [Storage Cmdlets in Windows PowerShell](/powershell/module/storage/)
