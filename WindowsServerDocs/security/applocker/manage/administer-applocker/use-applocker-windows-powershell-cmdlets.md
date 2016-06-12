---
title: Use the applocker Windows PowerShell Cmdlets
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3790d2ed-0bd8-47f2-b7b0-146ce56f4ff8
---
# Use the applocker Windows PowerShell Cmdlets
This topic describes how each applocker Windows PowerShell cmdlet can help you administer your applocker application control policies in  Windows Server 2012  and Windows 8.

## applocker Windows PowerShell cmdlets
The five applocker cmdlets are designed to streamline the administration of an applocker policy. They can be used to help create, test, maintain, and troubleshoot an applocker policy. The cmdlets are intended to be used in conjunction with the applocker user interface that is accessed through the Microsoft Management Console \(MMC\) snap\-in extension to the Local Security Policy snap\-in and Group Policy Management Console.

To edit or update a Group Policy Object \(GPO\) by using the applocker cmdlets, you must have Edit Setting permission. By default, members of the **Domain Admins** group, the **Enterprise Admins** group, and the **Group Policy Creator Owners** group have this permission. To perform tasks by using the Local Security policy snap\-in, you must be a member of the local **Administrators** group, or equivalent, on the computer.

### Import the applocker PowerShell cmdlet module
To use the applocker cmdlets, you must first import the applocker module by using the following command at the Windows PowerShell command prompt: `C:\PS> Import-Module applocker`. Scripting must be enabled on the computer.

### Retrieve application information
The [Get\-applockerFileInformation](http://go.microsoft.com/fwlink/?LinkId=169154) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=169154\) cmdlet retrieves the applocker file information from a list of files or from an event log. File information that is retrieved can include publisher information, file hash information, and file path information. File information from an event log may not contain all of these fields. Files that are not signed do not have any publisher information.

### Set applocker policy
The [Set\-applockerPolicy](http://go.microsoft.com/fwlink/?LinkId=169167) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=169167\) cmdlet sets the specified GPO to contain the specified applocker policy. If no Lightweight Directory Access Protocol \(LDAP\) is specified, the local GPO is the default.

### Retrieve an applocker policy
The [Get\-applockerPolicy](http://go.microsoft.com/fwlink/?LinkId=169165) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=169165\) cmdlet gets the applocker policy from the local GPO, from a specified GPO, or from the effective applocker policy on the computer. The output of the applocker policy is an applockerPolicy object or an XML\-formatted string.

### Generate rules for a given user or group
The [New\-applockerPolicy](http://go.microsoft.com/fwlink/?LinkId=169166) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=169166\) cmdlet uses a list of file information to automatically generate rules for a given user or group. It can generate rules based on publisher, hash, or path information. Use **Get\-applockerFileInformation** to create the list of file information.

### Test the applocker Policy against a file set
The [Test\-applockerPolicy](http://go.microsoft.com/fwlink/?LinkID=169000) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=169000\) cmdlet uses the specified applocker policy to test whether a specified list of files are allowed to run or not on the local computer for a specific user.

## Additional resources

-   For steps to perform other applocker policy tasks, see [Administer applocker]().

## See Also
[applocker Overview \[Client\]](assetId:///1637ae87-5059-4d95-8c68-96f35cbc88c7)


