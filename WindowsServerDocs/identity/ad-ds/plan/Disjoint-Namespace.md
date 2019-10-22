---
ms.assetid: d92731f1-e4d8-4223-9b07-ca1f40bb0e1f
title: Disjoint Namespace
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Disjoint Namespace

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

A disjoint namespace occurs when one or more domain member computers have a primary Domain Name Service (DNS) suffix that does not match the DNS name of the Active Directory domain of which the computers are members. For example, a member computer that uses a primary DNS suffix of corp.fabrikam.com in an Active Directory domain named na.corp.fabrikam.com is using a disjoint namespace.  
  
A disjoint namespace is more complex to administer, maintain, and troubleshoot than a contiguous namespace. In a contiguous namespace, the primary DNS suffix matches the Active Directory domain name. Network applications that are written to assume that the Active Directory namespace is identical to the primary DNS suffix for all domain member computers do not function properly in a disjoint namespace.  
  
## Support for disjoint namespaces  
Domain member computers, including domain controllers, can function in a disjoint namespace. Domain member computers can register their host (A) resource record and IP version 6 (IPv6) host (AAAA) resource record in a disjoint DNS namespace. When domain member computers register their resource records in this way, domain controllers continue to register global and site-specific service (SRV) resource records in the DNS zone that is identical to the Active Directory domain name.  
  
For example, assume that a domain controller for the Active Directory domain named na.corp.fabrikam.com that uses a primary DNS suffix of corp.fabrikam.com registers host (A) and IPv6 host (AAAA) resource records in the corp.fabrikam.com DNS zone. The domain controller continues to register global and site-specific service (SRV) resource records in the _msdcs.na.corp.fabrikam.com and na.corp.fabrikam.com DNS zones, which makes service location possible.  
  
> [!IMPORTANT]  
> Although Windows operating systems may support a disjoint namespace, applications that are written to assume that the primary DNS suffix is the same as the Active Directory domain suffix may not function in such an environment. For this reason, you should test all applications and their respective operating systems carefully before you deploy a disjoint namespace.  
  
A disjoint namespace should work (and is supported) in the following situations:  
  
-   When a forest with multiple Active Directory domains uses a single DNS namespace, which is also known as a DNS zone  
  
    An example of this is a company that uses regional domains with names such as na.corp.fabrikam.com, sa.corp.fabrikam.com, and asia.corp.fabrikam.com and uses a single DNS namespace, such as corp.fabrikam.com.  
  
-   When a single Active Directory domain is split into separate DNS namespaces  
  
    An example of this is a company with an Active Directory domain of corp.contoso.com that uses DNS zones such as hr.corp.contoso.com, production.corp.contoso.com, and it.corp.contoso.com.  
  
A disjoint namespace does not work properly (and is not supported) in the following situations:  
  
-   A disjoint suffix used by domain members matches an Active Directory domain name in this or another forest. This breaks Kerberos name-suffix routing.  
  
-   The same disjoint suffix is used in another forest. This prevents routing these suffixes uniquely between forests.  
  
-   When a domain member certification authority (CA) server changes its fully qualified domain name (FQDN) so that it no longer use the same primary DNS suffix that is used by the domain controllers of the domain to which the CA server is a member. In this case, you may have problems validating certificates the CA server issued, depending on what DNS names are used in the CRL Distribution Points. But if you place a CA server in a stable disjoint namespace, it works properly and is supported.  
  
## Considerations for disjoint namespaces  
The following considerations may help you decide if you should use a disjoint namespace.  
  
### Application compatibility  
As previously mentioned, a disjoint namespace can cause problems for any applications and services that are written to assume that a computer primary DNS suffix is identical to the name of the domain name of which it is a member. Before you deploy a disjoint namespace, you must check applications for compatibility issues. Also, be sure to check the compatibility of all applications that you use when you perform your analysis. This includes applications from Microsoft and from other software developers.  
  
### Advantages of disjoint namespaces  
Using a disjoint namespace can have the following advantages:  
  
-   Because the primary DNS suffix of a computer can indicate different information, you can manage the DNS namespace separately from the Active Directory domain name.  
  
-   You can separate the DNS namespace based on business structure or geographical location. For example, you can separate the namespace based on business unit names or physical location such as continent, country/region, or building.  
  
### Disadvantages of disjoint namespaces  
Using a disjoint namespace can have the following disadvantages:  
  
