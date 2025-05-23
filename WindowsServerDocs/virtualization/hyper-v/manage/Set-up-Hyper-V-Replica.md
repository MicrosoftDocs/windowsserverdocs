---
title: Set up Hyper-V Replica
description: Gives instructions for setting up Replica, testing failover, and doing a first replication.
ms.topic: how-to
ms.assetid: eea9e996-bfec-4065-b70b-d8f66e7134ac
ms.author: daknappe
author: dknappettmsft
ms.date: 01/16/2025
---

# Set up Hyper-V Replica

Hyper-V Replica is an integral part of the Hyper-V role. It contributes to your disaster recovery strategy by replicating a virtual machine (VM) from one Hyper-V host server to another to keep your workloads available. Hyper-V Replica creates a copy of a live VM to a replica offline VM. Note the following:

- **Hyper-V hosts**: Primary and secondary host servers can be physically co-located or in separate geographical locations with replication over a WAN link. Hyper-V hosts can be standalone, clustered, or a mixture of both. There's no Active Directory dependency between the servers and they don't need to be domain members.

- **Replication and change tracking**: When you enable Hyper-V Replica for a specific VM, initial replication creates an identical replica VM on a secondary host server. After that happens, Hyper-V Replica change tracking creates and maintains a log file that captures changes on a VM VHD. The log file is played in reverse order to the replica VHD based on replication frequency settings. This means that the latest changes are stored and replicated asynchronously. Replication can be over HTTP or HTTPS.

- **Extended (chained) replication**: This lets you replicate a VM from a primary host to a secondary host, and then replicate the secondary host to a third host. You can't replicate from the primary host directly to the second and the third.

    This feature makes Hyper-V Replica more robust for disaster recovery because if an outage occurs you can recover from both the primary and extended replica. You can fail over to the extended replica if your primary and secondary locations go down. The extended replica doesn't support application-consistent replication and must use the same VHDs that the secondary replica is using.

- **Failover**: If an outage occurs in your primary (or secondary if extended) location, you can manually initiate a test, planned, or unplanned failover.

    | Question | Test | Planned | Unplanned |
    |--|--|--|--|
    | When should I run this? | Verify that a VM can fail over and start in the secondary site<p>Useful for testing and training | During planned downtime and outages | During unexpected events |
    | Is a duplicate VM created? | Yes | No | No |
    | Where is it initiated? | On the replica VM | Initiated on primary and completed on secondary | On the replica VM |
    | How often should I run? | We recommend once a month for testing | Once every six months or in accordance with compliance requirements | Only if there's a disaster when the primary VM is unavailable |
    | Does the primary VM continue to replicate? | Yes | Yes. When the outage is resolve reverse replication replicates the changes back to the primary site so that primary and secondary are synchronized. | No |
    | Is there any data loss? | None | None. After failover Hyper-V Replica replicates the last set of tracked changes back to the primary to ensure zero data loss. | Depends on the event and recovery points |
    | Is there any downtime? | None. It doesn't impact your production environment. It creates a duplicate test VM during failover. After failover finishes you select **Failover** on the replica VM and it's automatically cleaned up and deleted. | The duration of the planned outage | The duration of the unplanned outage |

- **Recovery points**: When you configure replication settings for a VM, you specify the recovery points you want to store from it. Recovery points represent a snapshot in time from which you can recover a VM. Less data is lost if you recover from a recent recovery point. You could access recovery points up to 24 hours ago.

## Deployment prerequisites

Here's what you should verify before you begin:

- **Figure out which VHDs need to be replicated**. In particular, VHDs that contain data that is rapidly changing and not used by the Replica server after failover, such as page file disks, should be excluded from replication to conserve network bandwidth. Make a note of which VHDs can be excluded.

- **Decide how often you need to synchronize data**: The data on the Replica server is synchronized updated according to the replication frequency you configure (30 seconds, 5 minutes, or 15 minutes). The frequency you choose should consider the following: Are the VMs running critical data with a low RPO? What are your bandwidth considerations? Your highly critical VMs will obviously need more frequent replication.

- **Decide how to recover data**: By default Hyper-V Replica only stores a single recovery point that will be the latest replication sent from the primary to the secondary. However if you want the option to recover data to an earlier point in time you can specify that additional recovery points should be stored (to a maximum of 24 hourly points). If you do need additional recovery points you should note that this requires more overhead on processing and storage resources.

