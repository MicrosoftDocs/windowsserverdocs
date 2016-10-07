---
title: Evntcmd
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c1aabb74-76e7-4304-95a6-50ad87e92fd9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Evntcmd

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Configures the translation of events to traps, trap destinations, or both based on information in a configuration file. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
## Syntax  
```  
evntcmd [/s <ComputerName>] [/v <VerbosityLevel>] [/n] <FileName>  
```  
### Parameters  
|Parameter|Description|  
|-------------|---------------|  
|/s <ComputerName>|Specifies, by name, the computer on which you want to configure the translation of events to traps, trap destinations, or both. If you do not specify a computer, the configuration occurs on the local computer.|  
|/v <VerbosityLevel>|Specifies which types of status messages appear as traps and trap destinations are configured. This parameter must be an integer between 0 and 10. If you specify 10, all types of messages appear, including tracing messages and warnings about whether trap configuration was successful. If you specify 0, no messages appear.|  
|/n|Specifies that the SNMP service should not be restarted if this computer receives trap configuration changes.|  
|<FileName>|Specifies, by name, the configuration file that contains information about the translation of events to traps and trap destinations you want to configure.|  
|/?|Displays Help at the command prompt.|  
## Remarks  
-   If you want to configure traps but not trap destinations, you can create a valid configuration file by using Event to Trap Translator, which is a graphical utility. If you have the SNMP service installed, you can start Event to Trap Translator by typing **evntwin** at a command prompt. After you have defined the traps you want, click Export to create a file suitable for use with **evntcmd**. You can use Event to Trap Translator to easily create a configuration file and then use the configuration file with **evntcmd** at the command prompt to quickly configure traps on multiple computers.  
-   The syntax for configuring a trap is as follows:  
    **#pragma ADD***<EventLogFile> <EventSource> <EventID> [<Count> [<Period>]]*  
    -   The text **#pragma** must appear at the beginning of every entry in the file.  
    -   The parameter **ADD** specifies that you want to add an event to trap configuration.  
    -   The parameters *EventLogFile*, *EventSource*, and *EventID* are required. The parameter *EventLogFile* specifies the file in which the event is recorded. The parameter *EventSource* specifies the application that generates the event. The *EventID* parameter specifies the unique number that identifies each event. To find out what values correspond to particular events, start Event to Trap Translator by typing **evntwin** at a command prompt. Click **Custom**, and then click **Edit**. Under **Event Sources**, browse the folders until you locate the event you want to configure, click it, and then click **Add**. Information about the event source, the event log file, and the event ID appear under **Source,  Log**, and **Trap specific ID**, respectively.  
    -   The *Count* parameter is optional, and it specifies how many times the event must occur before a trap message is sent. If you do not use the *Count* parameter, the trap message is sent after the event occurs once.  
    -   The *Period* parameter is optional, but it requires you to use the *Count* parameter. The *Period* parameter specifies a length of time (in seconds) during which the event must occur the number of times specified with the Count parameter before a trap message is sent. If you do not use the *Period* parameter, a trap message is sent after the event occurs the number of times specified with the *Count* parameter, no matter how much time elapses between occurrences.  
-   The syntax for removing a trap is as follows:  
    **#pragma DELETE***<EventLogFile> <EventSource> <EventID>*  
    -   The text **#pragma** must appear at the beginning of every entry in the file.  
    -   The parameter *DELETE* specifies that you want to remove an event to trap configuration.  
    -   The parameters *EventLogFile*,  *EventSource*, and *EventID* are required. The parameter *EventLogFile* specifies the log in which the event is recorded. The parameter *EventSource* specifies the application that generates the event. The *EventID* parameter specifies the unique number that identifies each event.  
-   The syntax for configuring a trap destination is as follows:  
    **#pragma ADD_TRAP_DEST***<CommunityName> <HostID>*  
    -   The text **#pragma** must appear at the beginning of every entry in the file.  
    -   The parameter **ADD_TRAP_DEST** specifies that you want trap messages to be sent to a specified host within a community.  
    -   The parameter *CommunityName* specifies, by name, the community in which trap messages are sent.  
    -   The parameter *HostID* specifies, by name or IP address, the host to which you want trap messages to be sent.  
-   The syntax for removing a trap destination is as follows:  
    **#pragma DELETE_TRAP_DEST***<CommunityName> <HostID>*  
    -   The text **#pragma** must appear at the beginning of every entry in the file.  
    -   The parameter *DELETE_TRAP_DEST* specifies that you do not want trap messages to be sent to a specified host within a community.  
    -   The parameter *CommunityName* specifies, by name, the community in which trap messages are sent.  
    -   The parameter *HostID* specifies, by name or IP address, the host to which you do not want trap messages to be sent.  
## <a name="BKMK_Examples"></a>Examples  
The following examples illustrate entries in the configuration file for the **evntcmd** command. They are not designed to be typed at a command prompt.  
To send a trap message if the Event Log service is restarted, type:  
```  
#pragma ADD System "Eventlog" 2147489653  
```  
To send a trap message if the Event Log service is restarted twice in three minutes, type:  
```  
#pragma ADD System "Eventlog" 2147489653 2 180  
```  
To stop sending a trap message whenever the Event Log service is restarted, type:  
```  
#pragma DELETE System "Eventlog" 2147489653  
```  
To send trap messages within the community named Public to the host with the IP address 192.168.100.100, type:  
```  
#pragma ADD_TRAP_DEST public 192.168.100.100  
```  
To send trap messages within the community named Private to the host named Host1, type:  
```  
#pragma ADD_TRAP_DEST private Host1  
```  
To stop sending trap messages within the community named Private to the same computer on which you are configuring trap destinations, type:  
```  
#pragma DELETE_TRAP_DEST private localhost  
```  
## Additional references  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
