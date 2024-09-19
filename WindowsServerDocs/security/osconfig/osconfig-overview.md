---
title: OSConfig overview
description: OSConfig is a cross-platform scenario-based security tool to manage on-premises Windows Server 2025 and Arc-connected devices.
ms.topic: conceptual
ms.author: wscontent
author: xelu86
ms.date: 09/17/2024
---

# OSConfig overview

OSConfig is a security configuration stack that utilizes scenarios to efficiently deliver and apply administrative intent for achieving the desired state of on-premises and Arc-connected devices. The OSConfig stack comprises base cmdlets, native APIs, and a Scenario definition document. The Scenario definition is a data-driven description of configurations in a JSON payload, which describes a group of settings using name-value pairs with a predefined order and dependencies, corresponding to different subareas. OSConfig is a device configuration stack that is commonly shipped with the Windows Server Operating System (OS), providing an abstraction for local device configuration. Its object model design is data-driven, allowing for mapping to various providers in the Windows OS for device configuration.

Currently, OSConfig is employed to establish security baselines for various Microsoft Edge OSs such as Windows Server 2025 and ASZ HCI. It seamlessly integrates with Azure Policy, Microsoft Defender, Windows Admin Center, and Automanage Machine configuration to facilitate monitoring and compliance reporting. OSConfig is a potent tool that enables improved mapping or even direct conversion with other pre-existing management definitions, such as `.admx` files in Group Policy, `.mof` files within Windows Management Instrumentation (WMI), and Device Description Framework (DDF) files within the Configuration Service Provider (CSP).

## OSConfig drift control

One of the main features of OSConfig is known as *Drift Control*. When enabled, OSConfig is designed to automatically correct any system changes that deviate from the desired state. This is achieved through a refreshing task. When disabled, the refresh task is also disabled, and users can use other tools, with or without OSConfig, to modify the system. A single global drift control is in place to halt the refresh task for all device settings. However, not all configuration authorities that calls on OSConfig are considered the "default authority".

Each management tool can serve various purposes and be used by different actors, resulting in multiple authorities managing the same set of device settings. For instance, Azure Policy can be used for cloud or Arc-enabled resources at scale, while Windows Admin Center (WAC) can be used for local management. To address multiple authorities, an orchestrator was developed that ensures deterministic configuration in a multi-authority environment where various IT admin tools are utilized. Under this model, each authority is assigned a precedence order, and the authority with a higher precedence order takes precedence over lower precedence. This applies not only from a configuration perspective but also ensures that drift control is allowed per authority and even per scenario document. For users with resources in Azure Cloud or Arc-enabled, the cloud authority (Azure Policy) has the highest precedence, followed by the local authority (WAC and PowerShell) and any other deployment tool.

## OSConfig security baseline

Windows Server allows you to prioritize security from the outset by deploying a recommended security posture to your devices and Virtual Machines (VM). This can be achieved by applying a tailored security baseline that includes over 350 preconfigured Windows security settings. Through this approach, you can ensure the implementation of precise security settings that are compliant with relevant security standards.

Throughout the device lifecycle, users can apply the security baseline starting from the initial deployment by using PowerShell or WAC. These tools are part of the new security configuration platform. One of the standout features of this platform is the inbuilt drift control mechanism, which ensures that the system starts and remains in a known good security state. By utilizing this mechanism, users can maintain the desired security posture over time.

By using this security baseline, you can closely align with the:

- [Center for Internet Security (CIS) Benchmark](https://www.cisecurity.org/cis-benchmarks).
- [Defense Information Systems Agency Security Technical Implementation Guides](https://public.cyber.mil/stigs) (DISA STIG).
- [Federal Information Processing Standards (FIPS) 140-2](https://csrc.nist.gov/pubs/fips/140-2/upd2/final) requirements for the OS, and Azure Compute Security baselines.

> [!NOTE]
> These security baselines are enabled by default, making it easier for users to meet their compliance and regulatory requirements. The security baseline settings have been thoroughly verified for compatibility and performance impact.

### OSConfig security benefits

OSConfig is a valuable security configuration platform that applies security payloads to devices throughout their entire lifespan and is summarized as follows:

- One platform that supports the entire Configuration Lifecycle, including secure configuration, remediation, monitoring, reporting, and versioning.
- Provides a scalable, data-driven solution with a single, consistent implementation for several administrative tool sets to use, such as WAC, Arc, PowerShell, and Azure Guest config.
- Drives consistent results and enforces which authority takes precedence through the multiple authority model.
- Supports orchestration directives that honor prerequisites and inter-dependencies between settings.
- Enforces the desired state via configuration drift detection, reporting, and correction.
- Provides abstraction to allow extensibility models that support different configuration providers.

## See Also

- [How to deploy OSConfig security baseline](osconfig-how-to-configure-security-baseline.md)
