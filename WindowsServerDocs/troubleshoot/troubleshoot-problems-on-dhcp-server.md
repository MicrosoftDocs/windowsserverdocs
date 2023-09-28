---
title: Troubleshoot problems on the DHCP server
description: Find out how to troubleshoot problems on the DHCP server and collect data.
manager: dcscontentpm
ms.date: 09/27/2023
ms.topic: troubleshooting
author: Deland-Han
ms.author: delhan
---
# Troubleshoot problems on the DHCP server

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806271" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common DHCP issues.

This article discusses how to troubleshoot problems that occur on the DHCP server.

## Troubleshooting checklist

Check the following settings:

  - The DHCP server service is started and running. To check this setting, run the `net start` command, and look for **DHCP Server**.

  - The DHCP server is authorized. See [Windows DHCP Server Authorization in Domain Joined Scenario](/openspecs/windows_protocols/ms-dhcpe/56f8870b-a7c1-4db1-8a86-f69079fe5077).

  - Verify that IP address leases are available in the DHCP server scope for the subnet the DHCP client is on. To verify availability, see the statistic for the appropriate scope in the DHCP server management console.

  - Check whether any BAD\_ADDRESS listings can be found in Address Leases.

  - Check whether any devices on the network have static IP addresses that haven't been excluded from the DHCP scope.

  - Verify that the DHCP server binds to at least one IP address, and that this IP address is within the subnet of the scopes from which IP addresses must be leased out, unless using DHCP relay. To do this verification, run the `Get-DhcpServerv4Binding` or `Get-DhcpServerv6Binding` cmdlet. Server connection bindings are configured in the DHCP server management console under **IPv4 / IPv6 Advanced Properties**.

  - Verify that only the DHCP server is listening on UDP port 67 and 68 by running the `netstat -anb` command. No other process or other services, such as WDS or PXE, should occupy these ports.

  - Verify that the DHCP server IPsec exemption is added if you're dealing with an IPsec-deployed environment.

  - Verify that the relay agent IP address can be pinged from the DHCP server.

  - Enumerate and check configured DHCP policies and filters.

## Event logs

Check the System and DHCP Server service event logs at **Applications and Services Logs** > **Microsoft** > **Windows** > **DHCP-Server** for reported issues that are related to the observed problem.
Depending on the kind of issue, an event is logged to one of the following event channels:

- [DHCP Server Operational Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668\(v=ws.11\))
- [DHCP Server Administrative Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668\(v=ws.11\))
- [DHCP Server System Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668\(v=ws.11\))
- [DHCP Server Filter Notification Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668\(v=ws.11\))
- [DHCP Server Audit Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668\(v=ws.11\))

## Data collection

### DHCP Server log

The DHCP Server debug logs provide more information about the IP address lease assignment and the DNS dynamic updates that are done by the DHCP server. These logs by default are located in %windir%\\System32\\Dhcp.
For more information, see [Analyze DHCP Server Log Files](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd183591\(v=ws.10\)).

### Network trace

A correlating network trace may indicate what the DHCP server was doing at the time that the event was logged. To create such a trace by using the [Windows Troubleshooting Tools (TSS)](https://aka.ms/getTSS), follow the instructions at [DHCP troubleshooting guidance - Data collection](/troubleshoot/windows-server/networking/troubleshoot-dhcp-guidance#data-collection).

## See also

- [DHCP troubleshooting guidance](/troubleshoot/windows-server/networking/troubleshoot-dhcp-guidance)
- [Troubleshooting guide for Dynamic Host Configuration Protocol (DHCP)](troubleshoot-dhcp-issue.md)
- [Introduction to TroubleShootingScript toolset (TSS)](/troubleshoot/windows-client/windows-troubleshooters/introduction-to-troubleshootingscript-toolset-tss)
