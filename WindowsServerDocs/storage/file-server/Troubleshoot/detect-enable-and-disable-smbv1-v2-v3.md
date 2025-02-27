---
title: Turn SMBv1, SMBv2, and SMBv3 on or off in Windows
description: See various ways to detect, turn on, and turn off the Server Message Block (SMB) protocol (SMBv1, SMBv2, and SMBv3) in Windows client and server environments.
author: Deland-Han
manager: dcscontentpm
ms.topic: how-to
ms.author: delhan
ms.date: 02/26/2025
---

# Detect, turn on, and turn off SMBv1, SMBv2, and SMBv3 in Windows

This article describes how to turn on and turn off Server Message Block (SMB) version 1 (SMBv1), SMB version 2 (SMBv2), and SMB version 3 (SMBv3) on SMB client and server components.

If you turn off or remove SMBv1, you might encounter compatibility issues with old computers or software. But SMBv1 has significant security vulnerabilities, and [we strongly encourage you not to use it](https://techcommunity.microsoft.com/t5/storage-at-microsoft/stop-using-smb1/ba-p/425858). [SMBv1 isn't installed by default](/windows-server/storage/file-server/troubleshoot/smbv1-not-installed-by-default-in-windows) in any edition of Windows 11 or Windows Server 2019 and later versions. SMBv1 also isn't installed by default in Windows 10, except Home and Pro editions. We recommend that instead of reinstalling SMBv1, you update the SMB server that still requires it. For a list of third parties that require SMBv1 and their updates that remove the requirement, see [SMB1 Product Clearinghouse](https://aka.ms/stillneedssmb1).

## Turn off SMBv2 or SMBv3 for troubleshooting

We recommend keeping SMBv2 and SMBv3 turned on, but you might find it useful to turn one off temporarily for troubleshooting. For more information, see [How to detect status, enable, and disable SMB protocols on the SMB Server](detect-enable-and-disable-smbv1-v2-v3.md#how-to-detect-status-enable-and-disable-smb-protocols).

In Windows 10, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012, turning off SMBv3 deactivates the following functionality:

- Transparent failover: Provides clients with a way to reconnect without interruption to cluster nodes during maintenance or failover
- Scale-out: Supplies concurrent access to shared data on all file cluster nodes
- SMB Multichannel: Facilitates aggregation of network bandwidth and fault tolerance if multiple paths are available between the client and server
- SMB Direct: Adds remote direct memory access (RDMA) networking support for high performance, with low latency and low CPU use
- Encryption: Provides end-to-end encryption and offers protection from eavesdropping on untrustworthy networks
- Directory leasing: Improves application response times in branch offices through caching
- Performance optimization: Optimizes small random read/write I/O operations

In Windows 7 and Windows Server 2008 R2, turning off SMBv2 deactivates the following functionality:

- Request compounding - allows for sending multiple SMBv2 requests as a single network request
- Larger reads and writes - better use of faster networks
- Caching of folder and file properties - clients keep local copies of folders and files
- Durable handles - allow for connection to transparently reconnect to the server if there's a temporary disconnection
- Improved message signing - HMAC SHA-256 replaces MD5 as hashing algorithm
- Improved scalability for file sharing - number of users, shares, and open files per server greatly increased
- Support for symbolic links
- Client oplock leasing model - limits the data transferred between the client and server, improving performance on high-latency networks and increasing SMB server scalability
- Large MTU support - for full use of 10 Gigabit Ethernet (GbE)
- Improved energy efficiency - clients that have open files to a server can sleep

The SMBv2 protocol was introduced in Windows Vista and Windows Server 2008. The SMBv3 protocol was introduced in Windows 8 and Windows Server 2012. For more information about SMBv2 and SMBv3 capabilities, see the following articles:

- [Server Message Block overview](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831795(v=ws.11))
- [What's New in SMB](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/ff625695(v=ws.10))

## Use PowerShell to remove SMBv1

You can use the following PowerShell commands to detect, turn off, and turn on an SMBv1 client or server. Run the commands as a user that has elevated privileges.

> [!NOTE]
> The computer restarts after you run the PowerShell commands to turn off or turn on SMBv1.

- Detect:

  ```powershell
  Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
  ```

- Turn off:

  ```powershell
  Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
  ```

- Turn on:

  ```powershell
  Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
  ```

> [!TIP]
> As a user without elevated privileges, you can detect the SMBv1 status by running the following command: `Get-SmbServerConfiguration | Format-List EnableSMB1Protocol`.

### Use Server Manager to remove SMBv1

On the following versions of Windows Server, you can use Server Manager to remove SMBv1: Windows Server 2012, Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019.

To remove SMBv1 from these versions, take the following steps:

1. On the server that you want to remove SMBv1 from, open Server Manager.

1. On the Server Manager Dashboard, under **Configure this local server**, select **Add roles and features**.

1. On the **Before you begin** page, select **Start the Remove Roles and Features Wizard**, and then on the following page, select **Next**.

1. On the **Select destination server** page, under **Server Pool**, ensure that the server you want to remove the feature from is selected, and then select **Next**.

1. On the **Remove server roles** page, select **Next**.

1. On the **Remove features** page, clear the checkbox for **SMB 1.0/CIFS File Sharing Support**, and then select **Next**.

   ![Server Manager - Dashboard method](media/detect-enable-and-disable-smbv1-v2-v3-1.png)

1. On the **Confirm removal selections** page, confirm that the feature is listed, and then select **Remove**.

### Use Remove Programs to turn off SMBv1

On Windows 8.1, Windows 10, and Windows 11, you can use Remove Programs to turn off SMBv1.

To turn off SMBv1 on these operating systems, take the following steps:

1. In **Control Panel**, select **Programs and Features**.

1. Under **Control Panel Home**, select **Turn Windows features on or off** to open the **Windows Features** dialog.

1. In the **Windows Features** dialog, scroll down the list, clear the checkbox for **SMB 1.0/CIFS File Sharing Support**, and then select **OK**.

   ![Add-Remove Programs client method](media/detect-enable-and-disable-smbv1-v2-v3-2.png)

1. After Windows applies the change, on the confirmation page, select **Restart now**.

## Use the command line or Registry Editor to manage SMB protocols

You can use the command line or Registry Editor to detect the status of SMB protocols and to turn those protocols on or off.

> [!NOTE]
> When you turn SMBv2 on or off in Windows 8 or Windows Server 2012, SMBv3 is also turned on or off. This behavior occurs because these protocols share the same stack.

# [Server](#tab/server)

You can use the **Set-SMBServerConfiguration** cmdlet to turn on or turn off the SMBv1, SMBv2, and SMBv3 protocols on a server component.

You don't have to restart the computer after you run the **Set-SMBServerConfiguration** cmdlet.

### SMBv1

- Detect:

  ```powershell
  Get-SmbServerConfiguration | Select EnableSMB1Protocol
  ```

- Turn off:

  ```powershell
  Set-SmbServerConfiguration -EnableSMB1Protocol $false
  ```

- Turn on:

  ```powershell
  Set-SmbServerConfiguration -EnableSMB1Protocol $true
  ```

For more information, see [Server storage at Microsoft](https://techcommunity.microsoft.com/t5/Storage-at-Microsoft/Stop-using-SMB1/ba-p/425858).

### SMBv2 and SMBv3

- Detect:

  ```powershell
  Get-SmbServerConfiguration | Select EnableSMB2Protocol
  ```

- Turn off:

  ```powershell
  Set-SmbServerConfiguration -EnableSMB2Protocol $false
  ```

- Turn on:

  ```powershell
  Set-SmbServerConfiguration -EnableSMB2Protocol $true
  ```

### Turn SMB on or off on Windows 7, Windows Server 2008 R2, Windows Vista, and Windows Server 2008

To turn SMB protocols on or off on an SMB Server that runs Windows 7, Windows Server 2008 R2, Windows Vista, or Windows Server 2008, use Windows PowerShell or Registry Editor, as explained in the following sections.

#### Use Windows PowerShell

> [!NOTE]
> The commands in the following sections require PowerShell 2.0 or later.

##### SMBv1 on an SMB server

Detect:

```powershell
Get-Item HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters | ForEach-Object {Get-ItemProperty $_.pspath}
```

The default configuration is `Enabled`. As a result, no registry named value is created, so the command doesn't return an SMB1 value.

Turn off:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" SMB1 -Type DWORD -Value 0 -Force
```

Turn on:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" SMB1 -Type DWORD -Value 1 -Force
```

> [!NOTE]
> You must restart the computer after you make these changes.

For more information, see [Server storage at Microsoft](https://techcommunity.microsoft.com/t5/storage-at-microsoft/stop-using-smb1/ba-p/425858).

##### SMBv2 and SMBv3 on an SMB server

Detect:

```powershell
Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters | ForEach-Object {Get-ItemProperty $_.pspath}
```

Disable:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" SMB2 -Type DWORD -Value 0 -Force
```

Enable:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" SMB2 -Type DWORD -Value 1 -Force
```

> [!NOTE]
> You must restart the computer after you make these changes.

#### Use Registry Editor

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To turn SMBv1 on or off on an SMB server, open Registry Editor and go to the following registry key path:

**HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters**

Configure an entry that has the following properties:

- For the name, use **SMB2**.
- For the type, use **REG_DWORD**.
- For the data, use **0** for **Disabled** and **1** for **Enabled**. The default value is **1**, or **Enabled**. In this case, no registry key is created.

To turn SMBv2 on or off on an SMB server, open Registry Editor and go to the following registry key path:

**HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters**

Configure an entry that has the following properties:

- For the name, use **SMB1**.
- For the type, use **REG_DWORD**.
- For the data, use **0** for **Disabled** and **1** for **Enabled**. The default value is **1**, or **Enabled**. In this case, no registry key is created.

> [!NOTE]
> You must restart the computer after you make these changes.

# [Client](#tab/client)

On certain SMB clients, you can use the `sc.exe` command-line tool to detect the status of SMB protocols and to turn those protocols on or off. Specifically, you can use this tool on clients that run any of the following operating systems: Windows 10, Windows Server 2019, Windows 8.1, Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012.

### SMBv1 on an SMB client

- Detect:

  ```cmd
  sc.exe qc lanmanworkstation
  ```

- Turn off:

  ```cmd
  sc.exe config lanmanworkstation depend= bowser/mrxsmb20/nsi
  sc.exe config mrxsmb10 start= disabled
  ```

- Turn on:

  ```cmd
  sc.exe config lanmanworkstation depend= bowser/mrxsmb10/mrxsmb20/nsi
  sc.exe config mrxsmb10 start= auto
  ```

For more information, see [Server storage at Microsoft](https://techcommunity.microsoft.com/t5/storage-at-microsoft/stop-using-smb1/ba-p/425858)

### SMBv2 and SMBv3 on an SMB client

- Detect:

  ```cmd
  sc.exe qc lanmanworkstation
  ```

- Turn off:

  ```cmd
  sc.exe config lanmanworkstation depend= bowser/mrxsmb10/nsi
  sc.exe config mrxsmb20 start= disabled
  ```

- Turn on:

  ```cmd
  sc.exe config lanmanworkstation depend= bowser/mrxsmb10/mrxsmb20/nsi
  sc.exe config mrxsmb20 start= auto
  ```

> [!NOTE]
>
> - You must run these commands as a user that has elevated privileges.
> - You must restart the computer after you make these changes.

---

## Use Group Policy to turn off SMBv1

This section shows you how to use Group Policy to turn off SMBv1. You can use this method on various versions of Windows.

# [Server](#tab/server)

### SMBv1

You can turn off SMBv1 on an SMB server by configuring the following new item in the registry:

- Key path: **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters**
- Registry entry: **SMB1**
- Entry type: **REG_DWORD**
- Entry data: **0**, for **Disabled**

To use Group Policy to configure this item, take the following steps:

1. Open Group Policy Management Console. Right-click the Group Policy object (GPO) that should contain the new preference item, and then select **Edit**.

1. In the console tree under **Computer Configuration**, expand the **Preferences** folder, and then expand the **Windows Settings** folder.

1. Right-click the **Registry** node, point to **New**, and then select **Registry Item**.

   ![Registry - New - Registry Item](media/detect-enable-and-disable-smbv1-v2-v3-3.png)

In the **New Registry Properties** dialog, select or enter the following values:

- **Action**: **Create**
- **Hive**: **HKEY_LOCAL_MACHINE**
- **Key Path**: **SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters**
- **Value name**: **SMB1**
- **Value type**: **REG_DWORD**
- **Value data**: **0**

![New Registry Properties - General](media/detect-enable-and-disable-smbv1-v2-v3-4.png)

This procedure turns off the SMBv1 server components. You must apply this policy to all necessary workstations, servers, and domain controllers in the domain.

> [!NOTE]
> You can set Windows Management Instrumentation (WMI) filters to exclude specific operating systems or to exclude client or server operating systems. For more information, see [Group Policy Filtering](../../../identity/ad-ds/manage/group-policy/group-policy-processing.md#group-policy-filtering) and [Create WMI Filters for the GPO](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc947846(v=ws.10)).

> [!IMPORTANT]
> Some systems require access to the SYSVOL folder or other file shares but don't support SMBv2 or SMBv3. Examples of such systems include legacy Windows systems and older Linux and third-party systems. Be careful when you turn off SMBv1 on domain controllers on these systems.

# [Client](#tab/client)

### SMB v1

To turn off the SMBv1 client, you need to update the services registry key to prevent the start of **MRxSMB10**. Then you need to remove the dependency on **MRxSMB10** from the entry for **LanmanWorkstation** so that it can start normally without requiring **MRxSMB10** to first start.

This section shows you how to update and replace the default values in the following two items in the registry:

- Key path: **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\mrxsmb10**
  - Registry entry: **Start**
  - Entry type: **REG_DWORD**
  - Entry data: **4**, for **Disabled**
- Key path: **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation**
  - Registry entry: **DependOnService**
  - Entry type: REG_MULTI_SZ
  - Entry data: **"Bowser","MRxSmb20″,"NSI"**

> [!NOTE]
> The default value includes **MRxSMB10**, which is now removed as dependency.

To configure this entry by using Group Policy, take the following steps:

1. Open Group Policy Management Console. Right-click the GPO that should contain the new preference item, and then select **Edit**.

1. In the console tree under **Computer Configuration**, expand the **Preferences** folder, and then expand the **Windows Settings** folder.

1. Right-click the **Registry** node, point to **New**, and then select **Registry Item**.

1. In the **New Registry Properties** dialog, select or enter the following values:

   - **Action**: **Update**
   - **Hive**: **HKEY_LOCAL_MACHINE**
   - **Key Path**: **SYSTEM\CurrentControlSet\services\mrxsmb10**
   - **Value name**: **Start**
   - **Value type**: **REG_DWORD**
   - **Value data**: **4**

   ![Start Properties - General](media/detect-enable-and-disable-smbv1-v2-v3-5.png)

1. To remove the dependency on the **MRxSMB10** that was turned off, go to the **New Registry Properties** dialog, and then select or enter the following values:

   - **Action**: **Replace**
   - **Hive**: **HKEY_LOCAL_MACHINE**
   - **Key Path**: **SYSTEM\CurrentControlSet\Services\LanmanWorkstation**
   - **Value name**: **DependOnService**
   - **Value type**: **REG_MULTI_SZ**
   - **Value data**:
      - Bowser
      - MRxSmb20
      - NSI

   > [!NOTE]
   > Don't include bullet points in the three **Value data** strings. List only the strings, as shown in the following screen shot.

   ![DependOnService Properties](media/detect-enable-and-disable-smbv1-v2-v3-6.png)

   The default value includes **MRxSMB10** in many versions of Windows. By replacing the default value with these three strings, you effectively remove **MRxSMB10** as a dependency for **LanmanWorkstation**. Instead of the four default values, you have these three values.

   > [!NOTE]
   > When you use Group Policy Management Console, you don't have to use quotation marks or commas. Just type each entry on individual lines.

1. Restart the targeted systems to finish turning off SMBv1.

---

### Audit SMBv1 usage

To determine which clients are attempting to connect to an SMB server by using SMBv1, you can turn on auditing on Windows Server 2016, Windows 10, Windows 11, Windows Server 2019, Windows Server 2022, and Windows Server 2025.

- Enable:

  ```powershell
  Set-SmbServerConfiguration -AuditSmb1Access $true
  ```

- Disable:

  ```powershell
  Set-SmbServerConfiguration -AuditSmb1Access $false
  ```

- Detect:

  ```powershell
  Get-SmbServerConfiguration | Select AuditSmb1Access
  ```

After you turn on SMBv1 auditing, you can check the `Microsoft-Windows-SMBServer\Audit` event log for access events. Each time a client attempts to use SMBv1 to connect, an entry that has an event ID of 3000 appears in the log.

### Check Group Policy settings

If all the settings are in the same GPO, Group Policy Management displays the following settings:

![Group Policy Management Editor - Registry](media/detect-enable-and-disable-smbv1-v2-v3-7.png)

### Test and validate the policy

After you complete the configuration steps in Group Policy Management Console, allow the policy time to be replicated and updated. If needed for testing, run `gpupdate /force` at a command prompt, and then review the target computers to make sure that the registry settings are applied correctly. Make sure SMBv2 and SMBv3 are functioning for all other systems in the environment.

> [!NOTE]
> After you test the policy, restart the target systems.
