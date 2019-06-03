---
title: tlntadmn
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 78b61e8d-b953-44bb-8d57-f3b42da9e7a8 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# tlntadmn

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Administers a local or remote computer that is running the telnet Server Service.   
## Syntax  
```  
tlntadmn [<computerName>] [-u <UserName>] [-p <Password>] [{start | stop | pause | continue}] [-s {<SessionID> | all}] [-k {<SessionID> | all}] [-m {<SessionID> | all}  <Message>] [config [dom = <Domain>] [ctrlakeymap = {yes | no}] [timeout = <hh>:<mm>:<ss>] [timeoutactive = {yes | no}] [maxfail = <attempts>] [maxconn = <Connections>] [port = <Number>] [sec {+ | -}NTLM {+ | -}passwd] [mode = {console | stream}]] [-?]  
```  
### Parameters  

|                   Parameter                    |                                                                                                                                                       Description                                                                                                                                                        |
|------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                \<computerName>                 |                                                                                                                    Specifies the name of the server to connect to. The default is the local computer.                                                                                                                    |
|         -u \<UserName> -p \<Password>          |                                                Specifies administrative credentials for a remote server that you want to administer. This parameter is required if you want to administer a remote server to which you are not logged on with administrative credentials.                                                |
|                     start                      |                                                                                                                                            starts the telnet Server Service.                                                                                                                                             |
|                      stop                      |                                                                                                                                             Stops the telnet Server Service                                                                                                                                              |
|                     pause                      |                                                                                                                          pauses the telnet Server Service. No new connections will be accepted.                                                                                                                          |
|                    continue                    |                                                                                                                                            Resumes the telnet Server Service.                                                                                                                                            |
|          -s {\<SessionID> &#124; all}          |                                                                                                                                             Displays active telnet sessions.                                                                                                                                             |
|          -k {\<SessionID> &#124; all}          |                                                                                                        Ends telnet sessions. type the Session ID to end a specific session, or type all to end all the sessions.                                                                                                         |
|    -m {\<SessionID> &#124; all}  <Message>     |                                                   Sends a message to one or more sessions. type the session ID to send a message to a specific session, or type all to send a message to all sessions. type the message that you want to send between quotation marks.                                                   |
|             config dom = \<Domain>             |                                                                                                                                      Configures the default domain for the server.                                                                                                                                       |
|      config ctrlakeymap = {yes &#124; no}      |                                                                                     Specifies if you want the telnet server to interpret CTRL+A as ALT. type **yes** to map the shortcut key, or type **no** to prevent the mapping.                                                                                     |
|       config timeout = \<hh>:\<mm>:\<ss>       |                                                                                                                                 Sets the time-out period in hours, minutes, and seconds.                                                                                                                                 |
|     config timeoutactive = {yes &#124; no      |                                                                                                                                            Enables the idle session timeout.                                                                                                                                             |
|          config maxfail = \<attempts>          |                                                                                                                          Sets the maximum number of failed logon attempts before disconnecting.                                                                                                                          |
|        config maxconn = \<Connections>         |                                                                                                                                         Sets the maximum number of connections.                                                                                                                                          |
|            config port = <\Number>             |                                                                                                                    Sets the telnet port. You must specify the port with an integer smaller than 1024.                                                                                                                    |
| config sec {+ &#124; -}NTLM {+ &#124; -}passwd | Specifies whether you want to use NTLM, a password, or both to authenticate logon attempts. To use a particular type of authentication, type a plus sign (**+**) before that type of authentication. To prevent using a particular type of authentication, type a minus sign (**-**) before that type of authentication. |
|     config mode = {console &#124; stream}      |                                                                                                                                             Specifies the mode of operation.                                                                                                                                             |
|                       -?                       |                                                                                                                                           Displays help at the command prompt.                                                                                                                                           |

## Remarks  
-   To display the server settings, type **tlntadmn** without any parameters.  
-   To use the **tlntadmn** command, you must log on to the local computer with administrative credentials. To administer a remote computer, you must also provide administrative credentials for the remote computer. You can do so by logging on to the local computer with an account that has administrative credentials for both the local computer and the remote computer. If you cannot use this method, you can use the **-u** and **-p** parameters to provide administrative credentials for the remote computer.  

## <a name="BKMK_Examples"></a>Examples  
Configure the idle session timeout to 30 minutes.  
```  
tlntadmn config timeout=0:30:0  
```  
Display active telnet sessions.  
```  
tlntadmn -s  
```  

## Additional references  
-   [telnet Operations Guide](https://technet.microsoft.com/library/cc753164(v=ws.10).aspx)  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
