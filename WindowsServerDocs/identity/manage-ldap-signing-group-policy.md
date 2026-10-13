---
title: Configure LDAP Signing by Using Group Policy
description: Learn how to configure LDAP signing requirements on Windows Server domain controllers by using Group Policy to enhance security and prevent unauthorized access.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 10/02/2026
ai-usage: ai-assisted
#CustomerIntent: As a domain administrator, I want to configure LDAP signing requirements on my domain controllers so that I can protect my Active Directory environment from replay and man-in-the-middle attacks.
---

# Configure LDAP signing by using Group Policy for Active Directory Domain Services

Configuring your domain controllers to require LDAP signing improves the security of your Active Directory environment by rejecting unsigned LDAP binds. This article shows you how to configure LDAP server signing requirements by using Group Policy and how to identify clients that you need to update before enforcing this security requirement.

Unsigned network traffic is susceptible to replay attacks where an intruder intercepts authentication attempts and reuses credentials to impersonate legitimate users. Also, unsigned traffic is vulnerable to man-in-the-middle attacks where attackers can modify LDAP requests in transit. Requiring LDAP signing verifies integrity and prevents these attack vectors.

> [!NOTE]
> Windows Server 2025 or later requires LDAP signing by default for new Active Directory deployments. During an upgrade, Windows Server preserves existing signing policies to prevent disruption; if no LDAP server signing policy exists, Windows Server 2025 requires signing by default. For more information about default security behavior and version differences, see [LDAP signing for Active Directory Domain Services](ad-ds/ldap-signing.md).

## Prerequisites

- An account with permission to edit the applicable Group Policy Objects and modify registry settings on the target server. Use just-in-time elevation if your organization grants these permissions through Domain Admins.
- Access to a domain controller or a computer with Active Directory Domain Services (AD DS) Remote Server Administration Tools (RSAT) installed
- Group Policy Management Console installed

## Identify clients that use unsigned LDAP binds

Before you require LDAP signing, identify which clients in your environment are currently making unsigned LDAP binds. Active Directory logs summary events to help you discover these clients without disrupting service.

On domain controllers that permit unsigned binds, `Event ID 2887` logs a 24-hour summary when unsigned binds occur. On domain controllers that require signing, `Event ID 2888` summarizes rejected unsigned binds.

To get detailed information about specific clients making unsigned binds:

1. Open **Event Viewer** on the domain controller.
1. Go to **Applications and Services Logs** > **Directory Service**.
1. In the event list, locate `Event ID 2887` for summary information about unsigned binds.

To enable detailed logging that identifies specific client IP addresses:

