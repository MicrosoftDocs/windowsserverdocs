---
title: Features removed or no longer developed in Windows Server
description: Learn about the features and functionalities removed or no longer developed in Windows Server.
ms.topic: article
author: xelu86
ms.author: alalve
ms.date: 04/28/2025
---

# Features removed or no longer developed in Windows Server

Each release of Windows Server brings new features and improvements, while sometimes removing older ones to make room for better alternatives. This article details the features and functionalities removed or deprecated in Windows Server.

> [!TIP]
> You can get early access to Windows Server builds by joining the [Windows Insider Program for Business](https://insider.windows.com/for-business), which is a great way to test feature changes.

> [!NOTE]
> Windows Server Long-Term Servicing Channel (LTSC) releases have a Fixed Policy Lifecycle which includes 5 years of mainstream support and 5 years of extended support for a total lifecycle of 10 years. To learn more, see:
>
> - [Fixed Lifecycle Policy](/lifecycle/policies/fixed)
> - [Lifecycle Terms and Definitions](/lifecycle/definitions)

**This list is subject to change and might not include every affected feature or functionality.**

## Features no longer in development

We're no longer actively developing these features and may remove them from a future update. Some features were replaced with other features or functionality, while others are now available from different sources. Deprecation means a feature, functionality, or service is no longer in active development. A deprecated feature may be removed in future releases. A deprecated component still ships in Windows Server, is supported for production deployments, and continues to receive security and quality updates as per the product lifecycle.

# [Windows Server 2025](#tab/ws25)

| Feature | Explanation |
|--|--|
| Computer Browser | The Computer Browser driver and service are deprecated. The browser (browser protocol and service) is a dated and insecure device location protocol. This protocol, service, and driver were first disabled by default in Windows 10 with the removal of the SMB1 service. For more information on Computer Browser, see [MS-BRWS Common Internet File System](/openspecs/windows_protocols/ms-brws/3cfbad92-09b3-4abc-808f-c6f6347d5677). |
| Failover Clustering Cluster Sets | Failover Clustering Cluster Sets feature is no longer in active feature development and is deprecated. |
| Network Load Balancing (NLB) | NLB is no longer in active feature development and is deprecated. Consider using a Software Load Balancer (SLB) as an alternative. To learn more about SLB, see [What is Software Load Balancer (SLB) for SDN?](/azure/azure-local/concepts/software-load-balancer?context=/windows-server/context/windows-server-edge-networking) |
| NTLM | [NTLMv1](/windows/win32/secauthn/microsoft-ntlm) is removed. LANMAN and NTLMv2 are no longer under active feature development and are deprecated. NTLMv2 will continue to work but will be removed from Windows Server in a future release. Replace calls to NTLM to calls to [Negotiate](/windows/win32/secauthn/microsoft-negotiate), which try to authenticate with Kerberos and only fall back to NTLM when necessary. For more information, see [The evolution of Windows authentication](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/the-evolution-of-windows-authentication/ba-p/3926848). |
| Remote Mailslots | Remote Mailslots are deprecated. The Remote Mailslot protocol, which was initially introduced in MS DOS, is a dated and simple IPC method that is both unreliable and insecure. This protocol was first disabled by default in [Windows 11 Insider Preview Build](https://blogs.windows.com/windows-insider/2023/03/08/announcing-windows-11-insider-preview-build-25314/). For more information on Remote Mailslots, see [About Mailslots](/windows/win32/ipc/about-mailslots) and [[MS-MAIL]: Remote Mailslot Protocol](/openspecs/windows_protocols/ms-mail/8ea19aa4-6e5a-4aed-b628-0b5cd75a1ab9). |
| TLS 1.0 TLS 1.1 | TLS versions 1.0 and 1.1 are deprecated per internet standards and regulatory bodies due to security concerns mentioned in [RFC 8996](https://www.rfc-editor.org/rfc/rfc8996). These versions are disabled by default in Windows Server 2025. For more information on TLS deprecation, see [TLS 1.0 and TLS 1.1 deprecation in Windows](/windows/win32/secauthn/tls-10-11-deprecation-in-windows). |
| WebDAV Redirector service | The WebDAV Redirector service is deprecated. The service isn't installed by default in Windows Server. For more information on the WebDAV Redirector service, see [WebDAV - Win32 apps](/windows/win32/webdav/webdav-portal). |
| Windows Internal Database (WID) | WID is used by several roles, including ADFS, ADRMS, IPAM, RD Connection Broker, and WSUS. Consider using a free or full version of SQL Server for these roles. WID will be removed from Windows in a future release. To learn more about the different types of SQL Server available, see [SQL Server editions](/sql/sql-server/editions-and-components-of-sql-server-2022). |
| Windows Management Instrumentation Command line (WMIC) | Beginning with Windows Server 2025, WMIC is available as a feature on demand (FoD) which can be added with the `DISM /Add-Capability` command. It will be removed from Windows in a future release.<br><br> [PowerShell for WMI](/powershell/scripting/learn/ps101/07-working-with-wmi) replaces the WMIC tool. Use PowerShell or programmatically query WMI as a replacement for WMIC. To learn more about WMIC depreciation, see [WMI command line (WMIC) utility deprecation: Next steps](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/wmi-command-line-wmic-utility-deprecation-next-steps/ba-p/4039242) |
| Windows PowerShell 2.0 Engine | The Windows PowerShell 2.0 Engine is deprecated and isn't installed by default. Windows PowerShell 2.0 applications, and components should be migrated to PowerShell 5.0+. To learn more about the deprecation, see [Windows PowerShell 2.0 Deprecation](https://devblogs.microsoft.com/powershell/windows-powershell-2-0-deprecation/). |
| VBScript | VBScript is available as a feature on demand (FoD) and preinstalled in Windows Server 2025, before its removal from the operating system in a later release. As a replacement for VBScript, use PowerShell for automating tasks, custom actions, or scripts. To learn more about migrating to PowerShell, see [The VBScript-to-Windows PowerShell Conversion Guide](/previous-versions/windows/it-pro/windows-powershell-1.0/ee221101(v=msdn.10)).<br><br> If you're using VBScript within your webpage, functionality is currently limited to browsers predating Internet Explorer 11. We recommend migrating your webpages to JavaScript, which provides cross-browser compatibility and modern browser support. |
| Windows Server Update Services (WSUS) | WSUS is no longer actively developed, all the existing capabilities and content continue to be available for your deployments. |

# [Windows Server 2022](#tab/ws22)

| Feature | Explanation |
|--|--|
| Guarded Fabric and Shielded VMs | Windows Server and Azure Local are aligning with Azure to take advantage of continuing enhancements to [Azure Confidential Computing](/azure/confidential-computing/) and [Azure Security Center](/azure/security-center/). Having this alignment translates to more cloud security offerings being extended to customer data centers on-premises.<br><br>Microsoft continues to provide support for these features, but there's no further development on client versions of Windows as the Shielded VM RSAT feature is removed. |
| Hyper-V vSwitch on LBFO | The Hyper-V vSwitch no longer has the capability to be bound to an LBFO team. Instead, it must be bound via [Switch Embedded Teaming (SET)](/azure/azure-local/concepts/host-network-requirements#switch-embedded-teaming-set). This change only applies to Hyper-V. LBFO is still fully supported for other non Hyper-V scenarios. |
| Launching SConfig from a command prompt (CMD) | Starting with Windows Server 2022, `SConfig` is launched **by default** when you sign into a server running Server Core installation option. Moreover, PowerShell is now the default shell on Server Core. If you exit `SConfig`, you get to a regular interactive PowerShell window. Similarly, you can opt out from SConfig autolaunch. In this case, a PowerShell window pops up at sign-in. In either scenario, you can launch SConfig from PowerShell by running `SConfig`. |
| New EKUs for VBS enclaves | VBS enclaves are supported on Windows Server 2025 and later. *Existing* enclaves with the EKU 1.3.6.1.4.1.311.76.57.1.15 signature are still supported on Windows Server 2022 as long as they remain unchanged and don't require re-signing. |
| Windows Deployment Services (WDS) boot.wim image deployment | The operating system deployment functionality of WDS is being partially deprecated. Workflows that rely on `boot.wim` from Windows Server 2022 installation media shows a non-blocking deprecation notice, but the workflows aren't impacted.<br><br>Windows 11 workflows and workflows for future versions of Windows Server that rely on `boot.wim` from installation media is blocked.<br><br>Alternatives to WDS, such as [Microsoft Endpoint Configuration Manager](/mem/configmgr/) or the [Microsoft Deployment Toolkit](/windows/deployment/deploy-windows-mdt/get-started-with-the-microsoft-deployment-toolkit) (MDT), provide a better, more flexible, and feature-rich experience for deploying Windows images. You're advised to move to one of these solutions instead.<br><br>WDS PXE boot isn't affected. You can still use WDS to PXE boot devices to custom boot images. You can also still [run setup from a network share](/windows-hardware/manufacture/desktop/deploy-a-custom-image). Workflows that use custom `boot.wim` images, such as with Configuration Manager or MDT, aren't impacted. |
| Windows Internet Name Service (WINS) | WINS is a legacy computer name registration and resolution service. You should replace WINS with Domain Name System (DNS). For more information, see [Windows Internet Name Service (WINS)](../networking/technologies/wins/wins-top.md). |
| XDDM-based remote display driver | Starting with this release the Remote Desktop Services uses a Windows Display Driver Model (WDDM) based Indirect Display Driver (IDD) for a single session remote desktop. The support for Windows 2000 Display Driver Model (XDDM) based remote display drivers will be removed in a future release. Independent Software Vendors that use XDDM-based remote display driver should plan a migration to the WDDM driver model. For more information on implementing remote display indirect display driver, see [Updates for IddCx versions 1.4 and later](/windows-hardware/drivers/display/iddcx1.4-updates). |

# [Windows Server 2019](#tab/ws19)

| Feature | Explanation |
|--|--|
| Host Guardian Service Active Directory attestation mode | We're no longer developing Host Guardian Service Active Directory attestation mode. Instead, a new attestation mode is added, [host key attestation](../security/guarded-fabric-shielded-vm/guarded-fabric-create-host-key.md). Host key attestation is simpler and equally as compatible as Active Directory based attestation. This new mode provides equivalent functionality with a setup experience, simpler management, and fewer infrastructure dependencies than the Active Directory attestation. Host key attestation has no extra hardware requirements beyond what Active Directory attestation required, so all existing systems remain compatible with the new mode. To learn more about your attestation options, see [Deploy guarded hosts](../security/guarded-fabric-shielded-vm/guarded-fabric-configure-hgs-with-authorized-hyper-v-hosts.md). |
| IIS Digest Authentication | This authentication method is planned for replacement. Instead, you should start using other authentication methods such as Client Certificate Mapping. To learn more, see [Configuring One-to-One Client Certificate Mappings](/iis/manage/configuring-security/configuring-one-to-one-client-certificate-mappings) and [Application Settings](/iis-administration/configuration/appsettings.json). |
| IIS 6 Management compatibility | Specific features being considered for replacement are:<br><br><li>IIS 6 Metabase Compatibility (Web-Metabase)</li><li>IIS 6 Management Console (Web-Lgcy-Mgmt-Console)</li><li>IIS 6 Scripting Tools (Web-Lgcy-Scripting)</li><li>IIS 6 WMI Compatibility (Web-WMI)</li><br>IIS 6 Metabase Compatibility acts as an emulation layer between IIS 6-based metabase scripts and the file-based configuration used by IIS 7 or newer versions. You should start migrating management scripts to target IIS file-based configuration directly, by using tools such as the `Microsoft.Web.Administration` namespace.<br><br>You should also start migration from IIS 6.0 or earlier versions, and move to the latest version of IIS, which is always available in the most recent release of Windows Server. |
| Internet Storage Name Service (iSNS) | The Server Message Block (SMB) feature offers essentially the same functionality with more features. See [Server Message Block Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831795(v=ws.11)) for background information on this feature. |
| IPv4/6 Transition Technologies | 6to4 is disabled by default since Windows 10, version 1607 (the Anniversary Update). ISATAP is disabled by default since Windows 10, version 1703 (the Creators Update). Direct Tunnels is disabled by default. Use native IPv6 support instead. |
| Key Storage Drive in Hyper-V | We're no longer working on the Key Storage Drive feature in Hyper-V. If you're using generation 1 VM, check out [Generation 1 VM Virtualization Security](../virtualization/hyper-v/learn-more/generation-1-virtual-machine-security-settings-for-hyper-v.md) for information about options going forward. If you're creating new VMs, use Generation 2 VM with TPM devices for a more secure solution. |
| New EKUs for VBS enclaves | VBS enclaves are supported on Windows Server 2025 and later. *Existing* enclaves with the EKU 1.3.6.1.4.1.311.76.57.1.15 signature are still supported on Windows Server 2019 as long as they remain unchanged and don't require re-signing. |
| OneSync service | The OneSync service synchronizes data for the **Mail**, **Calendar**, and **People** apps. A sync engine to the Outlook app that provides the same synchronization was added. |
| Remote Differential Compression API support | Remote Differential Compression API support enabled synchronizing data with a remote source using compression technologies, which minimized the amount of data sent across the network. |
| RSA/AES Encryption for IIS | This encryption method is being considered for replacement because the superior Cryptography API: Next Generation (CNG) method is already available. To learn more, see [About CNG](/windows/win32/seccng/about-cng). |
| Storage Spaces in a Shared configuration using a SAS fabric | Deploy [Storage Spaces Direct](/azure/azure-local/concepts/storage-spaces-direct-overview?context=/windows-server/context/windows-server-storage) instead. Storage Spaces Direct supports the use of HLK-certified SAS enclosures, but in a non-shared configuration, as described in the [Storage Spaces Direct hardware requirements](../storage/storage-spaces/storage-spaces-direct-hardware-requirements.md). |
| Trusted Platform Module (TPM) management console | The information previously available in the TPM management console is now available on the [Device security](/windows/security/threat-protection/windows-defender-security-center/wdsc-device-security) page in the [Windows Defender Security Center](/windows/security/threat-protection/windows-defender-security-center/windows-defender-security-center). |
| WFP lightweight filter switch extension | The WFP lightweight filter switch extension enables developers to build [simple network packet filtering extensions for the Hyper-V virtual switch](/windows-hardware/drivers/network/using-virtual-switch-filtering). You can achieve the same functionality by creating a full filtering extension. As such, we'll be removing this extension in the future. |
| Windows PowerShell 2.0 | Migrate to Windows PowerShell 5.0 or later for the best features and performance. For more information, see the [PowerShell Documentation](/powershell/index?view=powershell-5.1&preserve-view=true). |
| Windows Server Essentials Experience | We're no longer developing the Essentials Experience role for the Windows Server Standard or Windows Server Datacenter SKUs. If you need an easy-to-use server solution for small-to-medium businesses, check out our new [Microsoft 365 for business](https://www.microsoft.com/microsoft-365/business) solution, or use [Windows Server 2016 Essentials](/windows-server-essentials/get-started/get-started). |
| [MultiPoint Services](../remote/multipoint-services/multipoint-services.md) | We're no longer developing the MultiPoint Services role as part of Windows Server. MultiPoint Connector services are available through [Feature on Demand](/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities) for both Windows Server and Windows 10. You can use [Remote Desktop Services](../remote/remote-desktop-services/remote-desktop-services-overview.md), in particular the Remote Desktop Services Session Host, to provide RDP connectivity. |
| [Offline symbol packages](/windows-hardware/drivers/debugger/debugger-download-symbols) (Debug symbol MSIs) | We're no longer making the symbol packages available as a downloadable MSI. Instead, the [Microsoft Symbol Server is moving to be an Azure-based symbol store](/archive/blogs/windbg/update-on-microsofts-symbol-server). If you need the Windows symbols, connect to the Microsoft Symbol Server to cache your symbols locally or use a manifest file with SymChk.exe on a computer with internet access. |
| [Software Restriction Policies](../identity/software-restriction-policies/software-restriction-policies.md) in Group Policy | Instead of using the Software Restriction Policies through Group Policy, you can use [AppLocker](/windows/security/threat-protection/applocker/applocker-overview) or [Windows Defender Application Control](/windows/security/threat-protection/windows-defender-application-control). You can use AppLocker and Windows Defender Application Control to manage which apps users can access and what code can run in the kernel. |

# [Windows Server 2016](#tab/ws16)

| Feature | Explanation |
|--|--|
| Configuration tools | `scregedit.exe` is deprecated. If you have scripts that depend on `scregedit.exe`, adjust them to use `reg.exe` or PowerShell methods.|
| NetCfg custom APIs | Installation of PrintProvider, NetClient, and ISDN using NetCfg custom APIs is deprecated. |
| Remote management | `WinRM.vbs` is deprecated. Instead, use functionality in the WinRM provider of PowerShell. |
| Sconfig.exe | Use [Sconfig.cmd](./sconfig-on-ws2016.md) instead. |
| SMB 2+ over NetBT | SMB 2+ over NetBT is deprecated. Instead, implement SMB over TCP or RDMA. |

---

## Features removed

We're removing the following features and functionalities from the installed product image in Windows Server. Applications or code that depend on these features won't function in future releases unless you use an alternate method. Removal occurs when a feature or functionality is no longer available for use and are eliminated from a product or service. The removal of features and functionalities can take place in any release of Windows Server. Some features are deprecated yet still ship in current versions of Windows Server. Components aren't removed from generally available supported versions that are within their product lifecycle.

# [Windows Server 2025](#tab/ws25)

| Feature | Explanation |
|--|--|
| Data Encryption Standard (DES) | DES, the symmetric-key block encryption cipher, is considered insecure against modern cryptographic attacks, and replaced by more robust encryption algorithms. DES was disabled starting with Windows Server 2008 R2 and is removed from Windows Server 2025 and later releases. |
| Internet Information Services (IIS) 6 Management Console (Web-Lgcy-Mgmt-Console) | The console is removed after being no longer developed in Windows Server 2019. You should also start migration from IIS 6.0 or earlier versions, and move to the latest version of IIS, which is always available in the most recent release of Windows Server. |
| NTLMv1 | Replace calls to NTLM by calls to [Negotiate](/windows/win32/secauthn/microsoft-negotiate), which tries to authenticate with Kerberos and only falls back to NTLM when necessary. For more information, see [The evolution of Windows authentication](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/the-evolution-of-windows-authentication/ba-p/3926848). |
| SMTP Server | As SMTP Server features were removed from Windows Server 2025, there's no replacement within the operating system. Consider using Exchange Server or a non-Microsoft SMTP server as an alternative. To learn more about enabling SMTP connection in Exchange Server, see [Receive connectors in Exchange Server](/exchange/mail-flow/connectors/receive-connectors). |
| Wordpad | We recommend Microsoft Word for rich text documents like `.doc` and `.rtf` and Windows Notepad for plain text documents like `.txt`. |

# [Windows Server 2022](#tab/ws22)

| Feature | Explanation |
|--|--|
| Internet Storage Name Service (iSNS) Server service | The iSNS Server service is removed after it was considered for removal in Windows Server version 1709. You can still connect to iSNS servers or add iSCSI targets individually. |

# [Windows Server 2019](#tab/ws19)

| Feature | Explanation |
|--|--|
| Business Scanning/<br> Distributed Scan Management (DSM) | We're removing this secure scanning and scanner management capability. There are no devices that support this feature. |
| [File Replication Service](https://support.microsoft.com/help/4025991/windows-server-version-1709-no-longer-supports-frs) (FRS) | Distributed File System (DFS) Replication replaced FRS. If you need to migrate any domain controllers that use FRS for the SYSVOL folder to DFS Replication, see [Streamlined Migration of FRS to DFSR SYSVOL](https://techcommunity.microsoft.com/t5/storage-at-microsoft/streamlined-migration-of-frs-to-dfsr-sysvol/ba-p/425405). |
| Hyper-V Network Virtualization (HNV) | [Network Virtualization](../networking/sdn/technologies/hyper-v-network-virtualization/whats-new-hyperv-network-virtualization-windows-server.md) is now included in Windows Server as part of the [Software Defined Networking](/azure/azure-local/concepts/software-defined-networking?context=/windows-server/context/windows-server-edge-networking) (SDN) solution. The SDN solution also includes the Network Controller, Software Load Balancing, User-Defined Routing, and Access Control Lists. |
| Nano Server installation option | Nano Server isn't available as an installable host operating system. Instead, Nano Server is available as a container operating system. To learn more about Nano Server as a container, see [Windows Container Base Images](/virtualization/windowscontainers/manage-containers/container-base-images). |
| Print components <br><br> (Now optional component for Server Core installations) | In previous releases of Windows Server, the print components were **disabled** by default in the Server Core installation option. We changed that in Windows Server 2016, enabling them by default. In Windows Server 2019, those print components are once again disabled by default for Server Core. If you need to enable the print components, you can do so by running the following cmdlet:<br><br> `Install-WindowsFeature Print-Server` |
| [Remote Desktop Connection Broker and Remote Desktop Virtualization Host](../remote/remote-desktop-services/desktop-hosting-service.md) in a Server Core installation | Most Remote Desktop Services deployments have these roles colocated with the Remote Desktop Session Host (RDSH), which requires Server with Desktop Experience. To be consistent with RDSH, we're changing these roles to also require Server with Desktop Experience. These RDS roles are no longer available for use in a [Server Core installation](../administration/server-core/what-is-server-core.md). If you need to [deploy these roles as part of your Remote Desktop infrastructure](../remote/remote-desktop-services/rds-deploy-infrastructure.md), you can [install them on Windows Server with Desktop Experience](../get-started/getting-started-with-server-with-desktop-experience.md). <br/><br/>These roles are also included in the Desktop Experience installation option of Windows Server 2019. |
| [RemoteFX 3D Video Adapter (vGPU)](../virtualization/hyper-v/deploy/deploy-graphics-devices-using-remotefx-vgpu.md) | We're developing new graphics acceleration options for virtualized environments. You can also use [Discrete Device Assignment (DDA)](../virtualization/hyper-v/plan/plan-for-deploying-devices-using-discrete-device-assignment.md) as an alternative. |
| Server Message Block (SMB) version 1 | Starting with this release, Server Message Block (SMB) version 1 is no longer installed by default. For details, see [SMBv1 isn't installed by default in Windows 10 version 1709, Windows Server version 1709 and later versions](../storage/file-server/Troubleshoot/smbv1-not-installed-by-default-in-windows.md). |

# [Windows Server 2016](#tab/ws16)

| Feature | Explanation |
|--|--|
| Journal.dll | The file `Journal.dll` is removed from Windows Server 2016. There's no replacement. |
| Security Configuration Wizard | The Security Configuration Wizard is removed. Instead, features are secured by default. If you need to control specific security settings, you can use either Group Policy or Microsoft Security Compliance Manager. |
| Share and Storage Management snap-in for Microsoft Management Console | If the computer you want to manage is running an operating system older than Windows Server 2016, connect to it with Remote Desktop and use the local version of the Share and Storage Management snap-in. On a computer running Windows 8.1 or earlier, use the Share and Storage Management snap-in from the Remote Server Administration Tools (RSAT) to view the computer you want to manage. Use Hyper-V on a client computer to run a virtual machine (VM) running Windows 7, Windows 8, or Windows 8.1 that has the Share and Storage Management snap-in in RSAT. |
| SQM | The opt-in components that manage participation in the Customer Experience Improvement Program is removed. |
| Windows Update | The `wuauclt.exe /detectnow` command is removed and no longer supported. To trigger a scan for updates, run the following PowerShell command:<br><br>`$AutoUpdates = New-Object -ComObject "Microsoft.Update.AutoUpdate"; $AutoUpdates.DetectNow()` |

---

## See also

- [Deprecation: What it means in the Windows lifecycle](https://techcommunity.microsoft.com/blog/windows-itpro-blog/deprecation-what-it-means-in-the-windows-lifecycle/4372457)
