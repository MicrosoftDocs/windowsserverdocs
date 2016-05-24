---
title: Clustered Role and Resource Properties
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 113b5967-f7a4-4038-b583-a9c343dbffd7
---
# Clustered Role and Resource Properties
This topic describes the user interface \(UI\) choices that are available on the following tabs in Failover Cluster Manager:  
  
-   [&lt;ClusteredRole&gt; Properties: General Tab](#BKMK_General)  
  
-   [&lt;Resource&gt; Properties: Policies Tab](#BKMK_Policies)  
  
-   [&lt;Resource&gt; Properties: Advanced Policies Tab](#BKMK_AdvancedPolicies)  
  
## <a name="BKMK_General"></a><ClusteredRole> Properties: General Tab  
The following table describes the UI choices that are available on the **Policies** tab for a clustered role.  
  
|Item|Details|  
|--------|-----------|  
|**Preferred Owners**|Select nodes from the list, and then use the buttons to list them in order.<br /><br />If you want this clustered role to be moved to a particular node whenever that node is available:<br /><br />-   Select the check box for a node and use the buttons to place it at the top of the list.<br />-   On the **Failover** tab, ensure that failback is allowed for this clustered role.<br /><br />Even if you clear the check box for a node in the **Preferred Owners** list, the clustered role could fail over to that node for the following reasons:<br /><br />-   You have not specified any preferred owners.<br />-   No node that is a preferred owner is currently online.<br /><br />To ensure that a clustered role never fails over to a particular node:<br /><br />1.  Select an individual resource in the clustered role.<br />2.  Open the **Properties** sheet for that resource.<br />3.  Select the **Advanced Policies** tab.<br />4.  Configure **Possible Owners**.|  
  
## <a name="BKMK_Policies"></a><Resource> Properties: Policies Tab  
The following table describes the UI choices that are available on the **Policies** tab for a cluster resource.  
  
|Item|Details|  
|--------|-----------|  
|**Period for restarts \(mm:ss\)**|Specify the length of the period \(minutes and seconds\) during which the Cluster service counts the number of times that a resource has been restarted.|  
|**Maximum restarts in the specified period**|Specify the number of times that you want the Cluster service to try to restart the resource during the period you specify. If the resource cannot be started after this number of attempts in the specified period, the Cluster service will take actions as specified by other fields on this tab.<br /><br />For example, if you specify **3** for **Maximum restarts in the specified period** and **15:00** for the period, the Cluster service attempts to restart the resource three times in a given 15 minute period. If the resource still does not run, instead of trying to restart it a fourth time, the Cluster service will take the actions that you specified in the other fields on this tab.|  
|**If restart is unsuccessful, fail over all resources in this role**|Controls how the Cluster service responds if the maximum number of restarts that you specified fail:<br /><br />-   Select this check box if you want the Cluster service to fail over the clustered role to another node.<br />-   Clear this check box if you want the Cluster service to leave this clustered role running on this node \(even if this resource is in a failed state\).|  
|**If all the restart attempts fail, begin restarting again after the specified period \(hh:mm\)**|Select this check box if you want the Cluster service to go into an extended waiting period after it attempts the maximum number of restarts on the resource. This extended waiting period is measured in hours and minutes. After the waiting period, the Cluster service will begin another series of restarts. This is true regardless of which node owns the clustered role at that time.|  
  
## <a name="BKMK_AdvancedPolicies"></a><Resource> Properties: Advanced Policies Tab  
The following table describes the UI choices that are available on the **Advanced Policies** tab for a cluster resource.  
  
|Item|Details|  
|--------|-----------|  
|**Possible Owners**|Clear the check box for a node only if you want to prevent this resource \(and the clustered role that contains this resource\) from failing over to that node. Otherwise, leave the boxes selected for all nodes. **Note:** If you select a check box for only one node, this resource \(and the clustered role that contains this resource\) cannot fail over.|  
|**Basic resource health check interval**|Specify how often you want the cluster to perform a basic check to see whether the resource appears to be online. We recommend that you select the **Use standard time period for the resource type** option unless you have a reason to change the interval. **Note:** This health check is also known as the Looks Alive poll.|  
|**Thorough resource health check interval**|Specify how often you want the cluster to perform a more thorough check, which looks for indications that the resource is online and functioning properly. We recommend that you select the **Use standard time period for the resource type** option unless you have a reason to change the interval. **Note:** This health check is also known as the Is Alive poll.|  
  
