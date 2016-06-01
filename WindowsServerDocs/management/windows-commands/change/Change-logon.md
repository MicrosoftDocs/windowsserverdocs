---
title: Change logon
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 41466260-aee9-4333-bcb6-178112c22afd
author: Lizap
---
# Change logon
Enables or disables logons from client sessions, or displays current logon status.

This utility is useful for system maintenance.

For examples of how to use this command, see [Examples](#BKMK_examples).

> [!NOTE]
> [!INCLUDE[rd_note-cmd-line-ref](includes/rd_note-cmd-line-ref_md.md)]

## Syntax

```
change logon {/query | /enable | /disable | /drain | /drainuntilrestart}
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\/query|Displays the current logon status, whether enabled or disabled.|
|\/enable|Enables logons from client sessions, but not from the console.|
|\/disable|Disables subsequent logons from client sessions, but not from the console. Does not affect currently logged on users.|
|\/drain|Disables logons from new client sessions, but allows reconnections to existing sessions.|
|\/drainuntilrestart|Disables logons from new client sessions until the computer is restarted, but allows reconnections to existing sessions.|
|\/?|Displays help at the command prompt.|

## Remarks

-   Only administrators can use the **change logon** command.

-   Logons are re\-enabled when you restart the system. If you are connected to the Remote Desktop Session Host \(RD Session Host\) server from a client session and disable logons, and then log off before re\-enabling logons, you will not be able to reconnect to your session. To re\-enable logons from client sessions, log on at the console.

## <a name="BKMK_examples"></a>Examples

-   To display the current logon status, type:

    ```
    change logon /query
    ```

-   To enable logons from client sessions, type:

    ```
    change logon /enable
    ```

-   To disable client logons, type:

    ```
    change logon /disable
    ```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Change](Change.md)

[Remote Desktop Services &#40;Terminal Services&#41; Command Reference](Remote-Desktop-Services--Terminal-Services--Command-Reference.md)


