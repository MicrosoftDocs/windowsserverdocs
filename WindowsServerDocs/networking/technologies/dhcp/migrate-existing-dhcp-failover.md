---
title: Migrate existing DHCP failover deployment on Windows Server
description: This article serves as a guide for how to migrate a Dynamic Host Configuration Protocol (DHCP) failover relationship in Windows Server.
ms.topic: how-to
ms.author: roharwoo
author: robinharwood
ms.date: 05/08/2025
#customer intent: As an IT administrator, I want to migrate a DHCP server to Windows Server so that I can ensure seamless network configuration and management.
---

# Migrate existing DHCP failover deployment

Migrating an existing DHCP failover deployment to a newer version of Windows Server ensures your network infrastructure remains up-to-date, secure, and efficient. This comprehensive guide walks you through the entire migration process, starting with breaking the failover relationship on your current servers, exporting and importing DHCP settings, and configuring failover on the new servers. By following this guide, IT administrators can transition their DHCP failover setup to the latest Windows Server environment, ensuring minimal downtime, and uninterrupted network services.

## Prerequisites

- At least Windows Server 2012 installed.

- The DHCP server role is installed.

- An existing failover relationship exists.

- Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures.

## Server details

The steps in this guide are valid for Windows Server versions starting from Windows Server 2012.

For this guide, consider the scenario where the DHCP failover deployment is migrated from Windows Server 2022 to Windows Server 2025. The following servers are used in this migration scenario:

- **DHCP-2022-1**: The initial DHCP server that's online with active scopes.
- **DHCP-2022-2**: The initial DHCP failover partner server for DHCP-2022-1.
- **DHCP-2025-1**: The DHCP server on Windows Server 2025 that replaces DHCP-2022-1.
- **DHCP-2025-2**: The DHCP server on Windows Server 2025 that replaces DHCP-2022-2.

## Delete the failover relationship between DHCP-2022-1 and DHCP-2022-2

You can delete the failover relationship using PowerShell, or the DHCP console. Deleting a failover relationship removes all scopes that are members of the failover relationship from the partner DHCP server.

### [PowerShell](#tab/powershell)

1. At an elevated Windows PowerShell prompt on DHCP-2022-1, use the cmdlet [Remove-DhcpServerv4Failover](/powershell/module/dhcpserver/remove-dhcpserverv4failover) to delete a failover relationship with the name **DHCP-2022-1-DHCP-2022-2**.  Type the following command and then press ENTER:

    ```powershell
    Remove-DhcpServerv4Failover –Name DHCP-2022-1-DHCP-2022-2
    ```

    Replace *DHCP-2022-1-DHCP-2022-2* with the name of the DHCP failover relationship you wish to delete.

1. Use the cmdlet [Get-DhcpServerv4Failover](/powershell/module/dhcpserver/get-dhcpserverv4failover) to get the failover relationships configured on the current DHCP server. Type the following command and then press ENTER:

    ```powershell
    Get-DhcpServerv4Failover
    ```

    Verify that the DHCP failover relationship name isn't displayed in the command output, indicating that it's successfully deleted.

> [!NOTE]
> DHCP scopes from the failover relationship are removed from the partner DHCP server. Scopes remain on the server where you entered the Remove-DhcpServerv4Failover command (DHCP-2022-1 in this example).

#### [DHCP console](#tab/dhcp-console)

1. In the DHCP console on DHCP-2022-1, right-click **IPv4** and then select the **Failover** tab.

1. Click **DHCP-2022-1-DHCP-2022-2** and then select **Delete**.

1. In the Delete Failover Relationship dialog box, select **OK**, confirm that deletion was successful, and then select **Close**.

1. Click **OK** to close the IPv4 properties window.

> [!NOTE]
> DHCP scopes from the failover relationship are removed from the partner DHCP server. Scopes remain on the server where you entered the Remove-DhcpServerv4Failover command (DHCP-2022-1 in this example).

---

## Export DHCP settings to new server

Use the following procedure to export server level settings from the DHCP server that has scopes you wish to enable for DHCP failover, in preparation for import to your new DHCP servers on Windows Server 2025. Only the DHCP server level configuration is exported and imported because the lease database is replicated from DHCP-2022-1 to DHCP-2025-2 when the failover relationship is established.

> [!NOTE]
> If you're using clustered DHCP, you only need to export DHCP settings from the active node.

### Export DHCP settings

Follow the steps to export DHCP settings from DHCP-2022-1.

1. On **DHCP-2025-1**, open an elevated Windows PowerShell prompt, enter the following commands:

    ```powershell
    mkdir C:\export
    mkdir C:\backup
    Export-DhcpServer –ComputerName DHCP-2022-1 –File C:\export\DHCP-2022-1exp.xml -Verbose
    ```

1. Connect to **DHCP-2025-2**, and in an elevated Windows PowerShell prompt, run the following:

    ```powershell
    mkdir C:\export
    mkdir C:\backup
    Export-DhcpServer –ComputerName DHCP-2022-1 –File C:\export\DHCP-2022-1exp.xml -Verbose
    ```

DHCP configuration settings are exported from a remote DHCP server, **DHCP-2022-1**, to a file on the local server, **DHCP-2025-1** and **DHCP-2025-2**.

Alternatively, you can export to a file on DHCP-2022-1, and then copy the settings file over the network to DHCP-2025-2 and DHCP-2025-1.

