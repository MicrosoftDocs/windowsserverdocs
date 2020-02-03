---
title: Troubleshoot the Event ID 50 Error Message
description: Describes how to troubleshoot the Event ID 50 Error Message
author: Deland-Han
manager: dcscontentpm
audience: ITPro
ms.topic: article
ms.author: delhan
ms.date: 12/25/2019
---

# Troubleshoot the Event ID 50 Error Message

##  Symptoms

When information is being written to the physical disk, the following two event messages may be logged in the system event log: 

```
Event ID: 50 
Event Type: Warning 
Event Source: Ftdisk 
Description: {Lost Delayed-Write Data} The system was attempting to transfer file data from buffers to \Device\HarddiskVolume4. The write operation failed, and only some of the data may have been written to the file.
Data: 
0000: 00 00 04 00 02 00 56 00 
0008: 00 00 00 00 32 00 04 80 
0010: 00 00 00 00 00 00 00 00 
0018: 00 00 00 00 00 00 00 00 
0020: 00 00 00 00 00 00 00 00 
0028: 11 00 00 80 
```

```
Event ID: 26 
Event Type: Information
Event Source: Application Popup
Description: Windows - Delayed Write Failed : Windows was unable to save all the data for the file \Device\HarddiskVolume4\Program Files\Microsoft SQL Server\MSSQL$INSTANCETWO\LOG\ERRORLOG. The data has been lost. This error may be caused by a failure of your computer hardware or network connection.

Please try to save this file elsewhere.
```

These event ID messages mean exactly the same thing and are generated for the same reasons. For the purposes of this article, only the event ID 50 message is described.

> [!NOTE] 
> The device and path in the description and the specific hexadecimal data will vary. 

##  More Information

An event ID 50 message is logged if a generic error occurs when Windows is trying to write information to the disk. This error occurs when Windows is trying to commit data from the file system Cache Manager (not hardware level cache) to the physical disk. This behavior is part of the memory management of Windows. For example, if a program sends a write request, the write request is cached by Cache Manager and the program is told the write is completed successfully. At a later point in time, Cache Manager tries to lazy write the data to the physical disk. When Cache Manager tries to commit the data to disk, an error occurs writing the data, and the data is flushed from the cache and discarded. Write-back caching improves system performance, but data loss and volume integrity loss can occur as a result of lost delayed-write failures.

It is important to remember that not all I/O is buffered I/O by Cache Manager. Programs can set a FILE_FLAG_NO_BUFFERING flag that bypasses Cache Manager. When SQL performs critical writes to a database, this flag is set to guarantee that the transaction is completed directly to disk. For example, non-critical writes to log files perform buffered I/O to improve overall performance. An event ID 50 message never results from non-buffered I/O.

There are several different sources for an event ID 50 message. For example, an event ID 50 message logged from a MRxSmb source occurs if there is a network connectivity problem with the redirector. To avoid performing incorrect troubleshooting steps, make sure to review the event ID 50 message to confirm that it refers to a disk I/O issue and that this article applies.

An event ID 50 message is similar to an event ID 9 and an event ID 11 message. Although the error is not as serious as the error indicated by the event ID 9 and an event ID 11 message, you can use the same troubleshooting techniques for a event ID 50 message as you do for an event ID 9 and an event ID 11 message. However, remember that anything in the stack can cause lost-delay writes, such as filter drivers and mini-port drivers. 

You can use the binary data that is associated with any accompanying "DISK" error (indicated by an event ID 9, 11, 51 error message or other messages) to help you in identifying the problem.

###  How to Decode the Data Section of an Event ID 50 Event Message 

When you decode the data section in the example of an event ID 50 message that is included in the "Summary" section, you see that the attempt to perform a write operation failed because the device was busy and the data was lost. This section describes how to decode this event ID 50 message. 

The following table describes what each offset of this message represents: 

|OffsetLengthValues|Length|Values|
|-----------|------------|---------|
|0x00|2|Not Used|
|0x02|2|Dump Data Size = 0x0004|
|0x04|2|Number of Strings = 0x0002|
|0x06|2|Offset to the strings|
|0x08|2|Event Category|
|0x0c|4|NTSTATUS Error Code = 0x80040032 = IO_LOST_DELAYED_WRITE|
|0x10|8|Not Used|
|0x18|8|Not Used|
|0x20|8|Not Used|
|0x28|4|NT Status error code|

#### Key Sections to Decode

**The Error Code**

In the example in the "Summary" section, the error code is listed in the second line. This line starts with "0008:" and it includes the last four bytes in this line:0008: 00 00 00 00 32 00 04 80 In this case, the error code is 0x80040032. The following code is the code for error 50, and it is the same for all event ID 50 messages: IO_LOST_DELAYED_WRITEWARNINGNote When you are converting the hexadecimal data in the event ID message to the status code, remember that the values are represented in the little-endian format.

**The Target Disk**

You can identify the disk that the write was being tried to by using the symbolic link that is listed to the drive in the "Description" section of the event ID message, for example: \Device\HarddiskVolume4. For additional information about how to identify the drive, click the following article number to view the article in the Microsoft Knowledge Base:
[159865 ](/EN-US/help/159865) How to Distinguish a Physical Disk Device from an Event Message

**The Final Status Code**

The final status code is the most important piece of information in an event ID 50 message. This is the error code that is return when the I/O request was made, and it is the key source of information. In the example in the "Summary" section, the final status code is listed at 0x28, the sixth line, that starts with "0028:" and includes the only four octets in this line: 

```
0028: 11 00 00 80 
```

In this case, the final status equals 0x80000011.This status code maps to STATUS_DEVICE_BUSY and implies that the device is currently busy.

>[!NOTE] 
> When you are converting the hexadecimal data in the event ID 50 message to the status code, remember that the values are represented in the little-endian format. Because the status code is the only piece of information that you are interested in, it may be easier to view the data in WORDS format instead of BYTES. If you do so, the bytes will be in the correct format and the data may be easier to interpret quickly.

To do so, click **Words** in the **Event Properties** window. In the Data Words view, the example in the "Symptoms" section would read as follows: Data: 

```
() Bytes (.) 
Words 0000: 00040000 00560002 00000000 80040032 0010: 00000000 00000000 00000000 00000000 0020: 00000000 00000000 80000011
```

To obtain a list of Windows NT status codes, see NTSTATUS.H in the Windows Software Developers Kit (SDK).