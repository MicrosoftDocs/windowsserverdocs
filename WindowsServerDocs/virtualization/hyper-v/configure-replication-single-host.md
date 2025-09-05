---
title: Enable Hyper-V Replica on a single host
description: Learn how to configure replication for virtual machines going to single Hyper-V hosts using Hyper-V Replica.
ms.topic: how-to
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 11/10/2025
---

# Enable Hyper-V Replica on a single host

Hyper-V Replica helps you protect your workloads by replicating virtual machines (VMs) between Hyper-V hosts running Windows Server. This article explains how to enable Hyper-V Replica on a single host by using Hyper-V Manager, PowerShell, or Windows Admin Center - Virtualization mode.

You can replicate between clusters, single hosts, or a combination of both. If you use a certificate for authentication, there's no Active Directory dependency between the hosts. Single hosts can either be domain members or be in a workgroup.

If you want to learn how to enable Hyper-V Replica on a failover cluster instead, see [Enable Hyper-V Replica on a failover cluster](configure-replication-failover-cluster.md). For more information about Hyper-V Replica and how it works, see [Hyper-V Replica overview](replication-overview.md).

## Prerequisites

Before you begin, make sure you meet the following prerequisites:

- You have a single Hyper-V host to receive the replicated VM. You also have another cluster or single host that runs the VM you want to replicate.

- Decide on an authentication method:

  - If your hosts are joined to the same or trusted Active Directory domains, you can use Kerberos (HTTP) authentication.

  - If your hosts aren't domain joined or are in untrusted domains, or you also want to use encryption, you must use certificate-based (HTTPS) authentication. You need to have a valid certificate installed on each host, both sending and receiving. The certificate must meet the following requirements:
    - Not be expired
    - Have both Client and Server Authentication Enhanced Key Usage (EKU) attributes and an associated private key.
    - Terminate at a valid root certificate.
    - The subject common name (CN) or subject alternative name (SAN) must match the fully qualified domain name (FQDN) of the host. If you're sending a VM from a cluster, you also need a certificate for the Hyper-V Replica Broker role FQDN on each primary host.

- Network connectivity between the hosts. By default, if you use Kerberos authentication, replication uses HTTP over port 80. If you use certificate-based authentication, replication uses HTTPS over port 443.

- A storage location on the receiving host to store the replicated VMs.

- A user account that has administrative privileges on both the primary and replica clusters or hosts.

## Enable Hyper-V Replica

Before you can replicate VMs to a single Hyper-V host, you need to enable Hyper-V Replica. You configure the receiving host, not the primary cluster or host.

To ensure that you can fail a VM back to the original primary host or cluster after a failover event, configure both primary and replica hosts and clusters for replication.

Use Hyper-V Manager, PowerShell, or Windows Admin Center - Virtualization mode to enable and configure Hyper-V Replica. Select the relevant tab for instructions.

### [Hyper-V Manager](#tab/hyper-v-manager)

To enable and configure Hyper-V Replica by using Hyper-V Manager:

1. Open **Hyper-V Manager** on a device you use to manage the host that you want to replicate to, or on the host itself where Windows Server with Desktop Experience is installed.

1. In the left pane, select the host you want to configure as the replica server.

1. In the right pane, under **Actions**, select **Hyper-V Settings**.

1. Under the **Server** section, select **Replication Configuration** in the left pane and make the following changes:

   1. Check the box **Enable this computer as a Replica server**.

   1. For **Authentication and ports**, check the box for the authentication method you want to use from **Use Kerberos (HTTP)** or **Use certificate-based authentication (HTTPS)**. Change the port if you don't want to use the default ports. If you're using certificate-based authentication, select **Select Certificate**, then you're prompted to select the certificate that matches the requirements.

   1. For **Authorization and storage**, select either **Allow replication from any authenticated server** to allow the replica server to accept VM replication traffic from any primary server that authenticates successfully, or **Allow replication from the specified servers** to accept traffic only from the primary servers you specifically select. For both options, you need to specify where the replicated VHDs should be stored on the replica host.

      If you select **Allow replication from the specified servers**, select **Add**. In **Add Authorization Entry**, specify the FQDN of a primary host, a location to store replica files, and a trust group. A trust group is a free-form text field that you can use to group primary servers. Select **OK**.

   1. Select **OK** to save your settings.

   :::image type="content" source="media/configure-replication-single-host/replication-settings-hyper-v-manager.png" alt-text="A screenshot of the Replication Configuration settings in Hyper-V Manager showing options to enable the server as a Replica and configure authentication and authorization." lightbox="media/configure-replication-single-host/replication-settings-hyper-v-manager.png":::

### [PowerShell](#tab/powershell)

To enable and configure Hyper-V Replica by using PowerShell, use cmdlets in the [Hyper-V](/powershell/module/hyper-v/) module. Replace placeholder `<values>` with your own values.

1. Open a PowerShell session as an administrator on a single host that you want to replicate to, or connect remotely by using the [Enter-PSSession](/powershell/module/microsoft.powershell.core/enter-pssession) cmdlet on a device you use to manage the cluster or host.

1. Import the Hyper-V module by running the following command:

   ```powershell
   Import-Module Hyper-V
   ```

1. Enable Hyper-V Replica by running the following commands. This simple example uses Kerberos authentication over port 80. For more information about the available parameters, such as for certificate authentication or restrict replication from specific hosts, see [Set-VMReplicationServer](/powershell/module/hyper-v/set-vmreplicationserver).

   ```powershell
   Set-VMReplicationServer -ReplicationEnabled $true -AllowedAuthenticationType Kerberos
   ```

