---
title: Set up Hyper-V Replica
ms.technology: compute-hyper-v
description: "Gives instructions for setting up Replica, testing failover, and doing a first replication."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.topic: article
ms.assetid: eea9e996-bfec-4065-b70b-d8f66e7134ac
author: KBDAzure
ms.author: kathydav
ms.date: 10/10/2016
---
# Set up Hyper-V Replica

>Applies To: Windows Server 2016

Hyper-V Replica is an integral part of the Hyper-V role. It contributes to your disaster recovery strategy by replicating virtual machines from one Hyper-V host server to another to keep your workloads available.  Hyper-V Replica creates a copy of a live virtual machine  to a replica offline virtual machine. Note the following:  

-   **Hyper-V hosts**: Primary and secondary host servers can be physically co-located or in separate geographical locations with replication over a WAN link. Hyper-V hosts can be  standalone, clustered, or a mixture of both. There's no Active Directory dependency between the servers and they don't need to be domain members.  

-   **Replication and change tracking**: When you enable Hyper-V Replica for a specific virtual machine, initial replication creates an identical replica virtual machine on a secondary host server. After that happens, Hyper-V Replica change tracking creates and maintains a log file that captures changes on a virtual machine VHD. The log file is played in reverse order to the replica VHD based on replication frequency settings. This means that the latest changes are stored and replicated asynchronously. Replication can be over HTTP or HTTPS.  

-   **Extended (chained) replication**: This lets you replicate a virtual machine from a primary host to a secondary host, and then replicate the secondary host to a third host. Note that you can't replicate from the primary host directly to the second and the third.  

    This feature makes Hyper-V Replica more robust for disaster recovery because if an outage occurs you can recover from both the primary and extended replica.  You can fail over to the extended replica if your primary and secondary locations go down. Note that the extended replica doesn't support application-consistent replication and must use the same VHDs that the secondary replica is using.  

-   **Failover**: If an outage occurs in your primary (or secondary in case of extended) location you can manually initiate a test, planned, or unplanned failover.  

    ||Test|Planned|Unplanned|  
    |-|--------|-----------|-------------|  
    |When should I run?|Verify that a virtual machine can fail over and start in the secondary site<br /><br />Useful for testing and training|During planned downtime and outages|During unexpected events|  
    |Is a duplicate virtual machine created?|Yes|No|No|  
    |Where is it initiated?|On the replica virtual machine|Initiated on primary and completed on secondary|On the replica virtual machine|  
    |How often should I run?|We recommend once a month for testing|Once every six months or in accordance with compliance requirements|Only in case of disaster when the primary virtual machine is unavailable|  
    |Does the primary virtual machine continue to replicate?|Yes|Yes. When the outage is resolve  reverse replication  replicates the changes back to the primary site so that primary and secondary are synchronized.|No|  
    |Is there any data loss?|None|None. After failover Hyper-V Replica replicates the last set of tracked changes back to the primary to ensure zero data loss.|Depends on the event and recovery points|  
    |Is there any downtime?|None. It doesn't impact your production environment. It creates a duplicate test virtual machine during failover. After failover finishes you select **Failover** on the replica virtual machine and it's automatically cleaned up and deleted.|The duration of the planned outage|The  duration of the unplanned outage|  

-   **Recovery points**: When you configure replication settings for a virtual machine, you specify the recovery points you want to store from it. Recovery points represent a snapshot in time from which you can recover a virtual machine. Obviously less data is lost if you recover from a very recent recovery point. You can access recovery points up to 24 hours ago.  

## Deployment prerequisites  
Here's what you should verify before you begin:  

-   **Figure out which VHDs need to be replicated**. In particular, VHDs that contain data that is rapidly changing and not used by the Replica server after failover, such as page file disks, should be excluded from replication to conserve network bandwidth. Make a note of which VHDs can be excluded.  

-   **Decide how often you need to synchronize data**:  The data on the Replica server is synchronized updated according to the replication frequency you configure (30 seconds, 5 minutes, or 15 minutes). The frequency you choose should consider the following: Are the virtual machines running critical data with a low RPO? What are you bandwidth considerations?  Your highly-critical virtual machines will obviously need more frequent replication.  

