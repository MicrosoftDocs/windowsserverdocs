---
title: OSConfig overview
description: OSConfig is a cross-platform scenario-based security tool to manage on-premises Windows Server 2025 and Arc-connected devices.
ms.topic: conceptual
ms.author: wscontent
author: xelu86
ms.contributor: Dona Mukherjee
ms.date: 09/24/2024
---

# OSConfig overview

OSConfig is a security configuration stack that utilizes scenarios to efficiently deliver and apply administrative intent for achieving the desired state of on-premises and Arc-connected devices. The OSConfig stack is composed of base cmdlets, native APIs, and a Scenario definition that defines the desired state configuration. The Scenario definition is a data-driven description of configurations, which describe a group of settings using name-value pairs with a predefined order and dependencies, corresponding to different subareas. OSConfig is a device configuration stack that is commonly shipped with the Windows Server Operating System (OS), providing an abstraction for local device configuration. Its object model design is data-driven, allowing for mapping to various providers in the Windows OS for device configuration.

Currently, OSConfig is employed to establish security baselines for various Microsoft Edge OSs such as Windows Server 2025 and Azure Stack HCI 23H2. It seamlessly integrates with Azure Policy, Microsoft Defender, Windows Admin Center, and Automanage Machine configuration to facilitate monitoring and compliance reporting. OSConfig is a potent tool that enables improved mapping or even direct conversion with other pre-existing management definitions, such as `.admx` files in Group Policy, `.mof` files within Windows Management Instrumentation (WMI), and Device Description Framework (DDF) files within the Configuration Service Provider (CSP).

## OSConfig drift control

One of the main features of OSConfig is known as *Drift Control*. When enabled, OSConfig is designed to automatically correct any system changes that deviate from the desired state. This is achieved through a refreshing task. When disabled, the refresh task is also disabled, and users can use other tools, with or without OSConfig, to modify the system. Each management tool can serve various purposes and be used by different actors, resulting in multiple authorities managing the same set of device settings. For instance, Azure Policy can be used for cloud or Arc-enabled resources at scale, while Windows Admin Center (WAC) can be used for local management.

To address multiple authorities, an orchestrator was developed that ensures deterministic configuration in a multi-authority environment where various IT admin tools are utilized. Under this model, each authority is assigned a precedence order, and the authority with a higher precedence order takes precedence over lower precedence. This applies not only from a configuration perspective but also ensures that drift control is allowed per authority and even per scenario document. For users with resources in Azure Cloud or Arc-enabled, the cloud authority (Azure Policy) has the highest precedence, followed by the local authority (WAC and PowerShell) and any other deployment tool.

## OSConfig security baselines

Windows Server allows you to prioritize security from the outset by deploying a recommended security posture to your devices and Virtual Machines (VM). Throughout the device lifecycle, users can apply these security baselines by using PowerShell or WAC. One of the standout features of OSConfig is the inbuilt drift control mechanism, which ensures that the system starts and remains in a known good security state.

Applying the OSConfig security baselines in your environment provides the following:

- Enhances the security posture by disabling legacy protocols and ciphers.
- Reduces OpEx (operating expenses) with a built-in drift protection mechanism that enables consistent at-scale monitoring via the Azure Arc Hybrid Edge baseline.
- Enables you to closely meet the [Center for Internet Security (CIS) Benchmark](https://www.cisecurity.org/cis-benchmarks) and [Defense Information Systems Agency Security Technical Implementation Guides](https://public.cyber.mil/stigs) (DISA STIG) requirement for the recommended OS security baseline.

### OSConfig security benefits

OSConfig is a valuable security configuration platform that applies security payloads to devices throughout their entire lifespan and is summarized as follows:

- One platform that supports the entire Configuration Lifecycle, including secure configuration, remediation, monitoring, reporting, and versioning.
- Provides a scalable, data-driven solution with a single, consistent implementation for several administrative tool sets to use, such as WAC, Arc, PowerShell, Azure Policy, and Azure Automanage Machine Configuration.
- Drives consistent results and enforces which authority takes precedence through the multiple authority model.
- Supports orchestration directives that honor prerequisites and inter-dependencies between settings.
- Enforces the desired state via configuration drift detection, reporting, and correction.
- Provides abstraction to allow extensibility models that support different configuration providers.

## See Also

- [How to deploy OSConfig security baseline](osconfig-how-to-configure-security-baseline.md)
