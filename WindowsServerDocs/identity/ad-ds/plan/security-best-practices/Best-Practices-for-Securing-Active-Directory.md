---
description: "Learn more about: Best Practices for Securing Active Directory"
ms.assetid: e2651dc8-4b31-4cd8-a400-3b8123890210
title: Best Practices for Securing Active Directory
author: iainfoulds
ms.author: daveba
manager: daveba
ms.date: 10/11/2023
ms.topic: article
---

# Best Practices for Securing Active Directory

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Attacks against computing infrastructure have increased over the last decade in all parts of the world. We live in an age of cyber-warfare, cybercrime, and hacktivism. As a result, organizations of all sizes all over the world have had to deal with information leaks, theft of intellectual property (IP), denial-of-service (DDoS) attacks, or even destroyed infrastructure.

However, as the threat landscape has changed over the years, the security landscape has also adapted to counter these threats. While no organization with an information technology (IT) infrastructure is ever perfectly immune to attack, the ultimate goal of security isn't preventing attack attempts altogether, but protecting the IT infrastructure from attacks. With the right policies, processes, and controls, you can protect key parts of your IT infrastructure from compromise.

In this article, we describe the most common types of vulnerabilities we've observed in Active Directory (AD) deployments. Next, we arm you with recommendations for how to protect these weak points from compromises. We designed these recommendations based on the expertise of our Microsoft IT (MSIT) and Microsoft Information Security and Risk Management (ISRM) organizations. We also show you steps you can take to reduce how much vulnerable infrastructure, or attack surface, on your AD is exposed to the outside world. We also include suggestions for how to recover vital data and infrastructure function if there's a security compromise.

## Common security vulnerabilities

In order to learn how to best protect your infrastructure, you first need to understand where attacks are most likely to strike and how they work. This article only covers general recommendations, but if you want to go into more detail, we've included links to more thorough articles.

Now, let's look at the most common security vulnerabilities.

### Common entry points

Initial breach targets, or entry points, are areas where attackers can most easily enter your IT infrastructure. Entry points are usually gaps in security or updates that attackers can exploit to gain access to a system within your infrastructure. Attackers usually start with one or two systems at a time, then escalate their attack as they spread their influence across more systems undetected.

The most common vulnerabilities are:

- Gaps in antivirus and antimalware deployments

- Incomplete patching

- Outdated applications and operating systems

- Misconfiguration

- Lack of secure application development practices

### Credential theft

Credential theft attacks are when an attacker gains privileged access to a computer on a network by using tools to extract credentials from sessions of accounts that are currently signed in. Attackers often go for specific accounts that already have elevated privileges. The attacker steals the credentials of this account to mimic its identity to gain access to the system.

Credential thieves usually target these kinds of accounts:

- Permanently privileged accounts

- VIP accounts

- Privilege-attached Active Directory accounts

- Domain controllers

- Other infrastructure services that affect identity, access, and configuration management, such as public key infrastructure (PKI) servers or systems management servers

Users with highly privileged accounts raise the risk of having their credentials stolen by engaging in the following behaviors:

- Signing into their privileged accounts on unsecured computers

- Browsing the internet while signed in to a privileged account

You should also avoid poor and risky configurations to protect the credential security of your system, such as:

- Configuring local privileged accounts with the same credentials across all systems.

- Assigning too many users to privileged domain groups, encouraging overuse.

- Insufficiently managing domain controller security.

For more information about vulnerable accounts, see [Attractive accounts for credential theft](Attractive-Accounts-for-Credential-Theft.md).

## Reduce Active Directory attack surface

You can prevent attacks by reducing the *attack surface* on your Active Directory deployment. In other words, you make your deployment safer by closing up gaps in security that we mentioned in the previous section.

### Avoid granting excessive privileges

Credential theft attacks depend on admins granting certain accounts excessive privileges. You can prevent these attacks is to do the following things:

- Remember there are three built-in groups that have the highest privileges in Active Directory by default: Enterprise Admins, Domain Admins, and Administrators. Make sure you take steps to protect those three groups, along with any other groups your organization gave elevated privileges to.

- Implement a least-privilege administrative model. Don't use highly privileged accounts for everyday administrative tasks if you can avoid it. Also, make sure your admin accounts only have the baseline privileges required to do their jobs, with no extra privileges they don't need. Avoid giving excessive privileges to user accounts that don't need them. Make sure you don't accidentally give an account the same privileges across systems unless they absolutely need them.

- Check the following areas of your infrastructure to make sure you aren't granting excessive privileges to user accounts:
  
  - Active Directory

  - Member servers

  - Workstations

  - Applications

  - Data repositories

For more information, see [Implementing least-privilege administrative models](Implementing-Least-Privilege-Administrative-Models.md).

### Use secure administrative hosts

Secure administrative hosts are computers configured to support administration for Active Directories and other connected systems. These hosts don't run nonadministrative software like email applications, web browsers, or productivity software like Microsoft Office.

When configuring a secure administrative host, you must follow these general principles:

- Never administer a trusted system from a less-trusted host.

- Require multifactor authentication when using privileged accounts or doing administrative tasks.

- Physical security for your administrative hosts is as important as system and network security.

For more information, see [Implementing secure administrative hosts](Implementing-Secure-Administrative-Hosts.md).

### Keep your domain controllers secure

If an attacker gains privileged access to a domain controller, they can modify, corrupt, and destroy the AD database. An attack on the domain controller potentially threatens all AD-managed systems and accounts within your organization. Therefore, it's important you take the following measures to keep your domain controllers safe:

- Keep your domain controllers physically secure within their datacenters, branch offices, and remote locations.