-   You must create and manage separate DNS zones for each Active Directory domain in the forest that has member computers that use a disjoint namespace. (That is, it requires an additional and more complex configuration.)  
  
-   You must perform manual steps to modify and manage the Active Directory attribute that allows domain members to use specified, primary DNS suffixes.  
  
-   To optimize name resolution, you must perform manual steps to modify and maintain Group Policy to configure member computers with alternate primary DNS suffixes.  
  
    > [!NOTE]  
    > The Windows Internet Name Service (WINS) could be used to offset this disadvantage by resolving single-label names. For more information about WINS, see the WINS Technical Reference ([https://go.microsoft.com/fwlink/?LinkId=102303](https://go.microsoft.com/fwlink/?LinkId=102303)).  
  
-   When your environment requires multiple primary DNS suffixes, you must configure the DNS suffix search order for all of the Active Directory domains in the forest appropriately.  
  
    To set the DNS suffix search order, you can use Group Policy objects or Dynamic Host Configuration Protocol (DHCP) Server service parameters. You can also modify the registry.  
  
-   You must carefully test all applications for compatibility issues.  
  
For more information about steps that you can take to address these disadvantages, see Create a Disjoint Namespace ([https://go.microsoft.com/fwlink/?LinkId=106638](https://go.microsoft.com/fwlink/?LinkId=106638)).  
  
### Planning a namespace transition  
Before you modify a namespace, review the following considerations, which apply to transitions from contiguous namespaces to disjoint namespaces (or the reverse):  
  
-   Manually configured Service Principal Names (SPNs) may no longer match DNS names after a namespace change. This can cause authentication failures.  
  
    For more information, see Service Logons Fail Due to Incorrectly Set SPNs ([https://go.microsoft.com/fwlink/?LinkId=102304](https://go.microsoft.com/fwlink/?LinkId=102304)).  
  
    -   If you use Windows Server 2003-based computers with constrained delegation, those computers may require additional configuration to change SPNs. For more information, see article 936628 in the Microsoft Knowledge Base ([https://go.microsoft.com/fwlink/?LinkId=102306](https://go.microsoft.com/fwlink/?LinkId=102306)).  
  
    -   If you want to delegate permissions to modify SPNs to subordinate administrators, see Delegating Authority to Modify SPNs ([https://go.microsoft.com/fwlink/?LinkId=106639](https://go.microsoft.com/fwlink/?LinkId=106639)).  
  
-   If you use Lightweight Directory Access Protocol (LDAP) over Secure Sockets Layer (SSL) (known as LDAPS) with a CA in a deployment that has domain controllers that are configured in a disjoint namespace, you must use the appropriate Active Directory domain name and primary DNS suffix when you configure the LDAPS certificates.  
  
    For more information about domain controller certificate requirements, see article 321051 in the Microsoft Knowledge Base ([https://go.microsoft.com/fwlink/?LinkId=102307](https://go.microsoft.com/fwlink/?LinkId=102307)).  
  
    > [!NOTE]  
    > Domain controllers that use certificates for LDAPS may require you to redeploy their certificates. When you do so, domain controllers may not select an appropriate certificate until they are restarted. For more information about LDAPS authentication and a related update for Windows Server 2003, see article 932834 in the Microsoft Knowledge Base ([https://go.microsoft.com/fwlink/?LinkId=102308](https://go.microsoft.com/fwlink/?LinkId=102308)).  
  
### Planning for disjoint namespace deployments  
Take the following precautions if you deploy computers in an environment that has a disjoint namespace:  
  
1.  Notify all software vendors with whom you do business that they must test and support a disjoint namespace. Ask them to verify that they support their applications in environments that use disjoint namespaces.  
  
2.  Test all versions of operating systems and applications in disjoint namespace lab environments. When you do, follow these recommendations:  
  
    1.  Resolve all software issues before you deploy the software into your environment.  
  
    2.  When possible, participate in beta tests of operating systems and applications that you plan to deploy in disjoint namespaces.  
  
3.  Ensure that administrators and helpdesk staff are aware of the disjoint namespace and its impact.  
  
4.  Create a plan that makes it possible for you to transition from a disjoint namespace to a contiguous namespace, if necessary.  
  
5.  Evangelize the importance of disjoint namespace support with operating system and application providers.  
  


