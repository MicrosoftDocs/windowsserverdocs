---
title: jetpack
description: Reference article for the jetpack command, which compacts a Windows Internet Name Service (WINS) or Dynamic Host Configuration Protocol (DHCP) database.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# jetpack



Compacts a Windows Internet Name Service (WINS) or Dynamic Host Configuration Protocol (DHCP) database. We recommend you compact the WINS database whenever it approaches 30 MB.

Jetpack.exe compacts the database by:

1. Copying the database information to a temporary database file.

2. Deleting the original database file, either WINS or DHCP.

3. Renames the temporary database files to the original filename.

## Syntax

```
jetpack.exe <database_name> <temp_database_name>
```

### Parameters

| Parameter | Description |
| ------- | -------- |
| `<database_name>` | Specifies the name of the original database file. |
| `<temp_database_name>` | Specifies the name of the temporary database file to be created by jetpack.exe.<p>Note: This temporary file is removed when the compact process is complete. For this command to work properly, you must make sure your temp file name is unique and that a file with that name doesn't already exist. |
| /? | Displays help at the command prompt. |

### Examples

To compact the WINS database, where **Tmp.mdb** is a temporary database and **Wins.mdb** is the WINS database, type:

```
cd %SYSTEMROOT%\SYSTEM32\WINS
NET STOP WINS
jetpack Wins.mdb Tmp.mdb
NET start WINS
```

To compact the DHCP database, where **Tmp.mdb** is a temporary database and **Dhcp.mdb** is the DHCP database, type:

```
cd %SYSTEMROOT%\SYSTEM32\DHCP
NET STOP DHCPSERVER
jetpack Dhcp.mdb Tmp.mdb
NET start DHCPSERVER
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
