---
title: Bootcfg query
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a4cacfd1-10a6-4a11-b0c5-f8abde72bfc8
---
# Bootcfg query
Queries and displays the \[boot loader\] and \[operating systems\] section entries from Boot.ini.

For examples of how this command can be used, see [Examples](#BKMK_examples).

## Syntax

```
bootcfg /query [/s <Computer> [/u <Domain>\<User> /p <Password>]]
```

## Parameters

|Term|Definition|
|--------|--------------|
|\/s <Computer>|Specifies the name or IP address of a remote computer \(do not use backslashes\). The default is the local computer.|
|\/u <Domain>\\<User>|Runs the command with the account permissions of the user specified by <User>or <Domain>\\<User>. The default is the permissions of the current logged on user on the computer issuing the command.|
|\/p <Password>|Specifies the password of the user account that is specified in the **\/u** parameter.|
|\/?|Displays help at the command prompt.|

##### Remarks

-   The following is a sample of **bootcfg \/query** output:

    ```
    Boot Loader Settings
    --------------------
    timeout: 30
    default: multi(0)disk(0)rdisk(0)partition(1)\WINDOWS

    Boot Entries
    ------------
    Boot entry ID:   1
    Friendly Name:   ""
    Path:            multi(0)disk(0)rdisk(0)partition(1)\WINDOWS
    OS Load Options: /fastdetect /debug /debugport=com1:
    ```

-   The Boot Loader Settings portion of the **bootcfg query** output displays each entry in the \[boot loader\] section of Boot.ini.

-   The Boot Entries portion of the **bootcfg query** output displays the following detail for each operating system entry in the \[operating systems\] section of Boot.ini: Boot entry ID, Friendly Name, Path, and OS Load Options.

## <a name="BKMK_examples"></a>Examples
The following examples show how you can use the **bootcfg \/query** command:

```
bootcfg /query
bootcfg /query /s srvmain /u maindom\hiropln /p p@ssW23
bootcfg /query /u hiropln /p p@ssW23
```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)