- **Figure out which workloads you'll replicate**: Standard Hyper-V Replica replication maintains consistency in the state of the VM operating system after a failover, but not the state of applications that running on the VM. If you want to be able to recovery your workload state you can create app-consistent recovery points. App-consistent recovery isn't available on the extended replica site if you're using extended (chained) replication.

- **Decide how to do the initial replication of VM data**: Replication starts by transferring the needs to transfer the current state of the VMs. This initial state can be transmitted directly over the existing network, either immediately or at a later time that you configure. You can also use a preexisting restored VM (for example, if you have restored an earlier backup of the VM on the Replica server) as the initial copy. Or, you can save network bandwidth by copying the initial copy to external media and then physically delivering the media to the Replica site. If you want to use a preexisting VM delete all previous snapshots associated with it.

## Deployment steps

### Step 1: Set up the Hyper-V hosts

You'll need at least two Hyper-V hosts with one or more VMs on each server. Get started and [Install the Hyper-V role on Windows Server](/windows-server/virtualization/hyper-v/get-started/install-the-hyper-v-role-on-windows-server). The host server that you'll replicate VMs to will need to be set up as the replica server.

1. In the Hyper-V settings for the server you'll replicate VMs to, in **Replication Configuration**, select **Enable this computer as a Replica server**.

2. You can replicate over HTTP or encrypted HTTPS. Select **Use Kerberos (HTTP)** or **Use certificate-based Authentication (HTTPS**). By default HTTP 80 and HTTPS 443 are enabled as firewall exceptions on the replica Hyper-V server. If you change the default port settings, you'll need to also change the firewall exception. If you're replicating over HTTPS, you'll need to select a certificate and you should have certificate authentication set up.

3. For authorization, select **Allow replication from any authenticated server** to allow the replica server to accept VM replication traffic from any primary server that authenticates successfully. Select **Allow replication from the specified servers** to accept traffic only from the primary servers you specifically select.

    For both options, you can specify where the replicated VHDs should be stored on the replica Hyper-V server.

4. Click **OK** or **Apply**.

### Step 2: Set up the firewall

To allow replication between the primary and secondary servers, traffic must get through the Windows Firewall (or any other third-party firewalls). When you installed the Hyper-V role on the servers by default exceptions for HTTP (80) and HTTPS (443) are created. If you're using these standard ports, you'll just need to enable the rules:

- To enable the rules on a standalone host server:

    1. Open Windows Firewall with Advance Security and click **Inbound Rules**.

    2. To enable HTTP (Kerberos) authentication, right-click **Hyper-V Replica HTTP Listener (TCP-In)** > **Enable Rule**. To enable HTTPS certificate-based authentication, right-click **Hyper-V Replica HTTPS Listener (TCP-In)** > **Enable Rule**.

- To enable rules on a Hyper-V cluster, open a Windows PowerShell session using **Run as Administrator**, then run one of these commands:

  - For HTTP:

    `get-clusternode | ForEach-Object  {Invoke-command -computername $_.name -scriptblock {Enable-Netfirewallrule -displayname "Hyper-V Replica HTTP Listener (TCP-In)"}}`

  - For HTTPS:

    `get-clusternode | ForEach-Object  {Invoke-command -computername $_.name -scriptblock {Enable-Netfirewallrule -displayname "Hyper-V Replica HTTPS Listener (TCP-In)"}}`

### Enable VM replication

Do the following on each VM you want to replicate:

1. In the **Details** pane of Hyper-V Manager, select a VM by clicking it.
    Right-click the selected VM and click **Enable Replication** to open the Enable Replication wizard.

2. On the **Before you Begin** page, click **Next**.

3. On the **Specify Replica Server** page, in the Replica Server box, enter either the NetBIOS or FQDN of the Replica server. If the Replica server is part of a failover cluster, enter the name of the Hyper-V Replica Broker. Click **Next**.

4. On the **Specify Connection Parameters** page, Hyper-V Replica automatically retrieves the authentication and port settings you configured for the replica server. If values aren't being retrieved check that the server is configured as a replica server, and that it's registered in DNS. If necessary, type in the setting manually.

