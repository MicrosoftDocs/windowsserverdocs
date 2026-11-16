---
title: Windows Admin Center Virtualization Mode RBAC
description: Windows Admin Center Virtualization Mode uses Windows authentication and RBAC. Learn how gateway trust, role scopes, and host permissions control access.
author: davannaw-msft
ms.author: dawhite
ms.topic: concept-article
ms.date: 11/11/2026
ms.custom: sfi-ga-nochange
ai-usage: ai-assisted
---

# Authentication and access control in Windows Admin Center Virtualization Mode

Authentication in Windows Admin Center Virtualization Mode verifies who signs in, and access control determines which resources and actions each user can access. These controls matter when many people use one gateway to manage hundreds of Hyper-V hosts and clusters.

After reading this article, you understand how users authenticate to the Virtualization Mode gateway, how the gateway establishes trust with managed hosts, and how role-based access control (RBAC) determines what each user can do across the resource hierarchy.

> [!IMPORTANT]
> Access to the Virtualization Mode (Virtualization Mode) gateway doesn't replace Windows permissions on your hosts. Many host and virtual machine (VM) operations run as the signed-in user, so users also need administrative rights on the hosts they manage. For details, see [Permissions on managed hosts](#permissions-on-managed-hosts).

## How access works at a glance

Access in Virtualization Mode is checked in three layers:

| Layer | Question it answers | Controlled by |
|---|---|---|
| Gateway authentication | Can this user sign in to the gateway? | Windows authentication against Active Directory, plus the gateway's user and administrator access lists |
| Virtualization Mode RBAC | What can this user do inside Virtualization Mode, and where? | Role assignments on the gateway root, resource groups, clusters, and hosts |
| Host permissions | Can this user's identity run the operation on the target host? | Local Administrators group membership on each managed host |

A user must pass every layer that applies to an action. For example, a user with the Fabric Manager role on a resource group can add a host to that group, but they must also have local administrator rights on the host to complete onboarding.

## How users authenticate to the Windows Admin Center Virtualization Mode gateway

Virtualization Mode uses Windows authentication. Users browse to `https://<gateway-FQDN>:<port>`, where `<gateway-FQDN>` is the gateway's fully qualified domain name, and sign in with their Active Directory account. Depending on browser settings, users on domain-joined clients that already have a Kerberos ticket might sign in automatically.

Virtualization Mode role assignments require a domain-joined gateway. The current role-assignment interface searches for and selects Active Directory users and groups; it doesn't offer local accounts for selection. A local account that can reach the core gateway therefore can't receive a Virtualization Mode enterprise role assignment through the current interface.

Windows Admin Center evaluates group security identifiers (SIDs) in the user's current Windows authentication token. Active Directory group membership changes don't affect authorization until the user obtains a token and Kerberos tickets that contain the updated group SIDs. Signing out of the Windows Admin Center user interface (UI) alone isn't established as sufficient to refresh that Windows authentication state.

The default maximum lifetime for a Kerberos ticket-granting ticket (TGT) in a Windows domain is 10 hours, but domain administrators can configure that policy. This value is an Active Directory and Kerberos setting, not a Windows Admin Center refresh interval.

## How core gateway access and Virtualization Mode enterprise RBAC work together

Core gateway access and Virtualization Mode RBAC are separate authorization systems:

- **Core gateway access** determines who can authenticate to and use the Windows Admin Center gateway. Its default access includes the gateway machine's built-in **Administrators** and **Users** groups.
- **Virtualization Mode RBAC** determines which Virtualization Mode resources and actions an authenticated identity can access. When an identity initializes the database by installing Windows Admin Center Virtualization Mode, Windows Admin Center assigns it the **Global Administrator** role at the gateway root.

Membership in the gateway's Administrators group, the gateway administrators access list, or the Domain Admins group doesn't independently bypass Virtualization Mode RBAC. An identity must match a Virtualization Mode user or group role assignment to access resources. Assign the Global Administrator role to at least one additional recoverable account or group so that enterprise access management doesn't depend on one identity.

## Gateway user and administrator access lists in Virtualization Mode

As in Windows Admin Center Administration Mode, the gateway keeps two access lists in **Settings** > **Access**:

- **Gateway users** can sign in to the gateway.
- **Gateway administrators** can sign in and also change gateway access settings.

These lists control core gateway access; they don't grant a Virtualization Mode role. For Virtualization Mode access, an authenticated Active Directory identity must also match a user or group assignment in Virtualization Mode RBAC.

