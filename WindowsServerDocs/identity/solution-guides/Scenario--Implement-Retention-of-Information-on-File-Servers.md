---
description: "Learn more about: Scenario: Implement Retention of Information on File Servers"
title: Scenario Implement Retention of Information on File Servers
author: robinharwood
ms.author: roharwoo
manager: femila
ms.date: 04/01/2022
ms.topic: conceptual
---

# Scenario: Implement Retention of Information on File Servers

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

A retention period is the amount of time that a document should be kept before it's expired. Depending on the organization, the retention period can be different. You can classify files in a folder as having a short, medium, or long-term retention period, and then assign a time frame for each period. You may want to keep a file indefinitely by putting it on legal hold.

## Scenario description

File Classification Infrastructure and File Server Resource Manager uses file management tasks and file classification to apply retention periods for a set of files. You can assign a retention period on a folder and then use a file management task to configure how long an assigned retention period is to last. When the files in the folder are about to expire, the owner of the file receives a notification email. You can also classify a file as being on legal hold so that the file management task won't expire the file.

You can find planning information for configuring retention in [Plan for Retention of Information on File Servers](plan-retention-information-file-servers.md).

You can find steps for classifying files for legal hold and configuring a retention period in [Deploy Implementing Retention of Information on File Servers (Demonstration Steps)](Deploy-Implementing-Retention-of-Information-on-File-Servers--Demonstration-Steps-.md).

> [!NOTE]
> That scenario only discusses how to manually classify a document for legal hold. However, it is possible to automatically classify documents for legal hold. One way to do this is to create a Windows PowerShell classifier that compares the file owner to a list of user accounts that are under legal hold. If the file owner is a part of the user account list, the file is classified for legal hold.

## In this scenario

This scenario is part of the Dynamic Access Control scenario. For more information about Dynamic Access Control, see:

- [Dynamic Access Control: Scenario Overview](Dynamic-Access-Control--Scenario-Overview.md)
