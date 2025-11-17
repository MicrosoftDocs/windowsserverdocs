---
title: Enable Hyper-V Replica on a failover cluster
description: Learn how to configure replication for virtual machines going to Hyper-V hosts in a failover cluster using Hyper-V Replica.
ms.topic: how-to
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 11/10/2025
---

# Enable Hyper-V Replica on a failover cluster

Hyper-V Replica helps you protect your workloads by replicating virtual machines (VMs) between Hyper-V hosts running Windows Server. This article explains how to enable Hyper-V Replica on a failover cluster.

You can replicate between clusters, single hosts, or a combination of both. If you use a certificate for authentication, there's no Active Directory dependency between the hosts. Single hosts can either be domain members or be in a workgroup.

If you want to learn how to enable Hyper-V Replica on a single host, see [Enable Hyper-V Replica on a single host](configure-replication-single-host.md). For more information about Hyper-V Replica and how it works, see [Hyper-V Replica overview](replication-overview.md).

## Prerequisites

Before you begin, make sure you meet the following prerequisites:

- You have a Hyper-V cluster to receive the replicated VM. You also have another cluster or single host that runs the VM you want to replicate.

- Decide on an authentication method:

  - If your clusters and hosts are joined to the same or trusted Active Directory domains, you can use Kerberos (HTTP) authentication.

  - If your clusters and hosts aren't domain joined or are in untrusted domains, or you also want to use encryption, you must use certificate-based (HTTPS) authentication. You need to have a valid certificate installed on each host, both sending and receiving. The certificate must meet the following requirements:
    - Not be expired
    - Have both Client and Server Authentication Enhanced Key Usage (EKU) attributes and an associated private key.
    - Terminate at a valid root certificate.
    - The subject common name (CN) or subject alternative name (SAN) must match the fully qualified domain name (FQDN) of the Hyper-V Replica Broker role you provide for the receiving cluster. If you're sending a VM from a cluster, you also need a certificate for the Hyper-V Replica Broker role FQDN on each primary host.

- Network connectivity between the clusters and hosts. By default, if you use Kerberos authentication, replication uses HTTP over port 80. If you use certificate-based authentication, replication uses HTTPS over port 443.

- A storage location on the receiving cluster that's available to all nodes to store the replicated VMs.

- The Hyper-V Replica Broker role requires an IP address. Make sure that for the cluster network used for management, you either have a static IP address available in the subnet or you have DHCP available on the subnet.

- A user account that has administrative privileges on both the primary and replica clusters or hosts.

