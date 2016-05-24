---
title: The NRPT
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0f6daba8-9238-4693-8ac2-91892110d81b
---
# The NRPT
The Name Resolution Policy Table \(NRPT\) in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] enables you to enforce name resolution policies on security\-aware DNS clients. For information about configuring the NRPT, see [Procedure: Configure the NRPT](../Topic/Procedure--Configure-the-NRPT.md).  
  
## In this section  
  
-   [Introduction to the NRPT](../Topic/The-NRPT.md#intro)  
  
-   [NRPT rule processing](../Topic/The-NRPT.md#proc)  
  
-   [Filter NRPT policy](../Topic/The-NRPT.md#filter)  
  
-   [View NRPT policy](../Topic/The-NRPT.md#view)  
  
## <a name="intro"></a>Introduction to the NRPT  
The NRPT is a table that contains rules that you can configure to specify DNS settings or special behavior for names or namespaces. The NRPT can be configured using the Group Policy Management Editor under **Computer Configuration\\Policies\\Windows Settings\\Name Resolution Policy**, or with Windows PowerShell. See the following example.  
  
The **Name Resolution Policy Table** in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is displayed below.  
  
![](../Image/DNSSEC_nrpt2.png)  
  
When the DNS Client service performs DNS name resolution, it checks the NRPT before it sends a DNS query. If a DNS query matches an entry in the NRPT, it is handled according to settings in the policy. Queries that do not match an NRPT entry are processed normally. You can use the NRPT to require that DNSSEC validation is performed on DNS responses for queries in the namespaces that you specify.  
  
The following table shows the options that you can use to configure the namespace to which a policy applies.  
  
|Option|Usage|  
|----------|---------|  
|Suffix|The policy applies to any name that ends in *.contoso.com*. This includes child domains.|  
|Prefix|The policy applies only to a host name. This policy is triggered only if the host name portion of a DNS query matches the flat name that is configured here. For example, an entry of *server1* applies to both *server1.contoso.com* and *server1.nwtraders.com*.|  
|FQDN|The policy applies only to the specified host. This fully qualified domain name \(FQDN\) is not the FQDN of a domain, but an FQDN of a host computer.|  
|Subnet \(IPv4\)|This option configures a policy, which applies to reverse IPv4 lookup queries.|  
|Subnet \(IPv6\)|This option configures a policy, which applies to reverse IPv6 lookup queries.|  
|Any|This option configures the default policy.|  
  
> [!NOTE]  
> The NRPT can be used to create different types of rules by choosing one of four available tabs. This topic only discusses rules configured using the **DNSSEC** tab, that apply to a DNSSEC deployment.  
  
Client computers that are not security\-aware, for example, computers running Windows XP, will ignore NRPT settings. For more information, see [DNS Clients](../Topic/DNS-Clients.md).  
  
## <a name="proc"></a>NRPT rule processing  
NRPT rules can be configured in a local, site, domain, or organizational unit \(OU\)\-linked Group Policy Object \(GPO\). Normal Group Policy processing rules apply. For more information, see [Group Policy processing and precedence](http://technet.microsoft.com/library/cc785665.aspx) \(http:\/\/technet.microsoft.com\/library\/cc785665.aspx\). NRPT rules are processed in the following order:  
  
1.  Local GPO  
  
2.  Site\-linked GPOs  
  
3.  Domain\-linked GPOs  
  
4.  Organizational unit\-linked GPOs  
  
If NRPT rules are present in multiple GPOs that apply to the same user or computer, the rules are merged, with more discrete rules taking precedence over more general rules. For example, a rule that applies to a child namespace takes precedence over a rule for the parent namespace, as shown in the following table.  
  
|GPO name|Namespace|DNSSEC\-enabled|Validation required|  
|------------|-------------|-------------------|-----------------------|  
|Default domain policy|contoso.com|√|X|  
|NRPT\_settings|secure.contoso.com|√|√|  
  
In this example, DNSSEC validation is required for DNS queries that have a suffix of secure.contoso.com, for example, www.secure.contoso.com. This includes queries in a child domain, for example, www.corp.secure.contoso.com. However, validation is not required for \*.contoso.com or \*.corp.contoso.com. Therefore, if parent and child domains require a different name resolution policy, you must explicitly create policies for the child namespace.  
  
> [!CAUTION]  
> NRPT rules do not overwrite each other. If two rules are created in two different GPOs that apply to the same namespace for the same user or computer, a conflict occurs, and neither rule is applied. If the rules apply to the same user or computer for different namespaces, they are merged. This rule does not apply to local Group Policy, however. If any NRPT settings are configured in domain Group Policy, then all local Group Policy NRPT settings are ignored.  
  
## <a name="filter"></a>Filter NRPT policy  
By default, new domain\-linked Group Policy Objects \(GPOs\) apply to the Authenticated Users group. You can apply NRPT policy to selected groups, users, and computers by removing the Authenticated Users group from **Security Filtering** and then adding a custom user, group, or computer. See the following example.  
  
![](../Image/DNSSEC_gp.png)  
  
In this example, a new GPO is created named **NRPT\_settings**. This GPO only applies to the computer **CLI1** using security filtering.  
  
## <a name="view"></a>View NRPT policy  
You can use the [Get\-DnsClientNrptPolicy](http://technet.microsoft.com/library/jj590779.aspx) cmdlet to view NRPT policies. See the following example.  
  
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
  
The **Get\-DnsClientNrptPolicy** cmdlet gets policy that applies to the local computer. In this example, the output indicates that DNSSEC validation is required for \*.secure.contoso.com, and is not required for \*.contoso.com.  
  
## <a name="also"></a>See also  
[DNS Servers](../Topic/DNS-Servers.md)  
  
[DNS Clients](../Topic/DNS-Clients.md)  
  
[DNS Zones](../Topic/DNS-Zones.md)  
  
[Trust Anchors](../Topic/Trust-Anchors.md)  
  
