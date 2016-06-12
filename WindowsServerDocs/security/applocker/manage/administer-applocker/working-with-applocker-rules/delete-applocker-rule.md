---
title: Delete an applocker Rule
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fdbff40d-394e-496b-8f24-08d7052b6762
---
# Delete an applocker Rule
This topic describes the steps to delete an applocker rule, which will prevent the application that is specified in the rule from running in  Windows Server 2012  and Windows 8.

As older applications are retired and new applications are deployed in your organization, it will be necessary to modify the application control policies. If an application becomes unsupported by the IT department or is no longer allowed due to the organization's security policy, then deleting the rule or rules associated with that application will prevent the application from running.

For information about testing an applocker policy to see what rules affect which files or applications, see [Test an applocker Policy by Using Test-applockerPolicy]().

You can perform this task by using the Group Policy Management Console for an applocker policy in a Group Policy Object \(GPO\) or by using the Local Security Policy snap\-in for an applocker policy on a local computer or in a security template. For information how to use these MMC snap\-ins to administer applocker, see [Using the MMC snap\-ins to administer applocker](#BKMK_Using_Snapins).

### <a name="BKMK_DeleteapplockerRuleGPO"></a>To delete a rule in an applocker policy

1.  In the console tree of the snap\-in, double\-click **Application Control Policies**, and then double\-click **applocker**.

2.  Click the appropriate rule collection for which you want to delete the rule.

3.  In the details pane, right\-click the rule to delete, click **Delete**, and then click **Yes**.

> [!NOTE]
> When using Group Policy, for the rule deletion to take effect on computers within the domain, the GPO must be distributed or refreshed.
> 
> When this procedure is performed on the local computer, the applocker policy takes effect immediately.