- Either a user account that is a domain administrator, or prestage a computer account in Active Directory for the Hyper-V Replica Broker role for the receiving cluster. For more information, see [Prestage an account for a clustered service or application](../../failover-clustering/configure-failover-cluster-accounts.md#prestage-an-account-for-a-clustered-service-or-application-optional).

## Enable the Hyper-V Replica Broker role

Before you can replicate VMs to a Hyper-V cluster, you need to enable the Hyper-V Replica Broker role. You configure the receiving cluster, not the primary cluster or host.

The Hyper-V Replica Broker is a clustered role that acts as the target for replication traffic. It provides a single point of contact for the primary server to connect to, even if the replica VM moves between nodes in the cluster.

To ensure you can fail a VM back to the original primary cluster or host after a failover event, configure both primary and replica clusters and hosts for replication.

Use Failover Cluster Manager or PowerShell to enable and configure the Hyper-V Replica Broker role. Select the relevant tab for instructions.

### [Failover Cluster Manager](#tab/failover-cluster-manager)

To enable and configure the Hyper-V Replica Broker cluster role by using Failover Cluster Manager:

1. Open **Failover Cluster Manager** on a device you use to manage the cluster that you want to replicate to, or on one of the nodes in the cluster.

1. In the left pane, expand the name of your cluster you want to replicate to, then select **Roles**.

1. In the right **Actions** pane, select **Configure Role**. In the **High Availability Wizard**, if you see **Before You Begin**, select **Next**.

1. For **Select Role**, select **Hyper-V Replica Broker**, then select **Next**.

   :::image type="content" source="media/configure-replication-failover-cluster/high-availability-wizard-select-role.png" alt-text="A screenshot of the High Availability Wizard in Failover Cluster Manager on the Select Role page highlighting the Hyper-V Replica Broker role option." lightbox="media/configure-replication-failover-cluster/high-availability-wizard-select-role.png":::

1. For **Client Access Point**, enter the name you want to use for the Hyper-V Replica Broker, then select **Next**. The name is used as the NetBIOS name for the role and is limited to 15 characters. This name must be unique in your Active Directory domain.

   :::image type="content" source="media/configure-replication-failover-cluster/high-availability-wizard-client-access-point.png" alt-text="A screenshot of the High Availability Wizard showing the Client Access Point page where the Hyper-V Replica Broker name is entered." lightbox="media/configure-replication-failover-cluster/high-availability-wizard-client-access-point.png":::

1. For **Confirmation**, review the information, then select **Next**. The Hyper-V Replica Broker role is configured. Initially, the role attempts to obtain an IP address from DHCP. You can change this setting later if you want to use a static IP address. If DHCP isn't available on the subnet, the role doesn't come online until you assign a static IP address.

1. View the **Summary**, then select **Finish**. You can also view a log of the actions performed by selecting **View Report**, which opens in a browser window.

1. Back in the **Roles** pane, right-click the new **Hyper-V Replica Broker** role, then select **Replication Settings**.

1. In the **Hyper-V Replica Broker Configuration** dialog box, make the following changes:

   1. Check the box **Enable this cluster as a Replica server**.

   1. Check the box for the authentication method you want to use from **Use Kerberos (HTTP)** or **Use certificate-based Authentication (HTTPS)**. Change the port if you don't want to use the default ports. If you're using certificate-based authentication, select **Select Certificate**, then you're prompted to select the certificate that matches the requirements.

   1. For **Authorization and storage**, select either **Allow replication from any authenticated server** to allow the replica server to accept VM replication traffic from any primary server that authenticates successfully, or **Allow replication from the specified servers** to accept traffic only from the primary servers you specifically select. For both options, you need to specify where the replicated VHDs should be stored on the replica Hyper-V cluster. For a cluster, this location needs to be accessible by all nodes in the cluster, such as a Cluster Shared Volume (CSV) at `C:\ClusterStorage\Volume1\Replica`.

      If you select **Allow replication from the specified servers**, select **Add**. In **Add Authorization Entry**, specify the FQDN of a primary host, a location to store replica files, and a trust group. A trust group is a free-form text field that you can use to group primary servers. Select **OK**.

   1. Select **OK** to save your settings.

   :::image type="content" source="media/configure-replication-failover-cluster/replica-broker-configuration.png" alt-text="A screenshot of the Hyper-V Replica Broker Configuration dialog displaying authentication, authorization, and storage path settings for replication." lightbox="media/configure-replication-failover-cluster/replica-broker-configuration.png":::

### [PowerShell](#tab/powershell)

To enable and configure the Hyper-V Replica Broker cluster role with PowerShell, use cmdlets in the [FailoverClusters](/powershell/module/failoverclusters/) module, as shown in the following examples. Replace placeholder `<values>` with your own values.

1. Open a PowerShell session as an administrator on one of the nodes in the cluster that you want to replicate to, or connect remotely by using the [Enter-PSSession](/powershell/module/microsoft.powershell.core/enter-pssession) cmdlet on a device you use to manage the cluster or host.

1. Import the FailoverClusters module by running the following command:

   ```powershell
   Import-Module FailoverClusters
   ```

1. Add the Hyper-V Replica Broker role by running the following commands. The value for `$netbiosName` is the name you want to use for the Hyper-V Replica Broker and is limited to 15 characters. This name must be unique in your Active Directory domain.

   ```powershell
   $netbiosName = "<Hyper-V Broker role name>"
   $clusterNetworkName = "<Cluster network name>" # The name of the cluster network used for management.
   $dhcp = $true # Set to $true to use DHCP, otherwise set to $false to use a static IP address.
   $staticIP = "<IPv4 address>"  # Only used if $DHCP is $false. The IP address must be part of the cluster network subnet.

   # Get the name of the cluster network used for management
   $clusterNetwork = Get-ClusterNetwork -Name $clusterNetworkName

   # Create the Hyper-V Replica Broker role resources
   Add-ClusterGroup -Name $netbiosName -GroupType VMReplicaBroker
   Add-ClusterResource -Name "Hyper-V Replica Broker $netbiosName" -Group $netbiosName -ResourceType "Virtual Machine Replication Broker"
   Add-ClusterResource -Name "$netbiosName" -Group $netbiosName -ResourceType "Network Name"
   Add-ClusterResource -Name ("IP Address " + $clusterNetwork.Address) -Group $netbiosName -ResourceType "IP Address"

   # Configure the IP Address resource
   If ($dhcp -eq $true) {
       Get-ClusterResource -Name ("IP Address " + $clusterNetwork.Address) | Set-ClusterParameter -Multiple @{"Network"=$clusterNetwork.Name;"EnableDhcp"=1} -Create
   }
   Else {
       Get-ClusterResource -Name ("IP Address " + $clusterNetwork.Address) | Set-ClusterParameter -Multiple @{"Network"=$clusterNetwork.Name;"Address"=$staticIP;"SubnetMask"=$clusterNetwork.AddressMask;"EnableDhcp"=0} -Create
   }

   # Set the DNS name for the Network Name resource
   Get-ClusterResource -Name $netbiosName | Set-ClusterParameter -Name DnsName -Value $netbiosName

   # Add dependencies
   Add-ClusterResourceDependency -Resource $netbiosName ("IP Address " + $clusterNetwork.Address)
   Add-ClusterResourceDependency -Resource "Hyper-V Replica Broker $netbiosName" $netbiosName

   # Bring the role online
   Start-ClusterGroup -Name $netbiosName
   ```

1. Check the status of the Hyper-V Replica Broker role by running the following command:

   ```powershell
   Get-ClusterGroup | ? GroupType -eq VMReplicaBroker
   ```

   Here's an example of the output you should see. The value for the **State** parameter should be  `Online`.

   ```output
   Name         OwnerNode State
   ----         --------- -----
   cluster01rep host02    Online
   ```

---

## Enable Windows Firewall rules for Hyper-V Replica

To allow replication between the primary and replica clusters and hosts, traffic must get through the Windows Firewall (or any other third-party firewalls). When you install the Hyper-V role on each host, the Windows Firewall creates exceptions for HTTP (80) and HTTPS (443), but doesn't enable them by default. You need to enable the appropriate rules for all receiving hosts.

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
      Test-VMReplicationConnection -ReplicaServerName '<Hyper-V Broker role FQDN>' -ReplicaServerPort 80 -AuthenticationType Kerberos
      ```

   - To test a connection to a replica cluster by using certificate-based authentication, run the following command. You need the thumbprint of a valid certificate for Hyper-V Replica on the primary host or cluster.

     ```powershell
     Test-VMReplicationConnection -ReplicaServerName '<Hyper-V Broker role FQDN>' -ReplicaServerPort 443 -AuthenticationType Certificate -CertificateThumbprint AA11BB22CC33DD44EE55FF66AA77BB88CC99DD00
     ```

   For either of these example commands, here's the output you should see if the test is successful:

   ```output
   The connection to the specified Replica server with the specified parameters was successful.
   ```
