---
title: "What's new in the VM Conversion Extension for Windows Admin Center (Preview)"
description: Discover the latest features and enhancements in the VM Conversion Extension for Windows Admin Center (Preview) to improve security, performance, and flexibility.
#customer intent: As a virtualization administrator, I want to understand the new features in the VM Conversion Extension so that I can optimize my virtual machine migration process.
author: pmiddha
ms.author: pmiddha
ms.topic: release-notes
ms.date: 01/16/2026
ms.reviewer: shsathee,pmiddha

---

# What's new in the VM Conversion extension for Windows Admin Center (Preview)

> [!IMPORTANT]
> The VM Conversion extension is currently in PREVIEW.
> This document provides information about a prerelease product that might change substantially before its release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.
>
> As a preview extension, the VM Conversion extension is governed by the [Windows Admin Center prerelease extension software license terms](/legal/windows-server/windows-admin-center/windows-pre-release-extension-eula).
> Microsoft isn't obligated under this agreement to provide any support services for the software. Issues, questions, and feedback not covered in this documentation can be filed [here](https://github.com/MicrosoftDocs/Windows-Admin-Center-Ideas-and-Feedback).

This article provides release notes for the VM Conversion Extension in Windows Admin Center. Use these notes to learn about new features, enhancements, and bug fixes in each version.

The VM Conversion Extension helps you migrate VMware virtual machines to Hyper-V. Each release includes improvements to security, performance, reliability, and user experience.

---

## Version 1.13.7

_Released February 2026_

