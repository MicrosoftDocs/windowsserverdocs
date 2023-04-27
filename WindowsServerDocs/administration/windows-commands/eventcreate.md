---
title: eventcreate
description: Reference article for the eventcreate command, which enables an administrator to create a custom event in a specified event log.
ms.topic: reference
ms.assetid: f2b1b26d-a70e-49a6-832b-91eb5a1a159a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# eventcreate

Enables an administrator to create a custom event in a specified event log.

> [!IMPORTANT]
> Custom events can't be written to the security log.

## Syntax

```
eventcreate [/s <computer> [/u <domain\user> [/p <password>]] {[/l {APPLICATION|SYSTEM}]|[/so <srcname>]} /t {ERROR|WARNING|INFORMATION|SUCCESSAUDIT|FAILUREAUDIT} /id <eventID> /d <description>
```

### Parameters

| Parameter | Description |
| --------- |------------ |
| /s `<computer>` | Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer. |
| /u `<domain\user>` | Runs the command with the account permissions of the user specified by `<user>` or `<domain\user>`. The default is the permissions of the current logged on user on the computer issuing the command. |
| /p `<password>` | Specifies the password of the user account that is specified in the **/u** parameter. |
| /l `{APPLICATION | SYSTEM}` | Specifies the name of the event log where the event will be created. The valid log names are **APPLICATION** or **SYSTEM**. |
| /so `<srcname>` | Specifies the source to use for the event. A valid source can be any string and should represent the application or component that is generating the event. |
| /t `{ERROR | WARNING | INFORMATION | SUCCESSAUDIT | FAILUREAUDIT}` | Specifies the type of event to create. The valid types are **ERROR**, **WARNING**, **INFORMATION**, **SUCCESSAUDIT**, and **FAILUREAUDIT**. |
| /id `<eventID>` | Specifies the event ID for the event. A valid ID is any number from 1 to 1000. |
| /d `<description>` | Specifies the description to use for the newly created event. |
| /? | Displays help at the command prompt. |

### Examples

The following examples show how you can use the **eventcreate** command:

```
eventcreate /t ERROR /id 100 /l application /d "Create event in application log"
eventcreate /t INFORMATION /id 1000 /d "Create event in WinMgmt source"
eventcreate /t ERROR /id 201 /so winword /l application /d "New src Winword in application log"
eventcreate /s server /t ERROR /id 100 /l application /d "Remote machine without user credentials"
eventcreate /s server /u user /p password /id 100 /t ERROR /l application /d "Remote machine with user credentials"
eventcreate /s server1 /s server2 /u user /p password /id 100 /t ERROR /d "Creating events on Multiple remote machines"
eventcreate /s server /u user /id 100 /t WARNING /d "Remote machine with partial user credentials"
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