-   **Decide how to recover data**:  By default Hyper-V Replica only stores a single recovery point that will be the latest replication sent from the primary to the secondary. However if you  want the option to recover data to an earlier point in time you can specify that additional recovery points should be stored (to a maximum of 24 hourly points). If you do need additional recovery points you should note that this requires more overhead on processing and storage resources.  

-   **Figure out which workloads you'll replicate**: Standard Hyper-V Replica replication maintains consistency in the state of the virtual machine operating system after a failover, but not the state of applications that running on the virtual machine. If you want to be able to recovery your workload state you can create app-consistent recovery points. Note that app-consistent recovery isn't available on the extended replica site if you're using extended (chained) replication.  

-   **Decide how to do the initial replication of virtual machine data**: Replication starts by transferring the needs to transfer the current state of the virtual machines. This initial state can be transmitted directly over the existing network, either immediately or at a later time that you configure. You can also use a pre-existing restored virtual machine (for example, if you have restored an earlier backup of the virtual machine on the Replica server) as the initial copy. Or, you can save network bandwidth by copying the initial copy to external media and then physically delivering the media to the Replica site.  If you want to use a preexisting virtual machine delete all previous snapshots associated with it.  

## Deployment steps  

### Step 1: Set up the Hyper-V hosts  
You'll need at least two Hyper-V hosts with one or more virtual machines on each server. [Get started with Hyper-V](../get-started/Get-started-with-Hyper-V-on-Windows.md). The host server that you'll replicate virtual machines to will need to be set up as the replica server.  

1.  In the Hyper-V settings for the server you'll replicate virtual machines to, in **Replication Configuration**, select **Enable this computer as a Replica server**.  

2.  You can replicate over HTTP or encrypted HTTPS. Select **Use Kerberos (HTTP)** or **Use certificate-based Authentication (HTTPS**). By default HTTP 80 and HTTPS 443 are enabled as firewall exceptions on the replica Hyper-V server. If you change the default port settings you'll need to also change the firewall exception. If you're replicating over HTTPS, you'll need to select a certificate and you should have certificate authentication set up.  

3.  For authorization, select **Allow replication from any authenticated server** to allow the replica server to accept virtual machine replication traffic from any primary server that authenticates successfully. Select **Allow replication from the specified servers** to accept traffic only from the primary servers you specifically select.  

    For both options you can specify where the replicated VHDs should be stored on the replica Hyper-V server.  

4.  Click **OK** or **Apply**.  

### Step 2: Set up the firewall  
To allow replication between the primary and secondary servers, traffic must get through the Windows firewall (or any other third-party firewalls). When you installed the Hyper-V role on the servers by default exceptions for HTTP (80) and HTTPS (443) are created. If you're using these standard ports, you'll just need to enable the rules:  

-  To enable the rules on a standalone host server:  

    1. Open Windows Firewall with Advance Security and click **Inbound Rules**.  

    2. To enable HTTP (Kerberos) authentication, right-click **Hyper-V Replica HTTP Listener (TCP-In)** >**Enable Rule.** To enable HTTPS certificate-based authentication, right-click **Hyper-V Replica HTTPS Listener (TCP-In)** > E**nable Rule**.  

-  To enable rules on a Hyper-V cluster, open a Windows PowerShell session using **Run as Administrator**, then run one of these commands:  

    -   For HTTP:  `get-clusternode | ForEach-Object  {Invoke-command -computername $_.name -scriptblock {Enable-Netfirewallrule -displayname "Hyper-V Replica HTTP Listener (TCP-In)"}}`  

    -   For HTTPS: `get-clusternode | ForEach-Object  {Invoke-command -computername $_.name -scriptblock {Enable-Netfirewallrule -displayname "Hyper-V Replica HTTPS Listener (TCP-In)"}}`  

### Enable virtual machine replication  
Do the following on each virtual machine you want to replicate:  

1.  In the **Details** pane of Hyper-V Manager, select a virtual machine by clicking it.  
    Right-click the selected virtual machine and click **Enable Replication** to open the Enable Replication wizard.  

2.  On the **Before you Begin** page, click **Next**.  

3.  On the **Specify Replica Server** page, in the Replica Server box, enter either the NetBIOS or FQDN of the Replica server. If the Replica server is part of a failover cluster, enter the name of the Hyper-V Replica Broker. Click **Next**.  

