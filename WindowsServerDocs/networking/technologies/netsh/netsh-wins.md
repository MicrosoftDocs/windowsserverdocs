---
title: Network Shell (Netsh) Example Batch File
description: You can use this topic to learn how to create a batch file that performs multiple tasks using Netsh in Windows Server 2016.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: c94e37a4-3637-4613-9eb5-ed604e831eca
manager: brianlic
ms.author: lizross
author: eross-msft
---

# Network Shell \(Netsh\) Example Batch File

Applies To: Windows Server 2016

You can use this topic to learn how to create a batch file that performs multiple tasks by using Netsh in Windows Server 2016. In this example batch file, the **netsh wins** context is used.

## Example Batch File Overview

You can use Netsh commands for Windows Internet Name Service \(WINS\) in batch files and other scripts to automate tasks. The following batch file example demonstrates how to use Netsh commands for WINS to perform a variety of related tasks.

In this example batch file, WINS\-A is a WINS server with the IP address 192.168.125.30 and WINS\-B is a WINS server with the IP address 192.168.0.189.

The example batch file accomplishes the following tasks.

- Adds a dynamic name record with IP address 192.168.0.205, MY\_RECORD \[04h\], to WINS\-A
- Sets WINS\-B as a push/pull replication partner of WINS\-A
- Connects to WINS\-B, and then sets WINS\-A as a push/pull replication partner of WINS\-B
- Initiates a push replication from WINS\-A to WINS\-B
- Connects to WINS\-B to verify that the new record, MY\_RECORD, was replicated successfully

## Netsh example batch file

In the following example batch file, lines that contain comments are preceded by "rem," for remark. Netsh ignores comments.

    rem: Begin example batch file.
    
    rem two WINS servers:
    
    rem (WINS-A) 192.168.125.30
    
    rem (WINS-B) 192.168.0.189
    
    rem 1. Connect to (WINS-A), and add the dynamic name MY\_RECORD \[04h\] to the (WINS-A) database.
    
    netsh wins server 192.168.125.30 add name Name=MY\_RECORD EndChar=04 IP={192.168.0.205}
    
    rem 2. Connect to (WINS-A), and set (WINS-B) as a push/pull replication partner of (WINS-A).
    
    netsh wins server 192.168.125.30 add partner Server=192.168.0.189 Type=2
    
    rem 3. Connect to (WINS-B), and set (WINS-A) as a push/pull replication partner of (WINS-B).
    
    netsh wins server 192.168.0.189 add partner Server=192.168.125.30 Type=2
    
    rem 4. Connect back to (WINS-A), and initiate a push replication to (WINS-B).
    
    netsh wins server 192.168.125.30 init push Server=192.168.0.189 PropReq=0
    
    rem 5. Connect to (WINS-B), and check that the record MY\_RECORD \[04h\] was replicated successfully.
    
    netsh wins server 192.168.0.189 show name Name=MY\_RECORD EndChar=04
    
    rem 6. End example batch file.

## Netsh WINS commands used in the example batch file

The following section lists the **netsh wins** commands that are used in this example procedure.

- **server**. Shifts the current WINS command\-line context to the server specified by either its name or IP address.
- **add name**. Registers a name on the WINS server.
- **add partner**. Adds a replication partner on the WINS server.
- **init push**. Initiates and sends a push trigger to a WINS server.
- **show name**. Displays detailed information for a particular record in the WINS server database.  

For more information, see [Network Shell (Netsh)](netsh.md).