> [!TIP]
> If a user receives HTTP 403 Forbidden after signing in, check core gateway access first. The gateway's user and administrator access lists are evaluated separately from Virtualization Mode enterprise RBAC, so a Virtualization Mode role assignment alone doesn't grant access through the gateway.

## How the gateway trusts managed hosts

Virtualization Mode doesn't manage hosts through a series of stateless remote PowerShell calls. Instead, it installs a lightweight agent on each managed host when you add the host to a resource group. The gateway and agents communicate over a mutually trusted, encrypted channel.

Certificates establish trust between the gateway and its agents:

- **Self-signed certificates** work well for evaluation because they don't require existing public key infrastructure (PKI).
- Use **Active Directory Certificate Services (AD CS)** for production. You configure a gateway certificate and an agent certificate template once, and Virtualization Mode issues and renews agent certificates in line with your existing PKI policies. To set up AD CS, go to gateway **Settings** and select the **Certificates** tab.

Each host can be managed by only one Virtualization Mode gateway at a time. If a host already has an agent registered with a different gateway, Virtualization Mode blocks onboarding.

> [!NOTE]
> Initial onboarding uses Windows Remote Management (WinRM) to deploy the agent. Ensure the gateway can reach each host over WinRM and that you provide credentials with administrative rights on the host when you add it.

## Virtualization Mode RBAC scopes and inheritance

Virtualization Mode RBAC controls actions such as organizing resources, onboarding hosts, managing templates, and running gateway-level operations. Role assignments inherit from the gateway root to resource groups, clusters, hosts, and their child resources.

Virtualization Mode resources follow a hierarchy:

**Gateway (root)** > **Resource groups** > **Clusters and hosts** > **VMs, storage, and networks**

You can assign roles at any of these scopes:

- **Gateway root:** the role applies to everything the gateway manages.
- **Resource group:** the role applies to every cluster, host, and VM in that group.
- **Cluster:** the role applies to the cluster, its nodes, and the VMs, storage, and networks on it.
- **Host:** the role applies to that standalone host and the VMs, storage, and networks on it.

Role assignments at a higher scope apply to all child resources. You can't assign roles to individual VMs today.

Use resource groups for broad delegation, and use cluster or host assignments when one team owns specific infrastructure inside a larger group. Design your resource groups around how you delegate work. Common patterns include grouping by environment (development, test, production), by site, or by the team that owns the workload. Plan your groups before you onboard hosts.

## Built-in roles in Windows Admin Center Virtualization Mode

Virtualization Mode includes three built-in roles. You can't modify built-in roles or create custom roles.

| Role | Intended for | Summary |
|---|---|---|
| **Global Administrator** | Gateway owners and security administrators | Full control of the gateway, including who has access, resource group structure, certificates, and backup and restore. |
| **Fabric Manager** | Virtualization and infrastructure administrators | Day-to-day fabric management in their assigned scope: add and remove hosts and clusters, manage templates, onboard to Azure Arc, and keep resources healthy. Can't change access, create or delete resource groups, or change gateway-wide settings. |
| **Reader** | Auditors, help desk, stakeholders | View resources and their state in their assigned scope. Can't make Virtualization Mode changes. |

## Permissions for each Virtualization Mode role

The following table lists Virtualization Mode actions and the roles that can perform them.

| Action | Global Administrator | Fabric Manager | Reader |
|---|:-:|:-:|:-:|
| View resources, inventory, and status | ✅ | ✅ | ✅ |
| Assign and remove roles (access control) | ✅ | ❌ | ❌ |
| Create, rename, or delete resource groups | ✅ | ❌ | ❌ |
| Add or remove hosts and clusters in a resource group | ✅ | ✅ | ❌ |
| Create and manage network intent templates | ✅ | ✅ | ❌ |
| Create, deploy, and convert VM templates | ✅ | ✅ | ❌ |
| Onboard resources to Azure Arc | ✅ | ✅ | ❌ |
| Renew agent certificates on managed resources (resource health) | ✅ | ✅ | ❌ |
| Configure gateway and agent certificate settings (AD CS) | ✅ | ❌ | ❌ |
| Re-establish trust with a host after restore | ✅ | ❌ | ❌ |
| Back up and restore the Virtualization Mode environment | ✅ | ❌ | ❌ |

Only users who hold the Global Administrator role can see the **Certificates** settings page.

## Assign Virtualization Mode roles to Active Directory users and groups

