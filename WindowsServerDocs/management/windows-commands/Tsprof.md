---
title: Tsprof
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 27047868-b706-4208-b7e0-1437a2325dd3
---
# Tsprof
Copies the Remote Desktop Services user configuration information from one user to another.

The Remote Desktop Services user configuration information is displayed in the Remote Desktop Services extensions to Local Users and Groups and Active Directory Users and Computers.

**Tsprof** can also set the profile path for a user.

For examples of how to use this command, see [Examples](#BKMK_examples).

> [!NOTE]
> [!INCLUDE[rd_note-cmd-line-ref](includes/rd_note-cmd-line-ref_md.md)]

## Syntax

```
tsprof /update {/domain:<DomainName> | /local} /profile:<Path> <UserName>
tsprof /copy {/domain:<DomainName> | /local} [/profile:<Path>] <Src_usr> <Dest_usr>
tsprof /q {/domain:<DomainName> | /local} <UserName>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\/update|Updates profile path information for <*UserName*> in domain <*DomainName*> to <*ProfilePath*>.|
|\/domain:<DomainName>|Specifies the name of the domain in which the operation is applied.|
|\/local|Applies the operation only to local user accounts.|
|\/profile:<Path>|Specifies the profile path as displayed in the Remote Desktop Services extensions in Local Users and Groups and Active Directory Users and Computers.|
|<UserName>|Specifies the name of the user for whom you want to update or query the server profile path.|
|\/copy|Copies user configuration information from <*SourceUser*> to <*DestinationUser*> and updates the profile path information for <*DestinationUser*> to <*ProfilePath*>. Both <*SourceUser*> and <*DestinationUser*> must either be local or must be in domain <*DomainName*>.|
|<Src\_usr>|Specifies the name of the user from whom you want to copy the user configuration information.|
|<Dest\_usr>|Specifies the name of the user to whom you want to copy the user configuration information.|
|\/q|Displays the current profile path of the user for whom you want to query the server profile path.|
|\/?|Displays help at the command prompt.|

## Remarks

-   The **tsprof** command is only available when you have installed the Terminal Server role service on a computer running [!INCLUDE[firstref_longhorn](includes/firstref_longhorn_md.md)] or RD Session Host role service on a computer running Windows Server 2008 R2.

## <a name="BKMK_examples"></a>Examples

-   To copy user configuration information from LocalUser1 to LocalUser2, type:

    ```
    tsprof /copy /local LocalUser1 LocalUser2
    ```

-   To set the Remote Desktop Services profile path for LocalUser1 to a directory called "c:\\profiles," type:

    ```
    tsprof /update /local /profile:c:\profiles LocalUser1
    ```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Remote Desktop Services &#40;Terminal Services&#41; Command Reference](Remote-Desktop-Services--Terminal-Services--Command-Reference.md)