1. Check the status of the replication configuration by running the following command:

   ```powershell
   Get-VMReplicationServer
   ```

   Here's an example of the output you should see. The value for the **State** parameter should be  `Online`.

   ```output
   RepEnabled AuthType KerbAuthPort CertAuthPort AllowAnyServer
   ---------- -------- ------------ ------------ --------------
   True       Kerb     80           443          True
   ```

### [Windows Admin Center](#tab/windows-admin-center)

> [!IMPORTANT]
> Configuring Hyper-V Replica using *Windows Admin Center - Virtualization mode* is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.
>
> During the preview, configuring Hyper-V Replica by using Windows Admin Center - Virtualization mode is available for the following scenarios:
>
> - Configuring a single host as a replica server and configuring replication for VMs from a single host to another single host. Failover clusters aren't supported at this time.
> - Replication and failover of VMs is from a primary host to a replica host only. Performing a test failover or configuring reverse replication or extended replication isn't supported at this time.
> - Hyper-V hosts must be running Windows Server 2022 or later.
>
> For more information about Windows Admin Center - Virtualization mode, see [Windows Admin Center - Virtualization mode overview](../windows-admin-center/virtualization-mode-overview.md).

To enable and configure Hyper-V Replica by using Windows Admin Center - Virtualization mode:

1. Go to your URL for **Windows Admin Center - Virtualization mode** and sign in.

1. In the left pane, select the host you want to configure as the replica server.

1. In the list of tools, select **Settings**.

1. In the **Settings** pane, under Hyper-V Host Settings, select **Replication** and make the following changes:

   1. Check the box **Enable this computer as a Replica server**.

   1. For **Authentication and Ports**, check the box for the authentication method you want to use from **Use Kerberos (HTTP)** or **Use certificate-based authentication (HTTPS)**. Change the port if you don't want to use the default ports. If you're using certificate-based authentication, select **Select**, then you're prompted to select the certificate that matches the requirements.

   1. For **Authorization and storage**, select either **Allow replication from any authenticated server** to allow the replica server to accept VM replication traffic from any primary server that authenticates successfully, or **Allow replication from the specified servers** to accept traffic only from the primary servers you specifically select. For both options, you need to specify where the replicated VHDs should be stored on the replica host.

      If you select **Allow replication from the specified servers**, select **Add**. In **Add Authorization Entry**, specify the FQDN of a primary host, a location to store replica files, and a trust group. A trust group is a free-form text field that you can use to group primary servers. Select **OK**.

   1. Select **Save** to save your settings.

   :::image type="content" source="media/configure-replication-single-host/replication-settings-windows-admin-center.png" alt-text="A screenshot of the Replication Configuration settings in Hyper-V Manager showing options to enable the server as a Replica and configure authentication and authorization." lightbox="media/configure-replication-single-host/replication-settings-windows-admin-center.png":::

---

## Enable Windows Firewall rules for Hyper-V Replica

To allow replication between the primary and replica clusters and hosts, traffic must get through the Windows Firewall (or any other third-party firewalls). When you install the Hyper-V role on each host, the Windows Firewall creates exceptions for HTTP (80) and HTTPS (443), but it doesn't enable them by default. You need to enable the appropriate rules for all receiving hosts.

You can enable the rules by using your preferred method of managing the Windows Firewall, such as centrally using Group Policy, or locally on each node by using the Windows Firewall with Advanced Security console or PowerShell. For more information about managing the Windows Firewall and how-to guides, see [Windows Firewall tools](/windows/security/operating-system-security/network-security/windows-firewall/tools).

The rules you need to enable depend on the authentication method you chose when you configured the Hyper-V Replica Broker role:

- Enable `Hyper-V Replica HTTP Listener (TCP-In)` for Kerberos (HTTP) authentication.
- Enable `Hyper-V Replica HTTPS Listener (TCP-In)` for certificate-based (HTTPS) authentication.

## Test replication configuration

After you enable and configure Hyper-V Replica and enable the appropriate Windows Firewall rules, test the configuration to ensure that the primary cluster or host can connect to the replica host as expected.

You can use the PowerShell cmdlet [`Test-VMReplicationConnection`](/powershell/module/hyper-v/test-vmreplicationconnection) to test the connection, as shown in the following examples. Be sure to replace placeholder `<values>` with your own.

1. Open a PowerShell session as an administrator on one of the hosts that you want to replicate from, or connect remotely by using the [Enter-PSSession](/powershell/module/microsoft.powershell.core/enter-pssession) cmdlet on a device you use to manage the cluster or host.

1. Use one of the following example commands:

   - To test a connection to a replica cluster by using Kerberos authentication, run the following command:

      ```powershell
      Test-VMReplicationConnection -ReplicaServerName '<Replica host FQDN>' -ReplicaServerPort 80 -AuthenticationType Kerberos
      ```

   - To test a connection to a replica cluster by using certificate-based authentication, run the following command. You need the thumbprint of a valid certificate for Hyper-V Replica on the primary host or cluster.

     ```powershell
     Test-VMReplicationConnection -ReplicaServerName '<Replica host FQDN>' -ReplicaServerPort 443 -AuthenticationType Certificate -CertificateThumbprint AA11BB22CC33DD44EE55FF66AA77BB88CC99DD00
     ```

   For either of these example commands, here's the output you should see if the test is successful:

   ```output
   The connection to the specified Replica server with the specified parameters was successful.
   ```
