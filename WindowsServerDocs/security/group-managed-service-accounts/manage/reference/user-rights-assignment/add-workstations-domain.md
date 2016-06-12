---
title: Add workstations to domain
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e3554c92-1c65-4ffb-879f-eaba163fa5cf
---
# Add workstations to domain
This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.

## Reference
This policy setting determines which users can add a computer to a specific domain. For it to take effect, it must be assigned so that it applies to at least one domain controller. A user who is assigned this user right can add up to ten workstations to the domain.

Adding a computer account to the domain allows the computer to participate in Active Directory\-based networking.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

Constant: SeMachineAccountPrivilege

### Possible values

-   User\-defined list of accounts

-   Not Defined

### Best practices

1.  Configure this setting so that only authorized members of the IT team are allowed to add computers to the domain.

### Location
**Computer Configuration\\Windows Settings\\Security Settings\\User Rights Assignment\\**

### Default values
By default, this setting allows access for Authenticated Users on domain controllers, and it is not defined on stand\-alone servers.

The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Not Defined|
|Default Domain Controller Policy|Not Defined|
|Stand\-Alone Server Default Settings|Not Defined|
|Domain Controller Effective Default Settings|Authenticated Users|
|Member Server Effective Default Settings|Not Defined|
|Client Computer Effective Default Settings|Not Defined|

### Operating system version differences
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

## Policy management
Users can also join a computer to a domain if they have the Create Computer Objects permission for an organizational unit \(OU\) or for the Computers container in the directory. Users who are assigned this permission can add an unlimited number of computers to the domain regardless of whether they have the **Add workstations to domain** user right.

Furthermore, computer accounts that are created by means of the **Add workstations to domain** user right have Domain Administrators as the owner of the computer account. Computer accounts that are created by means of permissions on the computer’s container use the creator as the owner of the computer account. If a user has permissions on the container and also has the **Add workstation to domain** user right, the computer is added based on the computer container permissions rather than the user right.

A restart of the computer is not required for this policy setting to be effective.

Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.

### Group Policy
Settings are applied in the following order through a Group Policy Object \(GPO\), which will overwrite settings on the local computer at the next Group Policy update:

1.  Local policy settings

2.  Site policy settings

3.  Domain policy settings

4.  OU policy settings

When a local setting is greyed out, it indicates that a GPO currently controls that setting.

## Security considerations
This policy has the following security considerations:

### Vulnerability
The **Add workstations to domain** user right presents a moderate vulnerability. Users with this right could add a computer to the domain that is configured in a way that violates organizational security policies. For example, if your organization does not want its users to have administrative privileges on their computers, users could install Windows on their computers and then add the computers to the domain. The user would know the password for the local administrator account, could log on with that account, and then add a personal domain account to the local Administrators group.

### Countermeasure
Configure this setting so that only authorized members of the IT team are allowed to add computers to the domain.

### Potential impact
For organizations that have never allowed users to set up their own computers and add them to the domain, this countermeasure has no impact. For those that have allowed some or all users to configure their own computers, this countermeasure forces the organization to establish a formal process for these procedures going forward. It does not affect existing computers unless they are removed from and then added to the domain.

## See Also
[User Rights Assignment](user-rights-assignment.md)


