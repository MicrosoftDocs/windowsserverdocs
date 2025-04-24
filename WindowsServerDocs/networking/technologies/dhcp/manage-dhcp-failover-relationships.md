---
title: Manage DHCP failover relationships in Windows Server
description: Learn how to manage DHCP failover relationships in Windows Server. This guide provides steps and best practices for configuring and maintaining DHCP failover.
ms.topic: how-to
author: meaghanlewis
ms.author: mosagie
ms.date: 04/23/2025
#customer intent: As a network administrator, I want to manage DHCP failover relationships so that I can ensure high availability and load balancing for DHCP services.
---

# Manage DHCP failover relationships in Windows Server

Learn how to manage DHCP failover relationships in Windows Server.

Failover relationships are settings used by two DHCP servers to share one or more failover-enabled DHCP scopes.

A single failover relationship can be associated to multiple DHCP scopes. You don't need to create a new failover relationship every time you enable failover on a DHCP scope, unless a new DHCP server is used as the failover partner or a new set of failover settings are required. It's recommended to reuse existing failover relationships whenever possible to avoid unnecessary duplication of failover settings.

## Prerequisites

- Understand how failover relationships work. For more information about DHCP failover relationships, see [DHCP failover overview](/windows-server/networking/technologies/dhcp/dhcp-failover).

- Two network-connected partner DHCP servers

- At least one DHCP scope exists on the local server

## Create failover relationships

To create a failover relationship on a DHCP server, you can use PowerShell, or you can use the DHCP console.

The default DHCP failover mode is load balance with 50% of leases being assigned by the local server and 50% being assigned by the partner server. Authentication is also enabled by default, but this setting isn't required. If authentication is enabled, you must also supply a shared secret. The scope ID provided must correspond to a scope configured on the local server that is not already failover-enabled, and doesn't already exist on the partner server. If DHCP failover is being configured remotely, the "local server" refers to the server specified on the command line or added to the management console.

You can't enable DHCP failover on a DHCP scope if the scope already exists on both DHCP servers in a failover relationship, as might occur in a split scope configuration. If a DHCP scope exists on the partner DHCP server it must be deleted prior to configuring DHCP failover. See the following examples:

### Configure DHCP failover using PowerShell

1. On the Windows desktop, select the Start button and type any part of the name **Windows PowerShell**.

1. Right-click Windows PowerShell and select **Run as Administrator**.

1. Use the PowerShell cmdlet [Add-DhcpServerv4Failover](/powershell/module/dhcpserver/add-dhcpserverv4failover) to add an IPv4 failover relationship on the DHCP server service. Run the following command:

```powershell
Add-DhcpServerv4Failover -ComputerName "dhcp1.contoso.com" -Name "dc1-dhcp1" -PartnerServer "dhcp2.contoso.com" -ScopeId 10.10.10.0,10.20.20.0 -SharedSecret "sEcReT"
```

This command creates a load balance failover relationship between **dhcp1.contoso.com** and **dhcp2.contoso.com**. The failover has scopes 10.10.10.0, and 10.20.20.0 present on **dhcp1.contoso.com**. These scopes are created on the partner DHCP server service that runs on the computer named **dhcp2.contoso.com** as part of the failover relationship creation. Message authentication is enabled for the server-to-server message exchange with the specified shared secret.

### Configure DHCP failover using the DHCP console

1. Open Server Manager if it's not already open.

1. Select **Tools**, then **DHCP**.

1. In the DHCP console, select your server, and expand it so you see IPv4.

1. Right-click, and select **Configure Failover...**.

    ![Screenshot of selecting Confgiure Failover from the option menu.](media/select-configure-failover.png)

1. The Configure Failover wizard opens.

1. Complete the steps to setup DHCP failover.

    ![Screenshot of using the DHCP console to create a failover relationship.](media/configure-failover.png)

In the previous examples, a new failover relationship named **dc1-dhcp1** is established between **dhcp1.contoso.com** and **dhcp2.contoso.com**. to use a 50-50 load balancing percentage for the DHCP scope with ID 192.168.10.0.

> [!IMPORTANT]
> A single DHCP server can support up to 31 failover relationships. To avoid exceeding this limit, reuse existing failover relationships when possible and delete failover relationships that aren't in use.
> Failover relationships can exist with no association to a DHCP scope. This occurs if you deconfigure failover on the last DHCP scope associated to a failover relationship, and do not also delete the failover relationship. You might do this if you plan to reuse the failover relationship later.

## View failover relationships

You can view failover relationships on a DHCP server using either Windows PowerShell, or the DHCP console.

### View DHCP failover using Windows PowerShell

To view failover relationships on a DHCP server, you can use the cmdlet [Get-DhcpServerv4Failover](/powershell/module/dhcpserver/get-dhcpserverv4failover) in an elevated Windows PowerShell prompt.

