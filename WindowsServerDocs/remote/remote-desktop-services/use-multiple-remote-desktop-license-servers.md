---
title: Use multiple Remote Desktop license servers
description: Learn how to use multiple Remote Desktop (RD) license servers so that they communicate with one another.
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 9/9/2024
---

# Use multiple Remote Desktop license servers

When using multiple Remote Desktop (RD) license servers, after applying the security update for [CVE-2024-38231](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2024-38231), ensure that the servers can properly communicate with one another. It's important that RD license servers can communicate with one another in either of the following scenarios:

- A license is returned to an RD license server that didn't issue it
- Automatic license server discovery, a mechanism that was abandoned starting with Windows Server 2008 R2, is still in use in a Remote Desktop deployment

## Workgroup-joined deployment

Workgroup-joined Remote Desktop deployments are meant for small deployments. We don't recommend using multiple RD license servers in workgroup-joined Remote Desktop deployments. 

> [!IMPORTANT]
> Support for multiple license servers in workgroups may be removed in a future version of Windows.

To use multiple RD license servers in the same workgroup, ensure that each license server can authenticate to one another, and that they recognize each other as license servers.

### Ensure license servers are authenticated

As an example, let’s consider two license servers called LICSVR1 and LICSVR2.

To ensure that LICSVR1 can authenticate to LICSVR2, you need to decide which account LICSVR1 uses to connect to LICSVR2. We recommend creating a dedicated user account on LICSVR2 with the following steps:

1. Connect to LICSVR2 using an administrator account. If doing so remotely, you may need to start the **Remote Desktop Connection** application using the _mstsc.exe /admin_ command if the target machine can't contact an RD license server.

1. Once connected, right-click **Start**, then select **Run**, and enter **lusrmgr.msc**. Then press **ENTER**.

1. Select **Users** in the left pane.

1. Open the **Action** menu and select **New User…**.

1. Choose a username and a unique strong password for the user. Then confirm the password.

1. Uncheck the "User must change password at next logon" checkbox.

1. Select **Create**.

Then, on LICSVR1, add the user and its credentials so that the _NT AUTHORITY\NETWORK SERVICE_ account can authenticate to LICSVR2 with the following steps:

1. Connect to LICSVR1. If doing so remotely, you may need to start the Remote Desktop Connection application using the _mstsc.exe /admin_ command if the target machine can't contact an RD license server.

1. Start a Command Prompt as _NT AUTHORITY\NETWORK SERVICE_. You can do this with PsExec from the Sysinternals Utilities, by running the following command as an administrator:

    ```bash
    psexec.exe -i -u "NT AUTHORITY\NETWORK SERVICE" cmd.exe
    ```

1. Then, add a username and password to the host computer with the following command:

    ```bash
    cmdkey /add:LICSVR2 /user:LICSVR2\<USERNAME> /pass
    ```

   where \<USERNAME> is the name of the user you decided that LICSVR1 uses to authenticate to LICSVR2.

1. When prompted for the password, enter the password of that user.

LICSVR1 should now be able to authenticate to LICSVR2. For LICSVR2 to recognize LICSVR1 as another license server, you need to add the user to a local group on LICSV2 and register that local group with the RD licensing service. In PowerShell running as administrator on LICSVR2, use the following command:

```powershell
New-LocalGroup -Name <GROUP-NAME> 
Add-LocalGroupMember -Group <GROUP-NAME> -Member "LICSVR2\<USERNAME>"
```

Where \<GROUP-NAME> is the desired name for the group and \<USERNAME> is the name of the user whose credentials are registered in LICSVR1.

To register that local group with the RD licensing service in the registry, run the following PowerShell command:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\TermServLicensing\Parameters" -Name " WorkgroupLicenseServerAccountsGroup" -Value "LICSVR2\<GROUP-NAME>" -Type String
```

## Domain-joined deployment

For domain-joined RD license servers to properly communicate with one another, they need to know that communication is coming from another RD license server. This can be achieved using one of the three manners described in this section.

- A domain administrator can publish each RD license server to Active Directory Domain Services (AD DS) using the [PublishLS WMI method of the Win32_TSLicenseServer class](/windows/win32/termserv/publishls-win32-tslicenseserver). This creates a site-level record in AD DS that can be used to authorize communication between RD license servers. In PowerShell as a domain administrator on a license server, run the command:

    ```powershell
    Invoke-WmiMethod -Class Win32_TSLicenseServer -Name PublishLS
    ```

- Alternatively, each RD license server can be configured to authorize communication from a particular set of RD license servers by configuring the **Use the specified Remote Desktop license servers** group policy. That group policy is described in more detail in [License Remote Desktop session hosts](/windows-server/remote/remote-desktop-services/rds-license-session-hosts#configure-licensing-for-an-rds-deployment-that-includes-only-the-rd-session-host-role-and-the-rd-licensing-role). Or the following registry value can be set to specify license servers. In PowerShell as an administrator on an RD license server, run the command:

    ```powershell
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\TermServLicensing\Parameters" -Name " SpecifiedLicenseServers" -Value "<LicSrv1DnsHostName>","<LicSrv2DnsHostName>" -Type MultiString
    ```

    Where \<LicSrv1DnsHostName> and \<LicSrv1DnsHostName> are the DNS host names of the other RD license servers. 

- For historical reasons, RD licensing services that run on Active Directory domain controllers don't require extra configuration.

> [!IMPORTANT]
> We strongly advise against installing the RD licensing server on domain controllers. Use this approach at your own risk. Per the Active Directory security best practices, domain controllers should be treated as critical infrastructure components and should minimize the amount of unrelated software they run. For more information, se [Protecting Domain Controllers](/windows-server/identity/ad-ds/plan/security-best-practices/avenues-to-compromise#protecting-domain-controllers).
