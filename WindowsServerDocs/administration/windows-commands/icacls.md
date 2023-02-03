---
title: icacls
description: Reference article for the icacls command, which displays or modifies discretionary access control lists (DACL) on specified files, and applies stored DACLs to files in specified directories.
ms.topic: reference
ms.assetid: 403edfcc-328a-479d-b641-80c290ccf73e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 08/21/2018
---

# icacls

Displays or modifies discretionary access control lists (DACLs) on specified files, and applies stored DACLs to files in specified directories.

> [!NOTE]
> This command replaces the deprecated [cacls command](cacls.md).

## Syntax

```
icacls <filename> [/grant[:r] <sid>:<perm>[...]] [/deny <sid>:<perm>[...]] [/remove[:g|:d]] <sid>[...]] [/t] [/c] [/l] [/q] [/setintegritylevel <Level>:<policy>[...]]
icacls <directory> [/substitute <sidold> <sidnew> [...]] [/restore <aclfile> [/c] [/l] [/q]]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| \<filename\> | Specifies the file for which to display or modify DACLs. |
| \<directory\> | Specifies the directory for which to display or modify DACLs. |
| /t | Performs the operation on all specified files in the current directory and its subdirectories. |
| /c | Continues the operation despite any file errors. Error messages will still be displayed. |
| /l | Performs the operation on a symbolic link instead of its destination. |
| /q | Suppresses success messages. |
| [/save \<ACLfile\> [/t] [/c] [/l] [/q]] | Stores DACLs for all matching files into an access control list (ACL) file for later use with **/restore**. |
| [/setowner \<username\> [/t] [/c] [/l] [/q]] | Changes the owner of all matching files to the specified user. |
| [/findsid \<sid\> [/t] [/c] [/l] [/q]] | Finds all matching files that contain a DACL explicitly mentioning the specified security identifier (SID). |
| [/verify [/t] [/c] [/l] [/q]] | Finds all files with ACLs that are not canonical or have lengths inconsistent with access control entry (ACE) counts. |
| [/reset [/t] [/c] [/l] [/q]] | Replaces ACLs with default inherited ACLs for all matching files. |
| [/grant[:r] \<sid\>:\<perm\>[...]] | Grants specified user access rights. Permissions replace previously granted explicit permissions.<p>Not adding the **:r**, means that permissions are added to any previously granted explicit permissions. |
| [/deny \<sid\>:\<perm\>[...]] | Explicitly denies specified user access rights. An explicit deny ACE is added for the stated permissions and the same permissions in any explicit grant are removed. |
| [/remove[:g \| :d]] \<sid\>[...] [/t] [/c] [/l] [/q] | Removes all occurrences of the specified SID from the DACL. This command can also use:<ul><li>**:g** - Removes all occurrences of granted rights to the specified SID.</li><li>**:d** - Removes all occurrences of denied rights to the specified SID. |
| [/setintegritylevel [(CI)(OI)] \<Level\>:\<Policy\>[...]] | Explicitly adds an integrity ACE to all matching files. The level can be specified as:<ul><li>**l** - Low</li><li>**m**- Medium</li><li>**h** - High</li></ul>Inheritance options for the integrity ACE may precede the level and are applied only to directories. |
| [/substitute \<sidold\>\<sidnew\> [...]] | Replaces an existing SID (*sidold*) with a new SID (*sidnew*). Requires using with the `<directory>` parameter. |
| /restore \<ACLfile\> [/c] [/l] [/q] | Applies stored DACLs from `<ACLfile>` to files in the specified directory. Requires using with the `<directory>` parameter. |
| /inheritancelevel: [e \| d \| r] | Sets the inheritance level, which can be:<ul><li>**e** - Enables inheritance</li><li>**d** - Disables inheritance and copies the ACEs</li><li>**r** - Disables inheritance and removes only inherited ACEs</li></ul> |

## Remarks

- SIDs may be in either numerical or friendly name form. If you use a numerical form, affix the wildcard character **&#42;** to the beginning of the SID.

- This command preserves the canonical order of ACE entries as:

    - Explicit denials

    -  Explicit grants

    - Inherited denials

    - Inherited grants

- The `<perm>` option is a permission mask that can be specified in one of the following forms:

    - A sequence of simple rights (basic permissions):

      - **F** - Full access

      - **M**- Modify access

      - **RX** - Read and execute access

      - **R** - Read-only access

      - **W** - Write-only access

    - A comma-separated list in parenthesis of specific rights (advanced permissions):

      - **D** - Delete

      - **RC** - Read control (read permissions)

      - **WDAC** - Write DAC (change permissions)

      - **WO** - Write owner (take ownership)

      - **S** - Synchronize

      - **AS** - Access system security

      - **MA** - Maximum allowed

      - **GR** - Generic read

      - **GW** - Generic write

      - **GE** - Generic execute

      - **GA** - Generic all

      - **RD** - Read data/list directory

      - **WD** - Write data/add file

      - **AD** - Append data/add subdirectory

      - **REA** - Read extended attributes

      - **WEA** - Write extended attributes

      - **X** - Execute/traverse

      - **DC** - Delete child

      - **RA** - Read attributes

      - **WA** - Write attributes

  - Inheritance rights may precede either `<perm>` form:

      - **(I)** - Inherit. ACE inherited from the parent container.

      - **(OI)** - Object inherit. Objects in this container will inherit this ACE. Applies only to directories.

      - **(CI)** - Container inherit. Containers in this parent container will inherit this ACE. Applies only to directories.

      - **(IO)** - Inherit only. ACE inherited from the parent container, but does not apply to the object itself. Applies only to directories.

      - **(NP)** - Do not propagate inherit. ACE inherited by containers and objects from the parent container, but does not propagate to nested containers. Applies only to directories.

## Examples

To save the DACLs for all files in the C:\Windows directory and its subdirectories to the ACLFile file, type:

```
icacls c:\windows\* /save aclfile /t
```

To restore the DACLs for every file within ACLFile that exists in the C:\Windows directory and its subdirectories, type:

```
icacls c:\windows\ /restore aclfile
```

To grant the user User1 Delete and Write DAC permissions to a file named Test1, type:

```
icacls test1 /grant User1:(d,wdac)
```

To grant the user defined by SID S-1-1-0 Delete and Write DAC permissions to a file, named Test2, type:

```
icacls test2 /grant *S-1-1-0:(d,wdac)
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
