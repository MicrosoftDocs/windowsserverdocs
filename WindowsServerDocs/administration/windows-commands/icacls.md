---
title: icacls
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 403edfcc-328a-479d-b641-80c290ccf73e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 08/21/2018
---

# icacls

Displays or modifies discretionary access control lists (DACLs) on specified files, and applies stored DACLs to files in specified directories.

For examples of how to use this command, see [Examples](#examples).

## Syntax

```
icacls <FileName> [/grant[:r] <Sid>:<Perm>[...]] [/deny <Sid>:<Perm>[...]] [/remove[:g|:d]] <Sid>[...]] [/t] [/c] [/l] [/q] [/setintegritylevel <Level>:<Policy>[...]]
icacls <Directory> [/substitute <SidOld> <SidNew> [...]] [/restore <ACLfile> [/c] [/l] [/q]]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<FileName>|Specifies the file for which to display DACLs.|
|\<Directory>|Specifies the directory for which to display DACLs.|
|/t|Performs the operation on all specified files in the current directory and its subdirectories.|
|/c|Continues the operation despite any file errors. Error messages will still be displayed.|
|/l|Performs the operation on a symbolic link versus its destination.|
|/q|Suppresses success messages.|
|[/save \<ACLfile> [/t] [/c] [/l] [/q]]|Stores DACLs for all matching files into *ACLfile* for later use with **/restore**.|
|[/setowner \<Username> [/t] [/c] [/l] [/q]]|Changes the owner of all matching files to the specified user.|
|[/findSID \<Sid> [/t] [/c] [/l] [/q]]|Finds all matching files that contain a DACL explicitly mentioning the specified security identifier (SID).|
|[/verify [/t] [/c] [/l] [/q]]|Finds all files with ACLs that are not canonical or have lengths inconsistent with ACE (access control entry) counts.|
|[/reset [/t] [/c] [/l] [/q]]|Replaces ACLs with default inherited ACLs for all matching files.|
|[/grant[:r] \<Sid>:<Perm>[...]]|Grants specified user access rights. Permissions replace previously granted explicit permissions.</br>Without **:r**, permissions are added to any previously granted explicit permissions.|
|[/deny \<Sid>:<Perm>[...]]|Explicitly denies specified user access rights. An explicit deny ACE is added for the stated permissions and the same permissions in any explicit grant are removed.|
|[/remove[:g\|:d]] \<Sid>[...]] [/t] [/c] [/l] [/q]|Removes all occurrences of the specified SID from the DACL.</br>**:g** removes all occurrences of granted rights to the specified SID.</br>**:d** removes all occurrences of denied rights to the specified SID.|
|[/setintegritylevel [(CI)(OI)]\<Level>:<Policy>[...]]|Explicitly adds an integrity ACE to all matching files. *Level* is specified as:</br>-   **L**[ow]</br>-   **M**[edium]</br>-   **H**[igh]</br>Inheritance options for the integrity ACE may precede the level and are applied only to directories.|
|[/substitute \<SidOld> <SidNew> [...]]|Replaces an existing SID (*SidOld*) with a new SID (*SidNew*). Requires the *Directory* parameter.|
|/restore \<ACLfile> [/c] [/l] [/q]|Applies stored DACLs from *ACLfile* to files in the specified directory. Requires the *Directory* parameter.|
|/inheritancelevel:[e\|d\|r]|Sets the inheritance level: <br>  **e** - Enables enheritance <br>**d** - Disables inheritance and copies the ACEs <br>**r** - Removes all inherited ACEs

## Remarks

-   SIDs may be in either numerical or friendly name form. If you use a numerical form, affix the wildcard character **&#42;** to the beginning of the SID.
-   **icacls** preserves the canonical order of ACE entries as:  
    -   Explicit denials
    -   Explicit grants
    -   Inherited denials
    -   Inherited grants
-   *Perm* is a permission mask that can be specified in one of the following forms:  
    -   A sequence of simple rights:

        **F** (full access)

        **M** (modify access)

        **RX** (read and execute access)

        **R** (read-only access)

        **W** (write-only access)
    -   A comma-separated list in parenthesis of specific rights:

        **D** (delete)

        **RC** (read control)

        **WDAC** (write DAC)

        **WO** (write owner)

        **S** (synchronize)

        **AS** (access system security)

        **MA** (maximum allowed)

        **GR** (generic read)

        **GW** (generic write)

        **GE** (generic execute)

        **GA** (generic all)

        **RD** (read data/list directory)

        **WD** (write data/add file)

        **AD** (append data/add subdirectory)

        **REA** (read extended attributes)

        **WEA** (write extended attributes)

        **X** (execute/traverse)

        **DC** (delete child)

        **RA** (read attributes)

        **WA** (write attributes)
-   Inheritance rights may precede either *Perm* form, and they are applied only to directories:

    **(OI)**: object inherit

    **(CI)**: container inherit

    **(IO)**: inherit only

    **(NP)**: do not propagate inherit

## Examples

To save the DACLs for all files in the C:\Windows directory and its subdirectories to the ACLFile file, type:

```
icacls c:\windows\* /save aclfile /t
```

To restore the DACLs for every file within ACLFile that exists in the C:\Windows directory and its subdirectories, type:

```
icacls c:\windows\ /restore aclfile
```

To grant the user User1 Delete and Write DAC permissions to a file named "Test1", type:

```
icacls test1 /grant User1:(d,wdac)
```

To grant the user defined by SID S-1-1-0 Delete and Write DAC permissions to a file, named "Test2", type:

```
icacls test2 /grant *S-1-1-0:(d,wdac)
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
