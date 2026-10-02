---
title: Manage Certificate Templates in Windows Server
description: Create, publish, validate, and retire Active Directory Certificate Services (AD CS) certificate templates on an enterprise CA in Windows Server.
#customer intent: As a PKI administrator, I want to create, publish, validate, and retire AD CS certificate templates so that I can change certificate issuance policy without disrupting applications or over-granting enrollment rights.
author: orin-thomas
ms.author: orthomas
ms.topic: how-to
ms.date: 08/17/2026
ai-usage: ai-assisted
---

# Manage AD CS certificate templates on an enterprise CA

A certificate template is a reusable set of rules that defines who can enroll for a certificate and how the certification authority (CA) configures each issued certificate. By managing templates carefully, you control your organization's certificate issuance policy so that you can change it without unexpectedly expanding enrollment rights or disrupting the applications that depend on those certificates.

Only enterprise CAs issue certificates based on templates. Active Directory Domain Services (AD DS) stores these templates, and every CA in the forest shares them. Standalone CAs don't use certificate templates.

This article explains how to create, update, publish, validate, and retire Active Directory Certificate Services (AD CS) certificate templates. You use a pilot workflow to validate each change on a narrow scope before you apply it to production enrollment.

## Prerequisites

Before you begin, ensure that you have:

- An AD DS forest and an enterprise CA.
- An account with the permissions required for the task. Membership in **Domain Admins**, or equivalent delegated permissions, is the documented minimum for administering a domain's certificate templates. Deleting a template requires membership in **Domain Admins** or **Enterprise Admins**, or equivalent.
- The AD CS management tools on the management computer. To install the tools on Windows Server, run the following command from an elevated PowerShell session:

  ```powershell
  Install-WindowsFeature RSAT-ADCS
  ```

- A documented certificate use case, the intended enrollment identities, the relying applications, and a pilot security group.
- Access to the issuing CA and controlled test identities that represent intended and unintended requesters.

> [!IMPORTANT]
> Create a template by duplicating a suitable existing template. Test a new, narrowly scoped template before you change production enrollment.

## Understand the three publication operations

Template management involves three separate operations.

| Operation | What it changes | What it doesn't do |
|---|---|---|
| Create or modify a certificate template | The template object in AD DS. A new template replicates to domain controllers throughout the forest. | It doesn't configure a CA to issue the template. |
| Publish a template to an issuing CA | The CA's issuance list. | It doesn't publish issued certificates to AD DS. |
| Publish an issued certificate to AD DS | The `userCertificate` attribute on the certificate subject's AD DS object. | It doesn't publish or enable a certificate template on a CA. |

If you need to publish issued certificates to AD DS, separately review the template's certificate-publication setting, the CA Exit Module's **Allow certificates to be published in the Active Directory** setting, and the CA's permissions to update the subject objects.

## Open the Certificate Templates snap-in

Use the Certificate Templates Microsoft Management Console (MMC) snap-in to administer certificate template objects.

1. Select and hold (or right-click) **Start**, select **Run**, enter `mmc`, and then select **OK**.
1. In MMC, select **File** > **Add/Remove Snap-in**.
1. Select **Certificate Templates**, select **Add**, and then select **OK**.

Use the Certification Authority snap-in instead when you need to change the templates that a specific CA can issue.

## Design a secure template

Start with the relying application's identity and certificate requirements. Before you duplicate a template, review the following template areas.

| Template area | Decision |
|---|---|
| **Compatibility** | Select the oldest CA and recipient operating systems that must use the template. The most recent available values are **Windows Server 2016** for **Certification Authority** and **Windows 10 / Windows Server 2016** for **Certificate recipient**. Windows Server 2025 isn't an available compatibility value. |
| **General** | Use a unique display name and define the validity and renewal periods. Record the template's short name, which is distinct from its display name. |
| **Subject Name** | Prefer identity information from AD DS. If you enable **Supply in the request**, restrict enrollment and validate every permitted identity value because the requester supplies subject information. |
| **Request Handling** and **Issuance Requirements** | Define the certificate purpose, private-key behavior, approval requirements, and authorized signatures that the enrollment flow requires. |
| **Cryptography** | Select a provider, algorithm, and key size that the CA, requesters, and relying applications support. No single configuration is appropriate for every certificate purpose. |
| **Extensions** | Limit application policies, key usage, basic constraints, certificate policy object identifiers (OIDs), and other extensions to the documented application requirements. Mark an extension critical only after testing every required certificate consumer. |
| **Security** | Grant **Read**, **Enroll**, and, only when intended, **Autoenroll** to narrowly scoped groups. |
| **Superseded Templates** | Identify any predecessor template and plan for certificates that remain valid after the replacement becomes available. |

