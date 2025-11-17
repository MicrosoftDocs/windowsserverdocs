---
title: Replicate DHCP failover in Windows Server
description: Follow the steps to replicate DHCP failover, using either the DHCP Console, or Windows PowerShell.
ms.author: daknappe
author: dknappettmsft
ms.date: 04/25/2025
ms.topic: how-to
---

# Replicate DHCP failover

Replication is the process of copying settings from one or more failover-enabled DHCP scopes to on a DHCP server to the server’s failover partner.

Three types of replication are available:

- **Server replication**: This type of replication copies the configuration of all failover-enabled scopes on the local server to its failover partner servers.

- **Relationship replication**: This type of replication copies the configuration of all DHCP scopes that are part of a selected failover relationship to the failover partner server.

- **Scope replication**: This type of replication copies the configuration of a selected DHCP scope to the failover partner server.

Follow the steps for the type of replication you want to perform, using either the DHCP console, or Windows PowerShell.

## Prerequisites

- At least Windows Server 2012

- The DHCP server role is installed

- An existing failover relationships work exists

- Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures.

> [!IMPORTANT]
> Replication can be initiated from either DHCP server in a failover relationship. Settings on the failover partner server are overwritten with the settings that are configured on the server where replication is initiated. Therefore, it's important to always ensure replication is initiated on the server that's configured with the settings you wish to use.

## Replicate failover settings at the server level

To replicate failover settings at the server level, follow these steps.

### [DHCP console](#tab/dhcp-console)

1. On a DHCP server, open Server Manager, select **Tools** and then select **DHCP**.

1. In the DHCP console, right-click **IPv4**, and then select **Replicate Failover Scopes**.

1. Select **OK** in the alert that appears.

1. In the **Failover Scope Configuration Replication** dialog box, verify that replication was successful, and then select **Close**.

### [PowerShell](#tab/powershell)

1. On a computer with the Windows PowerShell DHCP Server module installed, right-click **Windows PowerShell** and then select **Run as Administrator**.

1. Type the following command, and then press Enter. Replace the example values with values used in your environment.

    ```powershell
    Invoke-DhcpServerv4FailoverReplication –ComputerName dhcp1.contoso.com -Force
    ```

1. Verify that the scope IDs are listed in the command output for all failover enabled scopes on the DHCP server.

In this example, the primary DHCP server is named **dhcp1.contoso.com**. If the **ComputerName** parameter isn't specified, the command is run on the local server.

---

## Replicate failover settings at the relationship level

To replicate failover settings at the relationship level, follow these steps.

### [DHCP console](#tab/dhcp-console)

1. On a DHCP server, open Server Manager, select **Tools** and then select **DHCP**.

1. In the DHCP console, right-click any failover-enabled scope, and then select **Replicate Relationship**.

1. Select **OK** in the alert that appears.

1. In the **Failover Scope Configuration Replication** dialog box, verify that replication was successful, and then select **Close**.

### [PowerShell](#tab/powershell)

1. On a computer with the Windows PowerShell DHCP Server module installed, right-click **Windows PowerShell** and then select **Run as Administrator**.

1. Type the following command, and then press Enter. Replace the example values with values used in your environment.

    ```powershell
    Invoke-DhcpServerv4FailoverReplication –ComputerName dhcp1.contoso.com –Name dhcp1-dhcp2 -Force
    ```

1. Verify that the scope IDs are listed in the command output for all failover enabled scopes that are configured to use the specified failover relationship.

In this example, the primary DHCP server is named **dhcp1.contoso.com** and the failover relationship name is **dhcp1-dhcp2**. If the **ComputerName** parameter isn't specified, the command is run on the local server.

---

## Replicate failover settings at the scope level

To replicate failover settings at the scope level, follow these steps:

### [DHCP console](#tab/dhcp-console)

1. On a DHCP server, open Server Manager, select **Tools** and then select **DHCP**.

2. In the DHCP console, right-click any failover-enabled scope, and then select **Replicate Scope**.

3. In the **Failover Scope Configuration Replication** dialog box, verify that replication was successful, and then select **Close**.

### [PowerShell](#tab/powershell)

1. On a computer with the Windows PowerShell DHCP Server module installed, right-click **Windows PowerShell** and then select **Run as Administrator**.

1. Type the following command, and then press Enter. Replace the example values with values used in your environment.

    ```powershell
    Invoke-DhcpServerv4FailoverReplication –ComputerName dhcp1.contoso.com –ScopeID 10.0.10.0,10.0.20.0 -Force
    ```

1. Verify that the scope IDs are listed in the command output for all scopes that were specified on the command line.

In this example, the primary DHCP server is named **dhcp1.contoso.com**, and the DHCP scope IDs specified are **10.0.10.0** and **10.0.20.0**. If the **ComputerName** parameter isn't specified, the command is run on the local server.

---

## Related content

- [DHCP failover overview](/windows-server/networking/technologies/dhcp/dhcp-failover)


