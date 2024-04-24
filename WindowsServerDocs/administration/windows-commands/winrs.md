---
title: winrs
description: Reference article for the winrs command that allows you to manage and execute programs remotely.
ms.topic: reference
ms.author: jgerend
author: JasonGerend
ms.date: 04/01/2023
---
# winrs

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Windows remote Management using the winrs command enables you to manage and execute programs remotely.

## Syntax

```
winrs [/<parameter>[:<value>]] <command>
```

## Parameters

|           Parameter            |                                                                                                                                                                                    Description                                                                                                                                                                                     |
|--------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|      /remote:\<endpoint>       |                                                                                          Specifies the target endpoint using a NetBIOS name or the standard connection:<p>-   \<url\>: [\<transport>://]\<target>[:\<port>]<p>if not specified, **/r:localhost** is used.                                                                                          |
|          /unencrypted          | Specifies that the messages to the remote shell aren't encrypted. This parameter is useful for troubleshooting or when the network traffic is already encrypted using **ipsec**, or when physical security is enforced.<p>By default, the messages are encrypted using Kerberos or NTLM keys.<p>This command-line option is ignored when HTTPS transport is selected. |
|     /username:\<username>      |                                                                                Specifies username on command line.<p>If not specified, the tool uses Negotiate authentication or prompt for the name.<p>If **/username** is specified, **/password** must also be specified.                                                                                 |
|     /password:\<password>      |                                                                           Specifies password on command line.<p>If **/password** isn't specified but **/username** is, the tool prompts for the password.<p>If **/password** is specified, **/username** must also be specified.                                                                            |
|      /timeout:\<seconds>       |                                                                                                                                                                             This option is deprecated.                                                                                                                                                                             |
|       /directory:\<path>       |                                                                                            Specifies starting directory for remote shell.<p>If not specified, the remote shell starts in the user's home directory defined by the environment variable **%USERPROFILE%**.                                                                                             |
| /environment:\<string>=\<value\> |                                                                          Specifies a single environment variable to be set when shell starts, which allows changing default environment for shell.<p>Multiple occurrences of this switch must be used to specify multiple environment variables.                                                                          |
|            /noecho             |                                                                                                    Specifies that echo should be disabled. noecho may be necessary to ensure that user's answers to remote prompts aren't displayed locally.<p>By default echo is on.                                                                                                    |
|           /noprofile           |                                              Specifies that the user's profile shouldn't be loaded.<p>By default, the server attempts to load the user profile.<p>If the remote user isn't a local administrator on the target system, then this option is required (the default results in error.)                                               |
|         /allowdelegate         |                                                                                                                  Specifies that the user's credentials can be used to access a remote share, for example, a different machine than the target endpoint.                                                                                                                   |
|          /compression          |                                                                           Turn on compression.  Older installations on remote machines might not support compression. <p>Default setting is off because older installations on remote machines might not support compression.                                                                           |
|            /usessl             |                                                                                                               Use an SSL connection when using a remote endpoint.  Specifying SSL instead of the transport **https:** uses the default **WinRM** default port.                                                                                                                |
|               /?               |                                                                                                                                                                        Displays help at the command prompt.                                                                                                                                                                        |

## Remarks

- All command-line options accept either short form or long form. For example, both **/r** and **/remote** are valid.
- To terminate the **/remote** command, the user can type **Ctrl-C** or **Ctrl-break**, which is sent to the remote shell. The second **Ctrl-C** forces termination of **winrs.exe**.
- To manage active remote shells or winrs configuration, use the WinRM tool.  The URI alias to manage active shells is **shell/cmd**.  The URI alias for winrs configuration is **winrm/config/winrs**.

## Examples

```
winrs /r:https://contoso.com command
```

```
winrs /r:contoso.com /usessl command
```

```
winrs /r:myserver command
```

```
winrs /r:http://127.0.0.1 command
```

```
winrs /r:http://169.51.2.101:80 /unencrypted command
```

```
winrs /r:https://[::FFFF:129.144.52.38] command
```

```
winrs /r:http://[1080:0:0:0:8:800:200C:417A]:80 command
```

```
winrs /r:https://contoso.com /t:600 /u:administrator /p:$%fgh7 ipconfig
```

```
winrs /r:myserver /env:path=^%path^%;c:\tools /env:TEMP=d:\temp config.cmd
```

```
winrs /r:myserver netdom join myserver /domain:testdomain /userd:johns /passwordd:$%fgh789
```

```
winrs /r:myserver /ad /u:administrator /p:$%fgh7 dir \\anotherserver\share
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)