```powershell
Get-DhcpServerv4Failover
```

```output
    Name                : dc1.contoso.com-192.168.0.254
    PartnerServer       : 192.168.0.254
    Mode                : HotStandby
    LoadBalancePercent  :
    ServerRole          : Active
    ReservePercent      : 5
    MaxClientLeadTime   : 01:00:00
    StateSwitchInterval :
    State               : Normal
    ScopeId             : {192.168.50.0, 192.168.0.0}
    AutoStateTransition : False
    EnableAuth          : False
    
    Name                : dhcp1-dc1 load balance
    PartnerServer       : dhcp1.contoso.com
    Mode                : LoadBalance
    LoadBalancePercent  : 50
    ServerRole          :
    ReservePercent      :
    MaxClientLeadTime   : 01:00:00
    StateSwitchInterval :
    State               : Normal
    ScopeId             :
    AutoStateTransition : False
    EnableAuth          : False
```

An advantage to using Windows PowerShell to view failover relationships is that you can view more properties of the DHCP failover relationship than you can see in the DHCP console.

### View DHCP failover using the DHCP console

To view failover relationships using the DHCP console, complete the following steps:

1. Open Server Manager if it's not already open.

1. Select **Tools**, then **DHCP**.

1. In the DHCP console, select your server, and expand it so you see IPv4.

1. Select **Properties**, and then select the **Failover** tab.

    ![Screenshot of viewing the failover properties in the DHCP console.](media/failover-properties.png)

## Edit failover relationships

To edit failover relationships on a DHCP server, you can either use PowerShell or the DHCP console.

 or you can open the DHCP console, right-click **IPv4**, click **Properties**, and then click the **Failover** tab. See the following examples:

### Edit DHCP failover using Windows PowerShell

To edit failover relationships on a DHCP server, you can use the cmdlet [Set-DhcpServerv4Failover](/powershell/module/dhcpserver/set-dhcpserverv4failover).

1. On the Windows desktop, select the Start button and type any part of the name **Windows PowerShell**.

1. Right-click Windows PowerShell and select **Run as Administrator**.

1. Run the following command:

```powershell
Set-DhcpServerv4Failover –Name "dhcp1-dc1" –LoadBalancePercent 70
```

This command changes the failover relationship **dhcp1-dc1** to take 70% of the client requests served by the DHCP server.

### Edit properties of the failover relationship using the DHCP console

1. Open Server Manager if it's not already open.

1. Select **Tools**, then **DHCP**.

1. In the DHCP console, select your server, and expand it so you see IPv4.

1. Select **Properties**, and then select the **Failover** tab.

1. Choose a failover relationship, and then select **Edit**.

![Screenshot of editing the failover properties in the DHCP console.](media/edit-failover-relationship.png)

## Delete failover relationships

To delete a failover relationship on a DHCP server, you can either use PowerShell or the DHCP console.

### Delete a DHCP failover relationship using Windows PowerShell

To edit failover relationships on a DHCP server, you can use the cmdlet [Remove-DhcpServerv4Failover](/powershell/module/dhcpserver/remove-dhcpserverv4failover).

1. On the Windows desktop, select the Start button and type any part of the name **Windows PowerShell**.

1. Right-click Windows PowerShell and select **Run as Administrator**.

1. Run the following command:

```powershell
Remove-DhcpServerv4Failover –Name dhcp1.contoso.com-dhcp2-dns1.contoso.com
```

### Delete a DHCP failover relationship using the DHCP console

To delete a failover relationship using the DHCP console, complete the following steps:

1. Open Server Manager if it's not already open.

1. Select **Tools**, then **DHCP**.

1. In the DHCP console, select your server, and expand it so you see IPv4.

1. Select **Properties**, and then select the **Failover** tab.

1. Highlight the relationship name on the **Failover** tab and then select **Delete**. You're prompted to confirm the deletion, and if any scopes are currently associated with the failover relationship, these are listed.

    ![Screenshot of deleting a failover relationship in the DHCP console.](media/delete-failover-relationship.png)

1. Select **OK** to confirm deletion of the failover relationship. Deleting a failover relationship that has DHCP scopes associated with it removes those scopes from the partner DHCP server. The scopes remain on the DHCP server where the failover relationship was deleted.

> [!NOTE]
> If you remove the last DHCP scope from a failover relationship using the DHCP console, you're notified that the failover relationship can be deleted. The failover relationship is not automatically removed. If you do not plan to reuse the relationship later, manually delete this relationship from either the primary DHCP server or the failover partner.

## Related content

[DHCP Failover overview](/windows-server/networking/technologies/dhcp/dhcp-failover)
