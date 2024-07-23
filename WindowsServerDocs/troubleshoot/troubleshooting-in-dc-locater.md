---
title: Troubleshooting in DC locater
description: Learn how to troubleshoot DC Locater
ms.date: 07/30/2024
ms.topic: how-to
author: gswashington
ms.author: wscontent
---
# Troubleshooting the domain locator process

To troubleshoot the domain locator process:

1. Check Event Viewer on both the client and the server. The event logs may contain error messages indicating that there's a problem. To view Event Viewer, select **Start**, point to **Programs** > **Administrative Tools**, and then select **Event Viewer**. Check the System log on both the client and the server. Also check the Directory Service logs on the server and DNS logs on the DNS server.
2. Check the IP configuration by using the `ipconfig /all` command at a command prompt.
3. Use the Ping utility to verify network connectivity and name resolution. Ping both the IP address and the server name. You may also want to ping the domain name.
4. Use the Netdiag tool to determine whether networking components are working correctly. To send detailed output to a text file, use the following command:

    `netdiag /v >test.txt`  
    Review the log file, looking for problems, and investigate any implicated components. This file also contains other network configuration details.  
5. To fix minor problems, use the Netdiag tool with the following syntax:

    `netdiag /fix`.
6. Use the `nltest /dsgetdc:domainname` command to verify that a domain controller can be located for a specific domain.
7. Use the `NSLookup` tool to verify that DNS entries are correctly registered in DNS. Verify that the server host records and GUID SRV records can be resolved.

    For example, to verify record registration, use the following commands:  
        `nslookup servername. childofrootdomain. rootdomain.com`  
        `nslookup guid._msdcs. rootdomain.com`  

8. If either of these commands doesn't succeed, use one of the following methods to reregister records with DNS:
   - To force host record registration, type ipconfig /registerdns.
   - To force domain controller service registration, stop and start the Netlogon service.
9. To detect domain controller problems, run the DCdiag utility from a command prompt. The utility runs many tests to verify that a domain controller is running correctly. Use this command to send the results to a text file: `dcdiag /v >dcdiag.txt`  

10. Use the Ldp.exe tool to connect and bind to the domain controller to verify appropriate LDAP connectivity.
11. If you suspect that a particular domain controller has problems, it may be helpful to turn on Netlogon debug logging. Use the NLTest utility by typing this command: `nltest /dbflag:0x2000ffff`. The information is then logged in the Debug folder in the Netlogon.log file.
12. If you still haven't isolated the problem, use Network Monitor to monitor network traffic between the client and the domain controller.

## See also