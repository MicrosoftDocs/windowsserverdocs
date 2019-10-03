---
title: Network Policy Server user data collection
description: What information is used to help authenticate users by Network Policy Server in Windows Server 2016.
author: MicrosoftGuyJFlo
manager: mtillman
ms.author: joflore
ms.reviewer: richagi
ms.custom: it-pro
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 
ms.date: 05/01/2018

---
# Network Policy Server user data collection

This document explains how to find user information collected by the Network Policy Server (NPS) in the event you would like to remove it.

>[!Note]
>If you're interested in viewing or deleting personal data, please review Microsoft's guidance in the [Windows Data Subject Requests for the GDPR](https://docs.microsoft.com/microsoft-365/compliance/gdpr-dsr-windows) site. If you're looking for general information about GDPR, see the [GDPR section of the Service Trust portal](https://servicetrust.microsoft.com/ViewPage/GDPRGetStarted).

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

## Gather data from NPS

If accounting data is enabled and configured, then records of a user's NPS authentication attempts can be obtained from SQL Server or the log files depending on the configuration. 

If accounting data is configured for SQL Server, query for all records WHERE User_Name = `'<username>'`.

If accounting data is configured for a log file, then search the log file for the `<username>` to find all log entries.

Network Policy and Access Services event log entries are considered duplicative to the accounting data and don't need to be collected.

If accounting data is not enabled, then records of a user's NPS authentication attempts can be obtained from the Network Policy and Access Services event log by searching for the `<username>`.