Only Global Administrators can assign roles. A role assignment associates a built-in role and a scope with an Active Directory user or group. You must join the gateway to the domain, and the current **Access** interface selects Active Directory users and groups rather than local accounts.

1. Sign in to the Virtualization Mode gateway as a Global Administrator.
1. In the resource pane, select the gateway root, resource group, cluster, or host you want to delegate.
1. Open the **Access** tool.
1. Select **Add role assignment**.
1. Choose the role, then search for and select the Active Directory user or group.
1. Select **Save**.

The selected scope determines which resources inherit the assignment.

When a user holds more than one assignment, their effective access is the combination of all of them. For example, a user with Reader at the gateway root and Fabric Manager on the `Production` resource group can view everything but make changes only in `Production`.

Assign roles to Active Directory security groups rather than individual users. It's easier to audit, and onboarding or offboarding a person becomes a group membership change instead of a Virtualization Mode change.

## Permissions on managed hosts

Virtualization Mode RBAC decides which actions a user can start. It doesn't replace Windows permissions on the hosts themselves:

- **Operations run as the signed-in user.** When a user opens a host or VM tool, such as **Virtual machines**, the tool connects to the host by using that user's Windows identity.
- **The signed-in user must be a local administrator on each host they manage.** Users who aren't local administrators on the host see repeated credential prompts, even if they hold Global Administrator in Virtualization Mode. Adding a user to **Hyper-V Administrators** alone doesn't grant the required host permissions.
- **Virtualization Mode roles don't restrict host-level tools.** A user with the Reader role can't perform Virtualization Mode-specific actions, such as adding resources or managing templates. However, if that user is a local administrator on a host, host-level tools, such as creating a VM in the **Virtual machines** tool, still work, because Windows authorizes those actions. To keep a user read-only, don't grant them administrator rights on the hosts.

Treat local administrator membership on managed hosts as part of your access model. Review it alongside your Virtualization Mode role assignments.

## Recommended access control practices for Virtualization Mode

- **Start least-privileged.** Give most users Reader or Fabric Manager on the specific resource groups, clusters, or hosts they need. Keep Global Administrator to a small group of gateway owners.
- **Always keep at least two Global Administrators**, ideally through a group, so you don't lose access if one account becomes unavailable.
- **Use AD CS for certificates in production.** For details, see [Manage certificates in Windows Admin Center Virtualization Mode](manage-virtualization-mode-certificates.md).
- **Use groups everywhere.** Use security groups for gateway access lists, Virtualization Mode role assignments, and host local administrator membership.

## Troubleshoot Windows Admin Center Virtualization Mode access

| Symptom | Likely cause | What to do |
|---|---|---|
| HTTP 403 Forbidden after sign-in | Core gateway access denies the account before Virtualization Mode enterprise RBAC is evaluated. | Verify the gateway's user and administrator access lists in **Settings** > **Access**. |
| The enterprise resource list is empty | The authenticated caller has no mapped enterprise identity or matching role assignment. | Verify that an Active Directory user or group SID in the caller's current Windows token matches an enterprise role assignment. |
| A direct link to an enterprise object returns HTTP 404 Not Found | The object doesn't exist, or enterprise RBAC doesn't allow the caller to access it. | Verify the role assignment at the object or an inherited scope. |
| Repeated credential prompts when opening a host or VM | The signed-in user isn't a local administrator on the host. | Add the user or their group to the host's local Administrators group. |
| A user can't see a resource group, cluster, or host | The user has no role assignment on that resource or on a scope above it. | Assign a role on the resource or a scope above it. |
| A role or group change doesn't take effect | The current Windows authentication token or Kerberos tickets still contain the previous group SIDs. | Refresh the user's Windows authentication token and tickets, such as by signing out of Windows and signing back in. Signing out only from the Windows Admin Center UI might not refresh them. |
| Certificates settings aren't visible | Only Global Administrators can view the page. | Sign in as a Global Administrator. |

To gather more detail, capture a browser HTTP Archive (HAR) file while you reproduce the issue and check Event Viewer on the gateway for Windows Admin Center events.

## Next steps

- [What is Windows Admin Center Virtualization Mode?](virtualization-mode-overview.md)
- [Install Windows Admin Center Virtualization Mode](install-virtualization-mode.md)
- [Add resources to Windows Admin Center Virtualization Mode](add-virtualization-mode-resources.md)
- [Windows Admin Center Virtualization Mode known issues](virtualization-mode-known-issues.md)
- [User access options with Windows Admin Center](plan/user-access-options.md)