- Become familiar with your domain controller operating system.

- Configure your domain controllers with built-in and freely available configuration tools to make security configuration baselines you can enforce with group policy objects (GPOs).

For more information, see [Securing domain controllers against attack](Securing-Domain-Controllers-Against-Attack.md).

## Monitor Active Directory for signs of attack or compromise

Another way you can keep your AD deployment secure is to monitor it for signs of malicious attacks or security compromises. You can use legacy audit categories and audit policy subcategories, or use Advanced Audit Policy. For more information, see [Audit Policy Recommendations](Audit-Policy-Recommendations.md).

## Plan for security compromises

While you can protect your AD from outside attacks, no defense is ever truly perfect. It's important that in addition to taking preventative measures that you also plan for worst-case scenarios. When planning for security breaches, you should follow the guidelines in [Planning for compromise](Planning-for-Compromise.md), particularly the section [Rethinking the approach](Planning-for-Compromise.md#rethinking-the-approach), You should also read [Maintaining a more secure environment](Maintaining-a-More-Secure-Environment.md).

Here's a brief summary of things you should do when planning for security compromises, as described in more detail in [Maintaining a more secure environment](Maintaining-a-More-Secure-Environment.md):

- Maintain a more secure environment

- Create business-centric security practices for AD

- Assign business ownership to AD data

- Implement business-driven lifecycle management

- Classify all AD data as systems, applications, or users

To continue reading more detail about these practices, see [Maintaining a more secure environment](Maintaining-a-More-Secure-Environment.md).

## Security measure summary table

The following table summarizes the recommendations listed in this article, listed in order of priority. The ones closer to the bottom of the table are the ones you and your organization should prioritize when setting up your Active Directory. However, you're also free to adjust the priority order and how you implement each measure based on your organization's unique needs.

Each measure is also categorized based on whether it's tactical, strategic, preventative, or detective. *Tactical* measures focus on specific components of AD and any related infrastructure. *Strategic* measures are more comprehensive and therefore require more planning to implement. *Preventative* measures prevent attacks from bad actors. *Detective* measures help you detect security breaches as they happen, before they can spread to other systems.

| Security measure | Tactical or Strategic | Preventative or Detective |
|--|--|--|
| Patch applications. | Tactical | Preventative |
| Patch operating systems. | Tactical | Preventative |
| Deploy and promptly update antivirus and antimalware software across all systems and monitor for attempts to remove or disable it. | Tactical | Both |
| Monitor sensitive Active Directory objects for modification attempts and Windows for events that might indicate attempted compromise. | Tactical | Detective |
| Protect and monitor accounts for users who have access to sensitive data | Tactical | Both |
| Prevent powerful accounts from being used on unauthorized systems. | Tactical | Preventative |
| Eliminate permanent membership in highly privileged groups. | Tactical | Preventative |
| Implement controls to grant temporary membership in privileged groups when needed. | Tactical | Preventative |
| Implement secure administrative hosts. | Tactical | Preventative |
| Use application allowlists on domain controllers, administrative hosts, and other sensitive systems. | Tactical | Preventative |
| Identify critical assets, and prioritize their security and monitoring. | Tactical | Both |
| Implement least-privilege, role-based access controls for administration of the directory, its supporting infrastructure, and domain-joined systems. | Strategic | Preventative |
| Isolate legacy systems and applications. | Tactical | Preventative |
| Decommission legacy systems and applications. | Strategic | Preventative |
| Implement secure development lifecycle programs for custom applications. | Strategic | Preventative |
| Implement configuration management, review compliance regularly, and evaluate settings with each new hardware or software version. | Strategic | Preventative |
| Migrate critical assets to pristine forests with stringent security and monitoring requirements. | Strategic | Both |
| Simplify security for end users. | Strategic | Preventative |
| Use host-based firewalls to control and secure communications. | Tactical | Preventative |
| Patch devices. | Tactical | Preventative |
| Implement business-centric lifecycle management for IT assets. | Strategic | N/A |
| Create or update incident recovery plans. | Strategic | N/A |

## Related content

- [Avenues to Compromise](../../../ad-ds/plan/security-best-practices/Avenues-to-Compromise.md)

- [Attractive Accounts for Credential Theft](../../../ad-ds/plan/security-best-practices/Attractive-Accounts-for-Credential-Theft.md)

- [Reducing the Active Directory Attack Surface](../../../ad-ds/plan/security-best-practices/Reducing-the-Active-Directory-Attack-Surface.md)

- [Implementing Least-Privilege Administrative Models](../../../ad-ds/plan/security-best-practices/Implementing-Least-Privilege-Administrative-Models.md)

- [Implementing Secure Administrative Hosts](../../../ad-ds/plan/security-best-practices/Implementing-Secure-Administrative-Hosts.md)

- [Securing Domain Controllers Against Attack](../../../ad-ds/plan/security-best-practices/Securing-Domain-Controllers-Against-Attack.md)

- [Monitoring Active Directory for Signs of Compromise](../../../ad-ds/plan/security-best-practices/Monitoring-Active-Directory-for-Signs-of-Compromise.md)

- [Audit Policy Recommendations](../../../ad-ds/plan/security-best-practices/Audit-Policy-Recommendations.md)

- [Planning for Compromise](../../../ad-ds/plan/security-best-practices/Planning-for-Compromise.md)

- [Maintaining a More Secure Environment](../../../ad-ds/plan/security-best-practices/Maintaining-a-More-Secure-Environment.md)

- [Appendices](../../../ad-ds/plan/security-best-practices/Appendices.md)
