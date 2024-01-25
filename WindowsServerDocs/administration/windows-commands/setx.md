---
title: setx
description: Reference article for the setx command, which creates or modifies environment variables in the user or system environment, without requiring programming or scripting.
ms.topic: reference
ms.assetid: ef37482f-f8a8-4765-951a-2518faac3f44
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# setx

Creates or modifies environment variables in the user or system environment, without requiring programming or scripting. The **Setx** command also retrieves the values of registry keys and writes them to text files.

> [!NOTE]
> This command provides the only command-line or programmatic way to directly and permanently set system environment values. System environment variables are manually configurable through **Control Panel** or through a registry editor. The **set** command, which is internal to the command interpreter (Cmd.exe), sets user environment variables for the current console window only.

## Syntax

```
setx [/s <computer> [/u [<domain>\]<user name> [/p [<password>]]]] <variable> <value> [/m]
setx [/s <computer> [/u [<domain>\]<user name> [/p [<password>]]]] <variable>] /k <path> [/m]
setx [/s <computer> [/u [<domain>\]<user name> [/p [<password>]]]] /f <filename> {[<variable>] {/a <X>,<Y> | /r <X>,<Y> <String>} [/m] | /x} [/d <delimiters>]
```

### Parameters

| Parameter | Description |
|--|--|
| /s `<computer>` | Specifies the name or IP address of a remote computer. Do not use backslashes. The default value is the name of the local computer. |
| /u `[<domain>\]<user name>` | Runs the script with the credentials of the specified user account. The default value is the system permissions. |
| /p [`<password>`]| Specifies the password of the user account that is specified in the **/u** parameter. |
| `<variable>` | Specifies the name of the environment variable that you want to set. |
| `<value>` | Specifies the value to which you want to set the environment variable. |
| /k `<path>` | Specifies that the variable is set based on information from a registry key. The *path* uses the following syntax: `\\<HIVE>\<KEY>\...\<Value>`. For example, you might specify the following path: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation\StandardName` |
| /f `<filename>` | Specifies the file that you want to use. |
| /a `<X>,<Y>` | Specifies absolute coordinates and offset as search parameters. |
| /r `<X>,<Y> <String>` | Specifies relative coordinates and offset from **String** as search parameters. |
| /m | Specifies to set the variable in the system environment. The default setting is the local environment. |
| /x | Displays file coordinates, ignoring the **/a**, **/r**, and **/d** command-line options. |
| /d `<delimiters>` | Specifies delimiters such as **,** or **\\** to be used in addition to the four built-in delimiters — SPACE, TAB, ENTER, and LINEFEED. Valid delimiters include any ASCII character. The maximum number of delimiters is 15, including built-in delimiters. |
| /? | Displays help at the command prompt. |

#### Remarks

- This command is similar to the UNIX utility SETENV.

- You can use this command to set values for user and system environment variables from one of three sources (modes): Command Line Mode, Registry Mode, or File Mode.

- This command writes variables to the master environment in the registry. Variables set with **setx** variables are available in future command windows only, not in the current command window.

- **HKEY_CURRENT_USER** and **HKEY_LOCAL_MACHINE** are the only supported hives. REG_DWORD, REG_EXPAND_SZ, REG_SZ, and REG_MULTI_SZ are the valid **RegKey** data types.

- If you gain access to **REG_MULTI_SZ** values in the registry, only the first item is extracted and used.

- You can't use this command to remove values added to the local or system environments. You can use this command with a variable name and no value to remove a corresponding value from the local environment.

- REG_DWORD registry values are extracted and used in hexadecimal mode.

- File mode supports the parsing of carriage return and line feed (CRLF) text files only.

- Running this command on an existing variable removes any variable references and uses expanded values.

  For instance, if the variable %PATH% has a reference to %JAVADIR%, and %PATH% is manipulated using **setx**, %JAVADIR% is expanded and its value is assigned directly to the target variable %PATH%. This means that future updates to %JAVADIR% **will not** be reflected in the %PATH% variable.

- Be aware there's a limit of 1024 characters when assigning contents to a variable using **setx**.

  This means that the content is cropped if you go over 1024 characters, and that the cropped text is what's applied to the target variable. If this cropped text is applied to an existing variable, it can result in loss of data previously held by the target variable.

## Examples

To set the *MACHINE* environment variable in the local environment to the value *Brand1*, type:

```
setx MACHINE Brand1
```

To set the *MACHINE* environment variable in the system environment to the value *Brand1 Computer*, type:

```
setx MACHINE Brand1 Computer /m
```

To set the *MYPATH* environment variable in the local environment to use the search path defined in the *PATH* environment variable, type:

```
setx MYPATH %PATH%
```

To set the *MYPATH* environment variable in the local environment to use the search path defined in the *PATH* environment variable after replacing **~** with **%**, type:

```
setx MYPATH ~PATH~
```

To set the *MACHINE* environment variable in the local environment to *Brand1* on a remote computer named *computer1*, type:

```
setx /s computer1 /u maindom\hiropln /p p@ssW23 MACHINE Brand1
```

To set the *MYPATH* environment variable in the local environment to use the search path defined in the *PATH* environment variable on a remote computer named *computer1*, type:

```
setx /s computer1 /u maindom\hiropln /p p@ssW23 MYPATH %PATH%
```

To set the *TZONE* environment variable in the local environment to the value found in the **HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation\StandardName** registry key, type:

```
setx TZONE /k HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation\StandardName
```

To set the *TZONE* environment variable in the local environment of a remote computer named *computer1* to the value found in the **HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation\StandardName** registry key, type:

```
setx /s computer1 /u maindom\hiropln /p p@ssW23 TZONE /k HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation\StandardName
```

To set the *BUILD* environment variable in the system environment to the value found in the **HKEY_LOCAL_MACHINE\Software\Microsoft\WindowsNT\CurrentVersion\CurrentBuildNumber** registry key, type:

```
setx BUILD /k HKEY_LOCAL_MACHINE\Software\Microsoft\WindowsNT\CurrentVersion\CurrentBuildNumber /m
```

To set the BUILD environment variable in the system environment of a remote computer named Computer1 to the value found in the **HKEY_LOCAL_MACHINE\Software\Microsoft\WindowsNT\CurrentVersion\CurrentBuildNumber** registry key, type:

```
setx /s computer1 /u maindom\hiropln /p p@ssW23  BUILD /k HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\CurrentBuildNumber /m
```

To display the contents of a file named *Ipconfig.out*, along with the contents' corresponding coordinates, type:

```
setx /f ipconfig.out /x
```

To set the *IPADDR* environment variable in the local environment to the value found at the coordinate *5,11* in the *Ipconfig.out* file, type:

```
setx IPADDR /f ipconfig.out /a 5,11
```

To set the *OCTET1* environment variable in the local environment to the value found at the coordinate *5,3* in the *Ipconfig.out* file with delimiters **#$*.**, type:

```
setx OCTET1 /f ipconfig.out /a 5,3 /d #$*.
```

To set the *IPGATEWAY* environment variable in the local environment to the value found at the coordinate *0,7* with respect to the coordinate of *Gateway* in the *Ipconfig.out* file, type:

```
setx IPGATEWAY /f ipconfig.out /r 0,7 Gateway
```

To display the contents of the *Ipconfig.out* file, along with the contents' corresponding coordinates, on a computer named *computer1*, type:

```
setx /s computer1 /u maindom\hiropln /p p@ssW23 /f ipconfig.out /x
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
