---
title: Troubleshoot problems on the DHCP server
description: This artilce introduces how to troubleshoot problems on the DHCP server and collect data.
manager: dcscontentpm
ms.date: 5/26/2020
ms.topic: troubleshooting
author: Deland-Han
ms.author: delhan
---
# Troubleshoot problems on the DHCP server

This article discusses how to troubleshoot problems that occur on the
DHCP server.

## Troubleshooting checklist

Check the following settings:

  - The DHCP server service is started and running. To check this setting, run the **net start** command, and look for **DHCP Server**.

  - The DHCP server is authorized. See [Windows DHCP Server Authorization in Domain Joined Scenario](/openspecs/windows_protocols/ms-dhcpe/56f8870b-a7c1-4db1-8a86-f69079fe5077).

  - Verify that IP address leases are available in the DHCP server scope for the subnet the DHCP client is on. To do this, see the statistic for the appropriate scope in the DHCP server management console.

  - Check whether any BAD\_ADDRESS listings can be found in Address Leases.

  - Check whether any devices on the network have static IP addresses that have not been excluded from the DHCP scope.

  - Verify that the IP address to which DHCP server is bound is within the subnet of the scopes from which IP addresses must be leased out. This is in case no relay agent is available. To do this, run the **Get-DhcpServerv4Binding** or **Get-DhcpServerv6Binding** cmdlet.

  - Verify that only the DHCP server is listening on UDP port 67 and 68. No other process or other services (such as WDS or PXE) should occupy these ports. To do this, run the `netstat -anb` command.

  - Verify that the DHCP server IPsec exemption is added if you are dealing with an IPsec-deployed environment.

  - Verify that the relay agent IP address can be pinged from the DHCP server.

  - Enumerate and check configured DHCP policies and filters.

## Event logs

Check the System and DHCP Server service event logs (**Applications and Services Logs** \> **Microsoft** \> **Windows** \> **DHCP-Server**) for reported issues that are related to the observed problem.
Depending on the kind of issue, an event is logged to one of the following event channels:
[DHCP Server Operational Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668\(v=ws.11\))
[DHCP Server Administrative Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668\(v=ws.11\))
[DHCP Server System Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668\(v=ws.11\))
[DHCP Server Filter Notification Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668\(v=ws.11\))
[DHCP Server Audit Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668\(v=ws.11\))

## Data collection

### DHCP Server log

The DHCP Server service debug logs provide more information about the IP address lease assignment and the DNS dynamic updates that are done by the DHCP server. These logs by default are located in %windir%\\System32\\Dhcp.
For more information, see [Analyze DHCP Server Log Files](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd183591\(v=ws.10\)).

### Network trace

A correlating network trace may indicate what the DHCP server was doing at the time that the event was logged. To create such a trace, follow these steps:

1.  Go to [GitHub](https://github.com/CSS-Windows/WindowsDiag/tree/master/ALL/TSS), and download the [tss\_tools.zip](https://github.com/CSS-Windows/WindowsDiag/blob/master/ALL/TSS/tss_tools.zip) file.

2.  Copy the Tss\_tools.zip file, and expand it to a location on the local disk, such as to the C:\\tools folder.

3.  Run the following command from C:\\tools in an elevated Command Prompt window:
    ```console
    TSS Ron Trace <Stop:Evt:>20321:<Other:>DhcpAdminEvents NoSDP NoPSR NoProcmon NoGPresult
    ```

    >[!Note]
    >In this command, replace \<*Stop:Evt:*\> and \<*Other:*\> with the event ID and the event channel that you are going to focus on in your tracing session.
    >The Tss.cmd\_ReadMe\_Help.docx files that are contained in the Tss\_tools.zip file provide more information about all available settings.

4.  After the event is triggered, the tool creates a folder that is named C:\\MS\_DATA. This folder will contain some useful output files that provide general information about the network and domain configuration of the computer.
    The most interesting file in this folder is %Computername%\_date\_time\_packetcapture\_InternetClient\_dbg.etl.
    By using the [Network Monitor](https://www.microsoft.com/download/4865) application, you can load the file, and set the display filter on the “DHCP or
    DNS” protocol to examine what is going on behind the scenes.