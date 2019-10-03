---
title: eventcreate
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f2b1b26d-a70e-49a6-832b-91eb5a1a159a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# eventcreate



Enables an administrator to create a custom event in a specified event log. For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
eventcreate [/s <Computer> [/u <Domain\User> [/p <Password>]] {[/l {APPLICATION|SYSTEM}]|[/so <SrcName>]} /t {ERROR|WARNING|INFORMATION|SUCCESSAUDIT|FAILUREAUDIT} /id <EventID> /d <Description>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/s \<Computer>|Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer.|
|/u \<Domain\User>|Runs the command with the account permissions of the user specified by \<User> or <Domain\User>. The default is the permissions of the current logged on user on the computer issuing the command.|
|/p \<Password>|Specifies the password of the user account that is specified in the **/u** parameter.|
|/l {APPLICATION\|SYSTEM}|Specifies the name of the event log where the event will be created. The valid log names are APPLICATION and SYSTEM.|
|/so \<SrcName>|Specifies the source to use for the event. A valid source can be any string and should represent the application or component that is generating the event.|
|/t {ERROR\|WARNING\|INFORMATION\|</br>SUCCESSAUDIT\|FAILUREAUDIT}|Specifies the type of event to create. The valid types are ERROR, WARNING, INFORMATION, SUCCESSAUDIT, and FAILUREAUDIT.|
|/id \<EventID>|Specifies the event ID for the event. A valid ID is any number from 1 to 1000.|
|/d \<Description>|Specifies the description to use for the newly created event.|
|/?|Displays help at the command prompt.|

## Remarks

-   Custom events cannot be written to the security log.

## <a name="BKMK_examples"></a>Examples

The following examples show how you can use the eventcreate command:
```
eventcreate /t error /id 100 /l application /d "Create event in application log"
eventcreate /t information /id 1000 /so winmgmt /d "Create event in WinMgmt source"
eventcreate /t error /id 2001 /so winword /l application /d "new src Winword in application log"
eventcreate /s server /t error /id 100 /l application /d "Remote machine without user credentials"
eventcreate /s server /u user /p password /id 100 /t error /l application /d "Remote machine with user credentials"
eventcreate /s server1 /s server2 /u user /p password /id 100 /t error /so winmgmt /d "Creating events on Multiple remote machines"
eventcreate /s server /u user /id 100 /t warning /so winmgmt /d "Remote machine with partial user credentials"
```

#### Additional References

[Command-Line Syntax Key](command-line-syntax-key.md)
