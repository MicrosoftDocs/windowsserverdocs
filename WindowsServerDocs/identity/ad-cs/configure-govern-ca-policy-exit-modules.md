---
title: Configure AD CS Policy and Exit Modules
titleSuffix: Windows Server
description: Safely configure and govern AD CS certification authority (CA) policy and exit modules, including a tested change and rollback process, on Windows Server 2025.
#customer intent: As an IT administrator, I want to configure and govern CA policy and exit modules so that certificate requests and CA events are processed securely.
author: orin-thomas
ms.author: orthomas
ms.topic: how-to
ms.date: 08/17/2026
ai-usage: ai-assisted
---

# Configure and govern certification authority policy and exit modules

Active Directory Certificate Services (AD CS) policy and exit modules are part of the Certification Authority service. A policy module evaluates certificate requests and determines whether the certification authority (CA) issues, denies, or holds them pending. An exit module receives CA notifications after operations such as certificate issuance. Because Certificate Services loads and calls these modules while it processes requests, a module change can affect every request that the CA handles.

You might need to add a custom module to connect the CA to an external system, or to confirm that the supported default module is still in place. Because a bad change can stop the CA from issuing certificates, you need a tested, reversible process.

This article explains the CA module model, distinguishes it from Network Device Enrollment Service (NDES) policy modules, and provides a conservative change and rollback process for Windows Server 2025.

## Prerequisites

- A nonproduction CA that represents the production CA type, templates or standalone policy, client populations, and required exit destinations.
- A supported module version from Microsoft or the module vendor that explicitly supports Windows Server 2025 and the CA's architecture and dependencies.
- A documented owner for the module, its configuration, its signing and update process, its network destinations, and its rollback package.
- A current CA backup and a recorded baseline of the CA **Policy Module** and **Exit Module** settings. Follow your approved backup procedure, such as [Backup-CARoleService](/powershell/module/adcsadministration/backup-caroleservice), before the change.
- A planned service interruption and a validation plan that includes issuance, denial, pending disposition, and every required exit-module outcome.
- A CA administrator account. You need the **Manage CA** permission to configure policy and exit modules; the **Issue and Manage Certificates** permission that a certificate manager uses isn't sufficient.

> [!CAUTION]
> Don't install, register, or replace a third-party module in production by using generic instructions. Follow the module vendor's documented registration and configuration procedure. A DLL that's compatible with one CA version or architecture might prevent the Certification Authority service from starting on another.

## Understand the three policy surfaces

The following components have similar names but different scopes. Treating them as interchangeable can weaken enrollment controls or change the wrong service.

| Component | Scope | What it does |
|---|---|---|
| CA policy module | The Certification Authority service | Evaluates every request the CA receives and issues, denies, or holds it pending. It can also set or modify certificate extensions, the `NotBefore` and `NotAfter` properties, and the subject relative distinguished name, subject to restrictions. A CA has one active policy module. |
| CA exit module | The Certification Authority service | Receives operation notifications. It can inspect request and certificate properties but can't modify them. A CA can use more than one exit module. |
| NDES policy module | Network Device Enrollment Service (MSCEP) | Verifies and constrains Simple Certificate Enrollment Protocol (SCEP) challenge-password requests before NDES forwards an enrollment request to a CA. It doesn't configure the CA **Policy Module** tab or replace CA policy. NDES supports one registered NDES policy module. |

For the CA, policy and exit modules are Component Object Model (COM)-integrated DLLs that Certificate Services invokes as part of its server architecture. They aren't the same as the NDES policy module described in [Use a policy module with Network Device Enrollment Service](use-policy-module-with-network-device-enrollment-service.md).

## Retain supported default policy and exit module behavior

An enterprise CA should use only the Microsoft-provided enterprise policy module. That module uses certificate templates and template access control lists to authorize enrollment, adds predefined extensions to issued certificates, and supports smart card sign-in certificates. Replacing it removes those evaluation semantics, so don't replace it on an enterprise CA.

A standalone CA uses its own default policy behavior and normally holds certificate requests pending for manual review. Review and approve those requests as described in [Review and dispose of pending certificate requests](review-dispose-pending-certificate-requests.md).

Keep the default enterprise exit module enabled on an enterprise CA, even when you add a custom exit module. The CA supports multiple exit modules, but each additional module expands the CA's code, configuration, data, and availability dependencies.

## Plan the policy or exit module change

Before you make any configuration change, create a change record that answers the following questions:

1. What request decision or post-issuance outcome can't the existing Microsoft module provide?
1. Which CA type, certificate templates, or standalone policy paths does the change affect?
1. What data can the module read, transform, send, or publish, and where does it send that data?
1. How does the module behave when a destination, dependency, certificate, or network path fails?
1. Which module configuration and binaries restore the last known-good state?
1. Which requests arrive during the change window, and how will you reconcile their disposition afterward?

Use a signed, version-controlled vendor package. Verify its publisher and hash through your organization's approved software-integrity process. Don't grant broad local administrator, file-share write, or network permissions just to make an exit module work. Instead, limit each dependency to the least privilege required and test those permissions on the nonproduction CA.

## Security considerations for CA policy and exit modules

Treat a custom policy or exit module as privileged CA code. Certificate Services loads and calls it while processing requests, so it can affect the availability and security behavior of every request the CA handles. Limit who can introduce, update, configure, or roll back the module, and require an independently approved recovery package.

Keep CA administration separate from certificate management. The CA administrator controls module selection and configuration; the certificate manager controls request disposition. For an exit module, protect every notification and publication destination against unauthorized access, unexpected data disclosure, and injection through values derived from certificate requests.