Apply extra review to templates used for authentication, code signing, enrollment agents, requester-supplied subject information, or exportable private keys. For a specialized example of how purpose, cryptographic provider, key usage, application policies, and permissions relate, see [Configure certificate templates for ML-DSA](configure-ml-dsa-certificate-templates.md). Don't use its signature-only ML-DSA settings as a general template baseline.

## <a name="create-a-new-certificate-template"></a>Create and pilot a template

Create a template by duplicating the existing template that most closely matches the approved use case.

1. Open the Certificate Templates snap-in.
1. Select and hold (or right-click) the template to use as a starting point, and then select **Duplicate Template**.
1. On the **Compatibility** tab, select the minimum CA and certificate-recipient compatibility levels that your environment requires.
1. On the **General** tab, enter a distinct **Template display name**. Record both the display name and template short name.
1. Configure the subject, request-handling, cryptography, extension, and issuance settings that the use case requires.
1. On the **Security** tab, grant **Read** and **Enroll** to the pilot group. Grant **Autoenroll** only if automatic enrollment is part of the approved pilot.
1. Select **OK**.
1. Allow AD DS replication to complete before you publish and test the template.

If you remove **Authenticated Users** from the template access control list (ACL), grant every issuing CA's computer account **Read** permission. The default **Authenticated Users** entry includes the CA. Without another applicable **Read** entry, the CA can't read the template in AD DS. For more information, see [Certification Authority can't use a certificate template](/troubleshoot/windows-server/certificates-and-public-key-infrastructure-pki/ca-cant-use-certificate-template).

## Rename a custom template

You can't rename default certificate templates. Renaming a custom template updates only the template object in AD DS. If you already published the template to a CA or included it in another template's supersedence list, update those references.

1. Open the Certificate Templates snap-in.
1. Select the custom template.
1. Select **Action** > **Change Names**.
1. Enter a new value in **Template name**, **Template display name**, or both.
1. Select **OK**.
1. If you published the template, remove it from every issuing CA, restart the Active Directory Certificate Services service (CertSvc) on the affected CAs, and publish the renamed template again.
1. If another template supersedes the renamed template, update the superseding template's **Superseded Templates** list.

## Delete a certificate template

Delete a template only after you remove it from all issuing CAs and complete the retirement plan. Deletion is forest-wide and isn't a routine rollback mechanism. Depending on the environment and deletion-retention state, recovery might be possible through Active Directory Recycle Bin or an approved directory-backup recovery process. Deletion doesn't revoke already issued certificates. This procedure applies only to templates that you can delete. Version 1 templates are default templates that you can't delete.

1. Open the Certificate Templates snap-in.
1. Select and hold (or right-click) the template, and then select **Delete**.
1. Select **Yes** to confirm.

## Publish a template to a CA

Publishing adds an existing template to a CA's issuance list. It doesn't create or duplicate the template.

To use the Certification Authority console:

1. Open the Certification Authority snap-in.
1. Expand the issuing CA.
1. Select and hold (or right-click) **Certificate Templates**, and then select **New** > **Certificate Template to Issue**.
1. Select the template, and then select **OK**.

Instead, use the ADCSAdministration PowerShell module on the issuing CA. First, inspect the current issuance list:

```powershell
Get-CATemplate
```

Use the template short name to preview the change:

```powershell
Add-CATemplate -Name "PilotWebServer" -WhatIf
```

After you review the preview, publish the template:

```powershell
Add-CATemplate -Name "PilotWebServer"
```

For command details, see [Get-CATemplate](/powershell/module/adcsadministration/get-catemplate) and [Add-CATemplate](/powershell/module/adcsadministration/add-catemplate).

## Validate the pilot certificate template

Validate the enrollment policy, issued certificate, and relying application before you expand enrollment rights.

1. Confirm that `Get-CATemplate` lists the pilot template on the intended CA.
1. Sign in with a pilot identity. For a user certificate, open `certmgr.msc`. For a computer certificate, use a pilot computer and open `certlm.msc`.
1. Expand **Personal**, select and hold (or right-click) **Certificates**, and then select **All Tasks** > **Request New Certificate**.
1. Confirm that the pilot template is available, and enroll for a certificate.
1. Open the issued certificate. On the **Details** tab, verify the subject, subject alternative name, public key, key usage, application policies, basic constraints, and policy OIDs that apply to the design.
1. On the **Certification Path** tab, verify the expected chain.
1. Confirm that the certificate is in the intended user or local computer store and has an associated private key when required.
1. Test the relying application with the certificate. Certificate store presence alone doesn't prove that the application accepts or can use the certificate.
1. Test with a separately scoped identity that shouldn't be eligible for enrollment.
1. If you configured issued-certificate publication to AD DS, verify that result separately.

Also validate approval disposition, private-key export and access behavior where applicable, renewal, and supersedence before you expand the pilot group's membership.

## Supersede and retire a template

Use a new template instead of making a disruptive in-place change when a change could affect enrolled identities or an application's certificate selection.

1. Create, publish, and validate the replacement template with a pilot group.
1. On the replacement template's **Superseded Templates** tab, add the predecessor only if supersedence is part of the approved transition.
1. Test renewal and autoenrollment behavior. Supersedence can trigger enrollment for the replacement, but it doesn't automatically remove older certificates from a user's AD DS certificate store.
1. Expand the replacement template's enrollment scope in controlled stages.
1. Remove the predecessor from each CA's issuance list.
1. Monitor enrollment and application behavior for the defined rollback period.
1. Delete the predecessor template only when you no longer need rollback and the retirement plan permits deletion.

Plan certificate cleanup separately. Removing or deleting a template doesn't revoke certificates already issued from it. Revoke affected certificates and publish a certificate revocation list (CRL) when the revocation plan requires those actions. For supersedence behavior, see [Superseded certificate templates and impact on user's AD store](/troubleshoot/windows-server/certificates-and-public-key-infrastructure-pki/superseded-certificate-templates-impact-user-ad-store).

