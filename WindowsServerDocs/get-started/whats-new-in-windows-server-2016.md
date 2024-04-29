---
title: What's new in Windows Server 2016
description: This article describes some of the new features in Windows Server 2016 that are the ones most likely to have the greatest impact as you work with this release.
ms.topic: article
author: jasongerend
ms.author: jgerend
manager: femila
ms.date: 04/25/2024
ms.assetid: 2827f332-44d4-4785-8b13-98429087dcc7
---

# What's new in Windows Server 2016

This article describes some of the new features in Windows Server 2016 that are the ones most likely to have the greatest impact as you work with this release.

## Compute

The [Virtualization area](../virtualization/virtualization.yml) includes virtualization products and features for the IT professional to design, deploy, and maintain Windows Server.

### General

Physical and virtual machines benefit from greater time accuracy due to improvements in the Win32 Time and Hyper-V Time Synchronization Services. Windows Server can now host services that are compliant with upcoming regulations that require a 1ms accuracy with regard to UTC.

### Hyper-V

Hyper-V network virtualization (HNV) is a fundamental building block of Microsoft's updated Software Defined Networking (SDN) solution and is fully integrated into the SDN stack. Windows Server 2016 includes the following changes for Hyper-V:

- Windows Server 2016 now includes a programmable Hyper-V switch. Microsoft's Network Controller pushes HNV policies down to a Host Agent running on each host using the [Open vSwitch Database Management Protocol (OVSDB)](https://www.rfc-editor.org/info/rfc7047) as the SouthBound Interface (SBI). The Host Agent stores this policy using a customization of the [VTEP schema](https://github.com/openvswitch/ovs/blob/master/vtep/vtep.ovsschema) and programs complex flow rules into a performant flow engine in the Hyper-V switch. The flow engine in the Hyper-V switch is the same one that Azure uses. The entire SDN stack up through the Network Controller and Network Resource provider is also consistent with Azure, making its performance comparable to the Azure public cloud. Within Microsoft's flow engine, the Hyper-V switch is equipped to handle both stateless and stateful flow rules through a simple match action mechanism that defines how packets should be processed within the switch.

