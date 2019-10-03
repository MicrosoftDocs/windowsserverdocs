---
title: telnet
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b70a6156-9413-4300-84ce-a34c467e2b4e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# telnet

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Communicates with a computer running the telnet Server service. 
## Syntax
```
telnet [/a] [/e <EscapeChar>] [/f <FileName>] [/l <UserName>] [/t {vt100 | vt52 | ansi | vtnt}] [<Host> [<Port>]] [/?]
```
### Parameters
|Parameter|Description|
|-------|--------|
|/a|attempt automatic logon. Same as /l option except uses the currently logged on user s name.|
|/e \<EscapeChar>|Escape character used to enter the telnet client prompt.|
|/f \<FileName>|File name used for client side logging.|
|/l \<UserName>|Specifies the user name to log on with on the remote computer.|
|/t {vt100 &#124; vt52 &#124; ansi &#124; vtnt}|Specifies the terminal type. Supported terminal types are vt100, vt52, ansi, and vtnt.|
|\<Host> [\<Port>]|Specifies the hostname or IP address of the remote computer to connect to, and optionally the TCP port to use (default is TCP port 23).|
|/?|Displays help at the command prompt. Alternatively, you can type /h.|

## Remarks
-   You must install the telnet client software before you can run this command. For more information, see [Installing telnet](https://technet.microsoft.com/library/cc754293(v=ws.10).aspx).
-   You can run telnet without parameters to enter the telnet context, indicated by the telnet prompt (**Microsoft telnet>**). From the telnet prompt, you can use telnet commands to manage the computer running the telnet client.

## <a name="BKMK_Examples"></a>Examples
Use telnet to connect to the computer running the telnet Server Service at telnet.microsoft.com.
```
telnet telnet.microsoft.com
```
Use telnet to connect to the computer running the telnet Server Service at telnet.microsoft.com on TCP port 44 and log the session activity in a local file called telnetlog.txt
```
telnet /f telnetlog.txt telnet.microsoft.com 44
```

## additional references
-   [Installing telnet](https://technet.microsoft.com/library/cc754293(v=ws.10).aspx)
-   [telnet Technical Reference](https://technet.microsoft.com/library/cc754987(v=ws.10).aspx)
-   [Command-Line Syntax Key](command-line-syntax-key.md)
