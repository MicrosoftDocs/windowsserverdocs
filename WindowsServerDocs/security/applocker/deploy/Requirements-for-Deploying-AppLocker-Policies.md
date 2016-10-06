---
title: Requirements for Deploying AppLocker Policies
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 089fb913-0d77-42a2-b880-209db1d457fb
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Requirements for Deploying AppLocker Policies

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This deployment topic for the IT professional lists the requirements that you need to consider before you deploy AppLocker policies.

The following requirements must be met or addressed before you deploy your AppLocker policies:

-   [Deployment plan](#BKMK_ReqDepPlan)

-   [Supported operating systems](#BKMK_ReqSupportedOS)

-   [Policy distribution mechanism](#BKMK_ReqPolicyDistMech)

-   [Event collection and analysis system](#BKMK_ReqEventCollectionSystem)

### <a name="BKMK_ReqDepPlan"></a>Deployment plan
An AppLocker policy deployment plan is the result of investigating which applications are required and necessary in your organization, which applications are optional, and which applications are forbidden. To develop this plan, see [AppLocker Policies Design Guide](../design/AppLocker-Policies-Design-Guide.md). The following table is an example of the data you need to collect and the decisions you need to make to successfully deploy AppLocker policies on the supported operating systems (as listed in [Requirements to Use AppLocker](../get-started/Requirements-to-Use-AppLocker.md)).

|Business group|Organizational unit|Implement AppLocker?|Applications|Installation path|Use default rule or define new rule condition|Allow or deny|GPO name|Support policy|
|------------------|-----------------------|------------------------|----------------|---------------------|-------------------------------------------------|-----------------|------------|------------------|
|Bank Tellers|Teller-East and Teller-West|Yes|Teller software|C:\Program Files\Woodgrove\Teller.exe|File is signed; create a publisher condition|Allow|Tellers|Web help|
||||Windows files|C:\Windows|Create a path exception to the default rule to exclude \Windows\Temp|Allow||Help Desk|
||||Time Sheet Organizer|C:\Program Files\Woodgrove\HR\Timesheet.exe|File is not signed; create a file hash condition|Allow||Web help|
|Human Resources|HR-All|Yes|Check Payout|C:\Program Files\Woodgrove\HR\Checkcut.exe|File is signed; create a publisher condition|Allow|HR|Web help|
||||Internet Explorer 7|C:\Program Files\Internet Explorer\|File is signed; create a publisher condition|Deny||Help Desk|
||||Windows files|C:\Windows|Use the default rule for the Windows path|Allow||Help Desk|

**Event processing policy**

|Business group|AppLocker event collection location|Archival policy|Analyzed?|Security policy|
|------------------|---------------------------------------|-------------------|-------------|-------------------|
|Bank Tellers|Forwarded to: srvBT093|Standard|None|Standard|
|Human Resources|Do not forward|60 months|Yes; summary reports monthly to managers|Standard|

**Policy maintenance policy**

|Business group|Rule update policy|Application decommission policy|Application version policy|Application deployment policy|
|------------------|----------------------|-----------------------------------|------------------------------|---------------------------------|
|Bank Tellers|Planned: Monthly through business office triage<br /><br />Emergency: Request through Help Desk|Through business office triage; 30-day notice required|General policy: Keep past versions for 12 months<br /><br />List policies for each application|Coordinated through business office; 30-day notice required|
|Human Resources|Planned: Through HR triage<br /><br />Emergency: Request through Help Desk|Through HR triage; 30-day notice required|General policy: Keep past versions for 60 months<br /><br />List policies for each application|Coordinated through HR; 30-day notice required|

### <a name="BKMK_ReqSupportedOS"></a>Supported operating systems
AppLocker is supported only on certain operating systems. Some features are not available on all operating systems. For more information, see [Requirements to Use AppLocker](../get-started/Requirements-to-Use-AppLocker.md).

Software Restriction Policies are supported in Windows XP and Windows Server 2003, in addition to the versions listed in [Requirements to Use AppLocker](../get-started/Requirements-to-Use-AppLocker.md).

### <a name="BKMK_ReqPolicyDistMech"></a>Policy distribution mechanism
You need a way to distribute the AppLocker policies throughout the targeted business groups. AppLocker uses Group Policy management architecture to effectively distribute application control policies. AppLocker policies can also be configured on individual computers by using the Local Security Policy snap-in.

### <a name="BKMK_ReqEventCollectionSystem"></a>Event collection and analysis system
Event processing is important to understand application usage. You must have a process in place to collect and analyze AppLocker events so that application usage is appropriately restricted and understood. For procedures to monitor AppLocker events, see:

-   [Configure an AppLocker Policy for Audit Only](../manage/policies/Configure-an-AppLocker-Policy-for-Audit-Only.md)

-   [Configure an AppLocker Policy for Enforce Rules](../manage/policies/Configure-an-AppLocker-Policy-for-Enforce-Rules.md)

-   [Monitor Application Usage with AppLocker](../manage/Monitor-Application-Usage-with-AppLocker.md)

## See also
[AppLocker Policies Deployment Guide](AppLocker-Policies-Deployment-Guide.md)


