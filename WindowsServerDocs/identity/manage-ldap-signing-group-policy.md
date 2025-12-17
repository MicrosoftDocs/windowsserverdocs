---
title: Manage LDAP signing using Group Policy
description: Learn how to configure LDAP signing requirements on Windows Server domain controllers using Group Policy to enhance security and prevent unauthorized access.
author: robinharwood
ms.author: roharwoo
ms.service: windows-server
ms.topic: how-to
ms.date: 12/17/2025

#CustomerIntent: As a domain administrator, I want to configure LDAP signing requirements on my domain controllers so that I can protect my Active Directory environment from replay and man-in-the-middle attacks.
---

# Manage LDAP signing using Group Policy

Configuring your domain controllers to require LDAP signing significantly improves the security of your Active Directory environment by rejecting unsigned LDAP binds. This article shows you how to configure LDAP server signing requirements using Group Policy and how to identify clients that need to be updated before enforcing this security requirement.

Unsigned network traffic is susceptible to replay attacks where an intruder intercepts authentication attempts and reuses credentials to impersonate legitimate users. Additionally, unsigned traffic is vulnerable to man-in-the-middle attacks where attackers can modify LDAP requests in transit. Requiring LDAP signing provides integrity verification that prevents these attack vectors.

> [!NOTE]
> Windows Server 2025 and later versions enable LDAP signing by default for new Active Directory deployments. If you're upgrading from earlier versions, existing policies are preserved to prevent disruption. For more information about default security behavior and version differences, see [LDAP signing for Active Directory Domain Services](ad-ds/ldap-signing.md).

## Prerequisites

- An account with Domain administrator privileges or equivalent
- Access to a domain controller or a computer with Active Directory Domain Services (AD DS) Remote Server Administration Tools (RSAT) installed
- Group Policy Management Console installed

## Identify clients using unsigned LDAP binds

Before requiring LDAP signing, you should identify which clients in your environment are currently making unsigned LDAP binds. Active Directory logs summary events to help you discover these clients without disrupting service.

By default, domain controllers log Event ID 2887 once every 24 hours when unsigned binds occur. This event provides summary information about the number of unsigned simple binds and unsigned SASL binds detected.

To get detailed information about specific clients making unsigned binds:

1. Open **Event Viewer** on the domain controller.
1. Navigate to **Applications and Services Logs** > **Directory Service**.
1. Look for Event ID 2887 to see summary information about unsigned binds.

To enable detailed logging that identifies specific client IP addresses:

