---
title: Name Resolution Policy Table
description: Learn about the role of the Name Resolution Policy Table in a DNSSEC deployment
author: orin-thomas
ms.author: orthomas
ms.topic: conceptual
ms.date: 04/20/2025
ms.custom: template-how-to, team=cloud_advocates #Required; leave this attribute/value as-is.
# Customer intent: As a DNS administrator, I want to understand the Name Resolution Policy Table in a DNSSEC deployment.
---

# The NRPT

The Name Resolution Policy Table (NRPT) in Windows Server enables you to enforce name resolution policies on security-aware DNS clients. The NRPT contains rules that you can configure to specify DNS settings or special behavior for names or namespaces. The NRPT can be configured using the Group Policy Management Editor under **Computer Configuration\\Policies\\Windows Settings\\Name Resolution Policy**, or with PowerShell. 

When the DNS Client service performs DNS name resolution, it checks the NRPT before it sends a DNS query. If a DNS query matches an entry in the NRPT, it's handled according to settings in the policy. Queries that don't match an NRPT entry are processed normally. You can use the NRPT to require that DNSSEC validation is performed on DNS responses for queries in the namespaces that you specify.

The following table shows the options that you can use to configure the namespace to which a policy applies.

| Option          | Usage                                                                                                                                                                                                 |
|-----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Suffix**      | The policy applies to any name that ends in *`.contoso.com`*. This includes child domains.                                                                                                            |
| **Prefix**      | The policy applies only to a host name. This policy is triggered only if the host name portion of a DNS query matches the flat name that is configured here. For example, an entry of *`server1`* applies to both *`server1.contoso.com`* and *`server1.nwtraders.com`*. |
| **FQDN**        | The policy applies only to the specified host. This fully qualified domain name (FQDN) isn't the FQDN of a domain, but an FQDN of a host computer.                                                  |
| **Subnet (IPv4)** | This option configures a policy, which applies to reverse IPv4 lookup queries.                                                                                                                       |
| **Subnet (IPv6)** | This option configures a policy, which applies to reverse IPv6 lookup queries.                                                                                                                       |
| **Any**         | This option configures the default policy.                                                                                                                                                           |


> [!NOTE]
> The NRPT can be used to create different types of rules by choosing one of four available tabs. This topic only discusses rules configured using the <STRONG>DNSSEC</STRONG> tab, that apply to a DNSSEC deployment.

## NRPT rule processing

NRPT rules can be configured in a local, site, domain, or organizational unit (OU)-linked Group Policy Object (GPO). Normal Group Policy processing rules apply. NRPT rules are processed in the following order:

1.  Local GPO
1.  Site-linked GPOs
1.  Domain-linked GPOs
1.  Organizational unit-linked GPOs

If NRPT rules are present in multiple GPOs that apply to the same user or computer, the rules are merged, with more discrete rules taking precedence over more general rules. For example, a rule that applies to a child namespace takes precedence over a rule for the parent namespace, as shown in the following table.

| GPO name             | Namespace            | DNSSEC-enabled | Validation required |
|----------------------|----------------------|----------------|---------------------|
| Default domain policy | contoso.com          | √              | X                   |
| NRPT_settings         | secure.contoso.com   | √              | √                   |

In this example, DNSSEC validation is required for DNS queries that have a suffix of secure.contoso.com, for example, `www.secure.contoso.com`. This includes queries in a child domain, for example, `www.corp.secure.contoso.com`. However, validation isn't required for \*.contoso.com or \*.corp.contoso.com. Therefore, if parent and child domains require a different name resolution policy, you must explicitly create policies for the child namespace.

> [!WARNING]
> NRPT rules don't overwrite each other. If two rules are created in two different GPOs that apply to the same namespace for the same user or computer, a conflict occurs, and neither rule is applied. If the rules apply to the same user or computer for different namespaces, they're merged. This rule doesn't apply to local Group Policy, however. If any NRPT settings are configured in domain Group Policy, then all local Group Policy NRPT settings are ignored.

The NRPT can be configured to require or not require validation for specific segments of your namespace. For example, you might use a conditional forwarder to disable DNSSEC validation. Using this design, you can implement a conditional forwarder that directs client computers to an external, unsigned domain for a specific namespace, such as an FQDN. If the forwarded name is within a signed namespace in your organization, validation might be required unless you specifically disable it for that FQDN.

For example, assume that you have signed an internal domain, contoso.com and you also have an external website `www.contoso.com` that isn't signed. In this scenario, the internal and external domains use different authoritative servers. A conditional forwarder is used to resolve the name `www.contoso.com`. The NRPT can be configured as follows to ensure client computers are able to reach the external website without requiring DNSSEC validation:

| Name               | Conditional forwarder | DNSSEC-enabled | Validation required |
|--------------------|-----------------------|----------------|---------------------|
| contoso.com        | none                  | √              | √                   |
| `www.contoso.com`  | 208.84.0.53           | X              | X                   |

