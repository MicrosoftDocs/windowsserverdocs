---
title: Migrate to DHCP failover in Windows Server
description: Learn how to migrate DHCP failover relationships in Windows Server. This guide provides steps for migrating an existing DHCP failover deployment on Windows Server.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 05/06/2025
---
# Migrate to DHCP failover

This guide provides guidance for migrating your existing DHCP server deployment to a DHCP failover configuration in Windows Server. Whether you're transitioning from a split-scope or clustered DHCP setup, this document outlines the necessary steps to ensure a smooth migration.

## Prerequisites

- The DCHP Server role is installed on both DHCP servers used to configure the failover relationship. To install the DHCP server role, follow the steps in [Install and configure DHCP server](/windows-server/networking/technologies/dhcp/quickstart-install-configure-dhcp-server).
- An existing DHCP server that is set up and running.

## Export DHCP settings and leases

If you're using clustered DHCP, you only need to export DHCP settings from the currently active DHCP server. Perform the following procedure for both the currently active DHCP server, and the backup server only if you're using a split-scope design and need to replicate DHCP leases from both DHCP servers.

> [!IMPORTANT]
> You can't import DHCP leases for the same scope from two different DHCP servers. You must consolidate the exported files into a single file.

### Export DHCP settings and leases

1. On the DHCP server that will be used to initially configure DHCP failover, **dhcp-failover-server.contoso.com**, open an elevated Windows PowerShell prompt, type the following commands, and then press ENTER:

    ```powershell
        mkdir C:\export
        mkdir C:\backup
        Export-DhcpServer -ComputerName "dhcp-server.contoso.com" -File "C:\exportdir\dhcpexport.xml"
    ```

    This example exports all of the DHCP server, DHCPv4 and DHCPv6, configurations including scopes present on the DHCP server service to the specified export file in XML file format.

1. If needed, perform the export step again specifying a computer name of **dhcp-server-2.contoso.com**, and exporting to the file **C:\exportdir\dhcpexport2.xml**. When you're finished, you have one XML file for every DHCP server that has leases you wish to import to **dhcp-failover-server.contoso.com**.

1. If you have multiple files that contain leases for the same scope ID, these files must be consolidated before importing data to **dhcp-failover-server.contoso.com**.

## Import DHCP settings and leases to DHCP failover server

Before you perform this procedure, verify that you have consolidated and saved leases and settings from your current DHCP servers in a file on the new DHCP server. The following procedure assumes DHCP settings and leases are saved in the **C:\export\dhcpexport.xml** file on a DHCP server with a host name of **dhcp-failover-server.contoso.com**.

### Import DHCP settings and leases

- At an elevated Windows PowerShell prompt, type the following commands and press ENTER:

    ```powershell
    Import-DhcpServer -ComputerName "dhcp-failover-server.contoso.com" -File "C:\exports\dhcpexport.xml" -BackupPath "C:\dhcpbackup\"
    ```

    This example imports the configuration data in the specified file onto the DHCP failover server service named **dhcp-failover-server.contoso.com**. The file can contain DHCPv4 and DHCPv6 configuration data.

By default, all scopes are imported. A scope won't be imported if it already exists on the destination server. To specify only some scopes for import, use the **–ScopeId** parameter. For example:

```powershell
Import-DhcpServer -ComputerName "dhcp-failover-server.contoso.com" -File "C:\exports\dhcpexport.xml" -BackupPath "C:\dhcpbackup\" -ScopeId 10.10.10.0,10.20.20.0
```

This example imports the configuration data for scopes 10.10.10.0 and 10.20.20.0 from the specified file onto the DHCP server service that runs on the computer named **dhcp-failover-server.contoso.com**. If the export file contains scopes besides 10.10.10.0 and 10.20.20.0, those scopes are ignored. The DHCPv4 server level configuration data, if present in the export file, is also imported onto the DHCP server service.

> [!IMPORTANT]
> Verify that options and settings on the failover server are correct before proceeding. Options such as DNS servers, reservations, or filters also might need to be updated on the failover server.

## Import server level settings to DHCP failover partner server

Use the following steps to import server-level settings from **dhcp-server.contoso.com** to the failover partner server **dhcp-failover-server-2.contoso.com**.

### Import server level settings

- At an elevated Windows PowerShell prompt on the failover partner server, type the following commands and press ENTER:

    ```powershell
    mkdir C:\dhcpbackup\
    Import-DhcpServer -ComputerName "dhcp-failover-server-2.contoso.com" -File "C:\exports\dhcpexport.xml" -BackupPath "C:\dhcpbackup\"
    ```

The DHCP server’s database is backed up locally on the same server where the DHCP Server service is running even if you run the **Import-DhcpServer** cmdlet remotely.

## Configure DHCP failover

Next, configure DHCP failover for some or all scopes on **dhcp-failover-server.contoso.com**, specifying **dhcp-failover-server-2.contoso.com** as the failover partner server. For steps to configure DHCP failover, see [Configure DHCP Failover](/windows-server/networking/technologies/dhcp/manage-dhcp-failover-relationships?tabs=powershell#configure-failover-relationships) using either PowerShell or Server Manager.

## Update DHCP relay agents and complete migration

Finally, update [DHCP relay agents](/windows-server/networking/technologies/dhcp/dhcp-failover#relay-agents) to use the new DHCP servers and complete DHCP migration.

After leases and settings have been imported to the DHCP failover servers, settings are verified, and DHCP relays are updated, the migration is complete. You can stop the DHCP Server service on **dhcp-server.contoso.com**, and **dhcp-server-2.contoso.com** so that new DHCP leases are only issued from the DHCP failover servers.

## Related content

- [DHCP failover overview](/windows-server/networking/technologies/dhcp/dhcp-failover)

- [Manage DHCP failover relationships](/windows-server/networking/technologies/dhcp/manage-dhcp-failover-relationships?tabs=powershell)

