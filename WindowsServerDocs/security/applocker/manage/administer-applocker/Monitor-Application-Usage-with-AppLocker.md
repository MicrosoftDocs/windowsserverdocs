---
title: Monitor Application Usage with AppLocker
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 70f8b150-2948-4554-94e1-c611a1ba2907
---
# Monitor Application Usage with AppLocker
This topic describes how to monitor application usage when AppLocker policies are applied in [!INCLUDE[win8_server_1](includes/win8_server_1_md.md)] and [!INCLUDE[win8_client_1](includes/win8_client_1_md.md)].

Once you set rules and deploy the AppLocker policies, it is good practice to determine if the policy implementation is what you expected.

### <a name="BKMK_AppLkr_Disc_Effect_Pol"></a>Discover the effect of an AppLocker policy
You can evaluate how the AppLocker policy is currently implemented for documentation or audit purposes, or before you modify the policy. Updating your AppLocker Policy Deployment Planning document will help you track your findings. For information about creating this document, see [Creating Your AppLocker Planning Document](http://technet.microsoft.com/library/ee449479(WS.10).aspx). You can perform one or more of the following steps to understand what application controls are currently enforced through AppLocker rules.

-   **Analyze the AppLocker logs in Event Viewer**

    When AppLocker policy enforcement is set to **Enforce rules**, rules are enforced for the rule collection and all events are audited. When AppLocker policy enforcement is set to **Audit only**, rules are not enforced but are still evaluated to generate audit event data that is written to the AppLocker logs.

    For the procedure to access the log, see [View the AppLocker Log in Event Viewer](#BKMK_AppLkr_View_Log).

-   **Enable the Audit only AppLocker enforcement setting**

    By using the **Audit only** enforcement setting, you can ensure that the AppLocker rules are properly configured for your organization. When AppLocker policy enforcement is set to **Audit only**, rules are only evaluated but all events generated from that evaluation are written to the AppLocker log.

    For the procedure to do this, see [Configure an AppLocker Policy for Audit Only](Configure-an-AppLocker-Policy-for-Audit-Only.md).

-   **Review AppLocker events with Get\-AppLockerFileInformation**

    For both event subscriptions and local events, you can use the **Get\-AppLockerFileInformation** Windows PowerShell cmdlet to determine which files have been blocked or would have been blocked \(if you are using the audit\-only enforcement mode\) and how many times the event has occurred for each file.

    For the procedure to do this, see [Review AppLocker Events with Get\-AppLockerFileInformation](#BKMK_AppLkr_Review_Events).

-   **Review AppLocker events with Test\-AppLockerPolicy**

    You  can use the **Test\-AppLockerPolicy** Windows PowerShell cmdlet to determine determine whether any of the rules in your rule collections will be blocked on your reference computer or the computer on which you maintain policies.

    For the procedure to do this, see [Test an AppLocker Policy by Using Test-AppLockerPolicy](Test-an-AppLocker-Policy-by-Using-Test-AppLockerPolicy.md).

### <a name="BKMK_AppLkr_Review_Events"></a>Review AppLocker events with Get\-AppLockerFileInformation
For both event subscriptions and local events, you can use the **Get\-AppLockerFileInformation** Windows PowerShell cmdlet to determine which files have been blocked or would have been blocked \(if the **Audit only** enforcement setting is applied\) and how many times the event has occurred for each file.

[!INCLUDE[mingrp_admins](includes/mingrp_admins_md.md)]

> [!NOTE]
> If the AppLocker logs are not on the local computer, you will need permission to view the logs. If the output is saved to a file, you will need permission to read that file.

##### To review AppLocker events with Get\-AppLockerFileInformation

1.  Open a Command Prompt window.

2.  At the command prompt, type **PowerShell**, and then press ENTER.

3.  Run the following command to review how many times a file would have been blocked from running if rules were enforced:

    `Get-AppLockerFileInformation –EventLog –Logname "Microsoft-Windows-AppLocker\EXE and DLL" –EventType Audited –Statistics`

    > [!NOTE]
    > For an event subscription, specify the path to the forwarded event log for the Logname parameter.

4.  Run the following command to review how many times a file has been allowed to run or prevented from running:

    `Get-AppLockerFileInformation –EventLog –Logname "Microsoft-Windows-AppLocker\EXE and DLL" –EventType Allowed –Statistics`

### <a name="BKMK_AppLkr_View_Log"></a>View the AppLocker Log in Event Viewer
When AppLocker policy enforcement is set to **Enforce rules**, rules are enforced for the rule collection and all events are audited. When AppLocker policy enforcement is set to **Audit only**, rules are only evaluated but all events generated from that evaluation are written to the AppLocker log.

[!INCLUDE[mingrp_admins](includes/mingrp_admins_md.md)]

##### To view events in the AppLocker log by using Event Viewer

1.  Open Event Viewer. To do this, click **Start**, type **eventvwr.msc** in the **Search programs and files** box, and then press ENTER.

2.  In the console tree under **Application and Services Logs\\Microsoft\\Windows**, double\-click **AppLocker**.

AppLocker events are listed in either the **EXE and DLL** log, the **MSI and Script** log, or the **Packaged app\-Deployment** or **Packaged app\-Execution** log. Event information includes the enforcement setting, file name, date and time, and user name. The logs can be exported to other file formats for further analysis.

## See Also
[AppLocker Overview \[Client\]](assetId:///1637ae87-5059-4d95-8c68-96f35cbc88c7)


