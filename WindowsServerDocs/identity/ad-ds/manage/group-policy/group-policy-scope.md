---
title: Group Policy scope in Windows
description: Learn about how Group Policy scope defines specific users, computers, and organizational units within an Active Directory environment in Windows.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 06/13/2025
---

# Group Policy scope

Group Policy application determines which Group Policy Objects (GPOs) are applied to users or computers and enforces the corresponding settings. A solid understanding of Group Policy processing is essential for effectively planning and deploying Group Policy configurations. Understanding Group Policy processing begins with the concept of *scope*. Scope defines which GPOs are applicable to a user or computer, determined by their position within Active Directory (AD). You establish scope by linking GPOs to particular sites, domains, or organizational units (OUs) in AD.

## What is a scope?

The scope of a GPO refers to the range of users and computers that the policy settings can be applied to. Understanding the scope helps administrators control where and to whom their policies are applied. Changing the scope of Group Policy objects affects which policy settings apply and those that don't. You change the scope of Group Policy using processing order, filtering, and link options. To determine the scope for a specific user or computer, you can check its distinguished name in AD. The distinguished name uniquely identifies the object and indicates its position within the directory structure. For example:

```
CN=Kim Askers,OU=Human Resources,DC=corp,DC=contoso,DC=com
```

- **CN=Kim Askers**: This part identifies the Common Name (CN) of the object, which is often a person's name if the object represents a user.

- **OU=Human Resources**: This is the OU name, which is a container within the directory. It typically represents a department or group within the organization.

- **DC=corp**: This is a Domain Component, representing part of the domain name.

- **DC=contoso**: Another Domain Component, combined with the others, it builds the domain `contoso.com`.

- **DC=com**: The top-level domain component, in this case, `.com`.

Collectively, these components form a unique path that identifies the object (for example, Kim Askers in the Human Resources OU) within the `corp.contoso.com` domain's directory structure.

## GPO scope types

Effectively managing Group Policy requires a clear understanding of how GPO scope controls the application of policy settings to users and computers. Careful configuration of GPO scope enables administrators to apply policies to specific users and computers, improving security and simplifying management throughout the organization. Understanding these scope types and their interactions is crucial for resolving conflicts and maintaining an efficient organization. Review the following information to learn more about these scope types.

### Linking

Linking refers to the process of associating a GPO with a container object in AD. You can link GPOs to the following types of container objects:

- **Local objects**: Every Windows machine has a local GPO that applies first. Local GPOs are useful for defining policies that should apply regardless of the user's domain membership, especially in situations where a machine isn't connected to a network. However, they have the lowest precedence in an AD environment, meaning that domain-based GPOs can override settings defined locally.

- **Site objects**: Represent physical or logical groupings of computers, potentially spanning multiple domains. These apply after local GPOs. A site in AD represents a physical or logical segment of your network. Site-based GPOs can be used to apply settings to all the computers within a specific geographical location. They aren't used as frequently as domain or OU GPOs, given their broader scope, and potential complexity in configuration.

- **Domain objects**: Encompass all users and computers within a specific domain, including any OUs it contains. These apply after site GPOs. Domain-level GPOs are used to enforce settings across all users and computers within that domain. Since they apply at the domain level, they have more authority compared to site and local policies and can override them.

- **OU objects**: Allow for more granular grouping within a domain, supporting nested OUs, users, and computers. These have the highest level of precedence in the hierarchy of GPO application. They allow for the most granular control, as they can be applied to specific groups of users or computers within the domain. When multiple OUs are nested, the GPOs from the highest-level OUs are applied first, and those from lower-level OUs (closest to the object, whether it’s a user or a computer) are applied last, and thus can override settings from higher-level OUs.

These container objects define the boundaries for GPO application. By linking a GPO to a site, domain, or OU, you control which users and computers within those containers receive the policy settings. You can't link a GPO directly to a user object. However, by concatenating the distinguished name components from left to right, you can trace the sequence of container objects (sites, domains, OUs) that are capable of applying Group Policy to the user. In this example:

