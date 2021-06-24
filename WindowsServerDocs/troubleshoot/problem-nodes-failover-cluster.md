---
title: A problem with deleting a node
description: This article describes the problems encountered when removing nodes from active failover cluster membership.
ms.date: 05/28/2020
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
---
# Having a problem with nodes being removed from active Failover Cluster membership

This article introduces how to resolve the problems in which nodes are removed from active failover cluster membership randomly.

## Symptoms

When the issue occurs, you are seeing events like this logged in your System Event Log:

![Event 1135](media/problem-nodes-failover-cluster/1135-1.png)

This event will be logged on all nodes in the Cluster except for the node that was removed. The reason for this event is because one of the nodes in the Cluster marked that node as down. It then notifies all of the other nodes of the event. When the nodes are notified, they discontinue and tear down their heartbeat connections to the downed node.

## What caused the node to be marked down

All nodes in a Windows 2008 or 2008 R2 Failover Cluster talk to each other over the networks that are set to Allow cluster network communication on this network. The nodes will send out heartbeat packets across these networks to all of the other nodes. These packets are supposed to be received by the other nodes and then a response is sent back. Each node in the Cluster has its own heartbeats that it is going to monitor to ensure the network is up and the other nodes are up. The example below should help clarify this:

![Nodes](media/problem-nodes-failover-cluster/Node2.png)

If any one of these packets is not returned, then the specific heartbeat is considered failed. For example, W2K8-R2-NODE2 sends a request and receives a response from W2K8-R2-NODE1 to a heartbeat packet so it determines the network and the node is up.  If W2K8-R2-NODE1 sends a request to W2K8-R2-NODE2 and W2K8-R2-NODE1 does not get the response, it is considered a lost heartbeat and W2K8-R2-NODE1 keeps track of it.  This missed response can have W2K8-R2-NODE1 show the network as down until another heartbeat request is received.

By default, Cluster nodes have a limit of five failures in 5 seconds before the connection is marked down. So if W2K8-R2-NODE1 does not receive the response five times in the time period, it considers that particular route to W2K8-R2-NODE2 to be down. If other routes are still considered to be up, W2K8-R2-NODE2 will remain as an active member.

If all routes are marked down for W2K8-R2-NODE2, it is removed from active Failover Cluster membership and the Event 1135 that you see in the first section is logged. On W2K8-R2-NODE2, the Cluster Service is terminated and then restarted so it can try to rejoin the Cluster.

For more information on how we handle specific routes going down with three or more nodes, see ["Partitioned" Cluster Networks](/archive/blogs/askcore/partitioned-cluster-networks) blog that was written by Jeff Hughes.

## Now that we know how the heartbeat process works, what are some of the known causes for the process to fail

1. Actual network hardware failures. If the packet is lost on the wire somewhere between the nodes, then the heartbeats will fail. A network trace from both nodes involved will reveal this.

2. The profile for your network connections could possibly be bouncing from Domain to Public and back to Domain again. During the transition of these changes, network I/O can be blocked. You can check to see if this is the case by looking at the Network Profile Operational log. You can find this log by opening the Event Viewer and navigating to: Applications and Services Logs\Microsoft\Windows\NetworkProfile\Operational. Look at the events in this log on the node that was mentioned in the Event ID: 1135 and see if the profile was changing at this time. If so, check out the KB article [The network location profile changes from "Domain" to "Public" in Windows 7 or in Windows Server 2008 R2](https://support.microsoft.com/help/2524478/the-network-location-profile-changes-from-domain-to-public-in-windows).

3. You have IPv6 enabled on the servers, but have the following two rules disabled for Inbound and Outbound in the Windows Firewall:

    - Core Networking - Neighbor Discovery Advertisement
    - Core Networking - Neighbor Discovery Solicitation

4. Anti-virus software could be interfering with this process also. If you suspect this, test by disabling or uninstalling the software. Do this at your own risk because you will be unprotected from viruses at this point.

5. Latency on your network could also cause this to happen. The packets may not be lost between the nodes, but they may not get to the nodes fast enough before the timeout period expires.

6. IPv6 is the default protocol that Failover Clustering will use for its heartbeats. The heartbeat itself is a UDP unicast network packet that communicates over Port 3343. If there are switches, firewalls, or routers not configured properly to allow this traffic through, you can experience issues like this.

7. IPsec security policy refreshes can also cause this problem. The specific issue is that during an IPSec group policy update all IPsec Security Associations (SAs) are torn down by Windows Firewall with Advanced Security (WFAS). While this is happening, all network connectivity is blocked. When renegotiating the Security Associations if there are delays in performing authentication with Active Directory, these delays (where all network communication is blocked) will also block cluster heartbeats from getting through and cause cluster health monitoring to detect nodes as down if they do not respond within the 5-second threshold.

8. Old or out-of-date network card drivers and/or firmware.  At times, a simple misconfiguration of the network card or switch can also cause loss of heartbeats.

9. Modern network cards and virtual network cards may be experiencing packet loss.  This can be tracked by opening Performance Monitor and adding the counter "Network Interface\Packets Received Discarded".  This counter is cumulative and only increases until the server is rebooted.  Seeing a large number of packets dropped here could be a sign that the receive buffers on the network card are set too low or that the server is performing slowly and cannot handle the inbound traffic.  Each network card manufacturer chooses whether to expose these settings in the properties of the network card, therefore you need to refer to the manufacturer's website to learn how to increase these values and the recommended values should be used.  If you are running on VMware, the following blog talks about this in a little more detail including how to tell if this is the issue as well as points you to the VMWare article on the settings to change.

    [Nodes being removed from Failover Cluster membership on VMWare ESX](/archive/blogs/askcore/nodes-being-removed-from-failover-cluster-membership-on-vmware-esx)

These are the most common reasons that these events are logged, but there could be other reasons also. The point of this blog was to give you some insight into the process and also give ideas of what to look for. Some will raise the following values to their maximum values to try to get this problem to stop.

|Parameter|Default|Range|
|---|---|---|
|**SameSubnetDelay**|1000 milliseconds|250-2000 milliseconds|
|**CrossSubnetDelay**|1000 milliseconds|250-4000 milliseconds|
|**SameSubnetThreshold**|5|3-10|
|**CrossSubnetThreshold**|5|3-10|
||||

Increasing these values to their maximum may make the event and node removal go away, it just masks the problem. It doesn't fix anything. The best thing to do is found out the root cause of the heartbeat failures and get it fixed. The only real need for increasing these values is in a multi-site scenario where nodes reside in different locations and network latency cannot be overcome.
