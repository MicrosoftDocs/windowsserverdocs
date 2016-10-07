---
title: Using Advanced Security Auditing Options to Monitor Dynamic Access Control Objects
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6268b270-5340-43c9-972c-0593265d41fd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Using Advanced Security Auditing Options to Monitor Dynamic Access Control Objects

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This guide explains the process of setting up advanced security auditing capabilities that are made possible through settings and events that were introduced in Windows 8 and  Windows Server 2012 .

These procedures can be deployed with the advanced security auditing capabilities described in the following document:

-   [Advanced Security Auditing Walkthrough](Advanced-Security-Auditing-Walkthrough.md)


> [!NOTE]
> These auditing policies use the settings and events that were introduced in Windows 8 and  Windows Server 2012 . The contents of this guide apply to the list of supported Windows operating systems designated in the **Applies To** list at the beginning of this topic.

## In this guide
Domain administrators can create and deploy expression-based security audit policies by using file classification information (resource attributes), user claims, and device claims to target specific users and resources to monitor potentially significant activities on one or more computers. These policies can be deployed centrally by using Group Policy, or directly on a computer, in a folder, or in individual files.

The procedures in this document describe how to:

-   [Monitor the Central Access Policies that Apply on a File Server](using-advanced-security-auditing-options-to-monitor-dynamic-access-control-objects/Monitor-the-Central-Access-Policies-that-Apply-on-a-File-Server.md)

-   [Monitor the Central Access Policies Associated with Files and Folders](using-advanced-security-auditing-options-to-monitor-dynamic-access-control-objects/Monitor-the-Central-Access-Policies-Associated-with-Files-and-Folders.md)

-   [Monitor the Resource Attributes on Files and Folders](using-advanced-security-auditing-options-to-monitor-dynamic-access-control-objects/Monitor-the-Resource-Attributes-on-Files-and-Folders.md)

-   [Monitor Claim Types](using-advanced-security-auditing-options-to-monitor-dynamic-access-control-objects/Monitor-Claim-Types.md)

-   [Monitor User and Device Claims During Sign-in](using-advanced-security-auditing-options-to-monitor-dynamic-access-control-objects/Monitor-User-and-Device-Claims-During-Sign-in.md)

-   [Monitor Central Access Policy and Rule Definitions](using-advanced-security-auditing-options-to-monitor-dynamic-access-control-objects/Monitor-Central-Access-Policy-and-Rule-Definitions.md)

-   [Monitor Resource Attribute Definitions](using-advanced-security-auditing-options-to-monitor-dynamic-access-control-objects/Monitor-Resource-Attribute-Definitions.md)

-   [Monitor the Use of Removable Storage Devices](using-advanced-security-auditing-options-to-monitor-dynamic-access-control-objects/Monitor-the-Use-of-Removable-Storage-Devices.md)

    > [!IMPORTANT]
    > This procedure can be configured on computers running any of the supported Windows operating systems. The other monitoring procedures can be configured only as part of a functioning dynamic access control deployment.

## Related resources
[Security Auditing Overview](../access-control/Security-Auditing-Overview.md)