## Configure a CA policy module

Use this procedure only after the module vendor provides a supported installation and configuration sequence.

1. On the nonproduction CA, open **Certification Authority**.
1. Select the CA name, and then select **Properties** on the **Action** menu.
1. Select the **Policy Module** tab and record the currently selected module and any module-specific configuration.
1. For an enterprise CA, keep the Microsoft-provided enterprise policy module selected. Don't replace it.
1. For a standalone CA, use a custom policy module only when the default policy is unsuitable and the vendor supports the intended Windows Server 2025 configuration.
1. On a standalone CA, if you need a supported custom policy module, follow the vendor's registration procedure, and then select it through the **Policy Module** tab.
1. Select **Properties** only to configure settings that the module provider documents.
1. Schedule the required Certification Authority service restart. Don't apply a policy-module change during an unplanned outage or while critical enrollment requests are unaccounted for.

> [!IMPORTANT]
> A policy module controls the CA decision point. Test allowed, denied, and pending requests separately. A successful service restart doesn't demonstrate that template authorization, subject-name controls, or pending-request behavior remain correct.

## Configure CA exit modules

Exit modules receive CA notifications and can publish or notify after CA operations. They don't modify the certificate or request properties that they inspect.

1. On the nonproduction CA, open **Certification Authority**.
1. Select the CA name, and then select **Properties** on the **Action** menu.
1. Select the **Exit Module** tab and record every enabled exit module before you change the selection.
1. Confirm whether the default enterprise exit module must remain enabled. Keep it enabled on an enterprise CA.
1. Install or register the custom exit module only through the vendor's supported procedure.
1. On the **Exit Module** tab, select **Add** only for the module that the vendor's procedure registered.
1. Select **Properties** to configure documented settings.
1. Review each destination for certificate data, request attributes, notification recipients, authentication, authorization, TLS, retention, and failure behavior.
1. Restart the Certification Authority service during the approved change window, and then run the validation plan.

Don't assume that an exit module's destination is private just because the CA is private. Issued certificates, request attributes, names, and event details can be sensitive in some environments. Use authenticated destinations, protect stored data, and avoid including secrets in notifications.

## Validate the module change

First, confirm that you can reach the target CA administrative interface:

```cmd
certutil -config "CAHOST\Contoso Issuing CA" -pingadmin
```

> [!NOTE]
> Use `certutil` as an administrative inspection tool, not in production application code. Microsoft doesn't provide live-site support or application-compatibility guarantees for that use.

Then, test the module on the nonproduction CA with requests that cover the expected decision and notification paths:

1. Submit an authorized request. Verify the policy result and the issued certificate's required identity, purpose, and extensions.
1. Submit a request that the CA must deny. Verify that the policy rejects it and that no exit-module side effect creates an approved-looking result.
1. Submit a request that the policy intentionally holds pending. Verify that a certificate manager can review and dispose of it without altering CA policy.
1. Exercise each enabled exit-module notification or publication destination. Verify the expected result, access control, and data handling.
1. Simulate an unavailable destination in the nonproduction environment. Record whether issuance proceeds, waits, or fails, and make the behavior part of the production change decision.
1. Restart the Certification Authority service and repeat the tests. Review the CA operational logs and the module provider's logs for errors.

## Roll back a policy or exit module change safely

If the service doesn't start, request processing fails, or a required outcome doesn't validate, stop the change and restore the known-good module selection and configuration through the vendor's supported procedure.

1. Preserve the change-time logs, module versions, configuration values, and affected request IDs before you restore anything.
1. Restore the previous policy or exit-module configuration and its approved binary version.
1. Restart the Certification Authority service during the recovery window.
1. Confirm administrative connectivity, then test an authorized request, a denied request, a pending request, and each required exit outcome.
1. Reconcile every request received during the change window before you resume normal issuance.

Don't remove a module's files or registry configuration while Certificate Services is running unless the vendor explicitly documents that sequence. A partial removal can leave the CA unable to load its configured module.

## Troubleshoot module changes

| Symptom | Scope the investigation |
|---|---|
| The custom module isn't available in the CA console | Verify the vendor-supported installation and registration steps, CA architecture, required dependencies, and the account performing the installation. Don't substitute a generic registration command. |
| Requests unexpectedly become pending or denied | Identify whether the decision came from the CA policy module, template authorization, or NDES. The NDES policy module governs SCEP processing and isn't a substitute for CA policy troubleshooting. |
| The Certification Authority service won't start after the change | Stop submitting requests, collect service and module-provider logs, restore the known-good configuration, and engage the module vendor before trying further module changes. |
| An exit destination doesn't receive data | Verify the module's documented notification trigger, destination availability, identity, authorization, and TLS requirements. Don't assume that a missing notification means issuance failed; confirm the module's documented failure semantics. |
| A certificate manager can't alter module configuration | This is expected. Assign **Manage CA** only to the CA-administrator role; keep certificate-manager rights separate for request disposition. |

## Related content

- [Policy modules](/windows/win32/seccrypto/policy-modules)
- [Exit modules](/windows/win32/seccrypto/exit-modules)
- [Certificate Services Architecture](/windows/win32/seccrypto/certificate-services-architecture)
- [Use a policy module with Network Device Enrollment Service](use-policy-module-with-network-device-enrollment-service.md)
- [Install a policy module with the Network Device Enrollment Service](install-policy-module-network-device-enrollment-service.md)
- [certutil](/windows-server/administration/windows-commands/certutil)
