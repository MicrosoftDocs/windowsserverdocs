---
title: Troubleshoot Active Directory Federation Services with events and logging
description:  Learn how to use the admin and Tracelog to troubleshoot various Active Directory Federation Services issues.
author: billmath
ms.author: wscontent
ms.date: 05/25/2023
ms.topic: article
---

# Troubleshoot Active Directory Federation Services with events and logging

Active Directory Federation Services (AD FS) provides two primary logs that you can use to troubleshoot. They are:

- The Admin Log.
- The Tracelog.

## View the admin log

The Admin log provides high-level information on issues that are occurring and is enabled by default. To view the admin log:

1. Open **Event Viewer**.
1. Expand **Applications and Services Log**.
1. Expand **AD FS**.
1. Select **Admin**.

    :::image type="content" source="media/ad-fs-tshoot-logging/event1.PNG" alt-text="Screenshot of the Event Viewer with the Admin option called out.":::

## Use Tracelog

The Tracelog is where detailed messages are logged, and it's the most useful log when troubleshooting. Since a lot Tracelog information can be generated in a short amount of time, which can affect system performance, the logs are disabled by default.

### To enable and view the Tracelog

1. Open **Event Viewer** and expand **Applications and Services Log**.
1. Right-click on **Applications and Services Log**, and select **View**. Then select **Show Analytic and Debug Logs**. This pane shows more nodes.

    :::image type="content" source="media/ad-fs-tshoot-logging/event2.PNG" alt-text="Screenshot of the Event Viewer showing that the user right-clicked Applications and Services Log and selected View with the Show Analytic and Debug Logs option called out.":::

1. Expand **AD FS Tracing**.
1. Right-click on **Debug**, and select **Enable Log**.

    :::image type="content" source="media/ad-fs-tshoot-logging/event3.PNG" alt-text="Screenshot of the Event Viewer showing that the user right-clicked Debug with the Enable Log option called out.":::

## Event auditing information for AD FS on Windows Server 2016

By default, AD FS in Windows Server 2016 has a basic level of auditing enabled. With basic auditing, administrators see five or fewer events for a single request. This information marks a significant decrease in the number of events administrators have to look at in order to see a single request. You can raise or lower the auditing level by using the PowerShell cmdlet:

```powershell
Set-AdfsProperties -AuditLevel
```

The following table explains the available auditing levels.

|Audit Level|PowerShell syntax|Description|
|----- | ----- | ----- |
|None|Set-AdfsProperties -AuditLevel None|Auditing is disabled and no events are logged.|
|Basic (Default)|Set-AdfsProperties -AuditLevel Basic|No more than five events are logged for a single request.|
|Verbose|Set-AdfsProperties -AuditLevel Verbose|All events are logged. This level logs a significant amount of information per request.|

To view the current auditing level, you can use the PowerShell cmdlet: `Get-AdfsProperties`.

 :::image type="content" source="media/ad-fs-tshoot-logging/ADFS_Audit_1.PNG" alt-text="Screenshot of the PowerShell window showing the results of the Get-AdfsProperties cmdlet with the Audit Level property called out.":::

You can raise or lower the auditing level by using the PowerShell cmdlet: `Set-AdfsProperties -AuditLevel`.

:::image type="content" source="media/ad-fs-tshoot-logging/ADFS_Audit_2.png" alt-text="Screenshot of the PowerShell window showing the Set-AdfsProperties -AuditLevel Verbose cmdlet typed in the command prompt.":::

## Types of events

AD FS events can be of different types, based on the different types of requests processed by AD FS. Each type of event has specific data associated with it. The type of events can be differentiated between login requests and system requests. Your login requests might be token requests, and your system requests might be server-server calls, including fetching configuration information.

The following table describes the basic types of events.

|Event Type|Event ID|Description|
|----- | ----- | ----- |
|Fresh Credential Validation Success|1202|A request where the Federation Service validates fresh credentials successfully. This event includes WS-Trust, WS-Federation, SAML-P (first leg to generate SSO) and OAuth Authorize Endpoints.|
|Fresh Credential Validation Error|1203|A request where fresh credential validation failed on the Federation Service. This event includes WS-Trust, WS-Fed, SAML-P (first leg to generate SSO), and OAuth Authorize Endpoints.|
|Application Token Success|1200|A request where the Federation Service issues a security token successfully. For WS-Federation and SAML-P, this event is logged when the request is processed with the SSO artifact (such as the SSO cookie).|
|Application Token Failure|1201|A request where the security token issuance failed on the Federation Service. For WS-Federation and SAML-P, this event is logged when the request was processed with the SSO artifact (such as the SSO cookie).|
|Password Change Request Success|1204|A transaction where the Federation Service successfully processes the password change request.|
|Password Change Request Error|1205|A transaction where the Federation Service fails to process the password change request.|
|Sign Out Success|1206|Describes a successful sign out request.|
|Sign Out Failure|1207|Describes a failed sign out request.|

## Security auditing

Security auditing of the AD FS service account can sometimes help track issues with password updates, request/response logging, request content headers, and device registration results. Auditing of the AD FS service account is disabled by default.

