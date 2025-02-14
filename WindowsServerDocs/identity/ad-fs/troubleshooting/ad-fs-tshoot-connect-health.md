---
title: AD FS Troubleshooting - Microsoft Entra Connect Health data
description:  Learn how to troubleshoot data freshness from the Microsoft Entra Connect Health agent for AD FS.
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 10/14/2024
ms.topic: article
---

# Microsoft Entra Connect Health for AD FS data freshness alert troubleshooting steps
Microsoft Entra Connect Health for AD FS Data Freshness Alert - Health service data is not up-to-date troubleshooting steps.

## Check if your AD FS security audits are enabled
AD FS can be configured to do service auditing of user logons in order to reveal a level of detail. In order for the Usage Analytics feature to gather and analyze data, the Azure AD Connect Health agent needs the information in the AD FS Audit Logs. These logs are not enabled by default. On your AD FS servers, use the following procedures to enable auditing and to locate the audit logs. To check the status of AD FS security audits:

 1. Click Start, point to Administrative Tools, and then click Local Security Policy.
 2. Double-click Local Policies, and then click Audit Policy.
 3. In the details pane, double-click Audit object access.
 4. Check the status of the audit object policy on the Audit object access Properties page

## Enable AD FS audit events
Depending on your machine settings, we have steps for enabling here AD FS audit events.

`Run Restart-Service AdHealth*`

## If using AD FS on Windows Server 2016, make sure Verbose AuditLevel is set.
`Set-AD FSProperties -AuditLevel Verbose`
`Run Restart-Service AdHealth*`

## Check for multiple service member entries in config.json
Navigate to C:\Program Files\Azure Ad Connect Health ADFS `Agent\Insights\config.json`
Open the file in a json editor or look for multiple instances of string: ServiceType: AdFederationService

## Look for runtime errors in the agent debug trace
 1. In the event viewer, enable analytic and debug logs.
 2. Find `Applications and Service logs\ADHealth-AD FS\Debug`
 3. Right click, increase size to 100032 and enable log. Disable and then re-enable to clear.
 4. Restart the insight service by running: `Restart-Service AdHealth*`
 5. Wait for 5 minutes and refresh the log.
 6. Ctrl-f AgentType = Insights and look for logs with error/authorization information.
 7. If errors look to be related to oAuth/token issuance: Re-register to refresh agent key for insights service and run `Register-AzureADConnectHealthAD FSAgent`
 8. Otherwise the insights service can be executed in console mode to catch errors: Navigate to `C:\Program Files\Azure Ad Connect Health ADFS Agent\Insights` and run `Microsoft.Identity.Health.ADFS.InsightsService.exe /console`
 9. Look at the debug log and find exception items.