---
title: reg add
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d9ad143e-dc10-4e2e-a229-408393c40079
---
# reg add
adds a new subkey or entry to the registry.

## Syntax

```
reg add <KeyName> [{/v ValueName | /ve}] [/t Datatype] [/s Separator] [/d Data] [/f]
```

for examples of how to use this command, see [Examples](#BKMK_examples).

## Parameters

|Parameter|Description|
|-------------|---------------|
|<KeyName*>*|Specifies the full path of the subkey or entry to be added. To specify a remote computer, include the computer name \(in the format \\\\<computerName>\\\) as part of the *KeyName*. Omitting \\\\computerName\\ causes the operation to default to the local computer. The *KeyName* must include a valid root key. Valid root keys for the local computer are: HKLM, HKCU, HKCR, HKU, and HKCC. if a remote computer is specified, valid root keys are: HKLM and HKU.|
|\/v <ValueName>|Specifies the name of the registry entry to be added under the specified subkey.|
|\/ve|Specifies that the registry entry that is added to the registry has a null value.|
|\/t <type>|Specifies the type for the registry entry. *type* must be one of the following:<br /><br />reg\_SZ<br /><br />reg\_MULTI\_SZ<br /><br />reg\_DWOrd\_BIG\_ENDIAN<br /><br />reg\_DWOrd<br /><br />reg\_BINARY<br /><br />reg\_DWOrd\_LITTLE\_ENDIAN<br /><br />reg\_LINK<br /><br />reg\_FULL\_RESOURCE\_DESCRIPTOR<br /><br />reg\_expand\_SZ|
|\/s <Separator>|Specifies the character to be used to separate multiple instances of data when the reg\_MULTI\_SZ data type is specified and more than one entry needs to be listed. if not specified, the default separator is **\\0**.|
|\/d <Data>|Specifies the data for the new registry entry.|
|\/f|adds the registry entry without prompting for confirmation.|
|\/?|Displays help for **reg add** at the command prompt.|

## remarks

-   Subtrees cannot be added with this operation. This version of **reg** does not ask for confirmation when adding a subkey.

-   The following table lists the return values for the **reg add** operation.

|Value|Description|
|---------|---------------|
|0|Success|
|1|Failure|

-   for the reg\_expand\_SZ key type, use the caret symbol \( **^** \) with **%**" inside the \/d parameter

-

## <a name="BKMK_examples"></a>Examples
To add the key HKLM\\Software\\MyCo on remote computer ABC, type:

```
reg add \\ABC\HKLM\Software\MyCo
```

To add a registry entry to HKLM\\Software\\MyCo with a value named **Data** of type reg\_BINARY and data of **fe340ead**, type:

```
reg add HKLM\Software\MyCo /v Data /t reg_BINARY /d fe340ead
```

To add a multivalued registry entry to  HKLM\\Software\\MyCo with a value name of **MRU** of type reg\_MULTI\_SZ and data of **fax\\0mail\\0\\0**, type:

```
reg add HKLM\Software\MyCo /v MRU /t reg_MULTI_SZ /d fax\0mail\0\0
```

To add an expanded registry entry to HKLM\\Software\\MyCo with a value name of **path** of type reg\_expand\_SZ and data of **%systemroot%**, type:

```
reg add HKLM\Software\MyCo /v path /t reg_expand_SZ /d ^%systemroot^%
```

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


