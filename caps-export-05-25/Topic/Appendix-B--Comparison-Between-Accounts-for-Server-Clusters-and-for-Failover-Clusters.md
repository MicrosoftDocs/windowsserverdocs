---
title: Appendix B: Comparison Between Accounts for Server Clusters and for Failover Clusters
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 3e8633ad-1c8c-44f1-be19-6d15475f131c
author: kumudd
---
# Appendix B: Comparison Between Accounts for Server Clusters and for Failover Clusters
  This appendix supplements the information in [Failover Cluster Step-by-Step Guide: Configuring Accounts in Active Directory](../Topic/Failover-Cluster-Step-by-Step-Guide--Configuring-Accounts-in-Active-Directory.md), which we recommend that you read first.  
  
 There are a number of differences between the way Active Directory accounts function with clusters in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] as compared to clusters in Windows Server 2003. The differences are listed in the following table.  
  
 **Use of Active Directory accounts in Windows Server 2003 and Windows Server 2008**  
  
|Windows Server 2003|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]|  
|-------------------------|-------------------------------------------------------------------|  
|In Windows Server 2003, the Cluster service ran in the context of a specific Active Directory user account, the Cluster service account.|In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the Cluster service runs in a special context that provides the specific permissions and privileges necessary for the service \(similar to the local system context, but with reduced privileges\). This means that there is no Cluster service account in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].|  
|In Windows Server 2003, a Network Name resource could be configured so that it used Kerberos authentication, which meant it would have an Active Directory computer account with the same name as the Network Name resource. This was optional, and was typically used for message queuing, for clustered e\-mail, or for other applications where Kerberos authentication was required or preferred.|In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], all clustered services and applications must use Kerberos, which means all clustered services and applications have a computer account in Active Directory with the same name as the clustered service or application. This strengthens security in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], as compared to Windows Server 2003.|  
|In Windows Server 2003, although the Cluster service ran in the context of a user account, the cluster did not use a computer account \(computer object\) as an identity for actions performed by cluster wizards.|In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the cluster uses a computer account \(computer object\) when an identity is needed for a cluster action. For example, when a cluster wizard creates a computer account for a clustered service or application, the identity that is used is the cluster name account \(also known as the cluster name object or CNO\).|  
  
  