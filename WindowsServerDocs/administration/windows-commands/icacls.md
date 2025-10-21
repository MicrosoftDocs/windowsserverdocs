---
title: icacls
description: Reference article for the icacls command, which displays or modifies discretionary access control lists (DACL) on specified files, and applies stored DACLs to files in specified directories.
ms.topic: reference
author: dknappettmsft
ms.author: daknappe
ms.date: 06/06/2025
---

# icacls

Displays or modifies discretionary access control lists (DACLs) on specified files and applies stored DACLs to files in specified directories.

> [!NOTE]
> This command replaces the deprecated [cacls command](cacls.md).

## Syntax

```
icacls name [/save aclfile] [/setowner user] [/findsid Sid] [/verify] [/reset] [/T] [/C] [/L] [/Q]
icacls name [/grant[:r] Sid:perm[...]] [/deny Sid:perm [...]] [/remove[:g|:d]] Sid[...]]] [/setintegritylevel Level:policy[...]] [/T] [/C] [/L] [/Q]
icacls directory [/substitute SidOld SidNew [...]] [/restore aclfile] [/C] [/L] [/Q]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<name>` | Specifies the file for which to display or modify DACLs. |
| `<directory>` | Specifies the directory for which to display or modify DACLs. |
| /t | Performs the operation on all specified files in the current directory and its subdirectories. |
| /c | Continues the operation even if file errors occur. Error messages are still shown. |
| /l | Performs the operation on a symbolic link instead of its destination. |
| /q | Suppresses success messages. |
| /save `<ACLfile>` | Stores DACLs for all matching files into an access control list (ACL) file for later use with `/restore`. |
| /setowner `<user>` | Changes the owner of all matching files to the specified user. |
| /findsid `<sid>` | Finds all matching files that contain a DACL explicitly mentioning the specified security identifier (SID). |
| /verify | Finds all files with ACLs that aren't canonical or have lengths inconsistent with access control entry (ACE) counts. |
| /reset | Replaces ACLs with default inherited ACLs for all matching files. |
| /grant[:r] `<sid>`:`<perm>` | Grants specified user access rights. Permissions replace previously granted explicit permissions. Not adding **:r** means that permissions are added to any previously granted explicit permissions. |
| /deny `<sid>`:`<perm>` | Explicitly denies specified user access rights. An explicit deny ACE is added for the stated permissions and the same permissions in any explicit grant are removed. |
| /remove: g \| d `<sid>` | Removes all occurrences of the specified SID from the DACL. This command can also use:<br><br><li>**g** - Removes all occurrences of granted rights to the specified SID</li><li>**d** - Removes all occurrences of denied rights to the specified SID |
| /setintegritylevel `<perm><level>` | Explicitly adds an integrity ACE to all matching files. The level can be specified as:<br><br><li>**l** - Low</li><li>**m** - Medium</li><li>**h** - High</li></ul><br>Inheritance options for the integrity ACE may precede the level and are applied only to directories. |
| /substitute `<sidold>` `<sidnew>` | Replaces an existing SID (*sidold*) with a new SID (*sidnew*). Requires using with the `<directory>` parameter. |
| /restore `<ACLfile>` /c \| /l \| /q | Applies stored DACLs from `<ACLfile>` to files in the specified directory. Requires using with the `<directory>` parameter. |
| /inheritancelevel: e \| d \| r | Sets the inheritance level, which can be:<br><br><li>**e** - Enables inheritance</li><li>**d** - Disables inheritance and copies the ACEs</li><li>**r** - Disables inheritance and removes only inherited ACEs</li></ul> |

## Remarks

- SIDs may be in either numerical or friendly name form. If you use a numerical form, affix the wildcard character **&#42;** to the beginning of the SID.

- This command preserves the canonical order of ACE entries as:

  - Explicit denials

  - Explicit grants

  - Inherited denials

  - Inherited grants

- The `<perm>` option is a permission mask that can be specified for basic rights, advanced rights, or inheritance rights:

  - A sequence of simple rights (basic permissions) without the need to use parenthesis:

    - **N** - No access
    - **F** - Full access
    - **M** - Modify access
    - **RX** - Read and execute access
    - **R** - Read-only access
    - **W** - Write-only access
    - **D** - Delete access

  - A comma-separated list of specific rights (advanced permissions) which must use parenthesis:

    - **DE** - Delete
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

  - A sequence of inheritance rights which must use parenthesis:

    - **(I)** - Inherit. ACE inherited from the parent container.
    - **(OI)** - Object inherit. Objects in this container inherits this ACE. Applies only to directories.
    - **(CI)** - Container inherit. Containers in this parent container inherits this ACE. Applies only to directories.
    - **(IO)** - Inherit only. ACE inherited from the parent container, but doesn't apply to the object itself. Applies only to directories.
    - **(NP)** - Don't propagate inherit. ACE inherited by containers and objects from the parent container, but doesn't propagate to nested containers. Applies only to directories.

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

To grant the user defined by SID S-1-1-0 Delete and Write DAC permissions to a file named TestFile, type:

```
icacls TestFile /grant *S-1-1-0:(d,wdac)
```

To apply a *high* integrity level to a directory and ensure that both its files and subdirectories inherit this level, type:

```
icacls "myDirectory" /setintegritylevel (CI)(OI)H
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
