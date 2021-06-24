---
title: winrs
description: Reference article for winrs, which allows you to manage and execute programs remotely.
ms.topic: reference
ms.assetid: c370de31-5651-400a-872d-ef229aae2309
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# winrs

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Windows remote Management allows you to manage and execute programs remotely.
## Syntax
```
winrs [/<parameter>[:<value>]] <command>
```
#### Parameters

|           Parameter            |                                                                                                                                                                                    Description                                                                                                                                                                                     |
|--------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|      /remote:\<endpoint>       |                                                                                          Specifies the target endpoint using a NetBIOS name or the standard connection:<p>-   <url>: [\<transport>://]\<target>[:\<port>]<p>if not specified, **/r:localhost** is used.                                                                                          |
|          /unencrypted          | Specifies that the messages to the remote shell will not be encrypted. This is useful for troubleshooting or when the network traffic is already encrypted using **ipsec**, or when physical security is enforced.<p>By default, the messages are encrypted using Kerberos or NTLM keys.<p>This command-line option is ignored when HTTPS transport is selected. |
|     /username:\<username>      |                                                                                Specifies username on command line.<p>if not specified, the tool will use Negotiate authentication or prompt for the name.<p>if **/username** is specified, **/password** must also be specified.                                                                                 |
|     /password:\<password>      |                                                                           Specifies password on command line.<p>if **/password** is not specified but **/username** is, the tool will prompt for the password.<p>if **/password** is specified, **/username** must also be specified.                                                                            |
|      /timeout:\<seconds>       |                                                                                                                                                                             This option is deprecated.                                                                                                                                                                             |
|       /directory:\<path>       |                                                                                            Specifies starting directory for remote shell.<p>if not specified, the remote shell will start in the user's home directory defined by the environment variable **%USERPROFILE%**.                                                                                             |
| /environment:\<string>=<value> |                                                                          Specifies a single environment variable to be set when shell starts, which allows changing default environment for shell.<p>Multiple occurrences of this switch must be used to specify multiple environment variables.                                                                          |
|            /noecho             |                                                                                                    Specifies that echo should be disabled. This may be necessary to ensure that user's answers to remote prompts are not displayed locally.<p>By default echo is on.                                                                                                    |
|           /noprofile           |                                              Specifies that the user's profile should not be loaded.<p>By default, the server will attempt to load the user profile.<p>if the remote user is not a local administrator on the target system, then this option will be required (the default will result in error).                                               |
|         /allowdelegate         |                                                                                                                  Specifies that the user's credentials can be used to access a remote share, for example, found on a different machine than the target endpoint.                                                                                                                   |
|          /compression          |                                                                           Turn on compression.  Older installations on remote machines may not support compression so it is off by default.<p>Default setting is off, since older installations on remote machines may not support compression.                                                                           |
|            /usessl             |                                                                                                               Use an SSL connection when using a remote endpoint.  Specifying this instead of the transport **https:** will use the default **WinRM** default port.                                                                                                                |
|               /?               |                                                                                                                                                                        Displays help at the command prompt.                                                                                                                                                                        |

## Remarks
-   All command-line options accept either short form or long form. For example both **/r** and **/remote** are valid.
-   To terminate the **/remote** command, the user can type **Ctrl-C** or **Ctrl-break**, which will be sent to the remote shell. The second **Ctrl-C** will force termination of **winrs.exe**.
-   To manage active remote shells or winrs configuration, use the WinRM tool.  The URI alias to manage active shells is **shell/cmd**.  The URI alias for winrs configuration is **winrm/config/winrs**.

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

## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)

