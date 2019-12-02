---
title: Using ETW to troubleshoot LDAP connections
description: How to turn on and use ETW to trace LDAP connections between AD DS domain controllers.
audience: Admin
ms.custom:
- CI ID 110964
- CSSTroubleshoot 
author: Teresa-Motiv
manager: dcscontentpm
ms.prod: windows-server-dev
ms.technology: active-directory-lightweight-directory-services
ms.tgt_platform: multiple
keywords:
- event tracing LDAP
audience: Admin
ms.author: v-tea
ms.topic: article
ms.date: 11/22/2019
---

# Using ETW to troubleshoot LDAP connections

[Event Tracing for Windows (ETW)](https://docs.microsoft.com/windows/win32/etw/event-tracing-portal) can be a valuable troubleshooting tool for Active Directory Domain Services (AD DS). You can use ETW to trace the Lightweight Directory Access Protocol ([LDAP](https://docs.microsoft.com/previous-versions/windows/desktop/ldap/lightweight-directory-access-protocol-ldap-api)) communications between Windows clients and LDAP servers, including AD DS domain controllers.

## How to turn on ETW and start a trace

**To turn on ETW**

1. Open Registry Editor, and create the following registry subkey:

   **HKEY\_LOCAL\_MACHINE\\System\\CurrentControlSet\\Services\\ldap\\Tracing\\*ProcessName***

   In this subkey, *ProcessName* is the full name of the process that you want to trace, including its extension (for example, "Svchost.exe").

1. (**Optional**) Under this subkey, create a new entry that is named **PID**. To use this entry, assign a process ID as a DWORD value.  

   If you specify a process ID, ETW traces only the instance of the application that has this process ID.

**To start a tracing session**

- Open a Command Prompt window, and run the following command:

   ```cmd
   tracelog.exe -start <SessionName> -guid \#099614a5-5dd7-4788-8bc9-e29f43db28fc -f <FileName> -flag <TraceFlags>
   ```

   The placeholders in this command represent the following values.

  - \<*SessionName*> is an arbitrary identifier that is used to label the tracing session.  
  > [!NOTE]  
  > You will have to refer to this session name later when you stop the tracing session.
  - \<*FileName*> specifies the log file to which events will be written.
  - \<*TraceFlags*> should be one or more of the values that are listed in the [trace flags table](#values-for-trace-flags).

## How to end a tracing session and turn off Event Tracing

**To stop tracing**

- At the command prompt, run the following command:

   ```cmd
   tracelog.exe -stop <SessionName>
   ```

   In this command, \<*SessionName*> is the same name that you used in the **tracelog.exe -start** command.

**To turn off ETW**

- In Registry Editor, delete the **HKEY\_LOCAL\_MACHINE\\System\\CurrentControlSet\\Services\\ldap\\Tracing\\*ProcessName*** subkey.

## Values for trace flags

To use a flag, substitute the flag value for the <*TraceFlags*> placeholder in the arguments of the **tracelog.exe -start** command.

> [!NOTE]  
> You can specify multiple flags by using the sum of the appropriate flag values. For example, to specify the **DEBUG\_SEARCH** (0x00000001) and **DEBUG\_CACHE** (0x00000010) flags, the appropriate \<*TraceFlags*> value is **0x00000011**.

|Flag name |Flag value |Flag description |
| --- | --- | --- |
|**DEBUG_SEARCH** |0x00000001 |Logs search requests and the parameters that are passed to those requests. Responses are not logged here. Only the search requests are logged. (Use **DEBUG_SPEWSEARCH** to log the responses to search requests.) |
|**DEBUG_WRITE** |0x00000002 |Logs write requests and the parameters that are passed to those requests. Write requests include the add, delete, modify, and extended operations. |
|**DEBUG_REFCNT** |0x00000004 |Logs reference counting data and operations for connections and requests. |
|**DEBUG_HEAP** |0x00000008 |Logs all memory allocations and memory releases. |
|**DEBUG_CACHE** |0x00000010 |Logs cache activity. This activity includes adds, removes, hits, misses, and so on. |
|**DEBUG_SSL** |0x00000020 |Logs SSL information and errors. |
|**DEBUG_SPEWSEARCH** |0x00000040 |Logs all server responses to search requests. These responses include the attributes that were requested, plus all data that was received. |
|**DEBUG_SERVERDOWN** |0x00000080 |Logs server-down and connection errors. |
|**DEBUG_CONNECT** |0x00000100 |Logs data that is related to establishing a connection.<br />Use **DEBUG_CONNECTION** to log other data that is related to connections. |
|**DEBUG_RECONNECT** |0x00000200 |Logs automatic reconnect activity. This activity includes reconnect attempts, failures, and related errors. |
|**DEBUG_RECEIVEDATA** |0x00000400 |Logs activity that is related to receiving messages from the server. This activity includes events such as "waiting on the response from the server" and the response that is received from the server. |
|**DEBUG_BYTES_SENT** |0x00000800 |Logs all data sent by the LDAP client to the server. This function is essentially packet logging, but it always logs unencrypted data. (If a packet is sent over SSL, this function logs the unencrypted packet.) This logging can be verbose. This flag is probably best used on its own or combined with **DEBUG_BYTES_RECEIVED**. |
|**DEBUG_EOM** |0x00001000 |Logs events that are related to reaching the end of a message list. These events include information such as "message list cleared" and so on. |
|**DEBUG_BER** |0x00002000 |Logs operations and errors that are related to Basic Encoding Rules (BER). These operations and errors include problems in encoding, buffer size problems, and so on. |
|**DEBUG_OUTMEMORY** |0x00004000 |Logs failures to allocate memory. Also logs any failure to compute the required memory (for example, an overflow that occurs when computing the required buffer size). |
|**DEBUG_CONTROLS** |0x00008000 |Logs data that relates to controls. This data includes controls that are inserted, problems that affect controls, mandatory controls on a connection, and so on. |
|**DEBUG_BYTES_RECEIVED** |0x00010000 |Logs all data that is received by the LDAP client. This behavior is essentially packet logging, but it always logs unencrypted data. (If a packet is sent over SSL, this option logs the unencrypted packet.) This type of logging can be verbose. This flag is probably best used on its own or combined with **DEBUG_BYTES_SENT**. |
|**DEBUG_CLDAP** |0x00020000 |Logs events that are specific to UDP and connectionless LDAP. |
|**DEBUG_FILTER** |0x00040000 |Logs events and errors that are encountered when you construct a search filter.<br/>**Note** This option logs client events only during filter construction. It does not log any responses from the server about a filter. |
|**DEBUG_BIND** |0x00080000 |Logs bind events and errors. This data includes negotiation information, bind success, bind failure, and so on. |
|**DEBUG_NETWORK_ERRORS** |0x00100000 |Logs general network errors. This data includes send and receive errors.<br/>**Note** If a connection is lost or the server cannot be reached, **DEBUG_SERVERDOWN** is the preferred tag. |
|**DEBUG_VERBOSE** |0x00200000 |Logs general messages. Use this option for any messages that tend to generate a large amount of output. For example, it logs messages such as "end of message reached," "server has not responded yet," and so on. This option is also useful for generic messages. |
|**DEBUG_PARSE** |0x00400000 |Logs general message events and errors plus packet parsing and encoding events and errors. |
|**DEBUG_REFERRALS** |0x00800000 |Logs data about referrals and chasing referrals. |
|**DEBUG_REQUEST** |0x01000000 |Logs tracking of requests. |
|**DEBUG_CONNECTION** |0x02000000 |Logs general connection data and errors. |
|**DEBUG_INIT_TERM** |0x04000000 |Logs module initialization and cleanup (DLL Main, and so on). |
|**DEBUG_API_ERRORS** |0x08000000 |Supports logging incorrect use of the API. For example, this option logs data if the bind operation is called two times on the same connection. |
|**DEBUG_ERRORS** |0x10000000 |Logs general errors. Most of these errors can be categorized as module initialization errors, SSL errors, or overflow or underflow errors. |
|**DEBUG_PERFORMANCE** |0x20000000 |Logs data about process-global LDAP activity statistics after receiving a server response for an LDAP request. |

## Example

Consider an application, App1.exe, that sets passwords for user accounts. Suppose that App1.exe produces an unexpected error. To use ETW to help diagnose this problem, you follow these steps:

1. In Registry Editor, create the following registry entry:

   **HKEY\_LOCAL\_MACHINE\\System\\CurrentControlSet\\Services\\ldap\\Tracing\\App1.exe**

1. To start a tracing session, open a Command Prompt window, and run the following command:

   ```cmd
   tracelog.exe -start ldaptrace -guid \#099614a5-5dd7-4788-8bc9-e29f43db28fc -f .\ldap.etl -flag 0x80000
   ```

   After this command starts, **DEBUG\_BIND** makes sure that ETW writes tracing messages to .\\ldap.etl.

1. Start App1.exe, and reproduce the unexpected error.

1. To stop the tracing session, run the following command at the command prompt:

   ```cmd
    tracelog.exe -stop ldaptrace
   ```

1. To prevent other users from tracing the application, delete the **HKEY\_LOCAL\_MACHINE**\\**System**\\**CurrentControlSet**\\**Services**\\**ldap**\\**Tracing**\\**App1.exe** registry entry.

1. To review the information in the trace log, run the following command at the command prompt:

   ```cmd
    tracerpt.exe .\ldap.etl -o -report
    ```

   > [!NOTE]  
   > In this command, **tracerpt.exe** is a [trace consumer](https://go.microsoft.com/fwlink/p/?linkid=83876) tool.
