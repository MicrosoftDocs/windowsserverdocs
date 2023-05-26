---
title: #Required; page title is displayed in search results. Include the brand.
description: #Required; article description that is displayed in search results. 
author: robinharwood
ms.author: wscontent
ms.topic: how-to
ms.date: 05/26/2023
ms.custom: template-how-to-pattern
---

<!--
Remove all the comments in this template before you sign-off or merge to the 
main branch.

This template provides the basic structure of a How-to article pattern. See the
[instructions - How-to](../level4/article-how-to-guide.md) in the pattern library.

You can provide feedback about this template at: https://aka.ms/patterns-feedback

<!-- 1. H1 -----------------------------------------------------------------------------

Required: Start your H1 with a verb. Pick an H1 that clearly conveys the task the user 
will complete.

-->

# [H1 heading]
TODO: Add your heading

<!-- 2. Introductory paragraph ----------------------------------------------------------

Required: Lead with a light intro that describes, in customer-friendly language, what the 
customer will do. Answer the fundamental “why would I want to do this?” question. Keep it 
short.
Readers should have a clear idea of what they will do in this article after reading the 
introduction.

-->

[Add your introductory paragraph]
TODO: Add your introductory paragraph

<!-- 3. Prerequisites --------------------------------------------------------------------

Optional: If there are prerequisites for the task covered by the how-to guide, make 
**Prerequisites** your first H2 in the guide. The prerequisites H2 is never numbered.
Use clear and unambiguous language and use a unordered list format.
If there are specific versions of software a user needs, call out those versions (for example: 
Visual Studio 2019 or later).

-->

## Prerequisites

### Firmware

TPM 2.0
Secure Boot
Virtualization Extensions
DRTM + Transparent Secure Memory Encryption for AMD based systems
DMAR
TODO: Determine if prerequisites are appropriate
TODO: List the prerequisites if appropriate
May vary per hardware vendor, check vendor guidance

<!-- 4. Task H2s ------------------------------------------------------------------------------

Required: Each major step in completing a task should be represented as an H2 in the article.
These steps should be numbered.
The procedure should be introduced with a brief sentence or two.
Multiple procedures should be organized in H2 level sections.
Procedure steps use ordered lists.

-->

#### [GUI](#tab/gui)

1. Computer management, Device Manager, check all drivers are functioning correctly (prereq)
1. Confirm DRTM device is present for AMD based systems
1. Launch the Windows Security App
1. Device securtiy
1. Core isolation
1. enable Memory Integrity and Firmware Protection, sliders to On
1. Restart when prompted
1. Open System Information (msinfo32)
    1. Confirm Secure Boot State and Kernel DMA Protection is On
    1. Confirm Virtualization-based security is Running
    1. Confirm Virtualization-based security Services Running shows Hypervisor enforced Code Integrity and Secure Launch


#### [Windows Admin Center](#tab/WAC)

1. Sign into WAC
1. Select your sever
1. Nagivate to the Secure tool from the left-hand navigation panel, then select the Secured-core tab
1. Check the Security Features with a status of Not configured, then select Enable
1. When notified, select Schedule system reboot to persist the changes
1. Select either the Restart immediately or Schedule restart at a time suitable for you workload
1. Return to the WAC Security tool, confirm each of the Security Features have a status on On

#### [Registry](#tab/registry)

HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity
Enabled = 1 DWORD
WasEnabledBy = 0 DWORD

HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard
Enabled = 1 DWORD

Restart

---

<!-- 5. Next steps ------------------------------------------------------------------------

Required: Provide at least one next step and no more than three. Include some context so the 
customer can determine why they would click the link.
Add a context sentence for the following links.

-->

## Next steps
TODO: Add your next step link(s)

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.

-->