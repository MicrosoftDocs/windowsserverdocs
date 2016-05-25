---
title: Deploy an Active Directory-Detached Cluster
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 21bc89d4-e744-4a94-8ee2-a9d93c68a804
author: kumudd
---
# Deploy an Active Directory-Detached Cluster
In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you can deploy a failover cluster without dependencies in Active Directory Domain Services \(AD DS\) for network names. This is referred to as an *Active Directory\-detached cluster*. Using this deployment method enables you to create a failover cluster without the previously required permissions for creating computer objects in AD DS or the need to request that computer objects are prestaged in AD DS.  
  
When you create an Active Directory\-detached cluster, the cluster network name \(also known as the *administrative access point*\) and network names for any clustered roles with client access points are registered in Domain Name System \(DNS\). However, no computer objects are created for the cluster in AD DS. This includes the computer object for the cluster \(also known as the cluster name object or CNO\) and computer objects for any clustered roles that would typically have client access points in AD DS \(also known as virtual computer objects or VCOs\).  
  
> [!NOTE]  
> This deployment method still requires that the failover cluster nodes are joined to an Active Directory domain.  
  
## Deployment considerations  
An Active Directory\-detached cluster uses Kerberos authentication for intracluster communication. However, when authentication against the cluster network name is required, the cluster uses NTLM authentication. Therefore, we do not recommend this deployment method for any scenario that requires Kerberos authentication.  
  
The following table summarizes whether this deployment method is supported for a specific cluster workload.  
  
|Cluster Workload|Supported\/Not Supported|More Information|  
|--------------------|----------------------------|--------------------|  
|SQL Server|Supported|We recommend that you use SQL Server Authentication for an Active Directory\-detached cluster deployment.|  
|File server|Supported, but not recommended|Kerberos authentication is the preferred authentication protocol for Server Message Block \(SMB\) traffic.|  
|Hyper\-V|Supported, but not recommended|Live migration is not supported because it has a dependency on Kerberos authentication.<br /><br />Quick migration is supported.|  
|Message Queuing \(also known as MSMQ\)|Not supported|Message Queuing stores properties in AD DS.|  
  
In addition, be aware of the following issues for this type of cluster deployment:  
  
-   BitLocker Drive Encryption is not supported.  
  
-   Cluster\-Aware Updating \(CAU\) in self\-updating mode is not supported.  
  
    > [!NOTE]  
    > CAU is supported in remote\-updating mode.  
  
-   You cannot copy a clustered role between failover clusters that use different types of administrative access points.  
  
-   You can set the type of administrative access point only when you create the cluster. You cannot change it after the cluster is deployed.  
  
-   If you deploy a highly available file server by using this deployment method, you cannot use Server Manager to manage the file server. Instead, you must use Windows PowerShell or Failover Cluster Manager.  
  
    To use Failover Cluster Manager, after you deploy the highly available file server, you must add the fully qualified domain name \(FQDN\) of the File Server clustered role to the trusted hosts list on each node of the cluster. For example, start Windows PowerShell as an administrator, and then enter the following command, where *FileServerRole1.contoso.com* and *FileServerRole2.contoso.com* represent the names of two File Server clustered roles:  
  
    **winrm set winrm\/config\/client '@{TrustedHosts\="FileServerRole1.contoso.com,FileServerRole2.contoso.com"}'**  
  
    > [!NOTE]  
    > You must run this command on each node of the cluster.  
  
## How to deploy an Active Directory\-detached cluster  
Before you create the failover cluster, make sure that all servers that you want to add as cluster nodes meet the following prerequisites:  
  
-   All servers must be running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   All servers must be joined to the same Active Directory domain.  
  
-   All servers must have the Failover Clustering feature installed.  
  
-   All servers must use supported hardware and the collection of servers must pass all cluster validation tests. For more information, see [Failover Clustering Hardware Requirements and Storage Options](../Topic/Failover-Clustering-Hardware-Requirements-and-Storage-Options.md) and [Validate Hardware for a Failover Cluster_1](../Topic/Validate-Hardware-for-a-Failover-Cluster_1.md).  
  
To deploy an Active Directory\-detached cluster, you must use Windows PowerShell. You cannot use Failover Cluster Manager. To create the failover cluster, start Windows PowerShell as an administrator, and then use the **New\-Cluster** cmdlet with the **–AdministrativeAccessPoint** parameter set to a value of **Dns**.  
  
The following example creates a failover cluster \(*Cluster1*\) from two nodes \(*Node1* and *Node2*\), with an administrative access point of type DNS.  
  
```  
New-Cluster Cluster1 –Node Node1,Node2 –StaticAddress 192.168.1.16 -NoStorage –AdministrativeAccessPoint Dns  
  
```  
  
In this case, the cluster network name *Cluster1* will be created without a computer object in AD DS. In addition, all subsequent network names for clustered roles will be created without computer objects in AD DS.  
  
You can run the following Windows PowerShell command to verify the type of administrative access point for a failover cluster:  
  
```  
(Get-Cluster).AdministrativeAccessPoint  
```  
  
For an Active Directory\-detached cluster, the expected output value is **Dns**.  
  
