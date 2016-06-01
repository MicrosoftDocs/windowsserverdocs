---
title: Configure the Windows Firewall Log
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f6ec31b8-de54-4d7d-8d3c-f843bc516f24
---
# Configure the Windows Firewall Log
To configure Windows Firewall to log dropped packets or successful connections, use the [!INCLUDE[wfas](includes/wfas_md.md)] node in the Group Policy Management MMC snap\-in.

**Administrative credentials**

To complete these procedures, you must be a member of the Domain Administrators group, or otherwise be delegated permissions to modify the GPOs.

In this topic:

[To configure Windows Firewall logging for Windows Vista or Windows Server 2008](#bkmk_ToenableWindowsFirewallandconfigurethedefaultbehavior)

## <a name="bkmk_1"></a>
#### To configure Windows Firewall logging for Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, or Windows Server 2008 R2

1.  [Open the Group Policy Management Console to Windows Firewall with Advanced Security](Open-the-Group-Policy-Management-Console-to-Windows-Firewall-with-Advanced-Security.md).

2.  In the details pane, in the **Overview** section, click **Windows Firewall Properties**.

3.  For each network location type \(Domain, Private, Public\), perform the following steps.

    1.  Click the tab that corresponds to the network location type.

    2.  Under **Logging**, click **Customize**.

    3.  The default path for the log is **%windir%\\system32\\logfiles\\firewall\\pfirewall.log**. If you want to change this, clear the **Not configured** check box and type the path to the new location, or click **Browse** to select a file location.

        > [!IMPORTANT]
        > The location you specify must have permissions assigned that permit the Windows Firewall service to write to the log file.

    4.  The default maximum file size for the log is 4,096 kilobytes \(KB\). If you want to change this, clear the **Not configured** check box, and type in the new size in KB, or use the up and down arrows to select a size. The file will not grow beyond this size; when the limit is reached, old log entries are deleted to make room for the newly created ones.

    5.  No logging occurs until you set one of following two options:

        -   To create a log entry when Windows Firewall drops an incoming network packet, change **Log dropped packets** to **Yes**.

        -   To create a log entry when Windows Firewall allows an inbound connection, change **Log successful connections** to **Yes**.

    6.  Click **OK** twice.


