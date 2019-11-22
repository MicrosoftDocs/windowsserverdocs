---
title: Event Tracing in LDAP Applications
description: 
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
ms.date: 11/18/2019
---

# Event Tracing in LDAP Applications

Event Tracing for Windows ([ETW](https://docs.microsoft.com/windows/win32/etw/event-tracing-portal)) for applications that use [Lightweight Directory Access Protocol](https://docs.microsoft.com/previous-versions/windows/desktop/ldap/lightweight-directory-access-protocol-ldap-api). Certain areas of the LDAP Provider have an underlying implementation that is complex or that involves a sequence of steps that makes diagnosis of problems in these areas more difficult. ETW can be a valuable troubleshooting tool.

## How to turn on Event Tracing and start a trace

**To turn on LDAP client tracing**

1. Open Registry Editor and create the following registry subkey:

   **HKEY\_LOCAL\_MACHINE\\System\\CurrentControlSet\\Services\\ldap\\Tracing\\*ProcessName***

   ***ProcessName*** is the full name of the process that you want to trace, including its extension (for example, "Svchost.exe").

1. **Optional**. Under this subkey, create a new entry that has the name **PID** and a DWORD value. To use this entry, set the value to a process ID.  

   When you specify a process ID, ETW traces only the instance of the application that has this process ID.

**To start a tracing session**

- Open a Command Prompt window, and run the following command:

   ```cmd
   tracelog.exe -start <SessionName> -guid \#099614a5-5dd7-4788-8bc9-e29f43db28fc -f <FileName> -flag <TraceFlags>
   ```

   The placeholders in this command represent the following values.

  - \<*SessionName*> is an arbitrary identifier that is used to label the tracing session (you will need to refer to this session name later when you stop the tracing session).
  - \<*FileName*> specifies the log file to which events will be written.
  - \<*TraceFlags*> should be one or more of the values that are listed in the [trace flags table](#values-for-trace-flags).

## How to end a tracing session and turn off Event Tracing

**To stop tracing**

- At the command prompt, run the following command:

   ```cmd
   tracelog.exe -stop <SessionName>
   ```

   In this command, \<*SessionName*> is the same name as was used in the **tracelog.exe -start** command.

**To turn off Event Tracing**

- In Registry Editor, delete the **HKEY\_LOCAL\_MACHINE\\System\\CurrentControlSet\\Services\\ldap\\Tracing\\*ProcessName*** subkey.


## Values for trace flags

To use a flag, substitute the flag value for the <*TraceFlags*> placeholder in the arguments of the **tracelog.exe -start** command.

> [!NOTE]  
> You can specify multiple flags by using the sum of the appropriate flag values. For example, to specify the **DEBUG\_SEARCH** (0x00000001) and **DEBUG\_CACHE** (0x00000010) flags, the appropriate \<*TraceFlags*> value is **0x00000011**.

|Flag name |Flag value |Flag description |
| --- | --- | --- |
|**DEBUG_SEARCH** |0x00000001 |Logs search requests and the parameters passed to those requests. Responses are not logged here, only the search requests. (Use **DEBUG_SPEWSEARCH** to log the responses to search requests.) |
|**DEBUG_WRITE** |0x00000002 |Logs write requests and the parameters passed to those requests. Write requests include the add, delete, modify, and extended operations. |
|**DEBUG_REFCNT** |0x00000004 |Logs reference counting data and operations for connections and requests. |
|**DEBUG_HEAP** |0x00000008 |Logs all memory allocations and memory frees. |
|**DEBUG_CACHE** |0x00000010 |Logs cache activity. This activity includes adds, removes, hits, misses, and so on. |
|**DEBUG_SSL** |0x00000020 |Logs SSL information and errors. |
|**DEBUG_SPEWSEARCH** |0x00000040 |Logs all server responses to search requests. These responses include attributes requested, as well as all data that was received. |
|**DEBUG_SERVERDOWN** |0x00000080 |Logs server-down and connection errors. |
|**DEBUG_CONNECT** |0x00000100 |Logs data that is related to establishing a connection.<br />Use **DEBUG_CONNECTION** to log other data that is related to connections. |
|**DEBUG_RECONNECT** |0x00000200 |Logs automatic reconnect activity. This activity includes reconnect attempts, failures, and related errors. |
|**DEBUG_RECEIVEDATA** |0x00000400 |Logs activity that is related to receiving messages from the server. This activity includes events such as the response received from the server, waiting on the response from the server, and so on. |
|**DEBUG_BYTES_SENT** |0x00000800 |Logs all data sent by the LDAP client to the server. This function is essentially packet logging, but it always logs unencrypted data. (If a packet is sent over SSL, this function logs the unencrypted packet.) This logging can be verbose. Because of this, consider using this flag on its own (or in combination with **DEBUG_BYTES_RECEIVED**). |
|**DEBUG_EOM** |0x00001000 |Logs events that relate to reaching the end of a message list. These events include information such as "message list cleared" and so on. |
|**DEBUG_BER** |0x00002000 |Logs operations and errors that relate to Basic Encoding Rules (BER). These operations and errors include problems in encoding, buffer size problems, and so on. |
|**DEBUG_OUTMEMORY** |0x00004000 |Logs failures to allocate memory. Additionally, logs any failure to compute the required memory, for example, an overflow when computing the required buffer size. |
|**DEBUG_CONTROLS** |0x00008000 |Logs data that relates to controls. This data includes controls that are inserted, problems with controls, mandatory controls on a connection, and so on. |
|**DEBUG_BYTES_RECEIVED** |0x00010000 |Logs all data received by the LDAP client. This is essentially packet logging, but it always logs unencrypted data. (If a packet is sent over SSL, this logs the unencrypted packet.) This can be verbose and is probably best used on its own (or with **DEBUG_BYTES_SENT**). |
|**DEBUG_CLDAP** |0x00020000 |Logs events specific to UDP and connectionless LDAP. |
|**DEBUG_FILTER** |0x00040000 |Logs events and errors encountered when constructing a search filter.<br/>**Note** This only logs client events during filter construction. No responses from the server regarding a filter are included here. |
|**DEBUG_BIND** |0x00080000 |Logs bind events and errors. This includes negotiation information, bind success, bind fail, and so on. |
|**DEBUG_NETWORK_ERRORS** |0x00100000 |Logs general network errors. This includes send and receive errors.<br/>**Note** If a connection is lost or the server cannot be reached, **DEBUG_SERVERDOWN** is the preferred tag. |
|**DEBUG_VERBOSE** |0x00200000 |Logs general messages. This should be used for any messages that tend to generate a large amount of output, for example: end of message reached, server has not responded yet, and so on. This is also useful for generic messages. |
|**DEBUG_PARSE** |0x00400000 |Logs general message and packet parsing and encoding events and errors. |
|**DEBUG_REFERRALS** |0x00800000 |Logs data about referrals and chasing referrals. |
|**DEBUG_REQUEST** |0x01000000 |Logs tracking of requests. |
|**DEBUG_CONNECTION** |0x02000000 |Logs general connection data and errors. |
|**DEBUG_INIT_TERM** |0x04000000 |Logs module initialization and cleanup (DLL Main, and so on). |
|**DEBUG_API_ERRORS** |0x08000000 |Supports logging improper use of the API, for example, if bind is called twice on the same connection. |
|**DEBUG_ERRORS** |0x10000000 |Logs general errors. Most fall into one of the following categories: module initialization errors, SSL errors, or overflow or underflow errors. |
|**DEBUG_PERFORMANCE** |0x20000000 |Logs data on process-global LDAP activity statistics after receiving a server response for a LDAP request. |

## Example

Consider an application, App1.exe, that sets passwords for user accounts. Suppose App1.exe produces an unexpected error. To use ETW to help diagnose this problem, you would follow these steps:

1. In Registry Editor, create the following registry entry:

   **HKEY\_LOCAL\_MACHINE\\System\\CurrentControlSet\\Services\\ldap\\Tracing\\App1.exe**

1. To start a tracing session, open a Command Prompt window and run the following command:

   ```cmd
   tracelog.exe -start ldaptrace -guid \#099614a5-5dd7-4788-8bc9-e29f43db28fc -f .\ldap.etl -flag 0x80000
   ```

   After this command has started, **DEBUG\_BIND** tracing messages will be written to .\\ldap.etl.

1. Start App1.exe and reproduce the unexpected error.

1. To stop the tracing session, run the following command at the command prompt:

   ```cmd
    tracelog.exe -stop ldaptrace
   ```

1. To prevent other users from tracing the application, delete the registry entry (**HKEY\_LOCAL\_MACHINE**\\**System**\\**CurrentControlSet**\\**Services**\\**ldap**\\**Tracing**\\**App1.exe**).

1. To review the information in the trace log, run the following command at the command prompt:

   ```cmd
    tracerpt.exe .\ldap.etl -o -report
    ```

   In this command, **tracerpt.exe** is a [trace consumer](http://go.microsoft.com/fwlink/p/?linkid=83876) tool.
