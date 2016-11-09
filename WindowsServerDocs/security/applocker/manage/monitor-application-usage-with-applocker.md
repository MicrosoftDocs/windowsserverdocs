---
title: Monitor Application Usage with AppLocker
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 70f8b150-2948-4554-94e1-c611a1ba2907
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Monitor Application Usage with AppLocker

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes how to monitor application usage when AppLocker policies are applied in Windows Server?? 2012 and Windows?? 8.

Once you set rules and deploy the AppLocker policies, it is good practice to determine if the policy implementation is what you expected.

### <a name="BKMK_AppLkr_Disc_Effect_Pol"></a>Discover the effect of an AppLocker policy
You can evaluate how the AppLocker policy is currently implemented for documentation or audit purposes, or before you modify the policy. Updating your AppLocker Policy Deployment Planning document will help you track your findings. For information about creating this document, see [Creating Your AppLocker Planning Document](http://technet.microsoft.com/library/ee449479(WS.10).aspx). You can perform one or more of the following steps to understand what application controls are currently enforced through AppLocker rules.

-   **Analyze the AppLocker logs in Event Viewer**

    When AppLocker policy enforcement is set to **Enforce rules**, rules are enforced for the rule collection and all events are audited. When AppLocker policy enforcement is set to **Audit only**, rules are not enforced but are still evaluated to generate audit event data that is written to the AppLocker logs.

    For the procedure to access the log, see [View the AppLocker Log in Event Viewer](#BKMK_AppLkr_View_Log).

-   **Enable the Audit only AppLocker enforcement setting**

    By using the **Audit only** enforcement setting, you can ensure that the AppLocker rules are properly configured for your organization. When AppLocker policy enforcement is set to **Audit only**, rules are only evaluated but all events generated from that evaluation are written to the AppLocker log.

    For the procedure to do this, see [Configure an AppLocker Policy for Audit Only](policies/configure-an-applocker-policy-for-audit-only.md).

-   **Review AppLocker events with Get-applockerFileInformation**

    For both event subscriptions and local events, you can use the **Get-applockerFileInformation** Windows PowerShell cmdlet to determine which files have been blocked or would have been blocked (if you are using the audit-only enforcement mode) and how many times the event has occurred for each file.

    For the procedure to do this, see [Review AppLocker Events with Get-applockerFileInformation](#BKMK_AppLkr_Review_Events).

-   **Review AppLocker events with Test-applockerPolicy**

    You  can use the **Test-applockerPolicy** Windows PowerShell cmdlet to determine determine whether any of the rules in your rule collections will be blocked on your reference computer or the computer on which you maintain policies.

    For the procedure to do this, see [Test an AppLocker Policy by Using Test-applockerPolicy](policies/test-an-applocker-policy-by-using-test-applockerpolicy.md).

### <a name="BKMK_AppLkr_Review_Events"></a>Review AppLocker events with Get-applockerFileInformation
For both event subscriptions and local events, you can use the **Get-applockerFileInformation** Windows PowerShell cmdlet to determine which files have been blocked or would have been blocked (if the **Audit only** enforcement setting is applied) and how many times the event has occurred for each file.

Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure.

> [!NOTE]
> If the AppLocker logs are not on the local computer, you will need permission to view the logs. If the output is saved to a file, you will need permission to read that file.

##### To review AppLocker events with Get-applockerFileInformation

1.  Open a Command Prompt window.

2.  At the command prompt, type **PowerShell**, and then press ENTER.

3.  Run the following command to review how many times a file would have been blocked from running if rules were enforced:

    `Get-applockerFileInformation ???EventLog ???Logname "Microsoft-Windows-applocker\EXE and DLL" ???EventType Audited ???Statistics`

    > [!NOTE]
    > For an event subscription, specify the path to the forwarded event log for the Logname parameter.

4.  Run the following command to review how many times a file has been allowed to run or prevented from running:

    `Get-applockerFileInformation ???EventLog ???Logname "Microsoft-Windows-applocker\EXE and DLL" ???EventType Allowed ???Statistics`

### <a name="BKMK_AppLkr_View_Log"></a>View the AppLocker Log in Event Viewer
When AppLocker policy enforcement is set to **Enforce rules**, rules are enforced for the rule collection and all events are audited. When AppLocker policy enforcement is set to **Audit only**, rules are only evaluated but all events generated from that evaluation are written to the AppLocker log.

Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure.

##### To view events in the AppLocker log by using Event Viewer

1.  Open Event Viewer. To do this, click **Start**, type **eventvwr.msc** in the **Search programs and files** box, and then press ENTER.

2.  In the console tree under **Application and Services Logs\Microsoft\Windows**, double-click **AppLocker**.

AppLocker events are listed in either the **EXE and DLL** log, the **MSI and Script** log, or the **Packaged app-Deployment** or **Packaged app-Execution** log. Event information includes the enforcement setting, file name, date and time, and user name. The logs can be exported to other file formats for further analysis.



