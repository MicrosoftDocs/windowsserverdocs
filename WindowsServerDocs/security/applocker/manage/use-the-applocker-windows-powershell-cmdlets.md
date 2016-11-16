---
title: Use the AppLocker Windows PowerShell Cmdlets
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3790d2ed-0bd8-47f2-b7b0-146ce56f4ff8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Use the AppLocker Windows PowerShell Cmdlets

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic describes how each AppLocker Windows PowerShell cmdlet can help you administer your AppLocker application control policies in Windows Server 2012 and Windows 8.

## AppLocker Windows PowerShell cmdlets
The five AppLocker cmdlets are designed to streamline the administration of an AppLocker policy. They can be used to help create, test, maintain, and troubleshoot an AppLocker policy. The cmdlets are intended to be used in conjunction with the AppLocker user interface that is accessed through the Microsoft Management Console (MMC) snap-in extension to the Local Security Policy snap-in and Group Policy Management Console.

To edit or update a Group Policy Object (GPO) by using the AppLocker cmdlets, you must have Edit Setting permission. By default, members of the **Domain Admins** group, the **Enterprise Admins** group, and the **Group Policy Creator Owners** group have this permission. To perform tasks by using the Local Security policy snap-in, you must be a member of the local **Administrators** group, or equivalent, on the computer.

### Import the AppLocker PowerShell cmdlet module
To use the AppLocker cmdlets, you must first import the AppLocker module by using the following command at the Windows PowerShell command prompt: `C:\PS> Import-Module AppLocker`. Scripting must be enabled on the computer.

### Retrieve application information
The [Get-applockerFileInformation](http://go.microsoft.com/fwlink/?LinkId=169154) (http://go.microsoft.com/fwlink/?LinkId=169154) cmdlet retrieves the AppLocker file information from a list of files or from an event log. File information that is retrieved can include publisher information, file hash information, and file path information. File information from an event log may not contain all of these fields. Files that are not signed do not have any publisher information.

### Set AppLocker policy
The [Set-applockerPolicy](http://go.microsoft.com/fwlink/?LinkId=169167) (http://go.microsoft.com/fwlink/?LinkId=169167) cmdlet sets the specified GPO to contain the specified AppLocker policy. If no Lightweight Directory Access Protocol (LDAP) is specified, the local GPO is the default.

### Retrieve an AppLocker policy
The [Get-applockerPolicy](http://go.microsoft.com/fwlink/?LinkId=169165) (http://go.microsoft.com/fwlink/?LinkId=169165) cmdlet gets the AppLocker policy from the local GPO, from a specified GPO, or from the effective AppLocker policy on the computer. The output of the AppLocker policy is an AppLockerPolicy object or an XML-formatted string.

### Generate rules for a given user or group
The [New-applockerPolicy](http://go.microsoft.com/fwlink/?LinkId=169166) (http://go.microsoft.com/fwlink/?LinkId=169166) cmdlet uses a list of file information to automatically generate rules for a given user or group. It can generate rules based on publisher, hash, or path information. Use **Get-applockerFileInformation** to create the list of file information.

### Test the AppLocker Policy against a file set
The [Test-applockerPolicy](http://go.microsoft.com/fwlink/?LinkID=169000) (http://go.microsoft.com/fwlink/?LinkID=169000) cmdlet uses the specified AppLocker policy to test whether a specified list of files are allowed to run or not on the local computer for a specific user.

## Additional resources

-   For steps to perform other AppLocker policy tasks, see [Administer AppLocker](administer-applocker.md).




