---
title: cmdkey
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5fcd68ee-a14a-4b71-9300-c3f5c5d31e8e
---
# cmdkey
creates, lists, and deletes stored user names and passwords or credentials.

for examples of how this command can be used, see [Examples](#BKMK_examples).

## Syntax

```
cmdkey [{/add:<TargetName>|/generic:<TargetName>}] {/smartcard|/user:<UserName> [/pass:<Password>]} [/delete{:<TargetName>|/ras}] /list:<TargetName>
```

## Parameters

|Parameters|Description|
|--------------|---------------|
|\/add:<TargetName>|adds a user name and password to the list.<br /><br />Requires the parameter of <TargetName> which identifies the computer or domain name that this entry will be associated with.|
|\/generic:<TargetName>|adds generic credentials to the list.<br /><br />Requires the parameter of <TargetName> which identifies the computer or domain name that this entry will be associated with.|
|\/smartcard|Retrieves the credential from a smart card.|
|\/user:<UserName>|Specifies the user or account name to store with this entry. if *UserName* is not supplied, it will be requested.|
|\/pass:<Password>|Specifies the password to store with this entry. if *Password* is not supplied, it will be requested.|
|\/delete{:<TargetName> &#124; \/ras}|deletes a user name and password from the list. if *TargetName* is specified, that entry will be deleted. if \/ras is specified, the stored remote access entry will be deleted.|
|\/list:<TargetName>|Displays the list of stored user names and credentials. if *TargetName* is not specified, all stored user names and credentials will be listed.|
|\/?|Displays help at the command prompt.|

## remarks

-   if more than one smart card is found on the system when the \/smartcard command\-line option is used, **cmdkey** will display information about all available smart cards and then prompt the user to specify which one to use.

-   Passwords will not be displayed once they are stored.

## <a name="BKMK_examples"></a>Examples
To display a list of all user names and credentials that are stored, type:

```
cmdkey /list
```

To add a user name and password for user Mikedan to access computer Server01 with the password Kleo, type:

```
cmdkey /add:server01 /user:mikedan /pass:Kleo
```

To add a user name and password for user Mikedan to access computer Server01 and prompt for the password whenever Server01 is accessed, type:

```
cmdkey /add:server01 /user:mikedan
```

To delete the credential that remote access has stored, type:

```
cmdkey /delete /ras
```

To delete the credential that is stored for Server01, type:

```
cmdkey /delete:Server01
```

## additional references
[Command-Line Syntax Key](commandline-syntax-key.md)


