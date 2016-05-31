---
title: Background Intelligent Transfer Service (BITS) Overview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5d390641-50f0-4913-8130-fe23cc599644
author: britw
---
# Background Intelligent Transfer Service (BITS) Overview
Background Intelligent Transfer Service \(BITS\) uses idle network bandwidth to perform prioritized, throttled, asynchronous file transfers. Windows Update, Windows Server Update Services \(WSUS\), and Systems Management Server use BITS to efficiently deliver software updates to clients. Windows Defender uses BITS when fetching signature updates, and Microsoft's instant messaging products use BITS to transfer files.  
## BITS description  
BITS asynchronously transfers files in the foreground or background, controls the flow of the transfers to preserve the responsiveness of other network applications, and automatically resumes file transfers if a transfer session is interrupted, such as from disconnecting from the network or restarting the computer.  
## BITS for file transfers
Background transfers are optimal in that BITS uses idle network bandwidth to transfer the files and will increase or decrease the rate at which files are transferred based on the amount of idle network bandwidth available. If a network application begins to consume more bandwidth, BITS decreases its transfer rate to preserve the user's interactive experience.  
BITS continues to transfer files after an application exits if the user who initiated the transfer remains logged on and a network connection is maintained. If a connection is lost or if the user logs off, BITS suspends the transfer. BITS transfer information persists while the user is logged off, if network connectivity is interrupted, and during computer restarts. When the user logs on again, and network connectivity is restored, BITS resumes the user's transfer job.  
## Network bandwidth  
BITS constantly monitors for any increase or decrease in network traffic and adjusts the transfer rates of BITS jobs to ensure that other foreground applications, such as a web browser, get the bandwidth they need. If applications are using 85 percent of the available network bandwidth, BITS will use only the remaining 15 percent.  BITS uses a best-effort estimate of bandwidth usage. BITS versions 3.0 and subsequent versions use Internet Gateway Device counters, if available, to more accurately calculate available bandwidth. Otherwise, BITS uses the speed reported by the network interface card \(NIC\) to calculate bandwidth. Estimates based on the speed reported by the NIC can cause bandwidth calculation errors, when a fast network adapter is connected to the network over a slow link.  
## BITS queue  
BITS uses a queue to manage file transfer sessions. A session is started when an application creates a job, which is a container that has one or more files to transfer. While a download job can have any number of files, upload jobs can have only one. Properties can be set for individual files. Jobs inherit the security context of the application that created them. BITS provides API access to control jobs. A job can be programmatically started, stopped, paused, resumed, and queried for status. Before starting a job, a priority is set to specify when the job is processed relative to other jobs in the transfer queue.  
By default, all jobs are set to Normal priority. Jobs can optionally be set to High, Low, or Foreground priority. Background transfers are optimized by BITS, which increases and decreases \(or throttles\) the rate of transfer based on the amount of idle network bandwidth that is available. If a network application begins to consume more bandwidth, BITS decreases its transfer rate - except for Foreground priority downloads - to preserve the user's interactive experience.  
Higher-priority jobs preempt lower priority jobs. Jobs at the same priority level share transfer time, which prevents a large job from blocking small jobs in the transfer queue. Lower priority jobs do not receive transfer time until all higher priority jobs are complete or are in an error state.  
## Practical applications  
Use BITS for applications that need to transfer files asynchronously between a client and a server. There are three types of transfer jobs:  
- **Download job** Downloads files to the client. Asynchronously transfers files in the foreground or background  
- **Upload job** Uploads a file to the server  
- **Upload-reply job** Uploads a file to the server and receives a reply file from the server application  
  
## Server Manager Information  
When you install BITS using the Add Roles and Features Wizard, you have the option to install the BITS server Extensions Tools. The tools are required to manage BITS. However, the tools do not need to be installed on the same server on which you are installing BITS.  
By default, BITS is enabled when the WSUS Server Role is installed.  
## Additional technical resources  
[About BITS](https://msdn.microsoft.com//library/windows/desktop/aa362708.aspx)  
[Manage BITS (Background Intelligent Transfer Service) with Windows PowerShell](https://technet.microsoft.com/magazine/ff382721.aspx)  
[Managed Reference for BITS PowerShell Commands](https://msdn.microsoft.com/library/windows/desktop/dd904466.aspx)  
[Transferring Large Files Using BITs](https://blogs.msdn.microsoft.com/powershell/2009/01/11/transferring-large-files-using-bits/)  
[Using Windows PowerShell to Create BITS Transfer Jobs](https://msdn.microsoft.com/library/windows/desktop/ee663885.aspx)