### Enable security auditing

1. Select **Start**. Then go to **Programs** > **Administrative Tools**, and then choose **Local Security Policy**.
1. Go to the **Security Settings\Local Policies\User Rights Management** folder, and then double-click **Generate security audits**.
1. On the **Local Security Setting** tab, verify that the AD FS service account is listed. If it isn't present, select **Add User** or **Group**, and add it to the list. Then select **OK**.
1. Open a command prompt with elevated privileges and run the following command to enable auditing:
   `auditpol.exe /set /subcategory:"Application Generated" /failure:enable /success:enable`
1. Close **Local Security Policy**, and then open the AD FS Management snap-in.
1. To open the AD FS Management snap-in, select **Start**. Go to **Programs** > **Administrative Tools**, and then select **AD FS Management**.
1. In the **Actions** pane, select **Edit Federation Service Properties**.
1. In the **Federation Service Properties** dialog box, select the **Events** tab.
1. Select the **Success audits** and **Failure audits** check boxes.
1. Select **OK**.

    :::image type="content" source="media/ad-fs-tshoot-logging/event4.PNG" alt-text="Screenshot of the Events tab of the Federation Service Properties dialog box showing that the Success audits and Failure audits options are selected.":::

> [!NOTE]
> The previous instructions are used only when AD FS is on a stand-alone member server. If AD FS is running on a domain controller, instead of the **Local Security Policy**, use the **Default Domain Controller Policy** located in **Group Policy Management/Forest/Domains/Domain Controllers**. Select **edit** and go to **Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\User Rights Management**.

## Windows Communication Foundation and Windows Identity Foundation messages

In addition to trace logging, sometimes you might need to view Windows Communication Foundation (WCF) and Windows Identity Foundation (WIF) messages in order to troubleshoot an issue. You can view these messages by modifying the **Microsoft.IdentityServer.ServiceHost.Exe.Config** file on the AD FS server.

This file is located in **<%system root%>\Windows\ADFS** and is in XML format. The relevant portions of the file are shown in the following sample:

```xml
<!-- To enable WIF tracing, change the following switchValue to the desired trace level - Verbose, Information, Warning, Error, Critical -->

<source name="Microsoft.IdentityModel" switchValue="Off"> … </source>

<!-- To enable WCF tracing, change the following switchValue to the desired trace level - Verbose, Information, Warning, Error, Critical -->

<source name="System.ServiceModel" switchValue="Off" > … </source>
```

After you apply these changes, save the configuration, and restart the AD FS service. After you enable these traces by setting the appropriate switches, they'll appear in the AD FS Tracelog in the Windows Event Viewer.

## Correlating Events

One of the hardest things to troubleshoot is access issues that generate numerous errors or debug events.

To help with this, AD FS correlates all events that are recorded to the Event Viewer, in both the admin and the debug logs. Each of these logs corresponds to a particular request by using a unique Globally Unique Identifier (GUID) called the Activity ID. AD FS generates this ID when it presents the token issuance request to the web application for applications using the passive requestor profile. AD FS also generates an ID when it sends requests directly to the claims provider for applications using WS-Trust.

:::image type="content" source="media/ad-fs-tshoot-logging/activityid1.png" alt-text="Screenshot of the Details tab of the event Properties dialog box with the ActivityID value called out.":::

This activity ID remains the same for the entire duration of the request, and it's logged as part of every event recorded in the Event Viewer for that request. This means:

- Filtering or searching the Event Viewer by using this activity ID can help keep track of all related events that correspond to the token request.
- The same activity ID is logged across different machines, which allows you to troubleshooting a user request across multiple machines such as the Federation Server proxy (FSP).
- The activity ID also appears in the user's browser if the AD FS request fails in any way, thus allowing the user to communicate this ID to help desk or IT Support.

:::image type="content" source="media/ad-fs-tshoot-logging/activityid2.png" alt-text="Screenshot of the Details tab of the event Properties dialog box with the client request ID value called out.":::

To aid in the troubleshooting process, AD FS also logs the caller ID event whenever the token-issuance process fails on an AD FS server. This event contains the claim type and value of one of the following claim types, assuming that this information was passed to the Federation Service as part of a token request:

- `https://schemas.microsoft.com/ws/2008/06/identity/claims/windowsaccountnameh`
- `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier`
- `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/upnh`
- `https://schemas.microsoft.com/ws/2008/06/identity/claims/upn`
- `http://schemas.xmlsoap.org/claims/UPN`
- `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddressh`
- `https://schemas.microsoft.com/ws/2008/06/identity/claims/emailaddress`
- `http://schemas.xmlsoap.org/claims/EmailAddress`
- `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name`
- `https://schemas.microsoft.com/ws/2008/06/identity/claims/name`
- `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/privatepersonalidentifier`

The caller ID event also logs the activity ID to allow you to use that activity ID to filter or search the event logs for a particular request.

## Next Steps

- [AD FS Troubleshooting](ad-fs-tshoot-overview.md)
