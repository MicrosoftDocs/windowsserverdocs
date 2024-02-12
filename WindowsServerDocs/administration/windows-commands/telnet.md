---
title: telnet
description: Reference article for the telnet command, which communicates with a computer running the telnet server service.
ms.topic: reference
ms.assetid: b70a6156-9413-4300-84ce-a34c467e2b4e
ms.author: jgerend
author: JasonGerend
ms.date: 6/21/2022
---

# telnet

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Communicates with a computer running the telnet server service. Running this command without any parameters, lets you enter the telnet context, as indicated by the telnet prompt (**Microsoft telnet>**). From the telnet prompt, you can use telnet commands to manage the computer running the telnet client.

> [!IMPORTANT]
> You must install the telnet client software before you can run this command. For more information, see [Installing telnet](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754293(v=ws.10)).

## Syntax

```
telnet [/a] [/e <escapechar>] [/f <filename>] [/l <username>] [/t {vt100 | vt52 | ansi | vtnt}] [<host> [<port>]] [/?]
```

### Parameters

| Parameter | Description |
|--|--|
| /a | Attempts automatic logon. Same as **/l** option, except that it uses the currently logged on user's name. |
| /e `<escapechar>` | Specifies the escape character used to enter the telnet client prompt. |
| /f `<filename>` | Specifies the file name used for client side logging. |
| /l `<username>` | Specifies the user name to log on with on the remote computer. |
| /t `{vt100 | vt52 | ansi | vtnt}` | Specifies the terminal type. Supported terminal types are **vt100**, **vt52**, **ansi**, and **vtnt**. |
| `<host> [<port>]` | Specifies the hostname or IP address of the remote computer to connect to, and optionally the TCP port to use (default is TCP port 23). |
| /? | Displays help at the command prompt. |

## Examples

To use telnet to connect to the computer running the telnet Server Service at *telnet.microsoft.com*, type:

```
telnet telnet.microsoft.com
```

To use telnet to connect to the computer running the telnet Server Service at *telnet.microsoft.com* on TCP port 44 and to log the session activity in a local file called *telnetlog.txt*, type:

```
telnet /f telnetlog.txt telnet.microsoft.com 44
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Installing telnet](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754293(v=ws.10))

- [telnet Technical Reference](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754987(v=ws.10))
