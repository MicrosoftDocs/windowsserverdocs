---
ms.assetid: 155abe09-6360-4913-8dd9-7392d71ea4e6
title: Configuring a Computer for Troubleshooting
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/07/2018
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---
# Configuring a Computer for Troubleshooting

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Before you use advanced troubleshooting techniques to identify and fix Active Directory problems, configure your computers for troubleshooting. You should also have a basic understanding of troubleshooting concepts, procedures, and tools.

For information about monitoring tools for Windows Server, see the Step-by-Step Guide for [Performance and Reliability Monitoring in Windows Server](https://go.microsoft.com/fwlink/?LinkId=123737)

## Configuration tasks for troubleshooting

To configure your computer for troubleshooting Active Directory Domain Services (AD DS), perform the following tasks:

### Install Remote Server Administration Tools for AD DS

When you install AD DS to create a domain controller, the administrative tools that you use to manage AD DS are installed automatically. If you want to manage domain controllers remotely from a computer that is not a domain controller, you can install the Remote Server Administration Tools (RSAT) on a member server or workstation that is running a supported version of Windows. RSAT replaces Windows Support Tools from Windows Server 2003.

For information about installing RSAT, see the article [Remote Server Administration Tools](https://docs.microsoft.com/windows-server/remote/remote-server-administration-tools).

### Configure Reliability and Performance Monitor

Windows Server includes the Windows Reliability and Performance Monitor, which is a Microsoft Management Console (MMC) snap-in that combines the functionality of previous stand-alone tools, including Performance Logs and Alerts, Server Performance Advisor, and System Monitor. This snap-in provides a graphical user interface (GUI) for customizing Data Collector Sets and Event Trace Sessions.

Reliability and Performance Monitor also includes Reliability Monitor, an MMC snap-in that tracks changes to the system and compares them to changes in system stability, providing a graphical view of their relationship.

### Set logging levels

If the information that you receive in the Directory Service log in Event Viewer is not sufficient for troubleshooting, raise the logging levels by using the appropriate registry entry in **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics**.

By default, the logging levels for all entries are set to **0**, which provides the minimum amount of information. The highest logging level is **5**. Increasing the level for an entry causes additional events to be logged in the Directory Service event log.

Use the following procedure to change the logging level for a diagnostic entry. Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure.

> [!WARNING]
> We recommend that you do not directly edit the registry unless there is no other alternative. Modifications to the registry are not validated by the registry editor or by Windows before they are applied, and as a result, incorrect values can be stored. This can result in unrecoverable errors in the system. When possible, use Group Policy or other Windows tools, such as MMC snap-ins, to accomplish tasks, rather than editing the registry directly. If you must edit the registry, use extreme caution.
>

To change the logging level for a diagnostic entry

1. Click **Start** > **Run** > type **regedit** > click **OK**.
2. Navigate to the entry for which you want to set logging in.
   * EXAMPLE: HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesNTDSDiagnostics
3. Double-click the entry, and in **Base**, click **Decimal**.
4. In **Value**, type an integer from **0** through **5**, and then click **OK**.
