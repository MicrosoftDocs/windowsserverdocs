---
title: Configure Properties for a Virtual Machine Resource
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8754dc71-3a53-4b5a-b61f-230fbc3fe339
---
# Configure Properties for a Virtual Machine Resource
On the **Settings** tab in the properties of a virtual machine resource, you can configure settings for actions that the cluster can perform on the virtual machine.  
  
**Cluster\-controlled offline action**  
  
This is the action that the cluster will perform when it takes the virtual machine offline. This setting does not affect live migration, quick migration, or unplanned failover. It affects only moving or taking the resource offline by using [!INCLUDE[wps_2](../Token/wps_2_md.md)] or an application.  
  
|Option|Details|  
|----------|-----------|  
|**Save**|The cluster saves the state of the virtual machine before taking the virtual machine offline, so that the state can be restored when bringing the virtual machine back online. This is the default.|  
|**Shut down**|The cluster performs an orderly shutdown of the operating system \(waiting for all processes to close\) on the virtual machine before taking the virtual machine offline.|  
|**Shut down \(forced\)**|The cluster shuts down the operating system on the virtual machine without waiting for slower processes to finish, and then takes the virtual machine offline.|  
|**Turn off**|The cluster turns off the virtual machine without shutting down the operating system when taking the virtual machine offline. This is the same as turning off the power, which means that data loss may occur.|  
  
**Virtual machine stop action**  
  
This is the action that the cluster will perform on the virtual machine if the virtual machine stops as the result of actions from outside of the cluster. For example, a virtual machine can stop if a failure occurs in the operating system of the virtual machine, or in a service or application that is running in the virtual machine.  
  
|Option|Details|  
|----------|-----------|  
|Take resource offline until virtual machine restarts|The cluster takes the virtual machine resource offline. The resource is brought online when the virtual machine restarts.|  
|Mark resource as failed|The virtual machine is marked as failed and is moved permanently to another node.|  
  
**Heartbeat setting**  
  
|Option|Details|  
|----------|-----------|  
|**Enable heartbeat monitoring for the virtual machine**|When this option is selected, heartbeats are sent from the operating system running in the virtual machine to the operating system running the Hyper\-V role. If the heartbeats stop, indicating that virtual machine has become unresponsive, the cluster is notified, and it can attempt to restart or fail over the clustered virtual machine.|  
|**Enable cluster recovery actions for applications monitored on the virtual machine**|When this option is selected, you enable automatic recovery actions by the cluster in case a monitored service or application in the virtual machine fails. If a monitored service or application fails, the operating system running the Hyper\-V role is notified and the failover cluster can take action to restart or move the clustered virtual machine.|  
  