4.  On the **Specify Connection Parameters** page, Hyper-V Replica automatically retrieves the authentication and port settings you configured for the replica server. If values aren't  being retrieved check that the server is configured as a replica server, and that it's registered in DNS. If required type in the setting manually.  

5.  On the **Choose Replication VHDs** page, make sure the VHDs you want to replicate are selected, and clear the checkboxes for any VHDs that you want to exclude from replication. Then click **Next**.  

6.  On the **Configure Replication Frequency** page, specify how often changes should be synchronized from primary to secondary. Then click **Next**.  

7.  On the **Configure Additional Recovery Points** page, select whether you want to maintain only the latest recovery point or to create additional points.    If you want to consistently recover applications and workloads that have their own VSS writers we recommend you select **Volume Shadow Copy Service (VSS) frequenc**y and specify how often to create app-consistent snapshots. Note that the Hyper-V VMM Requestor Service must be running on both the primary and secondary Hyper-V servers. Then click **Next**.  

8.  On the **Choose Initial Replication** page, select the initial replication method to use.  The default setting to send initial copy over the network will copy the primary virtual machine configuration file (VMCX) and the virtual hard disk files (VHDX and VHD) you selected over your network connection. Verify network bandwidth availability if you're going to use this option. If the primary virtual machine is already configured on the secondary site as a replicate virtual machine it can be useful to select  **Use an existing virtual machine on the replication server as the initial copy**. You can use Hyper-V export to export the primary virtual machine and import it as a replica virtual machine on the secondary server. For larger virtual machines or limited bandwidth you can it choose to have initial replication over the network occur at a later time,  and then configure off-peak hours, or to send the initial replication information as offline media.  

    If you do offline replication you'll transport the initial copy to the secondary server using an external storage medium such as a hard disk or USB drive. To do this you'll need to connect the external storage to the primary server (or owner node in a cluster) and then when you select Send initial copy using external media you can specify a location locally or on your external media where the initial copy can be stored.  A placeholder virtual machine is created on the replica site. After initial replication completes the external storage can be shipped to the replica site. There you'll connect the external media to the secondary server or to the owner node of the secondary cluster. Then you'll import the initial replica to a specified location and merge it into the placeholder virtual machine.  

9. On the **Completing the Enable Replication** page, review the information in the Summary and then click **Finish.**. The virtual machine data will be transferred in accordance with your chosen settings. and a dialog box appears indicating that replication was successfully enabled.  

10. If you want to configure extended (chained) replication, open the replica server, and right-click the virtual machine you want to replicate. Click **Replication** > **Extend Replication** and specify the replication settings.  

## Run a failover  
After completing these deployment steps your replicated environment is up and running. Now you can run failovers as needed.  

**Test failover**:  If you want to run a test failover right-click the primary virtual machine and select **Replication** > **Test Failover**. Pick the latest or other recovery point if configured. A new test virtual machine will be created and started on the secondary site. After you've finished testing, select  **Stop Test Failover** on the replica virtual machine to clean it up. Note that for a virtual machine you can only run one test failover at a time. [Read more](https://blogs.technet.com/b/virtualization/archive/2012/07/26/types-of-failover-operations-in-hyper-v-replica.aspx).  

**Planned failover**: To run a planned failover right-click the primary virtual machine and select **Replication** > **Planned Failover**. Planned failover performs prerequisites checks to ensure zero data loss. It checks that the primary virtual machine is shut down before beginning the failover. After the virtual machine is failed over, it starts replicating the changes back to the primary site when it's available. Note that for this to work the  primary server should be configured to recive replication from the secondary server or from the Hyper-V Replica Broker in the case of a primary cluster. Planned failover sends the last set of tracked changes. [Read more](https://blogs.technet.com/b/virtualization/archive/2012/07/31/types-of-failover-operations-in-hyper-v-replica-part-ii-planned-failover.aspx).  

**Unplanned failover**: To run an unplanned failover, right-click on the replica virtual machine and select **Replication** > **Unplanned Failover** from Hyper-V Manager or Failover Clustering Manager. You can recover from the latest recovery point or from previous recovery points if this option is enabled. After failover, check that everything is working as expected on the failed over virtual machine, then click **Complete** on the replica virtual machine. [Read more](https://blogs.technet.com/b/virtualization/archive/2012/08/08/types-of-failover-operations-in-hyper-v-replica-part-iii-unplanned-failover.aspx).  
