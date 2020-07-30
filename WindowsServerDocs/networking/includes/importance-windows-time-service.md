---
author: eross-msft
ms.author: lizross
ms.date:  10/02/2018
ms.prod: windows-server
ms:topic: include
---

## Importance of Time Protocols
Time protocols communicate between two computers to exchange time information and then use that information to synchronize their clocks. With the Windows Time service time protocol, a client requests time information from a server and synchronizes its clock based on the information that is received.
  
The Windows Time service uses NTP to help synchronize time across a network. NTP is an Internet time protocol that includes the discipline algorithms necessary for synchronizing clocks. NTP is a more accurate time protocol than the Simple Network Time Protocol (SNTP) that is used in some versions of Windows; however, W32Time continues to support SNTP to enable backward compatibility with computers running SNTP-based time services such as Windows 2000.

There are many different reasons you might need accurate time.  The typical case for Windows is Kerberos, which requires 5 minutes of accuracy between the client and server.  However, there are many other areas that can be affected by time accuracy including:


- Government Regulations like:
	- 50 ms accuracy for FINRA in the US
	- 1 ms ESMA (MiFID II) in the EU.
- Cryptography Algorithms
- Distributed systems like Cluster/SQL/Exchange and Document DBs
- Blockchain framework for bitcoin transactions
- Distributed Logs and Threat Analysis 
- AD Replication
- PCI (Payment Card Industry), currently 1 second accuracy