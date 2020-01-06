---
title: Features removed or planned for removal in Windows Server 2019
description: Learn about the Features and functionalities removed or planned for removal starting with Windows Server 2019.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
author: jasongerend
ms.author: jgerend
manager: jasgro
ms.date: 10/22/2019
ms.localizationpriority: medium
---
# Features removed or planned for replacement starting Windows Server 2019

>Applies to: Windows Server 2019

Each release of Windows Server adds new features and functionality; we also occasionally remove features and functionality, usually because we've added a better option. Here are the details about the features and functionalities that we removed in Windows Server 2019.

> [!TIP]
> - You can get early access to Windows Server builds by joining the [Windows Insider program](https://insider.windows.com) - this is a great way to test feature changes.
> - Have questions about other releases? Check out [Features removed or planned for replacement in Windows Server](removed-features.md).

**The list is subject to change and might not include every affected feature or functionality.** 

## Features we removed in this release

We're removing the following features and functionalities from the installed product image in Windows Server 2019. Applications or code that depend on these features won't function in this release unless you use an alternate method.

| Feature	| Instead you can use... |
| --------- | -------------------- |
| Business Scanning, also called Distributed Scan Management (DSM)|We're removing this secure scanning and scanner management capability - there are no devices that support this feature. |
| Print components - now optional component for Server Core installations|In previous releases of Windows Server, the print components were *disabled* by default in the Server Core installation option. We changed that in Windows Server 2016, enabling them by default. In Windows Server 2019, those print components are once again disabled by default for Server Core. If you need to enable the print components, you can do so by running the **Install-WindowsFeature Print-Server** cmdlet. |
| [Remote Desktop Connection Broker and Remote Desktop Virtualization Host](../remote/remote-desktop-services/desktop-hosting-service.md) in a Server Core installation|Most Remote Desktop Services deployments have these roles co-located with the Remote Desktop Session Host (RDSH), which requires Server with Desktop Experience; to be consistent with RDSH we're changing these roles to also require Server with Desktop Experience. These RDS roles are no longer available for use in a [Server Core installation](../administration/server-core/what-is-server-core.md). If you need to [deploy these roles as part of your Remote Desktop infrastructure](../remote/remote-desktop-services/rds-deploy-infrastructure.md), you can [install them on Windows Server with Desktop Experience](../get-started/getting-started-with-server-with-desktop-experience.md). <br/><br/>These roles are also included in the Desktop Experience installation option of Windows Server 2019. |
| [RemoteFX 3D Video Adapter (vGPU)](../remote/remote-desktop-services/rds-remotefx-vgpu.md)|We're developing new graphics acceleration options for virtualized environments. You can also use [Discrete Device Assignment (DDA)](../virtualization/hyper-v/plan/plan-for-deploying-devices-using-discrete-device-assignment.md) as an alternative. |

## Features we're no longer developing

We're no longer actively developing these features and may remove them from a future update. Some features have been replaced with other features or functionality, while others are now available from different sources. 

If you have feedback about the proposed replacement of any of these features, you can use the [Feedback Hub app](https://support.microsoft.com/help/4021566/windows-10-send-feedback-to-microsoft-with-feedback-hub-app). 

| Feature	  | Instead you can use... |
| ----------- | --------------------- |
| Key Storage Drive in Hyper-V|We're no longer working on the Key Storage Drive feature in Hyper-V. If you're using generation 1 VMs, check out [Generation 1 VM Virtualization Security](../virtualization/hyper-v/learn-more/generation-1-virtual-machine-security-settings-for-hyper-v.md) for information about options going forward. If you're creating new VMs use Generation 2 virtual machines with TPM devices for a more secure solution. |
| Trusted Platform Module (TPM) management console|The information previously available in the TPM management console is now available on the [**Device security**](https://docs.microsoft.com/windows/security/threat-protection/windows-defender-security-center/wdsc-device-security) page in the [Windows Defender Security Center](https://docs.microsoft.com/windows/security/threat-protection/windows-defender-security-center/windows-defender-security-center). |
| Host Guardian Service Active Directory attestation mode|We're no longer developing Host Guardian Service Active Directory attestation mode - instead we've added a new attestation mode, [host key attestation](../security/guarded-fabric-shielded-vm/guarded-fabric-create-host-key.md), that's far simpler and equally as compatible as Active Directory based attestation.  This new mode provides equivalent functionality with a setup experience, simpler management and fewer infrastructure dependencies than the Active Directory attestation. Host key attestation has no additional hardware requirements beyond what Active Directory attestation required, so all existing systems will remain compatible with the new mode. See [Deploy guarded hosts](../security/guarded-fabric-shielded-vm/guarded-fabric-configure-hgs-with-authorized-hyper-v-hosts.md) for more information about your attestation options. |
| OneSync service | The OneSync service synchronizes data for the Mail, Calendar, and People apps. We've added a sync engine to the Outlook app that provides the same synchronization. |
| Remote Differential Compression API support | Remote Differential Compression API support enabled synchronizing data with a remote source using compression technologies, which minimized the amount of data sent across the network. |
| WFP lightweight filter switch extension | The WFP lightweight filter switch extension enables developers to build [simple network packet filtering extensions for the Hyper-V virtual switch](https://docs.microsoft.com/windows-hardware/drivers/network/using-virtual-switch-filtering). You can achieve the same functionality by creating a full filtering extension. As such, we'll be removing this extension in the future. |
