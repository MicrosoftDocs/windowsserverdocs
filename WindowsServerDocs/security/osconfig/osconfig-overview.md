---
title: OSConfig Overview for Windows Server
description: OSConfig is a cross-platform scenario-based security tool to manage on-premises Windows Server and Azure Arc-connected devices.
ms.topic: concept-article
ms.author: roharwoo
author: robinharwood

ms.date: 07/02/2026
ai-usage: ai-assisted

#customer intent: As a server administrator, I want to understand what OSConfig is and how it works so that I can use it to secure and maintain the desired state of my servers.
---

# OSConfig security configuration for Windows Server

OSConfig is a security configuration tool for Windows Server that applies and maintains a known good security state on your devices. It uses *scenarios*, which are predefined groups of settings, to deliver a consistent configuration to on-premises and Azure Arc-connected devices across their life cycle.

Over time, servers drift away from their intended security configuration, and applying settings consistently across many devices and management tools is hard to do by hand. OSConfig helps you keep each device in its intended state by detecting and correcting this drift automatically, so your servers stay secure and compliant.

This article explains what OSConfig is, how it works, and the scenarios it supports, so you can decide how to use it to secure and maintain your servers.

## How OSConfig works

The OSConfig stack consists of base cmdlets, native APIs, and a scenario definition that defines the desired state configuration. The scenario definition is a data-driven description of configurations. The configurations are groups of settings that use name/value pairs with a predefined order and dependencies that correspond to subareas.

The object model design is data driven, which allows mapping to various providers in the Windows operating system (OS) for device configuration. The following diagram describes the OSConfig flow.

:::image type="complex" source="../media/osconfig/osconfig-module-flowchart.png" alt-text="Flowchart of the OSConfig stack that shows management tools applying configuration through the OSConfig PowerShell module to a device.":::
   Flowchart of the OSConfig stack that shows how management tools apply configuration to a device. At the top, three out-of-band management sources sit above a dashed line: Windows Admin Center, Azure Policy and Machine Configuration, and Local Tooling. Each source has an arrow that points down to the OSConfig PowerShell module, which spans the width of the diagram as a band labeled Out of Band. A single arrow leads from the OSConfig PowerShell module down into a container labeled Device. Inside the Device container, three stacked boxes are connected by downward arrows in sequence: the OSConfig API and Platform passes to Configuration Providers, such as CSPs and registries, which in turn apply Security Features.
:::image-end:::

On Windows Server 2025, OSConfig integrates with Azure Policy, Microsoft Defender, Windows Admin Center, and Azure Policy machine configuration to support monitoring and compliance reporting. It also enables improved mapping or even direct conversion with other preexisting management definitions. These definitions include `.admx` files in Group Policy, `.mof` files in Windows Management Instrumentation (WMI), and Device Description Framework (DDF) files in the configuration service provider (CSP).

As a single platform, OSConfig:

- Applies configuration payloads across the device life cycle, including configuration, remediation, monitoring, reporting, and versioning.
- Works consistently across Windows Admin Center, Azure Arc, PowerShell, Azure Policy, and Azure Policy machine configuration.
- Honors prerequisites and dependencies among settings through orchestration directives.
- Maintains the desired state through configuration drift detection, reporting, and correction.

## OSConfig drift control

One of the main features of OSConfig is *drift control*. It helps ensure that the system starts and remains in a known good security state. When you turn it on, OSConfig automatically corrects any system changes that deviate from the desired state. OSConfig makes the correction through a refresh task.

When you turn off the feature, OSConfig also disables the refresh task. You can then use other tools, with or without OSConfig, to modify the system. Each management tool can serve various purposes, and different actors can use it, so multiple authorities can manage the same set of device settings. For instance, authorities can use Azure Policy for cloud or Azure Arc-enabled resources at scale, whereas they can use Windows Admin Center for local management.

To address multiple authorities, an orchestrator ensures deterministic configuration in an environment where multiple authorities use various IT admin tools. Under this model, each authority receives a precedence order. This precedence order doesn't just apply from a configuration perspective. It also allows drift control per authority and even per scenario document.

If you use cloud or Azure Arc-enabled resources, the precedence order is:

1. Cloud authority (Azure Policy)
1. Local authority (Windows Admin Center and Windows PowerShell)
1. Any other deployment tool

## OSConfig supported scenarios

OSConfig delivers configuration through scenarios. On Windows Server 2025, the supported scenarios fall into two areas: security baselines and App Control for Business.

### Security baselines

OSConfig-driven security baselines apply a recommended, role-aware security posture to your servers and virtual machines. Throughout the device life cycle, you apply them by using PowerShell or Windows Admin Center, and drift control helps keep each server in its known good state. This area includes:

- The Windows Server security baseline, tailored to the server role.
- Microsoft Defender Antivirus configuration.
- Windows Local Administrator Password Solution (LAPS).
- Secured-core server configuration.

Applying the security baselines helps you:

- Strengthen the security posture by disabling legacy protocols and ciphers.
- Reduce operating effort through built-in drift control for consistent, at-scale monitoring.
- Work toward the [Center for Internet Security (CIS) Benchmarks](https://www.cisecurity.org/cis-benchmarks) and [Defense Information Systems Agency Security Technical Implementation Guides (DISA STIGs)](https://public.cyber.mil/stigs) recommendations for the OS security baseline.

### App Control for Business

App Control for Business helps you control which applications and code can run on your servers, helping to reduce the risk from unauthorized or untrusted software. OSConfig provides a scenario to apply and maintain this configuration as part of the same desired-state model.

## Related content

- [Deploy security baselines with OSConfig](osconfig-how-to-configure-security-baselines.md)
- [Deploy App Control for Business with OSConfig](/windows/security/application-security/application-control/app-control-for-business/appcontrol)
