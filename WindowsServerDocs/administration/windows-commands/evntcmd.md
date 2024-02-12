---
title: evntcmd
description: Reference article for the evntcmd command, which configures the translation of events to traps, trap destinations, or both based on information in a configuration file.
ms.topic: reference
ms.assetid: c1aabb74-76e7-4304-95a6-50ad87e92fd9
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# evntcmd

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Configures the translation of events to traps, trap destinations, or both based on information in a configuration file.

## Syntax

```
evntcmd [/s <computername>] [/v <verbositylevel>] [/n] <filename>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /s `<computername>` | Specifies, by name, the computer on which you want to configure the translation of events to traps, trap destinations, or both. If you do not specify a computer, the configuration occurs on the local computer. |
| /v `<verbositylevel>` | Specifies which types of status messages appear as traps and trap destinations are configured. This parameter must be an integer between 0 and 10. If you specify 10, all types of messages appear, including tracing messages and warnings about whether trap configuration was successful. If you specify 0, no messages appear. |
| /n | Specifies that the SNMP service should not be restarted if this computer receives trap configuration changes. |
| `<filename>` | Specifies, by name, the configuration file that contains information about the translation of events to traps and trap destinations you want to configure. |
| /? | Displays help at the command prompt. |

#### Remarks

- if you want to configure traps but not trap destinations, you can create a valid configuration file by using Event to Trap Translator, which is a graphical utility. If you have the SNMP service installed, you can start Event to Trap Translator by typing **evntwin** at a command prompt. After you have defined the traps you want, click **Export** to create a file suitable for use with **evntcmd**. You can use Event to Trap Translator to easily create a configuration file and then use the configuration file with **evntcmd** at the command prompt to quickly configure traps on multiple computers.

- The syntax for configuring a trap is as follows:

  ```
  #pragma add <eventlogfile> <eventsource> <eventID> [<count> [<period>]]
  ```

  Where the text following is true:

    - **#pragma** must appear at the beginning of every entry in the file.

    - The parameter **add** specifies that you want to add an event to trap configuration.

    - The parameters **eventlogfile**, **eventsource**, and **eventID** are required, and where **eventlogfile** specifies the file in which the event is recorded, **eventsource** specifies the application that generates the event and **eventID** specifies the unique number that identifies each event.

    To determine what values correspond to each event, start the Event to Trap Translator by typing **evntwin** at a command prompt. Click **Custom**, and then click **edit**. Under **Event Sources**, browse the folders until you locate the event you want to configure, click it, and then click **add**. Information about the event source, the event log file, and the event ID appear under **Source,  Log**, and **Trap specific ID**, respectively.

    - The **count** parameter is optional, and it specifies how many times the event must occur before a trap message is sent. If you don't use this parameter, the trap message is sent after the event occurs once.

    - The **period** parameter is optional, but it requires you to use the **count** parameter. The **period** parameter specifies a length of time (in seconds) during which the event must occur the number of times specified with the **count** parameter before a trap message is sent. If you don't use this parameter, a trap message is sent after the event occurs the number of times specified with the ***count*** parameter, no matter how much time elapses between occurrences.

- The syntax for removing a trap is as follows:

  ```
  #pragma delete <eventlogfile> <eventsource> <eventID>
  ```

  Where the text following is true:

    - **#pragma** must appear at the beginning of every entry in the file.

    - The parameter **delete** specifies that you want to remove an event to trap configuration.

    - The parameters **eventlogfile**, **eventsource**, and **eventID** are required, and where **eventlogfile** specifies the file in which the event is recorded, **eventsource** specifies the application that generates the event and **eventID** specifies the unique number that identifies each event.

    To determine what values correspond to each event, start the Event to Trap Translator by typing **evntwin** at a command prompt. Click **Custom**, and then click **edit**. Under **Event Sources**, browse the folders until you locate the event you want to configure, click it, and then click **add**. Information about the event source, the event log file, and the event ID appear under **Source,  Log**, and **Trap specific ID**, respectively.

- The syntax for configuring a trap destination is as follows:

  ```
  #pragma add_TRAP_DEST <communityname> <hostID>
  ```

  Where the text following is true:

    - **#pragma** must appear at the beginning of every entry in the file.

    - The parameter **add_TRAP_DEST** specifies that you want trap messages to be sent to a specified host within a community.

    - The parameter **communityname** specifies, by name, the community in which trap messages are sent.

    - The parameter **hostID** specifies, by name or IP address, the host to which you want trap messages to be sent.

- The syntax for removing a trap destination is as follows:

  ```
  #pragma delete_TRAP_DEST <communityname> <hostID>
  ```

  Where the text following is true:

    - **#pragma** must appear at the beginning of every entry in the file.

    - The parameter **delete_TRAP_DEST** specifies that you do not want trap messages to be sent to a specified host within a community.

    - The parameter **communityname** specifies, by name, the community to which trap messages shouldn't be sent.

    - The parameter **hostID** specifies, by name or IP address, the host to which you don't want trap messages to be sent.

### Examples

The following examples illustrate entries in the configuration file for the **evntcmd** command. They are not designed to be typed at a command prompt.

To send a trap message if the Event Log service is restarted, type:

```
#pragma add System Eventlog 2147489653
```

To send a trap message if the Event Log service is restarted twice in three minutes, type:

```
#pragma add System Eventlog 2147489653 2 180
```

To stop sending a trap message whenever the Event Log service is restarted, type:

```
#pragma delete System Eventlog 2147489653
```

To send trap messages within the community named *Public* to the host with the IP address *192.168.100.100*, type:

```
#pragma add_TRAP_DEST public 192.168.100.100
```

To send trap messages within the community named *Private* to the host named *Host1*, type:

```
#pragma add_TRAP_DEST private Host1
```

To stop sending trap messages within the community named *Private* to the same computer on which you are configuring trap destinations, type:

```
#pragma delete_TRAP_DEST private localhost
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