## Import DHCP settings

The following procedure assumes DHCP settings are saved in the **C:\\export\\DHCP-2022-1exp.xml** file on a DHCP server with a host name of **DHCP-2025-1**. Replace the file and host names with names used in your environment. Don't repeat this procedure on DHCP-2025-2.

#### Import DHCP settings and leases to new server

Follow the steps to import DHCP settings and leases to DHCP-2025-1.

1. At an elevated Windows PowerShell prompt, enter the following commands:

    ```powershell
    Import-DhcpServer –ComputerName DHCP-2025-1 –File C:\export\DHCP-2022-1exp.xml -BackupPath C:\backup\ -ServerConfigOnly -Verbose -Force
    ```

This command imports only the server-level configuration of DHCP-2022-1 to DHCP-2025-1. Server-level settings include:

- Custom vendor classes and user classes

- Custom option definitions

- Server-level option values

- Server-level policies

- MAC address filters

- Custom conflict detection settings

These server-level settings must also be imported to the new DHCP failover partner server (DHCP-2025-2) with the same procedure.

> [!NOTE]
> The **–BackupPath** parameter is used to specify a path where the current DHCP server’s database is backed up prior to making any configuration changes as part of the import operation. To roll back the import operation, use the [Restore-DhcpServer](/powershell/module/dhcpserver/restore-dhcpserver) cmdlet, and specify **C:\backup** for the value of the **-Path** parameter.

> [!IMPORTANT]
> Verify that options and settings on DHCP-2025-1 are correct before proceeding.

### Import DHCP settings to new failover partner server

Follow the steps to import DHCP settings to DHCP-2025-2.

1. At an elevated Windows PowerShell prompt, enter the following commands:

    ```powershell
    Import-DhcpServer –ComputerName DHCP-2025-2 –File C:\export\DHCP-2022-1exp.xml -BackupPath C:\backup\ -ServerConfigOnly -Verbose -Force
    ```

## Configure DHCP failover between DHCP-2022-1 and DHCP-2025-1

Next, configure DHCP failover for all desired scopes on DHCP-2022-1, specifying DHCP-2025-1 as the failover partner server. For procedures to configure DHCP failover using PowerShell or the DHCP console, see [Configure DHCP Failover](/windows-server/networking/technologies/dhcp/manage-dhcp-failover-relationships?tabs=powershell#configure-failover-relationships).

This step replicates scopes and leases to DHCP-2025-1 in preparation for taking DHCP-2022-1 offline.

## Delete the DHCP failover relationship on DHCP-2025-1

Delete the DHCP failover relationship on DHCP-2025-1.

### [PowerShell](#tab/powershell)

1. At an elevated Windows PowerShell prompt on DHCP-2025-1, enter the following command:

    ```powershell
    Remove-DhcpServerv4Failover –Name DHCP-2022-1-DHCP-2025-1
    ```

    In the previous procedure, replace *DHCP-2022-1-DHCP-2025-1* with the name of the DHCP failover relationship you created in the previous procedure.

2. Type the following command and then press ENTER:

    ```powershell
    Get-DhcpServerv4Failover
    ```

    Verify that the DHCP failover relationship name isn't displayed in the command output, indicating that it's successfully deleted.

>[!NOTE]
> DHCP scopes added to the failover relationship ARE removed from the partner DHCP server. Scopes remain on the server where you entered the Remove-DhcpServerv4Failover command (DHCP-2025-1 in this procedure).

### [DHCP console](#tab/dhcp-console)

1. In the DHCP console on DHCP-2025-1, right-click **IPv4** and then click the **Failover** tab.

2. Click **DHCP-2022-1-DHCP-2025-1** and then click **Delete**.

3. In the Delete Failover Relationship dialog box, click **OK**, confirm that deletion was successful, and then click **Close**.

4. Click **OK** to close the IPv4 properties window.

>[!NOTE]
> DHCP scopes added to the failover relationship ARE removed from the partner DHCP server. Scopes remain on the server where you entered the Remove-DhcpServerv4Failover command (DHCP-2025-1 in this procedure).

---

## Configure DHCP failover between DHCP-2025-1 and DHCP-2025-2

Next, configure DHCP failover for all desired scopes on DHCP-2025-1, specifying DHCP-2025-2 as the failover partner server. For procedures to configure DHCP failover using PowerShell or the DHCP console, see [Configure DHCP Failover](/windows-server/networking/technologies/dhcp/manage-dhcp-failover-relationships?tabs=powershell#configure-failover-relationships).

## Update DHCP relay agents and complete migration

Finally, update [DHCP relay agents](/windows-server/networking/technologies/dhcp/dhcp-failover#relay-agents) to use the new DHCP servers and complete DHCP migration.

After leases and settings are replicated to DHCP-2025-1 and DHCP-2025-2, settings are verified, and DHCP relays are updated, you can stop the DHCP Server service on DHCP-2022-1 and DHCP-2022-2 so that new DHCP leases are only issued from DHCP-2025-1 or DHCP-2025-2.

## Related content

- [DHCP failover overview](/windows-server/networking/technologies/dhcp/dhcp-failover)

- [Manage DHCP failover relationships](/windows-server/networking/technologies/dhcp/manage-dhcp-failover-relationships?tabs=powershell)

