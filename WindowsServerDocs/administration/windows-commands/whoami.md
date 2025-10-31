---
title: whoami
description: Reference article for whoami, which displays user, group and privileges information for the user who is currently logged on to the local system.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 05/23/2025
---

# whoami

The `whoami` command shows information about the user, groups, and privileges for the account currently logged on to the local system. When run without any parameters, `whoami` returns the current domain and user name.

## Syntax

```
whoami [/upn | /fqdn | /logonid]
whoami {[/user] [/groups] [/claims] [/priv]} [/fo <format>] [/nh]
whoami /all [/fo <format>] [/nh]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|:::no-loc text="/upn":::|Displays the user name in user principal name (UPN) format.|
|:::no-loc text="/fqdn":::|Displays the user name in fully qualified domain name (FQDN) format.|
|:::no-loc text="/logonid":::|Displays the logon ID of the current user.|
|:::no-loc text="/user":::|Displays the current domain and user name and the security identifier (SID).|
|:::no-loc text="/groups":::|Displays the user groups to which the current user belongs.|
|:::no-loc text="/claims":::|Displays the claims for current user, such as claim name, flags, type and values.|
|:::no-loc text="/priv":::|Displays the security privileges of the current user.|
|:::no-loc text="/fo"::: \<format>|Specifies the output format. Valid values include:<br><br><li> **table** - Displays output in a table. This is the default value. <li> **:::no-loc text="list":::** - Displays output in a list. <li> **csv** - Displays output in comma-separated value (CSV) format. </li>|
|:::no-loc text="/all":::|Displays all information in the current access token, including the current user name, security identifiers (SID), privileges, and groups that the current user belongs to.|
|:::no-loc text="/nh":::|Specifies that the column header shouldn't be displayed in the output. This is valid only for table and CSV formats.|
|:::no-loc text="/?":::|Displays help at the command prompt.|

## Examples

To display the domain and user name of the person who is currently logged on to this computer, type:

```
whoami
```

Output similar to the following appears:

```
DOMAIN1\administrator
```

To display all of the information in the current access token, type:

```
whoami /all
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