Download link: [Version 1.13.7](https://dev.azure.com/WindowsAdminCenter/Windows%20Admin%20Center%20Feed/_artifacts/feed/wac-public-extensions/NuGet/msft.sme.vm-conversion/overview/1.13.7)

## Bug fixes - Version 1.13.7

- Addressed a migration issue where **migration getting stuck at 25% due to lost vCenter connection**.

- Resolved an issue where a **migration failure caused in-progress synchronizations to fail**.

- Fixed the synchronization error: `Requested Registry key access is not allowed.`

- Addressed a **migration error during destination VM creation**. For example, when migrating VM `abcdef`, the following error could occur:

   ```description
   Failed to create destination VM: Fatal error:
   Failed to configure network for VM 'abcdef'.
   Error: The property 'Name' cannot be found on this object.
   Verify that the property exists. (91%)
   ```

## Version 1.8.6

_Released January 2026_

Download link: [Version 1.8.6](https://dev.azure.com/WindowsAdminCenter/Windows%20Admin%20Center%20Feed/_artifacts/feed/wac-public-extensions/NuGet/msft.sme.vm-conversion/overview/1.8.6)

### Improvements

- Improved pre-check validation by ensuring Change Block Tracking (CBT) is enabled before synchronization readiness checks.

- Enhanced VM creation to correctly refresh and apply CPU, memory, and operating system settings when values are incomplete or invalid.

### Bug fixes

- Fixed an issue that could block migrations when required change tracking information was missing.

- Resolved a synchronization issue that could occur when VMware credentials contained a single quote (').

- Fixed an intermittent issue where the UI incorrectly reported that PowerCLI wasn't installed when it was already available.

---

## Version 1.8.5

_Released December 2025_

Download link: [Version 1.8.5](https://dev.azure.com/WindowsAdminCenter/Windows%20Admin%20Center%20Feed/_artifacts/feed/wac-public-extensions/NuGet/msft.sme.vm-conversion/overview/1.8.5)

### New features and enhancements

#### Secure Boot configuration reliability
- Added logic to automatically power off the VM before applying Secure Boot settings.
- Fixes failures that happen when you configure Secure Boot on a running VM.

#### Early change ID validation
- Added prevalidation for missing disk change IDs.
- Provides clear and early error messaging, avoiding unexpected failures later in the workflow.

#### Power state alignment
- Ensures the destination VMs power state consistently matches the source VM’s final power state after migration.
    - If the source VM is off and migration succeeds → destination VM remains off.
    - If the source VM is off and migration fails → source VM remains off.

#### Enhanced synchronization experience
- Introduced asynchronous file-path validation in the Synchronization Confirmation dialog.
- Reduces UI blocking and improves responsiveness during sync initiation.

#### Telemetry improvements
- Added additional telemetry signals to improve:
    - Performance analysis
    - Workflow reliability tracking
    - Troubleshooting efficiency

#### Security improvements
- Implemented log sanitization in the PowerShell layer to mask sensitive data.
- Ensures secure handling of credentials across logs and event traces.

#### VM list component update
- Reduced the VM synchronization and migration limit from 50 to 10 to improve reliability.
- Updated corresponding error and guidance messages to reflect the new threshold.

### Bug fixes

- Fixed an issue where powering on a VM resulted in the error: 'Validation failed for one or more fields.'
- Resolved an issue causing the error: 'Failed to create destination VM: cpuCount must be a positive number.'
- Addressed a problem where closing the browser mid-migration caused workflows to appear stuck at 80% when returning to Windows Admin Center. The Import VM step now automatically resumes and completes correctly.

---

## Version 1.8.3

_Released October 2025_

Download link: [Version 1.8.3](https://dev.azure.com/WindowsAdminCenter/Windows%20Admin%20Center%20Feed/_artifacts/feed/wac-public-extensions/NuGet/msft.sme.vm-conversion/overview/1.8.3)

### New features and enhancements

#### PowerCLI installation support
- Added a **PowerCLI installation option** on the landing page to help users set up the required component on the gateway.  
- Introduced an **alert banner** on the VM List and vSphere List pages that notifies users if PowerCLI is missing, with a direct link to install it.

#### Migration workflow improvements
- Improved stability, validation, and error handling for a smoother migration experience.

### Bug fixes

- Fixed an issue where the **Submit** button in the vCenter credentials dialog could remain disabled after a failure.  
- Resolved a problem where migrations could get stuck at **80% progress**.  

---

## Version 1.8.2

_Released October 2025_

Download link: [Version 1.8.2](https://dev.azure.com/WindowsAdminCenter/Windows%20Admin%20Center%20Feed/_artifacts/feed/wac-public-extensions/NuGet/msft.sme.vm-conversion/overview/1.8.2)

### New features

- **vCenter Version Display:**  
  You can now view the vCenter version directly on the **vCenter List** page for easier identification and management.

- **Migration Reconnection Banner:**  
  A new banner now appears, prompting users to stay signed in and refresh their session every 2 hours during migration to ensure continuity.

- **Quick Access to Documentation:**  
  The **“Open in New Window”** icon on the landing page now links directly to the official guide—
  [Migrate VMware Virtual Machines to Hyper-V in Windows Admin Center (Preview)](../use/vm-conversion-extension-overview.md).

### Other improvements

- Enhanced telemetry for improved diagnostics and secure handling of environment information.

---

## Version 1.8.0

_Released September 2025_

Download link: [Version 1.8.0](https://dev.azure.com/WindowsAdminCenter/Windows%20Admin%20Center%20Feed/_artifacts/feed/wac-public-extensions/NuGet/msft.sme.vm-conversion/overview/1.8.0)

### New features

- **Bulk VM Migration with Queuing Support**

    To migrate multiple VMs, select up to **10 virtual machines per operation**. Queuing improves performance and stability during large-scale migrations.  

    >[!NOTE]  
    >Ensure you stay signed in to Windows Admin Center -> VM Conversion Extension -> vCenter, and refresh your session every 2 hours.  
    >The browser session must stay active during the final migration step.  

- **Static IP Batch Support**

    Bulk migration now supports **static IP migration** for both **Windows** and **Linux** virtual machines. This feature automates network configuration, reducing manual reconfiguration after migration.

- **Batch Uninstall of VMware Tools (Windows VMs)** 

    You can now uninstall VMware Tools from multiple Windows virtual machines in a single batch operation before migration, streamlining the preparation process.

    >[!NOTE]
    >While batch uninstall is supported for Windows VMs, Linux VMs still require manual removal.

- **BIOS UUID Migration**

    The migration process now preserves the BIOS UUID from the source VM, ensuring improved compatibility and identity synchronization on Hyper-V.

    >[!NOTE]
    >Only the BIOS UUID is migrated. BIOS serial number format differs between VMware and Hyper-V, which can affect licensing checks. For more information, see [FAQ](vm-conversion-extension-faq.yml).

- **Standardized Destination Folder Structure**

    The destination VM folder structure now follows **Hyper-V conventions**. The Synchronization Confirmation dialog displays the folder path, helping administrators verify and predict destination locations.

- **Thick and Thin Disk Provisioning**

    During synchronization, you create VM disks as **thick (fixed)** or **thin (dynamic)** to match the **source VM’s configuration**, optimizing storage use, and simplifying post-migration management.

### Bug fixes

- Resolved migration error: *Physical network adapter 'Ethernet' not found*.  
- Corrected VM listing problem where the extension incorrectly marked VMs as failed when they were already present in **Hyper-V Manager**.    
- Improved notification accuracy during migration progress.  
- Enhanced prechecks for PowerCLI installation to catch failures early and provide clearer troubleshooting guidance.

### User experience changes

- **Session persistence for bulk migration**

  - Stay signed in to Windows Admin Center -> VM Conversion Extension -> vCenter and keep your browser session active throughout migration.

  - You must keep the browser session active during the final migration step.

- **Folder structure transparency**  

  - Destination folders now directly reflect **Hyper-V layout**.  
 
  - The Synchronization Confirmation dialog explicitly shows the destination path.

- **Linux VMs** - Install Hyper-V drivers on the guest OS before migration.  

- **Windows VMs** - VMware Tools batch uninstall is supported only for Windows VMs.  

- **Licensing note** - Differences in BIOS Serial Number might affect licensing. See [FAQ](vm-conversion-extension-faq.yml) for details.

## Related content

- [Overview of VMware to Hyper-V migration](vm-conversion-extension-overview.md)
- [Migrate VMware VMs to Hyper-V in Windows Admin Center](migrate-virtual-machines-vm-conversion-extension.md)
- [Troubleshoot VM Conversion Extension](troubleshoot-vm-conversion-extension.md)
- [VMware to Hyper-V migration FAQ](vm-conversion-extension-faq.yml)