---
title: Configure SMB authentication rate limiter for Windows
description: Learn how SMB authentication rate limiter works and how to configure it for Windows Server and Windows client.
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 10/25/2024

---

# Configure SMB authentication rate limiter for Windows

SMB authentication rate limiter is a feature of SMB server for Windows Server and Windows client designed to address brute force authentication attacks. Bruce force authentication attacks bombard the SMB server with multiple username and password-guess attempts per second. Beginning with Windows Server 2025 and Windows 11, version 24H2, SMB authentication rate limiter is enabled by default. The default delay between each failed NTLM or PKU2U-based authentication attempt is 2 seconds and can be configured. In this article. Learn how SMB authentication rate limiter works and how to configure it.

If an administrator allows access to the SMB server service through the Windows Firewall in order to open or copy remote files, a bad actor can use SMB access as a way to attempt authentication. Knowing a username, an attacker can send local or Active Directory based NTLM logons to a machine using several methods. Password guess frequency can range from dozens to thousands of sign-in attempts per second. To learn more about NTLM, see [NTLM Overview](../../security/kerberos/ntlm-overview.md).

If your organization has no intrusion detection software or doesn't set a password lockout policy, an attacker can guess a user's password. Although the SMB server runs by default across all versions of Windows, it's not accessible by default unless the firewall rule is allowed. An end user who turns off firewall and joins a device to an unsafe network faces a similar problem.

## How SMB authentication rate limiter works

The SMB server service uses the authentication rate limiter to implement a 2-second delay between each failed NTLM or PKU2U-based authentication attempt. Meaning if an attacker previously sent 300 brute force attempts per second from a client for 5 minutes (90,000 passwords), the same number of attempts would now take 50 hours or more. As with similar defense-in-depth techniques, the purpose of SMB authentication rate limiter is to make a Windows machine an unattractive a target by increasing the cost of the attack.

## Prerequisites

Before you can configure SMB authentication rate limiter, you need:

- An SMB server running on one of the following operating systems.
  - Windows Server 2025.
  - Windows 11, version 24H2, or later.
- Administrative privileges to the computer.
- If you're using Group Policy on a domain, you need privileges to create or edit a Group Policy object (GPO) and link it to the appropriate organizational unit (OU).

## Configure SMB authentication rate limiter

Using SMB authentication rate limiter you can set a delay between failed authentication attempts. You can also enable or disable the SMB rate limiter manually in PowerShell or using Group Policy. To enable SMB authentication rate limiter, follow the steps.

# [PowerShell](#tab/powershell)

Here's how to configure SMB authentication rate limiter using the [SmbServerConfiguration](/powershell/module/smbshare/set-smbserverconfiguration) cmdlet in PowerShell.

1. Open a PowerShell window as an administrator.

1. Determine the number of milliseconds you want to delay between each failed NTLM or PKU2U-based authentication attempt. The default value is 2000 milliseconds (2 second). Your value must be a multiple of 100 with an allowed range 0-10000.

1. Run the following command to enable SMB authentication rate limiter.

   ```powershell
    Set-SmbServerConfiguration -InvalidAuthenticationDelayTimeInMs <Milliseconds>
    ```

>[!NOTE]
> Setting the variable to 0 disables SMB authentication rate limiter.

To see the current value, run the following command:

```powershell
Get-SmbServerConfiguration | Format-List -Property InvalidAuthenticationDelayTimeInMs
```

# [Group Policy](#tab/group-policy)

Here's how to enabled and disable SMB authentication rate limiter using Group Policy for domain joined machines.

To configure SMB authentication rate limiter using Group Policy, follow these steps.

1. Open the **Group Policy Management Console**.
1. Edit or create a Group Policy Object (GPO) that you want to use.
1. In the console tree, select **Computer Configuration > Administrative Templates > Network > Lanman Server**.
1. For the setting, right-click **Enable authentication rate limiter** and select **Edit**.
1. Select **Enabled** and select **OK**.

Here's an example of the enabled Group Policy item.

:::image type="content" source="media/configure-smb-authentication-rate-limiter/enable-authentication-rate-limiter-group-policy.png" alt-text="Screenshot showing the Enable authentication rate limiter Group Policy setting.":::

> [!TIP]
> To set the invalid authentication delay time, you need to use PowerShell.

---

SMB authentication rate limiter doesn't affect Kerberos; Kerberos authenticates before an application protocol like SMB connects. SMB authentication rate limiter is designed to be another layer of defense in depth, especially for devices not joined to domains.

## Related content

- [SMB Authentication Rate Limiter in Insider builds](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-authentication-rate-limiter-in-insider-builds/ba-p/2829090)

