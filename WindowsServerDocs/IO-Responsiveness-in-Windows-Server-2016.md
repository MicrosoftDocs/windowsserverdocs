---
title: IO Responsiveness in Windows Server 2016
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: storage
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8f4c1ca1-86cb-41d0-8683-9e7cd3c057f8
---
# IO Responsiveness in Windows Server 2016
Windows Server is an operating system that has traditionally interfaced with a large number of storage environments. This includes various bus types \(FC, iSCSI, SAS, SATA, and NVMe\), as well as media types \(HDD and SSD\), and topologies \(SAN, NAS, and Direct Attached Storage\). This type of flexibility in turn required flexible and lenient handling of I\/O operations within the host operating system, as the performance characteristics and maintenance needs of all these environments can be very different.

Over time, in order to allow for various long\-running operations in differing environments, the Windows storage stack saw introductions of more and more retry logic at various layers. For example, imagine a faulty device that does not return command requests; while a class driver would retry on such a timed out I\/O several times, a port driver might have done so already. The result is a multiplication of retries, which causes a non\-deterministic outcome for applications – I\/O seems to be stuck, since no Success or Failure event is communicated to them. The I\/O is just being retried over and over at various layers.

## Goals and Approaches
The overall goal for Windows Server 2016 is to make the Windows Storage stack more responsive. A theoretical worst\-case retry time of several hours was simply not acceptable. At the same time, a balance has to be found between aggressive retiring and failing of “stuck” I\/O, and accommodation for long running storage operations.

Improvement of Windows Storage stack responsiveness is addressed using the two approaches described in this document.

### Approach 1: Traditional Storage Environments
The host OS has limited insight into the inner workings of traditional storage arrays. Operations, such as firmware updates or inline data rebuilds are hidden and often masked with higher latencies. To accommodate such deployments, the changes for traditional storage were kept to a minimum. Miniports are still able to set their desired I\/O timeout \(oftentimes ~60s on traditional storage\).

In order to ensure forward progress for applications, the number of total retries on I\/O timeout conditions were reduced significantly, to a maximum of 4. Using the 60s timeout example, that means the worst\-case wait time incurred by the host storage stack for timed\-out I\/O is:

60s \(original I\/O\) \+ 4x 60s \(retries\) \= ~5 minutes

When the 4 retries are exhausted and the device has still not succeeded or failed the I\/O, the storage stack will stop waiting and instead fail the request back to the upper layers \(usually the file system\).

### Approach 2: Storage Spaces Environments
Storage Spaces, which is based on direct\-attached storage, usually utilizing SAS or SATA devices, allows the Windows Storage Stack to be more aggressive. Well operating devices that are direct\-attached typically do not take more than 1s to complete I\/O requests. Under error conditions this time can increase to a few seconds, but there is no reason to have a default I\/O timeout of 60 or more seconds. The first change, when compared to 2012 R2 behavior is:

Storage Spaces now enforces an I\/O timeout value that will lie between 3 and 10 seconds.

This value may change over time. If an I\/O request sent by Storage Spaces does not complete within 3s \(in the most aggressive case\), it will be considered “timed out”.

For timed\-out Read, Write, and ReadCapacity requests, there will be only a single retry. The main difference here is that the retry will be happening very quickly. For example, if we assume an I\/O timeout value of 5s, and a device does not respond to an I\/O command, then the worst\-case wait time for the upper layers is as follows:

5s \(original I\/O\) \+ 1x 5s \(single retry\) \= ~10s

To avoid timing out on the same device again in the future, there is one additional change present for Storage Spaces environments on Windows Server 2016:

If I\/O timeouts are observed twice in a short period of time \(usually less than 20s\), the last device causing a timeout will be marked as “unresponsive” and no longer used by Storage Spaces, until the “unresponsive” flag has been cleared.

**Recovery**

The purpose of the changes described here  is to avoid having a single drive slow down the entire Spaces environment or even hang it. It is, of course, possible to recover drives marked as “unresponsive”.  To clear the “unresponsive” flag, you can either re\-seat the drive physically, or run the  **Reset\-PhysicalDisk** PowerShell command.

### Diagnosibility
To make the above described changes discoverable on a running machine, new events have been  added to the Windows Event Viewer. The following list includes events and event channels that are related to I\/O timeouts and unresponsive devices and contains information that can help with debugging and troubleshooting.

-   **System Event Log**

    Windows Logs \-> System

-   **Reset**

    Event ID: 129

    Description: The OS attempted to reset a given device. This typically occurs before an I\/O is retried.

-   **I\/O Retry**

    Event ID: 153

    Description: An I\/O operation was retried on a given device.

-   **StorDiag Operational Channel**

    Applications and Services Logs \->  Microsoft \->  Windows \-> StorDiag \->  Microsoft\-Windows\-Storage\-ClassPnP\/Operational

    The StorDiag operational channel is always enabled and has detailed information about errors encountered in the storage stack. Timeouts, Retries, as well as other errors are logged here with additional information \(where possible\), such as SCSI sense codes and SRB status codes.

-   **Spaces Operational Channel**

    Applications and Services Logs \->  Microsoft \->  Windows \->  StorageSpaces\-Driver \->  Operational

    The Storage Spaces operational channel contains detailed information about Spaces\-related events, including health and operational changes, as well as drives which have been marked as “unresponsive”.