## Remove a template from a CA

You can remove built-in and default templates from a CA's issuance list. Removing them doesn't delete their template objects from AD DS.

To use the Certification Authority console:

1. Open the Certification Authority snap-in.
1. Expand the issuing CA, and then select **Certificate Templates**.
1. In the details pane, select and hold (or right-click) the template, and then select **Delete**.

To use PowerShell, preview removal by using the template short name:

```powershell
Remove-CATemplate -Name "PilotWebServer" -WhatIf
```

After you review the preview, remove the template:

```powershell
Remove-CATemplate -Name "PilotWebServer"
```

Don't use `-AllTemplates` to roll back one template. That parameter removes every removable template from the CA's issuance list. For command details, see [Remove-CATemplate](/powershell/module/adcsadministration/remove-catemplate).

## Security considerations

- Separate template administration from enrollment. Don't grant administrators broad enrollment rights only to test a change.
- Use pilot groups instead of broadly scoped groups during validation.
- Review changes to requester-supplied subject information, enrollment-agent capability, application policies, key usage, approval, and private-key behavior with the application owner and security team.
- Confirm that the CA-wide `EDITF_ATTRIBUTESUBJECTALTNAME2` flag is disabled. If enabled, an identity that can submit a request can supply subject alternative name values regardless of the template's **Supply in the request** setting. Investigate the dependency before you change the flag.
- Test Cryptography Next Generation (CNG) and legacy provider selection with every supported requester and relying application.
- Document rollback before publication. The usual first rollback action is to remove the new template from the affected CA's issuance list, not delete its AD DS object.

## Troubleshoot template management

| Symptom | Checks |
|---|---|
| The template isn't available in the enrollment wizard. | Confirm that the CA is an enterprise CA, the template is on that CA's issuance list, AD DS replication is complete, and the requester has **Read** and **Enroll** permissions. |
| The CA can't issue the template after you restrict its ACL. | Confirm that the issuing CA's computer account has **Read** permission when **Authenticated Users** isn't present. |
| A required provider isn't available on the **Cryptography** tab. | Review the template compatibility settings and confirm that the provider is installed and that the requester and CA support it. |
| The issued certificate doesn't contain the expected capabilities. | Compare the certificate's details with the approved template design, including its purpose, extensions, subject configuration, and cryptography settings. |
| The CA issues the certificate, but the application can't use it. | Confirm private-key presence and permissions, provider support, certificate selection behavior, application policies, key usage, and chain trust. |
| Issued certificates don't appear on AD DS subject objects. | Troubleshoot issued-certificate publication. Review the template setting, CA Exit Module setting, and CA permissions instead of republishing the template to the CA. |

## Related content

- [Certificate template concepts](certificate-template-concepts.md)
- [Configure certificate templates for ML-DSA](configure-ml-dsa-certificate-templates.md)
- [Configure Certificate Enrollment Web Service for certificate key-based renewal](certificate-enrollment-certificate-key-based-renewal.md)
- [Certificates security posture assessment in Microsoft Defender for Identity](/defender-for-identity/security-posture-assessments/certificates)
