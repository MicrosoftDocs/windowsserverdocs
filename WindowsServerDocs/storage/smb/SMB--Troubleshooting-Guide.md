---
title: SMB: Troubleshooting Guide
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 77a4b097-eaf6-470a-92cb-05cc82adbecf
author: JasonGerend
---
# SMB: Troubleshooting Guide
This topic describes some common troubleshooting issues that can occur when using Server Message Block \(SMB\) and provides possible solutions to those issues.  
  
## Troubleshooting networking issues  
This section discusses potential networking issues with file servers and SMB and provides recommendations on how to avoid or mitigate these issues. Before continuing, you should review the following network improvements:  
  
> [!NOTE]  
> With the new Virtual Receive\-side scaling feature in  Windows Server 2012 R2 , virtual network adapters are now RSS\-capable and provide four TCP connections for each network adapter. In  Windows Server 2012 , there was only one TCP connection for each virtual network adapter.  
>   
> In  Windows Server 2012 R2 , SMB client connections are tracked per file share \(instead of per server\), and clients are then redirected to the cluster node with the best access to the volume used by the file share. This improves efficiency by reducing redirection traffic between file server nodes. Clients are redirected following an initial connection and when cluster storage is reconfigured.  
  
### The virtual network adapter on the host does not perform well  
**Cause**:  The virtual network adapter on the host is not RSS\-capable. Without a RSS\-capable network adapter, SMB uses only one TCP connection. This occurs when using 10GbE network adapters, RSS\-capable network adapters, and NIC Teaming.  
  
**Solution**:  Use multiple virtual network adapters to make sure you have multiple TCP connections. For more information, see the following blog post: [Windows Server 2012 File Server Tip: Make sure your network interfaces are RSS\-capable](http://blogs.technet.com/b/josebda/archive/2012/11/10/windows-server-2012-file-server-tip-make-sure-your-network-interfaces-are-rss-capable.aspx).  
  
### SMB prefers to use the slower physical network adapter over the virtual network adapter  
**Cause**:  The virtual network adapter on the host is not RSS\-capable while the physical network adapter is RSS\-capable. SMB always uses the RSS\-capable network adapter over the non\-RSS network adapter even when the RSS network adapter is slower.  
  
**Solution**:  You should disable the RSS capability on the physical network adapter, or use SMB Multichannel constraints to restrict SMB communication to one or more defined network interfaces. For more information, see the [New\-SmbMultichannelConstraint](http://technet.microsoft.com/library/jj635699.aspx) SMB Share cmdlet in Windows PowerShell.  
  
### When using multiple network adapters on the same subnet in a cluster, only one network adapter is used  
**Cause**:  Failover cluster networking cannot use more than one network adapter per subnet. To confirm this, use the [Get\-SmbServerNetworkInterface](http://technet.microsoft.com/en-us/library/jj635725.aspx) SMB Share cmdlet in Windows PowerShell.  
  
**Solution**:  You should configure each network adapter to use a different subnet. For more information, see the following blog post: [Windows Server 2012 File Server Tip: Use multiple subnets when deploying SMB Multichannel in a cluster](http://blogs.technet.com/b/josebda/archive/2012/11/12/windows-server-2012-file-server-tip-use-multiple-subnets-when-deploying-smb-multichannel-in-a-cluster.aspx).  
  
### SMB reports that the network adapter is not RDMA\-capable, even though I am using a RDMA\-capable network adapter  
**Cause**:  RDMA\-capable network adapters that have older drivers or firmware may not correctly identify themselves as being RDMA\-capable.  
  
**Solution**:  Update the network adapter’s firmware and driver from the manufacturer’s web site.  
  
### What is the required amount of network traffic before SMB Multichannel starts?  
**Cause**:  SMB Multichannel is used to discover the RSS and RDMA capabilities of network adapters. On server operating systems, SMB Multichannel starts when the initial read\/write operation occurs. On client operating systems, SMB Multichannel does not start until a certain amount of network traffic occurs.  
  
**Solution**:  On server operating systems, SMB Multichannel starts quickly is only once per session. On client operating systems, you can configure a registry entry to initiate SMB Multichannel more quickly. For more information, see the following blog post: [How much traffic needs to pass between the SMB Client and Server before Multichannel actually starts?](http://blogs.technet.com/b/josebda/archive/2013/01/18/how-much-traffic-needs-to-pass-between-the-smb-client-and-server-before-multichannel-actually-starts.aspx).  
  
### SMB Multichannel does not aggregate multiple 10GbE network adapters  
**Causes**:  A RSS\-capable 10GbE network adapter is sometimes identified as non\-RSS capable. When this occurs, SMB uses only one TCP connection.  
  
When using both RSS\-capable and non\-RSS network adapters, SMB Multichannel should only use the RSS\-capable network adapters.  
  
**Solutions**:  Server\-class network adapters should appear as RSS\-capable, and if they don’t, you should update the network adapter’s driver from the manufacturer’s web site, and then recheck the RSS settings.  
  
You may need to disable RSS on both network adapters to aggregate throughput. For more information, see the following blog post: [Windows Server 2012 File Server Tip: Make sure your network interfaces are RSS\-capable](http://blogs.technet.com/b/josebda/archive/2012/11/10/windows-server-2012-file-server-tip-make-sure-your-network-interfaces-are-rss-capable.aspx).  
  
### When accessing a Scale\-Out File Server, performance is limited  
**Cause**:  The client access network uses high speed RDMA, but the cluster network does not. This causes redirection to occur only over the cluster network \(which is usually a 1GbE network adapter\).  
  
**Solutions**:  You can configure the option to use the client access network for Cluster Shared Volumes \(CSV\).  
  
Upgrade to  Windows Server 2012 R2  where clients are automatically redirected to the cluster node with the best access to the volume used by the file share. For more information, see the following blog post: [Automatic SMB Scale\-Out Rebalancing in Windows Server 2012 R2](http://blogs.technet.com/b/josebda/archive/2013/10/30/automatic-smb-scale-out-rebalancing-in-windows-server-2012-r2.aspx).  
  
## See also  
  
-   [SMB Share Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/jj635726.aspx)  
  
-   [Server Message Block Overview](../smb/Server-Message-Block-Overview.md)  
  
-   [What's New in SMB in Windows Server 2012 R2](assetId:///46c0ac80-a54a-4324-948a-2dee66bcec75)  
  

