---
title: Background Intelligent Transfer Service (BITS) Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e2e6750c-60a7-432f-96ae-3a6105e4c620
---
# Background Intelligent Transfer Service (BITS) Overview
This topic provides overview information about BITS, as well as links to other resources pertaining to BITS.

**Did you mean…**

-   [Background Intelligent Transfer Service](http://msdn.microsoft.com/library/windows/desktop/bb968799(v=vs.85).aspx) in the Microsoft Dev Center.

-   [Managed Reference for BITS PowerShell Commands](http://msdn.microsoft.com/library/windows/desktop/dd904466(v=vs.85).aspx) in the Microsoft Dev Center.

## <a name="BKMK_OVER"></a>BITS description
Background Intelligent Transfer Service \(BITS\) asynchronously transfers files in the foreground or background, controls the flow of the transfers to preserve the responsiveness of other network applications, and automatically resumes file transfers if a transfer session is interrupted, such as from disconnecting from the network or restarting the computer.

Background transfers are optimal in that BITS uses idle network bandwidth to transfer the files and will increase or decrease the rate at which files are transferred based on the amount of idle network bandwidth available. If a network application begins to consume more bandwidth, BITS decreases its transfer rate to preserve the user's interactive experience.

BITS continues to transfer files after an application exits if the user who initiated the transfer remains logged on and a network connection is maintained. If a connection is lost or if the user logs off, BITS suspends the transfer. BITS persists transfer information while the user is logged off, across network disconnects, and during computer restarts. However, BITS will not force a connection. When the user logs on again, BITS resumes the user's transfer job.

BITS provides one foreground and three background priority levels that you use to prioritize transfer jobs. Higher priority jobs preempt lower priority jobs. Jobs at the same priority level share transfer time, which prevents a large job from blocking small jobs in the transfer queue. Lower priority jobs do not receive transfer time until all higher priority jobs are complete or in an error state.

BITS uses the Windows BranchCache for peer caching.

[BranchCache in Windows 7 and Windows Server 2008 R2 Overview](http://technet.microsoft.com/library/dd755969(WS.10).aspx)

## <a name="BKMK_APP"></a>Practical applications
Use BITS for applications that need to transfer files asynchronously between a client and a server. There are three types of transfer jobs:

1.  **Download job** downloads files to the clientAsynchronously transfer files in the foreground or background

2.  **Upload job** uploads a file to the server

3.  **Upload\-reply** job uploads a file to the server and receives a reply file from the server application

## <a name="BKMK_INSTALL"></a>Server Manager information
When you install BITS using the Add Roles and Features Wizard, you have the option to install the BITS server Extensions Tools. The tools are required to manage BITS. However the tools to not need to be installed on the same server on which you are installing BITS.

## <a name="BKMK_LINKS"></a>See also
The following table provides links to information that is relevant to BITS.

|Content type|References|
|----------------|--------------|
|**Operations**|[Managed Reference for BITS PowerShell Commands](http://msdn.microsoft.com/library/windows/desktop/dd904466(v=vs.85).aspx)<br /><br />[Using Windows PowerShell to Create BITS Transfer Jobs](http://msdn.microsoft.com/library/windows/desktop/ee663885(v=vs.85).aspx)<br /><br />[Manage BITS \(Background Intelligent Transfer Service\) with Windows PowerShell](http://technet.microsoft.com/magazine/ff382721.aspx)<br /><br />[Transferring \(Large\) Files Using BITs](http://blogs.msdn.com/b/powershell/archive/2009/01/11/transferring-large-files-using-bits.aspx)|
|**Troubleshooting**|Content not available|
|**Getting started**|[About BITS](http://msdn.microsoft.com/library/windows/desktop/aa362708(v=vs.85).aspx)|
|**Tools and settings**|Content not available|
|**Community resources**||
|**Related technologies**|[BranchCache in Windows 7 and Windows Server 2008 R2 Overview](http://technet.microsoft.com/library/dd755969(WS.10).aspx)|