5. On the **Choose Replication VHDs** page, make sure the VHDs you want to replicate are selected, and clear the checkboxes for any VHDs that you want to exclude from replication. Then click **Next**.

6. On the **Configure Replication Frequency** page, specify how often changes should be synchronized from primary to secondary. Then click **Next**.

7. On the **Configure Additional Recovery Points** page, select whether you want to maintain only the latest recovery point or to create additional points. If you want to consistently recover applications and workloads that have their own VSS writers we recommend you select **Volume Shadow Copy Service (VSS) frequency** and specify how often to create app-consistent snapshots. Note that the Hyper-V VMM Requestor Service must be running on both the primary and secondary Hyper-V servers. Then click **Next**.

8. On the **Choose Initial Replication** page, select the initial replication method to use. The default setting to send initial copy over the network will copy the primary VM configuration file (VMCX) and the virtual hard disk files (VHDX and VHD) you selected over your network connection. Verify network bandwidth availability if you're going to use this option. If the primary VM is already configured on the secondary site as a replicate VM it can be useful to select **Use an existing virtual machine on the replication server as the initial copy**. You can use Hyper-V export to export the primary VM and import it as a replica VM on the secondary server. For larger VMs or limited bandwidth you can it choose to have initial replication over the network occur at a later time, and then configure off-peak hours, or to send the initial replication information as offline media.

    If you do offline replication, you'll transport the initial copy to the secondary server using an external storage medium such as a hard disk or USB drive. To do this, you need to connect the external storage to the primary server (or owner node in a cluster) and then when you select Send initial copy using external media you can specify a location locally or on your external media where the initial copy can be stored. A placeholder VM is created on the replica site. After initial replication completes the external storage can be shipped to the replica site. There you'll connect the external media to the secondary server or to the owner node of the secondary cluster. Then you'll import the initial replica to a specified location and merge it into the placeholder VM.

9. On the **Completing the Enable Replication** page, review the information in the Summary, and then click **Finish.**. The VM data is transferred in accordance with your chosen settings. A dialog box appears to indicate that replication was successfully enabled.

10. If you want to configure extended (chained) replication, open the replica server, and right-click the VM you want to replicate. Click **Replication** > **Extend Replication** and specify the replication settings.

By default, Hyper-V replica points to a single default volume for VM replication. If you want to use a different CSV for VM replication, see [Configure multiple CSV for VM replication](configure-multiple-csv-for-vm-replication.md).

## Run a failover

After completing these deployment steps your replicated environment is up and running. Now you can run failovers as needed.

**Test failover**: If you want to run a test failover right-click the replica VM and select **Replication** > **Test Failover**. Pick the latest or other recovery point if configured. A new test VM is created and started on the secondary site. After you've finished testing, select **Stop Test Failover** on the replica VM to clean it up. For a VM you can only run one test failover at a time. For more information, see [Test failover in Hyper-V Replica](https://techcommunity.microsoft.com/t5/virtualization/types-of-failover-operations-in-hyper-v-replica-8211-part-i-8211/ba-p/381915).

**Planned failover**: To run a planned failover, right-click the primary VM and select **Replication** > **Planned Failover**. Planned failover performs prerequisites checks to ensure zero data loss. It checks that the primary VM is shut down before beginning the failover. After the VM is failed over, it starts replicating the changes back to the primary site when it's available. For this to work, the primary server should be configured to receive replication from the secondary server, or from the Hyper-V Replica Broker in the case of a primary cluster. Planned failover sends the last set of tracked changes. For more information, see [Planned failover in Hyper-V Replica](https://techcommunity.microsoft.com/t5/virtualization/types-of-failover-operations-in-hyper-v-replica-8211-part-ii/ba-p/381910).

**Unplanned failover**: To run an unplanned failover, right-click on the replica VM and select **Replication** > **Unplanned Failover** from Hyper-V Manager or Failover Clustering Manager. You can recover from the latest recovery point or from previous recovery points if this option is enabled. After failover, check that everything is working as expected on the failed over VM, then click **Complete** on the replica VM. [Read more](https://techcommunity.microsoft.com/t5/virtualization/types-of-failover-operations-in-hyper-v-replica-8211-part-iii/ba-p/381908).
