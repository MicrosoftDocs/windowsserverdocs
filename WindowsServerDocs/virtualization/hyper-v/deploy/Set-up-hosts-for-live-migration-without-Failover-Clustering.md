---
title: Set up hosts for live migration without Failover Clustering
description: Set up nonclustered hosts for live migration, configure authentication, and secure your network for seamless virtual machine moves.
ms.topic: how-to
ms.author: roharwoo
author: robinharwood
ms.date: 08/14/2025
---
# Set up hosts for live migration without Failover Clustering

Live migration lets you move running virtual machines between servers with minimal downtime. This article shows you how to set up nonclustered hosts for live migration in Hyper-V, including authentication options, network configuration, and security best practices. Use these steps if you didn’t configure live migration during Hyper-V installation, or need to update your settings.

## Requirements for setting up live migration

To set up nonclustered hosts for live migration, you need:

- Membership in the local Hyper-V Administrators group or the Administrators group on both the source and destination computers meets this requirement, unless you're setting up constrained delegation. Membership in the Domain Administrators group is required to set up constrained delegation.

- The Hyper-V role in Windows Server installed on the source and destination servers. You can run a live migration between hosts running Windows Server 2012 R2 and later. For installation instructions, see [Install the Hyper-V role on Windows Server](../get-started/Install-the-Hyper-V-role-on-Windows-Server.md).

- Source and destination computers that belong to the same Active Directory domain, or to domains that trust each other.

- The Hyper-V management tools installed on a computer running at least Windows Server 2016 or Windows 10, unless the tools are installed on the source or destination server and you run the tools from the server.

## Consider options for authentication and networking

Decide how you want to set up authentication, performance, and networking options.

- **Authentication**: Which protocol do you use to authenticate live migration traffic between the source and destination server? The protocol you choose determines whether you need to sign in to the source server before starting a live migration:

  - Kerberos lets you avoid signing in to the server, but requires you to set up constrained delegation. See the following details for instructions.
  - CredSSP lets you avoid setting up constrained delegation, but requires you to sign in to the source server. You can do this through a local console session, a Remote Desktop session, or a remote Windows PowerShell session.

      CredSSP requires you to sign in for situations that aren't always obvious. For example, if you sign in to TestServer01 to move a virtual machine to TestServer02, and then want to move the virtual machine back to TestServer01, you need to sign in to TestServer02 before you try to move the virtual machine back to TestServer01. If you don't, the authentication attempt fails, an error occurs, and you see the following message:

      "Virtual machine migration operation failed at migration Source.
      Failed to establish a connection with host *computer name*: No credentials are available in the security package 0x8009030E."

- **Performance**: Should you set up performance options? These options can reduce network and CPU usage, and make live migrations go faster. Check your requirements and infrastructure, and test different configurations to decide. The options are described at the end of step 2.

- **Network preference**: Do you allow live migration traffic through any available network, or do you isolate the traffic to specific networks? As a security best practice, isolate the traffic onto trusted, private networks because live migration traffic isn't encrypted when sent over the network. You can isolate the network by using a physically isolated network or another trusted networking technology like VLANs.

### Upgrading to Windows Server 2025