In this example, other names within the contoso.com namespace, such as finance.contoso.com, will still require validation because they don't match the NRPT FQDN rule for `www.contoso.com`.

## Filter NRPT policy

By default, new domain-linked Group Policy Objects (GPOs) apply to the Authenticated Users group. You can apply NRPT policy to selected groups, users, and computers by removing the Authenticated Users group from **Security Filtering** and then adding a custom user, group, or computer. 

## View NRPT policy

You can use the [Get-DnsClientNrptPolicy](/powershell/module/dnsclient/get-dnsclientnrptpolicy) cmdlet to view NRPT policies. See the following example.

```
PS C:\> Get-DnsClientNrptPolicy -Effective

Namespace                        : .contoso.com
QueryPolicy                      : QueryIPv6Only
SecureNameQueryFallback          : FallbackPrivate
DirectAccessIPsecCARestriction   :
DirectAccessProxyName            :
DirectAccessDnsServers           :
DirectAccessEnabled              : False
DirectAccessProxyType            :
DirectAccessQueryIPsecEncryption :
DirectAccessQueryIPsecRequired   :
NameServers                      :
DnsSecIPsecCARestriction         :
DnsSecQueryIPsecEncryption       :
DnsSecQueryIPsecRequired         : False
DnsSecValidationRequired         : False
NameEncoding                     :

Namespace                        : .secure.contoso.com
QueryPolicy                      : QueryIPv6Only
SecureNameQueryFallback          : FallbackPrivate
DirectAccessIPsecCARestriction   :
DirectAccessProxyName            :
DirectAccessDnsServers           :
DirectAccessEnabled              : False
DirectAccessProxyType            :
DirectAccessQueryIPsecEncryption :
DirectAccessQueryIPsecRequired   :
NameServers                      :
DnsSecIPsecCARestriction         :
DnsSecQueryIPsecEncryption       :
DnsSecQueryIPsecRequired         : False
DnsSecValidationRequired         : True
NameEncoding                     :
```

The **Get-DnsClientNrptPolicy** cmdlet gets policy that applies to the local computer. In this example, the output indicates that DNSSEC validation is required for \*.secure.contoso.com, and isn't required for \*.contoso.com.

## Procedure: Configure the NRPT

Use the following procedures to configure the Name Resolution Policy Table (NRPT). The examples that are provided demonstrate how to add a rule in an existing Group Policy Object (GPO) that requires DNSSEC validation for a namespace (zone).

### Configure the NRPT with the Group Policy Management Console

Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. 

1.  On a computer with the Group Policy Management feature installed, select **Tools** on the Server Manager menu, and then select **Group Policy Management**.
1.  In the Group Policy Management Console tree, navigate to **Forest: contoso.com\\Domains\\contoso.com\\Group Policy Objects**.
1.  Right-click the Group Policy Object (GPO) that you wish to configure, and then select **Edit**.
1.  In the Group Policy Management Editor tree, navigate to **Computer Configuration\\Policies\\Windows Settings\\Name Resolution Policy**.
1.  Under **Create Rules**, choose the part of the namespace to which the rule applies from the drop-down list. For example, choose **Suffix** to create a rule that applies to all names that end in the text that you provide.
1.  Next to the drop-down list item, for example, **Suffix**, type the namespace to which the rule applies. For example, to apply a rule to all devices in the *secure.contoso.com* zone, choose **Suffix** and type **secure.contoso.com**.
1.  On the **DNSSEC** tab, select the **Enable DNSSEC in this rule** check box, and then select the **Require DNS clients to check that name and address data has been validated by the DNS server** check box.
1.  At the bottom of this section of the NRPT, select **Create**.
1.  Under **Name Resolution Policy Table**, verify that the new rule is displayed.
1. Close the Group Policy Management Editor.
1. Close the Group Policy Management Console.

> [!TIP]
> To view an explanation of each choice in the drop-down list, choose an item, and then select in the text box to the right. A description of the selected item is displayed to the left under **Description**.

### Configure the NRPT with Windows PowerShell

Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. You can  add an NRPT rule to an existing Group Policy Object (GPO), use the **Add-DnsClientNrptRule** cmdlet. 

For example, to configure the GPO named **NRPT\_settings** with a rule requiring DNSSEC validation for the secure.contoso.com namespace run the command:

```powershell
    Add-DnsClientNrptRule -GpoName NRPT_settings -NameSpace secure.contoso.com -DnsSecEnable -DnsSecValidationRequired
```

To validate that the GPO was successfully configured, use the **Get-DnsClientNrptRule** cmdlet. For example to check the NRPT_settings for the rule configured in the previous example, run the command:

```powershell
    Get-DnsClientNrptRule -GpoName NRPT_settings
```
