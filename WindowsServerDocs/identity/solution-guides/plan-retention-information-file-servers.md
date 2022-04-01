---
title: Plan for retention of information on file servers
description: Plan how you can retain information on file servers.
ms.topic: conceptual
author: robinharwood
ms.author: roharwoo
manager: femila
ms.date: 04/01/2022
ms.prod: windows-server
---

# Plan for retention of information on file servers

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

A data retention policy is important for any organization. You can use the following information to plan how you retain information in your organization.

## Determine the retention schedule

Determining how long data is stored on file servers in your network and developing a data retention schedule offers the following advantages:

- Limits the amount of data to store which lowers the overall cost of storage in your organization
- Reduces liability
- Satisfies regulations

When you're determining your retention schedule, you should ensure that the retention schedule meets the regulatory compliance of the industry your organization is in. For example, if your company is a healthcare provider, you should understand the HIPAA regulations.

## Identify files to be retained

Before you can implement your data retention policy, you must first identify the data that is stored on each file server. Once the data has been identified, you should mark the folders with a retention period and retention start date. Also, you should remove the Delete Child permission from any folders that could contain files that are being retained. This will ensure that the files aren't accidentally deleted.

> [!IMPORTANT]
> Classification properties should not be specified as a date. You should use the retention period to classify the file. If the retention period should change, you can update the retention period interval without having to classify every file again.

## Considerations for multiple computers

There are several things to consider when you've more than one file server in your organization:

- Data retention policies are usually the same across the organization so you can reuse the same set of rules on multiple computers.
- The Data Classification Toolkit uses Windows PowerShell cmdlets to import and export classification rules. You should use this to export the configuration from a baseline computer and import to another computer to ensure that the configuration is the same.
- You should use dynamic name spaces when the source and destination servers use the same drive letters for the storage on the server. When you create a new file share by using Server Manager, you can specify the name space.

## See also

- [Scenario: Implement Retention of Information on File Servers](Scenario--Implement-Retention-of-Information-on-File-Servers.md)
- [Deploy Implementing Retention of Information on File Servers (Demonstration Steps)](Deploy-Implementing-Retention-of-Information-on-File-Servers--Demonstration-Steps-.md)
- [Dynamic Access Control: Scenario Overview](Dynamic-Access-Control--Scenario-Overview.md)