- HNV now supports [Virtual eXtensible Local Area Network (VXLAN) protocol](https://www.rfc-editor.org/info/rfc7348) encapsulation. HNV uses the VXLAN protocol in MAC distribution mode through the Microsoft Network Controller to map tenant overly network IP addresses to the physical underlay network IP addresses. The NVGRE and VXLAN Task Offloads support third-party drivers for improved performance.

- Windows Server 2016 includes a software load balancer (SLB) with full support for virtual network traffic and seamless interaction with HNV. The performant flow engine implements the SLB in the data plane v-Switch, then the Network Controller controls it for Virtual IP (VIP) or Dynamic IP (DIP) mappings.

- HNV implements correct L2 Ethernet headers to ensure interoperability with third-party virtual and physical appliances that depend on industry-standard protocols. Microsoft ensures that all transmitted packets have compliant values in all fields to guarantee interoperability. HNV requires support for Jumbo Frames (MTU > 1780) in the physical L2 network to account for packet overhead introduced by encapsulation protocols such as NVGRE and VXLAN. Jumbo Frame support ensures that guest Virtual Machines attached to an HNV Virtual Network maintain a 1514 MTU.

- [Windows Container](/virtualization/windowscontainers/) support adds performance improvements, simplified network management, and support for Windows containers on Windows 10. For more information, see [Containers: Docker, Windows, and Trends](https://azure.microsoft.com/blog/containers-docker-windows-and-trends/).

### Nano Server

What's New in [Nano Server](getting-started-with-nano-server.md). Nano Server now has an updated module for building Nano Server images, including more separation of physical host and guest virtual machine functionality and support for different Windows Server editions.

There are also improvements to the Recovery Console, including separation of inbound and outbound firewall rules and the ability to repair WinRM configuration.

### Shielded Virtual Machines

Windows Server 2016 provides a new Hyper-V-based Shielded Virtual Machine to protect any Generation 2 virtual machine from a compromised fabric. Among the features introduced in Windows Server 2016 are the following:

- A new **Encryption Supported** mode that offers more protections than for an ordinary virtual machine, but less than **Shielded** mode, while still supporting vTPM, disk encryption, Live Migration traffic encryption, and other features, including direct fabric administration conveniences such as virtual machine console connections and PowerShell Direct.

- Full support for converting existing non-shielded Generation 2 virtual machines to shielded virtual machines, including automated disk encryption.

- Hyper-V Virtual Machine Manager can now view the fabrics upon which a shielded virtual is authorized to run, providing a way for the fabric administrator to open a shielded virtual machine's key protector (KP) and view the fabrics it is permitted to run on.

- You can switch Attestation modes on a running Host Guardian Service. Now you can switch on the fly between the less secure but simpler Active Directory-based attestation and TPM-based attestation.

- End-to-end diagnostics tooling based on Windows PowerShell that is able to detect misconfigurations or errors in both guarded Hyper-V hosts and the Host Guardian Service.

- A recovery environment that offers a means to securely troubleshoot and repair shielded virtual machines within the fabric in which they normally run while offering the same level of protection as the shielded virtual machine itself.

- Host Guardian Service support for existing safe Active Directory – you can direct the Host Guardian Service to use an existing Active Directory forest as its Active Directory instead of creating its own Active Directory instance

For more details and instructions for working with shielded virtual machines, see [Guarded Fabric and Shielded VMs](../security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms-top-node.md).

## Identity and Access

New features in [Identity](../identity/Identity-and-Access.yml) improve the ability for organizations to secure Active Directory environments and help them migrate to cloud-only deployments and hybrid deployments, where some applications and services are hosted in the cloud and others are hosted on premises.

### Active Directory Certificate Services

Active Directory Certificate Services (AD CS) in Windows Server 2016 increases support for TPM key attestation: You can now use Smart Card KSP for key attestation, and devices that are not joined to the domain can now use NDES enrollment to get certificates that can be attested for keys being in a TPM.

### Active Directory Domain Services

Active Directory Domain Services includes improvements to help organizations secure Active Directory environments and provide better identity management experiences for both corporate and personal devices. For more information, see [What's new in Active Directory Domain Services (AD DS) in Windows Server 2016](../identity/whats-new-active-directory-domain-services.md).

### Active Directory Federation Services

Active Directory Federation Services (AD FS) in Windows Server 2016 includes new features that enable you to configure AD FS to authenticate users stored in Lightweight Directory Access Protocol (LDAP) directories. For more information, see [What's New in AD FS for Windows Server 2016](../identity/ad-fs/overview/whats-new-active-directory-federation-services-windows-server.md).

### Web Application Proxy

The latest version of Web Application Proxy focuses on new features that enable publishing and pre-authentication for more applications and improved user experience. Check out the full list of new features that includes pre-authentication for rich client apps such as Exchange ActiveSync and wildcard domains for easier publishing of SharePoint apps. For more information, see [Web Application Proxy in Windows Server 2016](../remote/remote-access/web-application-proxy/web-app-proxy-windows-server.md).

## Administration

The [Management and Automation area](../administration/manage-windows-server.yml) focuses on tool and reference information for IT pros who want to run and manage Windows Server 2016, including Windows PowerShell.

Windows PowerShell 5.1 includes significant new features, including support for developing with classes and new security features that extend its use, improve its usability, and allow you to control and manage Windows-based environments more easily and comprehensively. See [New Scenarios and Features in WMF 5.1](/powershell/module/microsoft.powershell.core/about/about_windows_powershell_5.1#new-scenarios-and-features-in-wmf-51) for details.

New additions for Windows Server 2016 include: the ability to run PowerShell.exe locally on Nano Server (no longer remote only), new Local Users & Groups cmdlets to replace the GUI, added PowerShell debugging support, and added support in Nano Server for security logging & transcription and JEA.

Here are some other new administration features:

### PowerShell Desired State Configuration (DSC) in Windows Management Framework (WMF) 5

Windows Management Framework 5 includes updates to Windows PowerShell Desired State Configuration (DSC), Windows Remote Management (WinRM), and Windows Management Instrumentation (WMI).

For more info about testing the DSC features of Windows Management Framework 5, see the series of blog posts discussed in [Validate features of PowerShell DSC](https://devblogs.microsoft.com/powershell/validate-features-of-powershell-dsc/). To download, see [Windows Management Framework 5.1](/powershell/scripting/wmf/setup/install-configure).

### PackageManagement unified package management for software discovery, installation, and inventory

Windows Server 2016 and Windows 10 includes a new PackageManagement feature (formerly called OneGet) that enables IT Professionals or DevOps to automate software discovery, installation, and inventory (SDII), locally or remotely, no matter what the installer technology is and where the software is located.

For more info, see [https://github.com/OneGet/oneget/wiki](https://github.com/OneGet/oneget/wiki).

### PowerShell enhancements to assist digital forensics and help reduce security breaches

To help the team responsible for investigating compromised systems - sometimes known as the "blue team" - we've added additional PowerShell logging and other digital forensics functionality, and we've added functionality to help reduce vulnerabilities in scripts, such as constrained PowerShell, and secure CodeGeneration APIs.

For more info, see the [PowerShell ♥ the Blue Team](https://devblogs.microsoft.com/powershell/powershell-the-blue-team/) blog post.

## Networking

The [Networking area](../networking/index.yml) addresses networking products and features for the IT professional to design, deploy, and maintain Windows Server 2016.

### Software-Defined Networking

You can now both mirror and route traffic to new or existing virtual appliances. Together with a distributed firewall and Network security groups, this enables you to dynamically segment and secure workloads in a manner similar to Azure. Second, you can deploy and manage the entire Software-defined networking (SDN) stack using System Center Virtual Machine Manager. Finally, you can use Docker to manage Windows Server container networking, and associate SDN policies not only with virtual machines but containers as well. For more information, see [Plan a Software Defined Network Infrastructure](/azure-stack/hci/concepts/plan-software-defined-networking-infrastructure).

### TCP performance improvements

The default Initial Congestion Window (ICW) has been increased from 4 to 10 and TCP Fast Open (TFO) has been implemented. TFO reduces the amount of time required to establish a TCP connection and the increased ICW allows larger objects to be transferred in the initial burst. This combination can significantly reduce the time required to transfer an Internet object between the client and the cloud.

In order to improve TCP behavior when recovering from packet loss we have implemented TCP Tail Loss Probe (TLP) and Recent Acknowledgment (RACK). TLP helps convert Retransmit TimeOuts (RTOs) to Fast Recoveries and RACK reduces the time required for Fast Recovery to retransmit a lost packet.

## Security and Assurance

The [Security and Assurance area](../security/Security-and-Assurance.yml) Includes security solutions and features for the IT professional to deploy in your data center and cloud environment. For information about security in Windows Server 2016 generally, see [Security and Assurance](../security/Security-and-Assurance.yml).

### Just Enough Administration

Just Enough Administration in Windows Server 2016 is security technology that enables delegated administration for anything that can be managed with Windows PowerShell. Capabilities include support for running under a network identity, connecting over PowerShell Direct, securely copying files to or from JEA endpoints, and configuring the PowerShell console to launch in a JEA context by default. For more details, see [JEA on GitHub](https://aka.ms/JEA).

### Credential Guard

Credential Guard uses virtualization-based security to isolate secrets so that only privileged system software can access them. For more information, see [Protect derived domain credentials with Credential Guard](/windows/security/identity-protection/credential-guard/credential-guard).

Credential Guard for Windows Server 2016 includes the following updates for signed-in user sessions:

- Kerberos and New Technology LAN Manager (NTLM) use virtualization-based security to protect Kerberos amd NTLM secrets for signed-in user sessions.

- Credential Manager protects saved domain credentials using virtualization-based security. Signed-in credentials and saved domain credentials don't pass to remote hosts using Remote Desktop.

- You can enable Credential Guard without a Unified Extensible Firmware Interface (UEFI) lock.

### Remote Credential Guard

Credential Guard includes support for RDP sessions so that the user credentials remain on the client side and are not exposed on the server side. This also provides Single Sign On for Remote Desktop. For more information, see [Protect derived domain credentials with Windows Defender Credential Guard](/windows/access-protection/credential-guard/credential-guard).

Remote Credential Guard for Windows Server 2016 includes the following updates for signed-in users:

- Remote Credential Guard keeps Kerberos and NTLM secrets for signed-in user credentials on the client device. Any authentication requests from the remote host for assessing network resources as the user require the client device to use the secrets.

- Remote Credential Guard protects supplied user credentials when using Remote Desktop.

### Domain protections

Domain protections now require an Active Directory domain.

### Domain-joined device support for authentication using public key

If a domain-joined device can register its bound public key with a Windows Server 2016 domain controller (DC), then the device can authenticate with the public key using Kerberos PKINIT authentication to a Windows Server 2016 DC.

Domain-joined devices with bound public keys registered with a Windows Server 2016 domain controller can now authenticate to a Windows Server 2016 domain controller using Kerberos Public Key Cryptography for Initial Authentication (PKINIT) protocols.

Key Distribution Centers (KDCs) now support authentication using Kerberos key trust.

For more information, see [What's new in Kerberos authentication](../security/kerberos/whats-new-in-kerberos-authentication.md#kdc-support-for-public-key-trust-based-client-authentication).

### PKINIT Freshness extension support

Kerberos clients now attempt the PKINIT freshness extension for public key based sign-ons.

KDCs now support the PKInit freshness extension. However, they don't offer the PKINIT freshness extension by default.

For more information, see [What's new in Kerberos authentication](../security/kerberos/whats-new-in-kerberos-authentication.md#kerberos-client-and-kdc-support-for-rfc-8070-pkinit-freshness-extension).

### Rolling public key only user's NTLM secrets

Starting with the Windows Server 2016 domain functional level (DFL), DCs now support rolling the NTLM secrets of a public-key-only user. This feature is unavailable in lower domain functioning levels (DFLs).

> [!WARNING]
> Adding a DC enabled before the November 8, 2016 update to a domain that supports rolling NTLM secrets can cause the DC to crash.

For new domains, this feature is enabled by default. For existing domains, you must configure it in the Active Directory Administrative Center.

From the Active Directory Administrative Center, right-click on the domain in the left pane and select **Properties**. Select the checkbox **Enable rolling of expiring NTLM secrets during sign on for users who are required to use Windows Hello for Business or smart card for interactive logon**. After that, select **OK** to apply this change.

### Allowing network NTLM when user is restricted to specific domain-joined devices

DCs can now support allowing network NTLM when a user is restricted to specific domain-joined devices in the Windows Server 2016 DFL and higher. This feature is unavailable in DFLs running an earlier operating system than Windows Server 2016.

To configure this setting, in the authentication policy, select **Allow NTLM network authentication when the user is restricted to selected devices**.

For more information, see [Authentication policies and authentication policy silos](../security/credentials-protection-and-management/authentication-policies-and-authentication-policy-silos.md).

### Device Guard (Code Integrity)

Device Guard provides kernel mode code integrity (KMCI) and user mode code integrity (UMCI) by creating policies that specify what code can run on the server. See [Introduction to Windows Defender Device Guard: virtualization-based security and code integrity policies](/windows/device-security/device-guard/introduction-to-device-guard-virtualization-based-security-and-code-integrity-policies).

### Windows Defender

[Windows Defender Overview for Windows Server 2016](../security/windows-defender/windows-defender-overview-windows-server.md). Windows Server Antimalware is installed and enabled by default in Windows Server 2016, but the user interface for Windows Server Antimalware is not installed. However, Windows Server Antimalware will update antimalware definitions and protect the computer without the user interface. If you need the user interface for Windows Server Antimalware, you can install it after the operating system installation by using the Add Roles and Features Wizard.

### Control Flow Guard

Control Flow Guard (CFG) is a platform security feature that was created to combat memory corruption vulnerabilities. See [Control Flow Guard](/windows/win32/secbp/control-flow-guard) for more information.

## Storage

[Storage](../storage/storage.yml) in Windows Server 2016 includes new features and enhancements for software-defined storage, and for traditional file servers. Below are a few of the new features, for more enhancements and further details, see [What's New in Storage in Windows Server 2016](../storage/whats-new-in-storage.md).

### Storage Spaces Direct

Storage Spaces Direct enables building highly available and scalable storage using servers with local storage. It simplifies the deployment and management of software-defined storage systems and unlocks use of new classes of disk devices, such as SATA SSD and NVMe disk devices, that were previously not possible with clustered Storage Spaces with shared disks.

For more info, see [Storage Spaces Direct](/azure-stack/hci/concepts/storage-spaces-direct-overview).

### Storage Replica

Storage Replica enables storage-agnostic, block-level, synchronous replication between servers or clusters for disaster recovery, and stretching of a failover cluster between sites. Synchronous replication enables mirroring of data in physical sites with crash-consistent volumes to ensure zero data loss at the file-system level. Asynchronous replication allows site extension beyond metropolitan ranges with the possibility of data loss.

For more info, see [Storage Replica](../storage/storage-replica/storage-replica-overview.md).

### Storage Quality of Service (QoS)

You can now use storage quality of service (QoS) to centrally monitor end-to-end storage performance and create management policies using Hyper-V and CSV clusters in Windows Server 2016.

For more info, see [Storage Quality of Service](../storage/storage-qos/storage-qos-overview.md).

## [Failover Clustering](../failover-clustering/whats-new-in-failover-clustering.md)

Windows Server 2016 includes many new features and enhancements for multiple servers that are grouped together into a single fault-tolerant cluster using the Failover Clustering feature. Some of the additions are listed below; for a more complete listing, see [What's New in Failover Clustering in Windows Server 2016](../failover-clustering/whats-new-in-failover-clustering.md).

### Cluster Operating System Rolling Upgrade

Cluster Operating System Rolling Upgrade enables an administrator to upgrade the operating system of the cluster nodes from  Windows Server 2012 R2  to Windows Server 2016 without stopping the Hyper-V or the Scale-Out File Server workloads. Using this feature, the downtime penalties against Service Level Agreements (SLA) can be avoided.

For more info, see [Cluster Operating System Rolling Upgrade](../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md).

### Cloud Witness

Cloud Witness is a new type of Failover Cluster quorum witness in Windows Server 2016 that leverages Microsoft Azure as the arbitration point. The Cloud Witness, like any other quorum witness, gets a vote and can participate in the  quorum calculations. You can configure cloud witness as a quorum witness using the Configure a Cluster Quorum Wizard.

For more info, see [Deploy Cloud Witness](../failover-clustering/deploy-cloud-witness.md).

### Health Service

The Health Service improves the day-to-day monitoring, operations, and maintenance experience of cluster resources on a Storage Spaces Direct cluster.

For more info, see [Health Service](../failover-clustering/health-service-overview.md).

## Application development

### Internet Information Services (IIS) 10.0

New features provided by the IIS 10.0 web server in Windows Server 2016 include:

- Support for the HTTP/2 protocol in the Networking stack and integrated with IIS 10.0, allowing IIS 10.0 websites to automatically serve HTTP/2 requests for supported configurations. This allows numerous enhancements over HTTP/1.1 such as more efficient reuse of connections and decreased latency, improving load times for web pages.
- Ability to run and manage IIS 10.0 in Nano Server. See [IIS on Nano Server](iis-on-nano-server.md).
- Support for Wildcard Host Headers, enabling administrators to set up a web server for a domain and then have the web server serve requests for any subdomain.
- A new PowerShell module (IISAdministration) for managing IIS.

For more details, see [IIS](https://iis.net/learn).

### Distributed Transaction Coordinator (MSDTC)

Three new features are added in Microsoft Windows 10 and Windows Server 2016:

- A new interface for Resource Manager Rejoin can be used by a resource manager to determine the outcome of an in-doubt transaction after a database restarts due to an error. See [IResourceManagerRejoinable::Rejoin](/previous-versions/windows/desktop/mt203799(v=vs.85)) for details.

- The DSN name limit is enlarged from 256 bytes to 3072 bytes. See [IDtcToXaHelperFactory::Create](/previous-versions/windows/desktop/ms686861(v=vs.85)), [IDtcToXaHelperSinglePipe::XARMCreate](/previous-versions/windows/desktop/ms679248(v=vs.85)), or [IDtcToXaMapper::RequestNewResourceManager](/previous-versions/windows/desktop/ms680310(v=vs.85)) for details.

- Improved tracing allowing you to set a registry key to include an image file path in the Tracelog file name so you can tell which Tracelog file to check. See [How to enable diagnostic tracing for MS DTC on a Windows-based computer](https://support.microsoft.com/kb/926099) for details on configuring tracing for MSDTC.

## DNS Server

Windows Server 2016 contains the following updates for Domain Name System (DNS) Server.

### DNS policies

You can configure DNS policies to specify how a DNS server responds to DNS queries. You can configure DNS responses based on client IP address, time of day, and several other parameters. DNS policies can enable location-aware DNS, traffic management, load balancing, split-brain DNS, and other scenarios. For more information, see the [DNS Policy Scenario Guide](../networking/dns/deploy/DNS-Policies-Overview.md).

### RRL

You can enable Response Rate Limiting (RRL) on your DNS servers to prevent malicious systems from using your DNS servers to initiate a Distributed Denial of Service (DDoS) attack on a DNS client. RRL prevents your DNS server from responding to too many requests at once, which protects it during scenarios when a botnet sends multiple requests at once to try to disrupt server operations.

### DANE support

You can use DNS-based Authentication of Named Entities (DANE) support ([RFC 6394](https://www.rfc-editor.org/rfc/rfc6394) and [RFC 6698](https://www.rfc-editor.org/rfc/rfc6698)) to specify which certificate authority your DNS clients should expect certificates from for domain names hosted in your DNS server. This prevents a form of man-in-the-middle attack where a malicious actor corrupts a DNS cache and points a DNS name to their own IP address.

### Unknown record support

You can add records that the DNS server doesn't explicitly support by using the unknown record functionality. A record is unknown when the DNS server doesn't recognize its RDATA format. Windows Server 2016 supports unknown record types ([RFC 3597](https://www.rfc-editor.org/rfc/rfc3597)), so you can add unknown records to Windows DNS server zones in binary on-wire format. The windows caching resolver can already process unknown record types. Windows DNS server doesn't perform record-specific processing for unknown records, but can send them in response to queries it receives.

### IPv6 root hints

Windows DNS server now includes IPv6 root hints published by the Internet Assigned Numbers Authority (IANA). Support for IPv6 root hints lets you make internet queries that use the IPv6 root servers to perform name resolutions.

### Windows PowerShell support

Windows Server 2016 includes new commands you can use to configure DNS in PowerShell. For more information, see [Windows Server 2016 DnsServer module](/powershell/module/dnsserver/?view=windowsserver2016-ps&preserve-view=true) and [Windows Server 2016 DnsClient module](/powershell/module/dnsclient/?view=windowsserver2016-ps&preserve-view=true).

## DNS client

The DNS client service now offers enhanced support for computers with more than one network interface.

Multi-homed computers can also use DNS client service binding to improve server resolution:

- When you use a DNS server configured on a specific interface to resolve a DNS query, the DNS client binds to the interface before sending the query. This binding lets the DNS client specify the interface where name resolution should take place, optimizing communications between applications and DNS client over the network interface.

- If the DNS server you're using was designated by a Group Policy setting from the Name Resolution Policy Table (NRPT), the DNS client service doesn't bind to the specified interface.

> [!NOTE]
> Changes to the DNS Client service in Windows 10 are also present in computers running Windows Server 2016 and later.

## Remote Desktop Services

Remote Desktop Services (RDS) made the following changes for Windows Server 2016.

### App compatibility

RDS and Windows Server 2016 are compatible with many Windows 10 applications, creating a user experience that's almost identical to a physical desktop.

### Azure SQL Database

The Remote Desktop (RD) Connection Broker can now store all deployment information, such as connection states and user-host mappings, in a shared Azure Structured Query Language (SQL) Database. This feature lets you use a highly available environment without having to use an SQL Server Always On Availability Group. For more information, see [Use Azure SQL DB for your Remote Desktop Connection Broker high availability environment](https://techcommunity.microsoft.com/t5/microsoft-security-and/new-windows-server-2016-capability-use-azure-sql-db-for-your/ba-p/249787).

### Graphical improvements

Discrete Device Assignment for Hyper-V lets you map graphics processing units (GPUs) on a host machine directly to a virtual machine (VM). Any applications on the VM that need more GPU than the VM can provide can use the mapped GPU instead. We also improved the RemoteFX vGPU, including support for OpenGL 4.4, OpenCL 1.1, 4K resolution, and Windows Server VMs. For more information, see [Discrete Device Assignment](https://techcommunity.microsoft.com/t5/virtualization/bg-p/Virtualization).

### RD Connection Broker improvements

We improved how the RD Connection Broker handles connection during logon storms, which are periods of high sign in requests from users. The RD Connection Broker can now handle over 10,000 concurrent sign in requests! Maintenance improvements also make it easier for you to perform maintenance on your deployment by being able to quickly add servers back into the environment once they're ready to go back online. For more information, see [Improved Remote Desktop Connection Broker Performance](https://techcommunity.microsoft.com/t5/microsoft-security-and/improved-remote-desktop-connection-broker-performance-with/ba-p/249559).

### RDP 10 protocol changes

Remote Desktop Protocol (RDP) 10 now uses the H.264/AVC 444 codec, which optimizes across both video and text. This release also includes pen remoting support. These new capabilities allow your remote session to feel more like a local session. For more information, see [RDP 10 AVC/H.264 improvements in Windows 10 and Windows Server 2016](https://techcommunity.microsoft.com/t5/microsoft-security-and/remote-desktop-protocol-rdp-10-avc-h-264-improvements-in-windows/ba-p/249588).

### Personal session desktops

Personal session desktops is a new feature that lets you host your own personal desktop in the cloud. Administrative privileges and dedicated session hosts removes the complexity of hosting environments where users want to manage a remote desktop like a local desktop. For more information, see [Personal Session Desktops](../remote/remote-desktop-services/rds-personal-session-desktops.md).

## Kerberos authentication

Windows Server 2016 includes the following updates for Kerberos authentication.

## KDC support for Public Key Trust-based client authentication

Key Distribution Centers (KDCs) now support public key mapping. If you provision a public key for an account, the KDC supports Kerberos PKInit explicitly using that key. Because there's no certificate validation, Kerberos supports self-signed certificates but doesn't support authentication mechanism assurance.

Accounts you've configured to use Key Trust will only use Key Trust regardless of how you configured the UseSubjectAltName setting.

## Kerberos client and KDC support for RFC 8070 PKInit Freshness Extension

Starting with Windows 10, version 1607 and Windows Server 2016, Kerberos clients can use the [RFC 8070 PKInit freshness extension](https://datatracker.ietf.org/doc/draft-ietf-kitten-pkinit-freshness/) for public key-based sign-ons. KDCs have the PKInit freshness extension disabled by default, so to enable it you must configure the KDC support for PKInIt Freshness Extension KDC administrative template policy on all DCs in your domain.

The policy has the following settings available when your domain is in the Windows Server 2016 domain functional level (DFL):

- **Disabled**: The KDC never offers the PKInit Freshness Extension and accepts valid authentication requests without checking for freshness. Users don't receive the fresh public key identity SID.
- **Supported**: Kerberos supports PKInit Freshness Extension on request. Kerberos clients successfully authenticating with the PKInit Freshness Extension receive the fresh public key identity SID.
- **Required**: PKInit Freshness Extension is required for successful authentication. Kerberos clients that don't support the PKInit Freshness Extension will always fail when using public key credentials.

## Kerberos clients allow IPv4 and IPv6 address host names in Service Principal Names (SPNs)

Starting with Windows 10 version 1507 and Windows Server 2016, you can configure Kerberos clients to support IPv4 and IPv6 host names in SPNs. For more information, see [Configuring Kerberos for IP Addresses](configuring-kerberos-over-ip.md).

## KDC support for Key Trust account mapping

Domain controllers now support Key Trust account mapping and fallback to existing AltSecID and User Principal Name (UPN) in the SAN behavior. You can configure the UseSubjectAltName variable to the following settings:

- Setting the variable to 0 makes explicit mapping required. Users must use either a Key Trust or set an ExplicitAltSEcID variable.

- Setting the variable to 1, which is the default value, allows implicit mapping.

  - If you configure a Key Trust for an account in Windows Server 2016 or later, then KDC uses the KeyTrust for mapping.

  - If there's no UPN in the SAN, KDC will attempt to use the AltSecID for mapping.
  
  - If there's a UPN in the SAN, KDC will attempt to use the UPN for mapping.
