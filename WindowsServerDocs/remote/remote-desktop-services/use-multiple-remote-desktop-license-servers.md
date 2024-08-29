---
title: Use multiple remote desktop license servers
description: Learn how to use multiple remote desktop license servers so that they communicate with one another.
ms.topic: article
ms.assetid: 80d82d30-3ad0-4a8c-9a9b-2773c47eee19
author: robinharwood
ms.author: wscontent
ms.date: 7/3/2024
manager: dongill
---

# Use multiple remote desktop license servers

When using multiple RD license servers, after applying the security update for CVE-2024-38231, one should ensure that they can properly communicate with one another. This is particularly relevant in either of the following scenarios:

- A license is returned to an RD license server that did not issue it
- Automatic license server discovery, a mechanism which was abandoned starting with Windows Server 2008 R2, is still in use in a Remote Desktop deployment

## Workgroup-joined deployment

Workgroup-joined Remote Desktop deployments are meant for small deployments. We do not recommend using multiple RD license servers in workgroup-joined Remote Desktop deployments. Support for multiple license servers in workgroups may be removed in a future version of Windows.

To use multiple RD license servers in the same workgroup, you need to ensure that each license server can authenticate to one another, and that they recognize each other as being license servers.

For the purpose of illustrating this configuration, let’s consider two license servers called LICSVR1 and LICSVR2.

To ensure that LICSVR1 can authenticate to LICSVR2, you need to decide which account LICSVR1 will use to connect to LICSVR2. For this purpose, we recommend creating a dedicated user account on LICSVR2:

1. Connect to LICSVR2 using an administrator account. If doing so remotely, you may need to start the **Remote Desktop Connection** application using the mstsc.exe /admin command if the target machine can't contact an RD license server.

1. Once connected, right-click **Start**, then select **Run**, and enter **lusrmgr.msc**. Then press **ENTER**.

1. Select **Users** in the left pane.

1. Open the **Action** menu and select **New User…**.

1. Choose a username and a unique strong password for the user. Then confirm the password.

1. Uncheck the "User must change password at next logon" checkbox.

1. Select **Create**.

Then, on LICSVR1, add the user and its credentials so they can be used by the NT AUTHORITY\NETWORK SERVICE account to authenticate to LICSVR2:

1. Connect to LICSVR1. If doing so remotely, you may need to start the Remote Desktop Connection application using the mstsc.exe /admin command if the target machine can't contact an RD license server.

1. Start a Command Prompt as NT AUTHORITY\NETWORK SERVICE. You can do this with PsExec from the Sysinternals Utilities, by running the following command as an administrator:

    ```ps
    psexec.exe -i -u "NT AUTHORITY\NETWORK SERVICE" cmd.exe
    ```

1. Then, add a username and password to the host computer with the following command:

    ```ps
    cmdkey /add:LICSVR2 /user:LICSVR2\<USERNAME> /pass
    ```

   where <USERNAME> is the name of the user you decided that LICSVR1 will use to authenticate to LICSVR2.

1. When prompted for the password, enter the password of that user.

LICSVR1 should now be able to authenticate to LICSVR2. Now, to ensure that LICSVR2 recognize LICSVR1 as being another license server, you’ll then need to add the user to a local group on LICSV2 and register that local group with the RD licensing service. In PowerShell running as administrator on LICSVR2, this can be achieved as follows:

```powershell
New-LocalGroup -Name <GROUP-NAME> 
Add-LocalGroupMember -Group <GROUP-NAME> -Member "LICSVR2\<USERNAME>"
```

where <GROUP-NAME> is the desired name for the group and <USERNAME> is the name of the user whose credentials are registered in LICSVR1.

To register that local group with the RD licensing service in the registry, the following PowerShell command can be used:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\TermServLicensing\Parameters" -Name " WorkgroupLicenseServerAccountsGroup" -Value "LICSVR2\<GROUP-NAME>" -Type String
```

## Domain-joined deployment

For domain-joined RD license servers to properly communicate with one another, they need to be able to recognize that a communication is coming from another RD license server. This can be achieved using one of the three manners described below.

- A domain administrator can publish each RD license server to Active Directory Domain Services (AD DS) using the PublishLS WMI method of the Win32_TSLicenseServer class. This will create a site-level record in AD DS that can be used to authorize communication between RD license servers. In PowerShell running as a domain administrator on a license server, this can be achieved by running:

    ```powershell
    Invoke-WmiMethod -Class Win32_TSLicenseServer -Name PublishLS
    ```

- Alternatively, each RD license server can be configured to authorize communication from a particular set of RD license servers by configuring the Use the specified Remote Desktop license servers group policy described in License Remote Desktop session hosts | Microsoft Learn or configuring the following registry value. In PowerShell running as administrator on a RD license server, this can be achieved by running:

    ```powershell
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\TermServLicensing\Parameters" -Name " SpecifiedLicenseServers" -Value "<LicSrv1DnsHosName>","<LicSrv2DnsHosName>" -Type MultiString
    ```

where <LicSrv1DnsHosName> and <LicSrv1DnsHosName> are the DNS host name of the other RD license servers.

- For historical reasons, RD licensing services running on Active Directory domain controllers do not require additional configuration. We strongly advise against installing the RD licensing server on domain controllers. Use this approach at your own risk. Per the Active Directory security best practices, domain controllers should be treated as critical infrastructure components and should minimize the amount of unrelated software they run. See Protecting Domain Controllers for more information.
