---
title: AD FS Troubleshooting - Microsoft Entra Connect Health Data
description: Learn how to troubleshoot data freshness from the Microsoft Entra Connect Health agent for Active Directory Federation Services.
ms.date: 10/14/2024
ms.topic: troubleshooting-general
---

# AD FS troubleshooting: Data freshness alert for Microsoft Entra Connect Health

This article describes troubleshooting steps for the Microsoft Entra Connect Health for Active Directory Federation Services (AD FS) data freshness alert: "Health service data is not up to date."

## Check if your AD FS security audits are enabled

You can configure AD FS to do service auditing of user sign-ins to reveal a level of detail. For the Usage Analytics feature to gather and analyze data, the Microsoft Entra Connect Health agent needs the information in the AD FS audit logs. These logs aren't enabled by default. On your AD FS servers, use the following procedures to enable auditing and to locate the audit logs. To check the status of AD FS security audits:

 1. Select **Start**, point to **Administrative Tools**, and then select **Local Security Policy**.
 1. Double-click **Local Policies**, and then select **Audit Policy**.
 1. On the details pane, double-click **Audit object access**.
 1. Check the status of the audit object policy on the **Audit object access properties** page.

## Enable AD FS audit events

Depending on your machine settings, we have steps here to enable AD FS audit events:

`Run Restart-Service AdHealth*`

## If you use AD FS on Windows Server 2016, make sure Verbose AuditLevel is set

Use these commands:

`Set-AD FSProperties -AuditLevel Verbose`

`Run Restart-Service AdHealth*`

## Check for multiple service member entries in config.json

Go to *C:\Program Files\Azure Ad Connect Health ADFS Agent\Insights\config.json*.
Open the file in a JSON editor or look for multiple instances of the string `ServiceType: AdFederationService`.

## Look for runtime errors in the agent debug trace

 1. In the event viewer, enable analytic and debug logs.
 1. Find `Applications and Service logs\ADHealth-AD FS\Debug`.
 1. Right-click, increase the size to **100032**, and enable the log. Disable and then reenable to clear.
 1. Restart the insight service by running `Restart-Service AdHealth*`.
 1. Wait for five minutes, and then refresh the log.
 1. Select Ctrl+F to find `AgentType = Insights`. Look for logs with error/authorization information.
 1. If errors look to be related to OAuth/token issuance, reregister to refresh the agent key for the insights service. Then run `Register-AzureADConnectHealthAD FSAgent`.
 1. Otherwise, you can run the insights service in console mode to catch errors. Go to *C:\Program Files\Azure Ad Connect Health ADFS Agent\Insights* and run `Microsoft.Identity.Health.ADFS.InsightsService.exe /console`.
 1. Look at the debug log and find exception items.
