---
title: ntbackup
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6bce6b0d-646b-46b6-b833-0ff1d6f082c2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ntbackup



The **ntbackup** command is not available in Windows Vista or Windows Server 2008. Instead, you should use the **wbadmin** command and subcommands to back up and restore your computer and files from a command prompt.

You cannot recover backups that you created with **ntbackup** by using **wbadmin**. However, a version of **ntbackup** is available as a download for Windows Server 2008 and Windows Vista users who want to recover backups that they created using **ntbackup**. This downloadable version of **ntbackup** enables you to perform recoveries only of legacy backups, and it cannot be used on computers running Windows Server 2008 or Windows Vista to create new backups. To download this version of **ntbackup**, see [https://go.microsoft.com/fwlink/?LinkId=82917](https://go.microsoft.com/fwlink/?LinkId=82917).

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

[Wbadmin](wbadmin.md)