```
CN=Kim Askers,OU=Managers,OU=Research,OU=RandD,DC=corp,DC=contoso,DC=com
```

```
OU=Managers,OU=Research,OU=RandD,DC=corp,DC=contoso,DC=com
OU=Research,OU=RandD,DC=corp,DC=contoso,DC=com
OU=RandD,DC=corp,DC=contoso,DC=com
DC=corp,DC=contoso,DC=com
```

Each of these locations represents a level in the AD hierarchy where Group Policy can be applied. The Group Policy service collects all GPOs linked to these containers to determine which policies are in scope for a user or computer. Processing starts with the OU closest to the user or computer and moves up the hierarchy to the domain. This process results in a list of GPOs that could apply to the user or computer. However, not all GPOs in this list is necessarily applied, as additional factors such as filtering and link options might affect their application.

### GPLink attribute

Group Policy linking is possible on AD sites, domains, and OUs because each of these objects contains a GPLink attribute. Although the GPLink attribute is defined in the AD schema as a single-valued string, Group Policy treats it as if it were multivalued. The Group Policy Management Console (GPMC) stores the GPLink attribute using the following format:

```
[distinguishedNameOfGroupPolicyContainer;linkOptions][...][...]
```

The `distinguishedNameOfGroupPolicyContainer` token is the unique name of the Group Policy Container (GPC) in AD. Each GPO has two parts: the Group Policy template (stored on the file system), and the GPC (stored in the domain partition of AD).

The `linkOptions` token is an integer that specifies the link options for the Group Policy object. You can enable or disable a GPO link, and you can also set it as enforced. The `linkOptions` value is a bitmask, allowing combinations of these settings to control how the GPO is applied. For example:

- **Enabled (0x0):** This value means that the GPO link is active and applied normally. When no special options are set, the default state is enabled, which corresponds to a `linkOptions` value of `0x0`.

- **Disabled (0x1):** When the link is disabled, it means that the GPO isn't applied at all, even if it's linked to the container. This corresponds to setting the first bit, with a `linkOptions` value of `0x1`.

- **Enforced (0x2):** When a GPO link is set to **Enforced**, its settings override any conflicting settings from other non-enforced GPOs, regardless of their position in the processing order. In the GPMC, an enforced link is indicated by a padlock icon on the linked policy. Enforced GPO settings always apply, even if policy inheritance is blocked at the organizational unit level.

When you disable the link of a GPO, it stops the Group Policy service from considering that GPO when applying policies to targeted users or computers. GPO links are stored in a sequence where each link is represented by a `distinguishedNameOfGroupPolicyContainer` and `linkOptions`, enclosed in square brackets (`[ ]`) and separated by semicolons (`;`). This sequence is read from left to right by the Group Policy service. When a new GPO is linked, its entry is inserted at the beginning of this sequence, pushing existing entries to the right. This means that the sequence is continually reordered with the most recently linked GPO at the front.

Although the GPOs are read from left to right, they're applied in reverse order, with the last GPO in the sequence (rightmost) being applied first. This reversing process assigns precedence, the first GPO in the sequence has the lowest precedence because it's applied first but can be overridden by any subsequent GPOs. Each following GPO has progressively higher precedence, being able to override those that came before it. Thus, the last GPO in the sequence has the highest precedence, as it can supersede all others if there's any conflict in settings. This order ensures that the latest policies linked are the most dominant.

For example, suppose you have the following GPOs:

- GPO1: `[LDAP://{cn=1111aaa-0000-1111-22bb-333333cccccc},cn=policies;cn=system;DC=corp;DC=contoso;DC=com;0]`
- GPO2: `[LDAP://{cn=2222aaa-0000-1111-22bb-333333cccccc},cn=policies;cn=system;DC=corp;DC=contoso;DC=com;0]`
- GPO3: `[LDAP://{cn=3333aaa-0000-1111-22bb-333333cccccc},cn=policies;cn=system;DC=corp;DC=contoso;DC=com;0]`

The GPLink attribute might look like this:

