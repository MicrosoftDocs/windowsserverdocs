---
title: Network Policy Server (NPS) and GDPR
description: This topic provides information about General Data Protection Regulation (GDPR)and Network Policy Server in Windows Server 2016.
author: MicrosoftGuyJFlo
manager: mtillman
ms.author: joflore
ms.reviewer: richagi
ms.custom: it-pro
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 
ms.date: 04/03/2018

---
# Network Policy Server and GDPR

In May 2018, a European privacy law, the [General Data Protection Regulation (GDPR)](https://ec.europa.eu/info/law/law-topic/data-protection_en), is due to take effect. The GDPR imposes new rules on companies, government agencies, non-profits, and other organizations that offer goods and services to people in the European Union (EU), or that collect and analyze data tied to EU residents. The GDPR applies no matter where you are located.
Microsoft products and services are available today to help you meet the GDPR requirements. Read more about Microsoft Privacy policy in the [Trust Center](https://www.microsoft.com/trustcenter).

This document explains how to find information that Network Policy Server (NPS) may leave behind and delete it if a user asks to be forgotten.

## Information Collected by NPS

- Timestamp
- Event Timestamp
- Username
- Full Qualified Username
- Client IP Address
- Client Vendor
- Client Friendly Name
- Authentication Type
- Numerous other fields concerning the RADIUS protocol

## Gather GDPR data from NPS

If accounting data is enabled and configured, then records of a user’s NPS authentication attempts can be obtained from SQL Server or the log files depending on the configuration. 

If accounting data is configured for SQL Server, query for all records WHERE User_Name = `'<username>'`.

If accounting data is configured for a log file, then search the log file for the `<username>` to find all log entries.

Network Policy and Access Services event log entries are considered duplicative to the accounting data and don’t need to be collected.

If accounting data is not enabled, then records of a user’s NPS authentication attempts can be obtained from the Network Policy and Access Services event log by searching for the `<username>`.

## Delete GDPR data from NPS

If a user asks to be forgotten the following steps help yo to accomplish this task.

- Delete all Network Policy and Access Services event logs older than 30 days.
- Delete all accounting data log files older than 30 days.
- Delete all accounting data SQL Server records older than 30 days or delete records WHERE User_Name = `'<username>'` if you prefer to keep more than 30 days of accounting data.
