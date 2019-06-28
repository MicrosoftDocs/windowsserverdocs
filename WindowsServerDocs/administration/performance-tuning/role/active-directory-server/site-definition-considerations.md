---
title: Site definition and domain controller placement in ADDS performance tuning
description: Site definition and domain controller placement considerations in Active Directory performance tuning.
ms.prod: windows-server-threshold
ms.technology: performance-tuning-guide
ms.topic: article
ms.author: TimWi; ChrisRob; HerbertM; KenBrumf;  MLeary; ShawnRab
author: phstee
ms.date: 10/16/2017
---

# Proper placement of domain controllers and site considerations

Proper site definition is critical to performance. Clients falling out of site can experience poor performance for authentications and queries. Furthermore, with the introduction of IPv6 on clients, the request can come from either the IPv4 or the IPv6 address and Active Directory needs to have sites properly defined for IPv6. The operating system prefers IPv6 to IPv4 when both are configured.

Starting in Windows Server 2008, the domain controller attempts to use name resolution to do a reverse lookup in order to determine the site the client should be in. This can cause exhaustion of the ATQ Thread Pool and cause the domain controller to become unresponsive. The appropriate resolution to this is to properly define the site topology for IPv6. As a workaround, one can optimize the name resolution infrastructure to respond quickly to domain controller requests. For more info see [Windows Server 2008 or Windows Server 2008 R2 Domain Controller delayed response to LDAP or Kerberos requests](https://support.microsoft.com/kb/2668820).

An additional area of consideration is locating Read/Write DCs for scenarios where RODCs are in use.  Certain operations require access to a writable Domain Controller or target a writable Domain Controller when a Read-Only Domain Controller would suffice.  Optimizing these scenarios would take two paths:
-   Contacting writable Domain Controllers when a Read-Only Domain Controller would suffice.  This requires an application code change.
-   Where a writable Domain Controller may be necessary.  Place read-write Domain Controllers at central locations to minimize latency.

For further information reference:
-   [Application Compatibility with RODCs](https://technet.microsoft.com/library/cc772597.aspx)
-   [Active Directory Service Interface (ADSI) and the Read Only Domain Controller (RODC) – Avoiding performance issues](https://blogs.technet.microsoft.com/fieldcoding/2012/06/24/active-directory-service-interface-adsi-and-the-read-only-domain-controller-rodc-avoiding-performance-issues/)

## Optimize for referrals

Referrals are how LDAP queries are redirected when the domain controller does not host a copy of the partition queried. When a referral is returned, it contains the distinguished name of the partition, a DNS name, and a port number. The client uses this information to continue the query on a server that hosts the partition. This is a DCLocator scenario and all of the recommendations site definitions and domain controller placement is maintained, but applications which depend on referrals are often overlooked. It is recommended to ensure AD Topology including site definitions and domain controller placement properly reflects the needs of the client. Also, this may include having domain controllers from multiple domains in a single site, tuning DNS settings, or relocating the site of an application.

## Optimization considerations for trusts

In an intra-forest scenario, trusts are processed according to the following domain hierarchy: Grand-Child Domain -&gt; Child Domain -&gt; Forest Root Domain -&gt; Child Domain -&gt; Grand-Child Domain. This means that secure channels at the forest root, and each parent, can become overloaded due to aggregation of authentication requests transiting the DCs in the trust hierarchy. This may also incur delays in Active Directories of large geographical dispersion when authentication also has to transit highly latent links to affect the above flow. Overloads can occur in inter-forest and down-level trust scenarios. The following recommendations apply to all scenarios:

-   Properly tune the MaxConcurrentAPI to support the load across the secure channel. For more info, see [How to do performance tuning for NTLM authentication by using the MaxConcurrentApi setting](https://support.microsoft.com/kb/2688798/EN-US).

-   Create shortcut trusts as appropriate based on load.

-   Ensure that every domain controller in the domain is able to perform name resolution and communicate with the domain controllers in the trusted domain.

-   Ensure locality considerations are taken into account for trusts.

-   Enable Kerberos where possible and minimize use of the secure channel to reduce risk of running into MaxConcurrentAPI bottlenecks.

Cross domain trust scenarios are an area that has been consistently a pain point for many customers. Name resolution and connectivity issues, often due to firewalls, cause resource exhaustion on the trusting domain controller and impact all clients. Furthermore, an often overlooked scenario is optimizing access to trusted domain controllers. The key areas to ensure this works properly are as follows:

-   Ensure the DNS and WINS name resolution that the trusting domain controllers are using can resolve an accurate list of domain controllers for the trusted domain.

    -   Statically added records have a tendency to become stale and reintroduce connectivity problems over time. DNS forwards, Dynamic DNS, and merging WINS/DNS infrastructures are more maintainable in the long run.

    -   Ensure proper configuration of forwarders, conditional forwards, and secondary copies for both forward and reverse lookup zones for every resource in the environment which a client may need to access. Again, this requires manual maintenance and has a tendency to become stale. Consolidation of infrastructures is ideal.

-   Domain controllers in the trusting domain will attempt to locate domain controllers in the trusted domain that are in the same site first and then failback to the generic locators.

    -   For more info on how DCLocator works, see [Finding a Domain Controller in the Closest Site](https://technet.microsoft.com/library/cc978016.aspx).

    -   Converge site names between the trusted and trusting domains to reflect domain controller in the same location. Ensure subnet and IP address mappings are properly linked to sites in both forests. For more info, see [Domain Locator Across a Forest Trust](http://blogs.technet.com/b/askds/archive/2008/09/24/domain-locator-across-a-forest-trust.aspx).

    -   Ensure ports are open, according to DCLocator needs, for domain controller location. If firewalls exist between the domains, ensure that the firewalls are properly configured for ALL trusts. If firewalls are not open, the trusting domain controller will still attempt to access the trusted domain. If communication fails for any reason, the trusting domain controller will eventually time out the request to the trusted domain controller. However, these time outs can take several seconds per request and can exhaust network ports on the trusting domain controller if the volume of incoming requests is high. The client may experience the waits to timeout at the domain controller as hung threads, which could translate to hung applications (if the application runs the request in the foreground thread). For more info, see [How to configure a firewall for domains and trusts](https://support.microsoft.com/kb/179442).

    -   Use DnsAvoidRegisterRecords to eliminate poorly performing or high-latency domain controllers, such as those in satellite sites, from advertising to the generic locators. For more info, see [How to optimize the location of a domain controller or global catalog that resides outside of a client's site](https://support.microsoft.com/kb/306602).

        > [!NOTE]
        > There is a practical limit of about 50 to the number of domain controllers the client can consume. These should be the most site-optimal and highest capacity domain controllers.

    
    -  Consider placing domain controllers from trusted and trusting domains in the same physical location.

For all trust scenarios, credentials are routed according to the domain specified in the authentication requests. This is also true for queries to the LookupAccountName and LsaLookupNames (as well as others, these are just the most commonly used) APIs. When the domain parameters for these APIs are passed a NULL value, the domain controller will attempt to find the account name specified in every trusted domain available.

-   Disable checking all available trusts when NULL domain is specified. [How to restrict the lookup of isolated names in external trusted domains by using the LsaLookupRestrictIsolatedNameLevel registry entry](https://support.microsoft.com/kb/818024)

-   Disable passing authentication requests with NULL domain specified across all available trusts. [The Lsass.exe process may stop responding if you have many external trusts on an Active Directory domain controller](https://support.microsoft.com/kb/923241/EN-US)

## See also
- [Performance tuning Active Directory Servers](index.md)
- [Hardware considerations](hardware-considerations.md)
- [LDAP considerations](ldap-considerations.md)
- [Troubleshooting ADDS performance](troubleshoot.md) 
- [Capacity Planning for Active Directory Domain Services](https://go.microsoft.com/fwlink/?LinkId=324566)