```
[LDAP://{cn=3333aaa-0000-1111-22bb-333333cccccc},cn=policies;cn=system;DC=corp;DC=contoso;DC=com;0]
[LDAP://{cn=2222aaa-0000-1111-22bb-333333cccccc},cn=policies;cn=system;DC=corp;DC=contoso;DC=com;0]
[LDAP://{cn=1111aaa-0000-1111-22bb-333333cccccc},cn=policies;cn=system;DC=corp;DC=contoso;DC=com;0]
```

The GPLink order might look like this:

- 1st (GPO3): `[LDAP://{cn=3333aaa-0000-1111-22bb-333333cccccc},cn=policies;cn=system;DC=corp;DC=contoso;DC=com;0]`
- 2nd (GPO2): `[LDAP://{cn=2222aaa-0000-1111-22bb-333333cccccc},cn=policies;cn=system;DC=corp;DC=contoso;DC=com;0]`
- 3rd (GPO1): `[LDAP://{cn=1111aaa-0000-1111-22bb-333333cccccc},cn=policies;cn=system;DC=corp;DC=contoso;DC=com;0]`

The application order might look like this:

- 1st (GPO1): `[LDAP://{cn=1111aaa-0000-1111-22bb-333333cccccc},cn=policies;cn=system;DC=corp;DC=contoso;DC=com;0]` (applied last, highest precedence)
- 2nd (GPO2): `[LDAP://{cn=2222aaa-0000-1111-22bb-333333cccccc},cn=policies;cn=system;DC=corp;DC=contoso;DC=com;0]`
- 3rd (GPO3): `[LDAP://{cn=3333aaa-0000-1111-22bb-333333cccccc},cn=policies;cn=system;DC=corp;DC=contoso;DC=com;0]` (applied first, lowest precedence)

### GPO filtering

When you manage Group Policy in AD, security filtering and WMI filtering are essential tools for refining which users and computers a GPO applies to. These filtering mechanisms allow administrators to precisely target GPOs, enabling efficient and flexible policy deployment across various IT environments.

- **Security Filtering**

  Security Filtering in Group Policy is a method to determine which users or computers are allowed to apply a particular GPO. This is based on permissions set within AD. To apply a GPO, both the **Read** and **Apply Group Policy** permissions must be granted to the user or computer. The Group Policy service assesses each GPO to see if the required permissions are present. If a user or computer has the necessary permissions, the GPO is included in the list of applicable GPOs for that user or computer.

- **WMI Filtering**

  Windows Management Instrumentation (WMI) Filtering further refines which GPOs apply by using queries that evaluate certain conditions on the target system. WMI allows administrators to create queries based on system features, operating systems, and other managed components to determine GPO applicability. These queries result in a true or false outcome, influencing whether the GPO remains applicable. If the WMI query result is true, the GPO stays in the filtered list, otherwise it's removed.

In summary, Security Filtering utilizes permission settings to determine GPO applicability, ensuring that only users and computers with the appropriate access rights can apply the policies. Meanwhile, WMI Filtering employs system attributes and conditions through queries to further refine policy targeting. Together, these processes work in tandem to finalize the list of GPOs relevant to a particular user or computer in a single cycle.

## GPO conflict resolution

Each GPO contains various policy settings, and it's common for multiple GPOs to define the same setting, leading to potential conflicts. Consider two employees trying to reserve the same meeting room at the same time—only the last reservation made is honored, overriding the previous one. To manage these conflicts, Group Policy uses a technique called "last-writer-wins". This method resolves conflicts based on the order of application, where the most recently applied GPO takes precedence. The order of application is determined by a hierarchy. First, policies are applied at the Local level, followed by the site, domain, and then OU. Within the same AD location, GPOs are applied according to their link order that's set in the GPMC.

While conflict resolution often addresses settings linked at different AD locations, conflicts can also occur between GPOs linked to the same location. In these cases, Group Policy continues to use the last-writer-wins approach to determine which setting takes precedence. The order in which GPOs are applied at a given AD location is defined by their link order in the GPMC. Understanding how GPOs are linked and ordered in GPMC is key to predicting which settings are enforced when conflicts arise at the same AD location.