1. Open **Registry Editor** on the domain controller.
1. Go to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics`.
1. Set the **16 LDAP Interface Events** value to **2** (Basic logging).
1. Monitor for `Event ID 2889`, which logs each unsigned bind attempt, including the client IP address and identity.
1. After the investigation, set **16 LDAP Interface Events** back to **0** to disable detailed logging.

**Note:** The eventlog and registry path names have the LDS instance name for LDS servers.

After you identify all clients that need updates, configure them to request LDAP signing before you enforce signing requirements on your domain controllers.

## Configure LDAP signing requirements

Configure LDAP signing on both servers (domain controllers and LDS servers) and client computers to ensure secure LDAP communications across your environment.

### Client computers

Configure client computers to request LDAP signing when they communicate with domain controllers. Set up this configuration by using local policy on individual computers or through a domain Group Policy Object for enterprise-wide deployment. To prevent service disruptions, configure clients before you enforce signing on domain controllers. Verify client compliance by repeating the steps in the previous [Identify clients that use unsigned LDAP binds](#identify-clients-that-use-unsigned-ldap-binds) section to check for unsigned bind attempts.

> [!NOTE]
> All currently supported versions of Windows client use LDAP signing by default as LDAP clients. Manually configure this setting to set a specific signing level or ensure that legacy systems comply with your security requirements.

To configure LDAP signing on client computers by using Group Policy:

1. Open **Microsoft Management Console** by selecting **Start** > **Run**, typing **mmc.exe**, and selecting **OK**.
1. Select **File** > **Add/Remove Snap-in**.
1. Select **Group Policy Object Editor**, and then select **Add**.
1. Select **Browse**, and then select **Default Domain Policy** or your preferred Group Policy Object.
1. Select **OK**, and then select **Finish**.
1. Select **Close**, and then select **OK**.
1. Navigate to **Default Domain Policy** > **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options**.
1. Open the context menu for **Network security: LDAP client signing requirements**, and then select **Properties**.
1. Select one of the following options:
   - **None**: The client doesn't request signing (not recommended)
   - **Negotiate signing**: The client requests signing if the server supports it (recommended for gradual deployment)
   - **Require signing**: The client requires signing for all LDAP traffic (recommended for maximum security)
1. Select **OK**.
1. Select **Yes** in the confirmation dialog.

After you configure this setting, client computers request LDAP signing based on the selected policy. The policy takes effect at the next Group Policy refresh. To apply it immediately, run [gpupdate](/windows-server/administration/windows-commands/gpupdate) with the `/force` option.

### Domain controllers

Domain controllers check the server LDAP signing requirement to decide whether they accept unsigned LDAP binds. You usually set this requirement through the Default Domain Controllers Policy. Select the operating system version that matches your domain controllers to see the appropriate configuration steps.

#### [Windows Server 2025](#tab/windows-server-2025)

New Active Directory deployments on Windows Server 2025 or later require LDAP signing by default. The **Domain controller: LDAP server signing requirements enforcement** Group Policy setting configures this default, which is separate from the **Domain controller: LDAP server signing requirements** policy.

The **Domain controller: LDAP server signing requirements enforcement** policy takes precedence over the **Domain controller: LDAP server signing requirements** policy. When you configure both policies, the enforcement policy setting applies. This configuration ensures that new deployments automatically have stronger security defaults while allowing administrators to explicitly modify the behavior if needed.

To configure LDAP signing enforcement on Windows Server 2025:

1. Open **Microsoft Management Console** by selecting **Start** > **Run**, typing **mmc.exe**, and selecting **OK**.
1. Select **File** > **Add/Remove Snap-in**.
1. Select **Group Policy Management Editor**, and then select **Add**.
1. Select **Browse** next to Group Policy Object.
1. In the **Browse for a Group Policy Object** dialog, select **Default Domain Controllers Policy** under your domain, and then select **OK**.
1. Select **Finish**, and then select **OK**.
1. Go to **Default Domain Controllers Policy** > **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options**.
1. Open the context menu for **Domain controller: LDAP server signing requirements enforcement**, and then select **Properties**.
1. Turn on **Define this policy setting**, and choose one of the following options:
   - **Default:** **Not Configured**, which has the same effect as **Enabled** (default for new deployments).
   - **Enabled:** The enforcement policy requires LDAP signing regardless of the **Domain controller: LDAP server signing requirements** policy.
   - **Disabled:** The **Domain controller: LDAP server signing requirements** policy determines the LDAP signing requirement.
1. Select **OK**.
1. Select **Yes** in the confirmation dialog.

> [!IMPORTANT]
> If you're upgrading from an earlier version of Windows Server to Windows Server 2025, Windows Server preserves existing LDAP signing policies to prevent disruption. Review your current policy settings and update them as appropriate for your security requirements.

#### [Windows Server 2022 or earlier](#tab/windows-server-2022)

To set up LDAP signing on domain controllers:

1. Open **Microsoft Management Console** by selecting **Start** > **Run**, typing **mmc.exe**, and selecting **OK**.
1. Select **File** > **Add/Remove Snap-in**.
1. Select **Group Policy Management Editor**, and then select **Add**.
1. Select **Browse** next to Group Policy Object.
1. In the **Browse for a Group Policy Object** dialog, select **Default Domain Controllers Policy** under your domain, and then select **OK**.
1. Select **Finish**, and then select **OK**.
1. Go to **Default Domain Controllers Policy** > **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options**.
1. Open the context menu for **Domain controller: LDAP server signing requirements**, and then select **Properties**.
1. Turn on **Define this policy setting**, and choose one of the following options:
   - **None**: A domain controller accepts both signed and unsigned LDAP binds (not recommended)
   - **Require signing**: A domain controller rejects unsigned LDAP binds (recommended)
1. Select **OK**.
1. Select **Yes** in the confirmation dialog.

---

Group Policy applies this setting during the next policy refresh cycle. To apply it immediately, run `gpupdate /force` on your domain controllers. When set to **Require signing**, domain controllers reject LDAP simple binds over non-SSL/TLS connections and SASL binds that don't request signing.

## Configure LDAP signing for Active Directory Lightweight Directory Services

For Active Directory Lightweight Directory Services (AD LDS) instances, configure LDAP signing through a registry setting instead of Group Policy. Use this method to set signing requirements independently for each AD LDS instance.

To configure LDAP signing for an AD LDS instance:

1. Open **Registry Editor** on the server hosting the AD LDS instance.
1. Go to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\<InstanceName>\Parameters`.
1. Create a new **DWORD (32-bit) Value** named `LDAPServerIntegrity`.
1. Set the value to **2** to enable signing requirements.
1. Close **Registry Editor**.

The setting takes effect immediately without a restart. The `LDAPServerIntegrity` value accepts the following values:

- **0**: Disables signing (default).
- **2**: Requires signing.

To configure LDAP signing enforcement for an AD LDS instance:

1. Open **Registry Editor** on the server hosting the AD LDS instance.
1. Go to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\<InstanceName>\Parameters`.
1. Create a new **DWORD (32-bit) Value** named **LDAPServerEnforceIntegrity**.
1. Set the value to **1** to enable signing requirements.
1. Close **Registry Editor**.

The setting takes effect immediately without needing a restart. The **LDAPServerIntegrity** value accepts the following values:

- **0**: Signing behavior follows registry entry LDAPServerIntegrity
- **1**: Signing is required (default)

## Verify LDAP signing configuration

After you configure LDAP signing requirements, verify that the configuration works as expected. Test the configuration by attempting an unsigned LDAP bind. If the LDAP signing policy requires signing, the domain controller rejects the bind.

Verify LDAP signing enforcement:

> [!WARNING]
> This test sends simple-bind credentials without TLS. Run it only in an isolated lab, use a nonprivileged disposable test account, and never enter production credentials.

1. On a computer with AD DS Admin Tools, open **LDP.exe** by selecting **Start** > **Run**, typing **ldp.exe**, and selecting **OK**.
1. Select **Connection** > **Connect**.
1. Type your domain controller name in **Server** and **389** in **Port**, and then select **OK**.
1. After you connect, select **Connection** > **Bind**.
1. Under **Bind type**, select **Simple bind**.
1. Enter credentials and select **OK**.

If the domain controller enforces the LDAP signing requirement, you receive an error message: "Ldap_simple_bind_s() failed: Strong Authentication Required." This error confirms that the domain controller rejects unsigned LDAP binds.

For production validation, monitor Event Viewer for Event ID `2888`. This event logs a summary every 24 hours showing how many unsigned bind attempts the domain controller rejected.
