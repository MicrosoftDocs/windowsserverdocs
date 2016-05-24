---
title: Appendix A: Dealing with Accounts After a Failover Cluster is Destroyed
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 35a6022c-4d3c-4346-a0df-aef9e8bd391f
author: kumudd
---
# Appendix A: Dealing with Accounts After a Failover Cluster is Destroyed
  This appendix supplements the information in [Failover Cluster Step-by-Step Guide: Configuring Accounts in Active Directory](../Topic/Failover-Cluster-Step-by-Step-Guide--Configuring-Accounts-in-Active-Directory.md), which we recommend that you read first.  
  
 You might choose to delete a clustered service or application, or destroy an entire failover cluster, using the Failover Cluster Management snap\-in. By default, when you do this, the corresponding computer accounts \(objects\) are disabled, but not deleted, in Active Directory. The accounts \(objects\) that are disabled are the cluster name object and the computer accounts for any clustered services or applications. Preserving the accounts means that you can perform a recovery process by first deleting a clustered service or application, or destroying a cluster, and then restoring from backup. In such a recovery process, application data that is stored in the computer accounts, for example, for a clustered instance of Message Queuing, will not be lost.  
  
 However, you might want to delete accounts from Active Directory after you delete a clustered service or application, or after you destroy a cluster. You can delete the accounts by using the Active Directory Users and Computers snap\-in. In addition, you can perform certain deletion operations by running the **cluster** command with appropriate options. This appendix provides instructions for those **cluster** command options.  
  
 **In this appendix**  
  
 [Step for ensuring that when a clustered service or application is deleted, the associated computer account is deleted](#BKMK_autodelete)  
  
 [Step for destroying a cluster and also deleting automatically-created computer accounts](#BKMK_destroy)  
  
##  <a name="BKMK_autodelete"></a> Step for ensuring that when a clustered service or application is deleted, the associated computer account is deleted  
 By using the command in this procedure, you change the default actions that occur whenever you delete a clustered service or application \(or more specifically, the Network Name resource in a clustered service or application\). Before the default is changed, what happens is that when the clustered service or application is deleted, the associate computer account is disabled, but not deleted. When you use the following command to change that default, the associated computer account is not only disabled, it is deleted.  
  
 Membership in the **Domain Admins** group, or equivalent, is the minimum required to complete this procedure. Review details about using the appropriate accounts and group memberships at [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=83477](http://go.microsoft.com/fwlink/?LinkId=83477).  
  
#### To ensure that when a clustered service or application is deleted, the associated computer account is deleted  
  
-   Open a command prompt as an administrator and type the following command:  
  
     `cluster <ClusterName> restype “Network Name” /priv DeleteVcoOnResCleanup=1`  
  
     where `<ClusterName>` is the name of the cluster.  
  
     To return the default behavior to the original default \(where the associated computer account is disabled but not deleted\), type the same command but substitute **0** \(zero\) instead of **1** at the end of the command.  
  
##  <a name="BKMK_destroy"></a> Step for destroying a cluster and also deleting automatically\-created computer accounts  
 By using the command in this procedure, you can destroy a cluster and also delete the accounts that were automatically created by failover cluster wizards for that cluster \(for example, the cluster name account, also known as the cluster name object, might have been automatically created by a failover cluster wizard\). This command does not delete manually created or prestaged computer accounts.  
  
 Membership in the **Domain Admins** group, or equivalent, is the minimum required to complete this procedure. Review details about using the appropriate accounts and group memberships at [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=83477](http://go.microsoft.com/fwlink/?LinkId=83477).  
  
#### To destroy a cluster and also delete automatically\-created computer accounts  
  
-   Open a command prompt as an administrator and type the following command:  
  
     `cluster <ClusterName> /destroy /CleanupActiveDirectory`  
  
     where `<ClusterName>` is the name of the cluster.  
  
  