Starting with Windows Server 2025, [Credential Guard is enabled by default](/windows/security/identity-protection/credential-guard/#default-enablement-on-windows-server) on all domain-joined servers that aren't domain controllers. Because of this, you can't use CredSSP-based live migration with Hyper-V after upgrading to Windows Server 2025. CredSSP-based delegation is the default for Windows Server 2022 and earlier for live migration. Instead, use Kerberos constrained delegation, as described in the following section. For more information, see [Live migration with Hyper-V breaks when upgrading to Windows Server 2025](/windows/security/identity-protection/credential-guard/considerations-known-issues#live-migration-with-hyper-v-breaks-when-upgrading-to-windows-server-2025-preview).

## Step 1: Configure constrained delegation (optional)

If you decide to use Kerberos to authenticate live migration traffic, configure constrained delegation using an account that is a member of the Domain Administrators group.

### Use the Users and Computers snap-in to set up constrained delegation

1. Open the Active Directory Users and Computers snap-in. In Server Manager, select the server, then select **Tools** > **Active Directory Users and Computers**.

1. In the navigation pane in **Active Directory Users and Computers**, select the domain and then double-click the **Computers** folder.

1. In the **Computers** folder, right-click the computer account of the source server, and then select **Properties**.

1. In **Properties**, select the **Delegation** tab.

1. On the **Delegation** tab, select **Trust this computer for delegation to the specified services only**, and then select **Use any authentication protocol**.

1. Select **Add**.

1. In **Add Services**, select **Users or Computers**.

1. From **Select Users or Computers**, type the name of the destination server. Select **Check Names** to verify it, and then select **OK**.

1. From **Add Services**, in the list of available services, do the following and then select **OK**:

    - To move virtual machine storage, select **cifs**. This is required if you want to move the storage along with the virtual machine, and if you want to move only a virtual machine's storage. If the server is configured to use SMB storage for Hyper-V, this should already be selected.

    - To move virtual machines, select **Microsoft Virtual System Migration Service**.

1. On the **Delegation** tab of the Properties dialog box, check that the services you selected in the previous step are listed as the services to which the destination computer can present delegated credentials. Select **OK**.

1. In the **Computers** folder, select the computer account of the destination server and repeat the process. In the **Select Users or Computers** dialog box, make sure to specify the name of the source server.

The configuration changes take effect after:

- The changes replicate to the domain controllers that the servers running Hyper-V are logged into.
- The domain controller issues a new Kerberos ticket.

## Step 2: Set up the source and destination computers for live migration

This step covers options for authentication and networking. For better security, select specific networks for live migration traffic, as discussed earlier. You also choose a performance option in this step.

### Use Hyper-V Manager to set up the source and destination computers for live migration

1. Open Hyper-V Manager. In Server Manager, select **Tools** > **Hyper-V Manager**.

1. In the navigation pane, select a server. If it isn't listed, right-click **Hyper-V Manager**, select **Connect to Server**, enter the server name, and select **OK**. Repeat to add more servers.

1. In the **Action** pane, select **Hyper-V Settings** > **Live Migrations**.

1. In the **Live Migrations** pane, select **Enable incoming and outgoing live migrations**.

1. Under **Simultaneous live migrations**, enter a different number if you don't want to use the default of 2.

1. Under **Incoming live migrations**, if you want to use specific network connections to accept live migration traffic, select **Add** to type the IP addr1. To set Kerberos and performance options, expand **Live Migrations** and select **Advanced Features**.
    - If you set up constrained delegation, under **Authentication protocol**, select **Kerberos**.
    - Under **Performance options**, review the details and select a different option if it fits your environment.ce options**, review the details and choose a different option if it's appropriate for your environment.

1. Select **OK**.

1. Select the other server in Hyper-V Manager and repeat these steps.

### Use Windows PowerShell to set up the source and destination computers for live migration

You can use three cmdlets to set up live migration on nonclustered hosts: [Enable-VMMigration](/powershell/module/hyper-v/enable-vmmigration), [Set-VMMigrationNetwork](/powershell/module/hyper-v/set-vmmigrationnetwork), and [Set-VMHost](/powershell/module/hyper-v/set-vmhost). This example uses all three to:

- Set up live migration on the local host
- Let incoming migration traffic only on a specific network
- Choose Kerberos as the authentication protocol

Each line is a separate command.

```PowerShell
PS C:\> Enable-VMMigration

PS C:\> Set-VMMigrationNetwork 192.168.10.1

PS C:\> Set-VMHost -VirtualMachineMigrationAuthenticationType Kerberos
```

`Set-VMHost` also lets you choose a performance option and other host settings. For example, to choose SMB but keep the authentication protocol set to the default of CredSSP, enter:

```PowerShell
PS C:\> Set-VMHost -VirtualMachineMigrationPerformanceOption SMB
```

This table describes how the performance options work.

| Option | Description |
|--------|-------------|
| TCP/IP | Copies the memory of the virtual machine to the destination server over a TCP/IP connection. |
| Compression | Compresses the memory content of the virtual machine before copying it to the destination server over a TCP/IP connection. Compression is the **default** setting. |
| SMB | Copies the memory of the virtual machine to the destination server over an SMB 3.0 connection.<br>- SMB Direct is used when the network adapters on the source and destination servers have Remote Direct Memory Access (RDMA) enabled.<br>- SMB Multichannel automatically detects and uses multiple connections when a proper SMB Multichannel configuration is set up.<br>For more information, see [Improve Performance of a File Server with SMB Direct](/windows-server/storage/file-server/smb-direct). |

## Next steps

After you set up the hosts, you're ready to do a live migration. For instructions, see [Use live migration without Failover Clustering to move a virtual machine](../manage/Use-live-migration-without-Failover-Clustering-to-move-a-virtual-machine.md).


