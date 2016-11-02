---
title: Test and Update an AppLocker Policy
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dc696889-1651-4985-8f6c-945d245d30f2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Test and Update an AppLocker Policy

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic discusses the steps required to test an AppLocker policy prior to deployment in  Windows Server 2012  and Windows 8.

You should test each set of rules to ensure that the rules perform as intended. If you use Group Policy to manage AppLocker policies, complete the following steps for each Group Policy Object (GPO) where you have created AppLocker rules. Because AppLocker rules are inherited from linked GPOs, you should deploy all of the rules for simultaneous testing in all of your test GPOs.

## Step 1: Enable the Audit only enforcement setting
By using the **Audit only** enforcement setting, you can ensure that the AppLocker rules that you have created are properly configured for your organization. This setting can be enabled on the **Enforcement** tab of the **AppLocker Properties** dialog box. For the procedure to do this, see [Configure an AppLocker Policy for Audit Only](policies/configure-an-applocker-policy-for-audit-only.md).

## Step 2: Configure the Application Identity service to start automatically
Because AppLocker uses the Application Identity service to verify the attributes of a file, you must configure it to start automatically in any one GPO that applies AppLocker rules. For the procedure to do this, see [Configure the Application Identity Service](policies/configure-the-application-identity-service.md). For AppLocker policies that are not managed by a GPO, you must ensure that the service is running on each computer in order for the policies to be applied.

## Step 3: Test the policy
Test the AppLocker policy to determine if your rule collection needs to be modified. Because you have created AppLocker rules, enabled the Application Identity service, and enabled the **Audit only** enforcement setting, the AppLocker policy should be present on all client computers that are configured to receive your AppLocker policy.

The **Test-applockerPolicy** Windows PowerShell cmdlet can be used to determine whether any of the rules in your rule collection will be blocked on your reference computers. For the procedure to do this, see [Test an AppLocker Policy by Using Test-applockerPolicy](policies/test-an-applocker-policy-by-using-test-applockerpolicy.md).

## Step 4: Analyze AppLocker events
You can either manually analyze AppLocker events or use the **Get-applockerFileInformation** Windows PowerShell cmdlet to automate the analysis.

**To manually analyze AppLocker events**

You can view the events either in Event Viewer or a text editor and then sort those events to perform an analysis, such as looking for patterns in application usage events, access frequencies, or access by user groups. If you have not configured an event subscription, then you will have to review the logs on a sampling of computers in your organization. For more information about using Event Viewer, see [View the AppLocker Log in Event Viewer](monitor-application-usage-with-applocker.md#BKMK_AppLkr_View_Log).

**To analyze AppLocker events by using Get-applockerFileInformation**

You can use the **Get-applockerFileInformation** Windows PowerShell cmdlet to analyze AppLocker events from a remote computer. If an application is being blocked and should be allowed, you can use the AppLocker cmdlets to help troubleshoot the problem.

For both event subscriptions and local events, you can use the **Get-applockerFileInformation** cmdlet to determine which files have been blocked or would have been blocked (if you are using the **Audit only** enforcement mode) and how many times the event has occurred for each file. For the procedure to do this, see [Review AppLocker Events with Get-applockerFileInformation](monitor-application-usage-with-applocker.md#BKMK_AppLkr_Review_Events).

After using **Get-applockerFileInformation** to determine how many times that a file would have been blocked from running, you should review your rule list to determine whether a new rule should be created for the blocked file or whether an existing rule is too strictly defined. Ensure that you check which GPO is currently preventing the file from running. To determine this, you can use the Group Policy Results Wizard to view rule names.

## Step 5: Modify the AppLocker policy
After you have identified which rules need to be edited or added to the policy, you can use the Group Policy Management Console to modify the AppLocker rules in the relevant GPOs. For AppLocker policies that are not managed by a GPO, you can use the Local Security Policy snap-in. For information how to modify an AppLocker policy, see, [Edit an AppLocker Policy](edit-an-applocker-policy.md).

## Step 6: Repeat policy testing, analysis, and policy modification
Repeat the previous steps 3???5 until all the rules perform as intended before applying enforcement.

## Additional resources

-   For steps to perform other AppLocker policy tasks, see [Administer AppLocker](administer-applocker.md).