1. Open **Registry Editor** on the domain controller.
1. Navigate to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics`.
1. Set the **16 LDAP Interface Events** value to **2** (Basic logging).
1. Monitor for Event ID 2889, which logs each unsigned bind attempt including the client IP address and identity.

After identifying all clients that require updates, configure them to request LDAP signing before proceeding to enforce signing requirements on your domain controllers.

## Configure LDAP signing requirements

Configure LDAP signing on both domain controllers and client computers to ensure secure LDAP communications across your environment.

### Client computers

Client computers need to be configured to request LDAP signing when communicating with domain controllers. This can be configured using local policy on individual computers or through a domain Group Policy Object for enterprise-wide deployment. We recommend configuring clients before enforcing signing on domain controllers to prevent service disruptions. You can verify client compliance by repeating the steps in the previous [Identify clients using unsigned LDAP binds](#identify-clients-using-unsigned-ldap-binds) section to check for unsigned bind attempts.

To configure LDAP signing on client computers using Group Policy:

1. Open **Microsoft Management Console** by selecting **Start** > **Run**, typing **mmc.exe**, and selecting **OK**.
1. Select **File** > **Add/Remove Snap-in**.
1. Select **Group Policy Object Editor**, then select **Add**.
1. Select **Browse**, and then select **Default Domain Policy** or your preferred Group Policy Object.
1. Select **OK**, then select **Finish**.
1. Select **Close**, then select **OK**.
1. Navigate to **Default Domain Policy** > **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options**.
1. Right-click **Network security: LDAP client signing requirements**, and select **Properties**.
1. Select one of the following options:
   - **None**: Client doesn't request signing (not recommended)
   - **Negotiate signing**: Client requests signing if server supports it (recommended for gradual deployment)
   - **Require signing**: Client requires signing for all LDAP traffic (recommended for maximum security)
1. Select **OK**.
1. Select **Yes** in the confirmation dialog.

After configuring this setting, client computers will request LDAP signing based on the selected policy. The policy takes effect at the next Group Policy refresh or can be applied immediately using `gpupdate /force`.

### Domain controllers

Domain controllers evaluate the server LDAP signing requirement to determine whether to accept unsigned LDAP binds. This setting is typically configured through the Default Domain Controllers Policy.

To configure LDAP signing on domain controllers:

1. Open **Microsoft Management Console** by selecting **Start** > **Run**, typing **mmc.exe**, and selecting **OK**.
1. Select **File** > **Add/Remove Snap-in**.
1. Select **Group Policy Management Editor**, and then select **Add**.
1. Select **Browse** next to Group Policy Object.
1. In the **Browse for a Group Policy Object** dialog, select **Default Domain Controllers Policy** under your domain, and then select **OK**.
1. Select **Finish**, then select **OK**.
1. Navigate to **Default Domain Controllers Policy** > **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options**.
1. Right-click **Domain controller: LDAP server signing requirements**, and select **Properties**.
1. Enable **Define this policy setting**, then select one of the following options:
   - **None**: Domain controller accepts both signed and unsigned LDAP binds (not recommended)
   - **Require signing**: Domain controller rejects unsigned LDAP binds (recommended)
1. Select **OK**.
1. Select **Yes** in the confirmation dialog.

Group Policy will apply this setting during the next policy refresh cycle. To apply immediately, run `gpupdate /force` on your domain controllers. When set to **Require signing**, domain controllers will reject LDAP simple binds over non-SSL/TLS connections and SASL binds that don't request signing.

## Configure LDAP signing for Active Directory Lightweight Directory Services

For Active Directory Lightweight Directory Services (AD LDS) instances, LDAP signing is configured through a registry setting rather than Group Policy. This allows you to configure signing requirements independently for each AD LDS instance.

To configure LDAP signing for an AD LDS instance:

1. Open **Registry Editor** on the server hosting the AD LDS instance.
1. Navigate to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\<InstanceName>\Parameters`.
1. Create a new **DWORD (32-bit) Value** named **LDAPServerIntegrity**.
1. Set the value to **2** to enable signing requirements.
1. Close Registry Editor.

The setting takes effect immediately without requiring a restart. The LDAPServerIntegrity value accepts the following values:

- **0**: Signing is disabled (default)
- **2**: Signing is required

## Verify LDAP signing configuration

After configuring LDAP signing requirements, you should verify that the configuration is working as expected. You can test this by attempting an unsigned LDAP bind, which should be rejected if signing is properly configured.

To verify LDAP signing is enforced:

1. On a computer with AD DS Admin Tools installed, open **LDP.exe** by selecting **Start** > **Run**, typing **ldp.exe**, and selecting **OK**.
1. Select **Connection** > **Connect**.
1. Type your domain controller name in **Server** and **389** in **Port**, then select **OK**.
1. After the connection is established, select **Connection** > **Bind**.
1. Under **Bind type**, select **Simple bind**.
1. Enter credentials and select **OK**.

If LDAP signing is properly enforced, you should receive an error message: "Ldap_simple_bind_s() failed: Strong Authentication Required." This confirms that the domain controller is rejecting unsigned LDAP binds.

For production validation, monitor Event Viewer for Event ID 2888, which logs a summary every 24 hours showing how many unsigned bind attempts were rejected.
