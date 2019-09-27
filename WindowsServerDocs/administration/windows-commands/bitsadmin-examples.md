---
title: bitsadmin examples
description: "The following examples show how to use the bitsadmin tool to perform the most common tasks."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cb8f8374-ba6e-4a68-85a1-9a95b8215354
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 05/31/2018
---

# bitsadmin examples

The following examples show how to use the `bitsadmin` tool to perform the most common tasks.

## Transfer a file

The **/transfer** switch is a shortcut for performing the tasks listed below. This switch creates the job, adds the files to the job, activates the job in the transfer queue, and completes the job. BITSAdmin continues to show progress information in the MS-DOS window until the transfer completes or an error occurs.

**bitsadmin /transfer myDownloadJob /download /priority normal `https://downloadsrv/10mb.zip c:\\10mb.zip`**

## Create a download job

Use the **/create** switch to create a download job named myDownloadJob.

**bitsadmin /create myDownloadJob**

BITSAdmin returns a GUID that uniquely identifies the job. Use the GUID or job name in subsequent calls. The following text is sample output.

``` syntax
Created job {C775D194-090F-431F-B5FB-8334D00D1CB6}.
```

Next, use the **/addfile** switch to add one or more files to the download job.

## Add files to the download job

Use the **/addfile** switch to add a file to the job. Repeat this call for each file you want to add. If multiple jobs use myDownloadJob as their name, you must replace myDownloadJob with the job's GUID to uniquely identify the job.

**bitsadmin /addfile myDownloadJob https://downloadsrv/10mb.zip c:\\10mb.zip**

To activate the job in the transfer queue, use the **/resume** switch.

## Activate the download job

When you create a new job, BITS suspends the job. To activate the job in the transfer queue, use the **/resume** switch. If multiple jobs use myDownloadJob as their name, you must replace myDownloadJob with the job's GUID to uniquely identify the job.

**bitsadmin /resume myDownloadJob**

To determine the progress of the job, use the **/list**, **/info**, or **/monitor** switch.

## Determine the progress of the download job

Use the **/info** switch to determine the progress of a job. If multiple jobs use myDownloadJob as their name, you must replace myDownloadJob with the job's GUID to uniquely identify the job.

**bitsadmin /info myDownloadJob /verbose**

The **/info** switch returns the state of the job and the number of files and bytes transferred. When the state is TRANSFERRED, BITS has successfully transferred all files in the job. The **/verbose** argument provides complete details of the job. The following text is sample output.

``` syntax
GUID: {482FCAF0-74BF-469B-8929-5CCD028C9499} DISPLAY: myDownloadJob
TYPE: DOWNLOAD STATE: TRANSIENT_ERROR OWNER: domain\user
PRIORITY: NORMAL FILES: 0 / 1 BYTES: 0 / UNKNOWN
CREATION TIME: 12/17/2002 1:21:17 PM MODIFICATION TIME: 12/17/2002 1:21:30 PM
COMPLETION TIME: UNKNOWN
NOTIFY INTERFACE: UNREGISTERED NOTIFICATION FLAGS: 3
RETRY DELAY: 600 NO PROGRESS TIMEOUT: 1209600 ERROR COUNT: 0
PROXY USAGE: PRECONFIG PROXY LIST: NULL PROXY BYPASS LIST: NULL
ERROR FILE:    https://downloadsrv/10mb.zip -> c:\10mb.zip
ERROR CODE:    0x80072ee7 - The server name or address could not be resolved
ERROR CONTEXT: 0x00000005 - The error occurred while the remote file was being 
processed.
DESCRIPTION:
JOB FILES:
        0 / UNKNOWN WORKING https://downloadsrv/10mb.zip -> c:\10mb.zip
NOTIFICATION COMMAND LINE: none
```

To receive information for all jobs in the transfer queue, use the **/list** or **/monitor** switch.

## Completing the download job

When the state of the job is TRANSFERRED, BITS has successfully transferred all files in the job. However, the files are not available until you use the **/complete** switch. If multiple jobs use myDownloadJob as their name, you must replace myDownloadJob with the job's GUID to uniquely identify the job.

**bitsadmin /complete myDownloadJob**

## Monitoring jobs in the transfer queue

Use the **/list**, **/monitor**, or **/info** switch to monitor jobs in the transfer queue. The **/list** switch provides information for all jobs in the queue.

**bitsadmin /list**

The **/list** switch returns the state of the job and the number of files and bytes transferred for all jobs in the transfer queue. The following text is sample output.

``` syntax
{6AF46E48-41D3-453F-B7AF-A694BBC823F7} job1 SUSPENDED 0 / 0 0 / 0
{482FCAF0-74BF-469B-8929-5CCD028C9499} job2 TRANSIENT_ERROR 0 / 1 0 / UNKNOWN

Listed 2 job(s).
```

Use the **/monitor** switch to monitor all jobs in the queue. The **/monitor** switch refreshes the data every 5 seconds. To stop the refresh, enter CTRL+C.

**bitsadmin /monitor**

The **/monitor** switch returns the state of the job and the number of files and bytes transferred for all jobs in the transfer queue. The following text is sample output.

``` syntax
MONITORING BACKGROUND COPY MANAGER(5 second refresh)
{6AF46E48-41D3-453F-B7AF-A694BBC823F7} job1 SUSPENDED 0 / 0 0 / 0
{482FCAF0-74BF-469B-8929-5CCD028C9499} job2 TRANSIENT_ERROR 0 / 1 0 / UNKNOWN
{0B138008-304B-4264-B021-FD04455588FF} job3 TRANSFERRED 1 / 1 100379370 / 100379370
```

## Deleting jobs from the transfer queue

Use the **/reset** switch to remove all jobs from the transfer queue.

**bitsadmin /reset**

The following text is sample output.

``` syntax
{DC61A20C-44AB-4768-B175-8000D02545B9} canceled.
{BB6E91F3-6EDA-4BB4-9E01-5C5CBB5411F8} canceled.
2 out of 2 jobs canceled.
```
