---
title: Test Updates
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 078f1907-8c80-46c6-a037-c375e2a07a5b
author: britw
---
# Test Updates
Until you install an update, you cannot be certain about the impact it will have on other programs running on your systems. By installing an update in a test environment, you can assess its impact before you decide whether to deploy it to your production systems. This approach can prevent unplanned downtime and lost productivity.  
  
WSUS enables you to create custom computer groups that you can use to test updates. For example, the following image depicts three computer groups: two custom groups that are created by the administrator \(Test and Accounting\), and the built\-in **All Computers** group.  
  
In this example, the Test group contains a small number of computers that are representative of the computers in the Accounting group. The administrator can first approve updates for the Test group. If the testing goes well, the administrator can roll out the updates to the Accounting group.  
  
![](../Image/f74817dd-8d19-497f-b310-f12f0060daa2.gif)  
  
You can create multiple test computer groups with configurations that resemble the computers in departments in your organization.  
  
## Test service packs carefully  
You should thoroughly test large bundles of updates such as service packs to ensure that they do not break line\-of\-business applications.  
  
> [!IMPORTANT]  
> Most notably:  
>   
> -   [!INCLUDE[firstref_client_7](../Token/firstref_client_7_md.md)] with Service Pack 1 \(SP1\)  
> -   [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] with Service Pack 1 \(SP1\)  
  
Following is a typical test strategy:  
  
1.  Set up test computer groups in which the test computers are configured with the same applications as the production groups.  
  
2.  Approve installation only to these groups.  
  
3.  Verify that the applications continue to function correctly.  
  
