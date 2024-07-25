---
title: Troubleshooting in DC Locator
description: Learn how to troubleshoot the domain controller location process
ms.date: 07/30/2024
ms.topic: how-to
author: gswashington
ms.author: wscontent
---

<!-- Other article in Learn refers to the DC location algorithm as "DC Locator". I have adopted this naming convention for this article even though the original version of the article did not use it. -->

# Troubleshooting in DC Locator

> [!IMPORTANT]
> Windows Server 2025 is in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Authentication is the first step in virtually all functional scenarios in an Active Directory enterprise environment. Authentication, in turn, can't occur unless the client can first communicate with an Active Directory domain controller.

DC location refers to the algorithm the client machine uses to find a suitable domain controller (DC). DC location is a critical baseline functionality in all enterprise environments. It may be necessary at times to perform troubleshooting when using Active Directory domain controller location algorithm (DC Locator).

## Troubleshooting steps

To troubleshoot the DC Locator domain controller locator process:

1. Check Event Viewer on both the client and the server. The event logs may contain error messages indicating that there's a problem. To view Event Viewer, select **Start**, point to **Programs** > **Administrative Tools**, and then select **Event Viewer**. Check the System log on both the client and the server. Also check the Directory Service logs on the server and DNS logs on the DNS server.
1. Check the IP configuration by using the `ipconfig /all` command at a command prompt.
1. Use the Ping utility to verify network connectivity and name resolution. Ping both the IP address and the server name. You may also want to ping the domain name.
1. Use the Netdiag tool to determine whether networking components are working correctly. To send detailed output to a text file, use the following command:

    `netdiag /v >test.txt`  
    Review the log file, looking for problems, and investigate any implicated components. This file also contains other network configuration details.  
1. To fix minor problems, use the Netdiag tool with the following syntax:

    `netdiag /fix`.
1. Use the `nltest /dsgetdc:domainname` command to verify that a domain controller can be located for a specific domain.
1. Use the `NSLookup` tool to verify that DNS entries are correctly registered in DNS. Verify that the server host records and GUID SRV records can be resolved.

    For example, to verify record registration, use the following commands:  
        `nslookup servername. childofrootdomain. rootdomain.com`  
        `nslookup guid._msdcs. rootdomain.com`  

1. If either of these commands doesn't succeed, use one of the following methods to reregister records with DNS:
   - To force host record registration, type ipconfig /registerdns.
   - To force domain controller service registration, stop and start the Netlogon service.
. To detect domain controller problems, run the DCdiag utility from a command prompt. The utility runs many tests to verify that a domain controller is running correctly. Use this command to send the results to a text file: `dcdiag /v >dcdiag.txt`  

1. Use the Ldp.exe tool to connect and bind to the domain controller to verify appropriate LDAP connectivity.
1. If you suspect that a particular domain controller has problems, it may be helpful to turn on Netlogon debug logging. Use the NLTest utility by typing this command: `nltest /dbflag:0x2000ffff`. The information is then logged in the Debug folder in the Netlogon.log file.
1. If you still haven't isolated the problem, use Network Monitor to monitor network traffic between the client and the domain controller.

## See also