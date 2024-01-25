---
title: bitsadmin examples
description: Examples showing how to use the bitsadmin tool to perform the most common tasks.
ms.topic: reference
ms.assetid: cb8f8374-ba6e-4a68-85a1-9a95b8215354
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 05/31/2018
---

# bitsadmin examples

The following examples show how to use the `bitsadmin` tool to perform the most common tasks.

## Transfer a file

To create a job, add files, activate the job in the transfer queue, and to complete the job:

`bitsadmin /transfer myDownloadJob /download /priority normal https://downloadsrv/10mb.zip c:\\10mb.zip`

BITSAdmin continues to show progress information in the MS-DOS window until the transfer completes or an error occurs.

## Create a download job

To create a download job named *myDownloadJob*:

```
bitsadmin /create myDownloadJob
```

BITSAdmin returns a GUID that uniquely identifies the job. Use the GUID or job name in subsequent calls. The following text is sample output.

### Sample output

`created job {C775D194-090F-431F-B5FB-8334D00D1CB6}`

## Add files to the download job

To add a file to the job:

```
bitsadmin /addfile myDownloadJob https://downloadsrv/10mb.zip c:\\10mb.zip
```

Repeat this call for each file you want to add. If multiple jobs use *myDownloadJob* as their name, you must use the job's GUID to uniquely identify it for completion.

## Activate the download job

After you create a new job, BITS automatically suspends the job. To activate the job in the transfer queue:

```
bitsadmin /resume myDownloadJob
```

If multiple jobs use *myDownloadJob* as their name, you must use the job's GUID to uniquely identify it for completion.

## Determine the progress of the download job

The **/info** switch returns the state of the job and the number of files and bytes transferred. When the state is shown as `TRANSFERRED`, it means that BITS has successfully transferred all files in the job. You can also add the **/verbose** argument to get complete details of the job, and **/list** or **/monitor** to get all the jobs in the transfer queue.

To return the state of the job:

```
bitsadmin /info myDownloadJob /verbose
```

If multiple jobs use *myDownloadJob* as their name, you must use the job's GUID to uniquely identify it for completion.

## Complete the download job

To complete the job after the state changes to `TRANSFERRED`:

```
bitsadmin /complete myDownloadJob
```

You must run the `/complete` switch before the files in the job become available. If multiple jobs use *myDownloadJob* as their name, you must use the job's GUID to uniquely identify it for completion.

## Monitor jobs in the transfer queue using the /list switch

To return the state of the job and the number of files and bytes transferred for all jobs in the transfer queue:

```
bitsadmin /list
```

### Sample output

```
{6AF46E48-41D3-453F-B7AF-A694BBC823F7} job1 SUSPENDED 0 / 0 0 / 0
{482FCAF0-74BF-469B-8929-5CCD028C9499} job2 TRANSIENT_ERROR 0 / 1 0 / UNKNOWN

Listed 2 job(s).
```

## Monitor jobs in the transfer queue using the /monitor switch

To return the state of the job and the number of files and bytes transferred for all jobs in the transfer queue, refreshing the data every 5 seconds:

```
bitsadmin /monitor
```

> [!NOTE]
> To stop the refresh, press CTRL+C.

### Sample output

```
MONITORING BACKGROUND COPY MANAGER(5 second refresh)
{6AF46E48-41D3-453F-B7AF-A694BBC823F7} job1 SUSPENDED 0 / 0 0 / 0
{482FCAF0-74BF-469B-8929-5CCD028C9499} job2 TRANSIENT_ERROR 0 / 1 0 / UNKNOWN
{0B138008-304B-4264-B021-FD04455588FF} job3 TRANSFERRED 1 / 1 100379370 / 100379370
```

## Monitor jobs in the transfer queue using the /info switch

To return the state of the job and the number of files and bytes transferred:

```
bitsadmin /info
```

### Sample output

```
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

## Delete jobs from the transfer queue

To remove all jobs from the transfer queue, use the /reset switch:

```
bitsadmin /reset
```

### Sample output

```
{DC61A20C-44AB-4768-B175-8000D02545B9} canceled.
{BB6E91F3-6EDA-4BB4-9E01-5C5CBB5411F8} canceled.
2 out of 2 jobs canceled.
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
