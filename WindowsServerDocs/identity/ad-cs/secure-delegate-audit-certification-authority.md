---
title: Secure, Delegate, Audit AD CS Administration
titleSuffix: Windows Server
description: Use least privilege, controlled certificate enrollment, and audit collection to operate an AD CS certification authority on Windows Server 2025.
#customer intent: As an IT administrator, I want to secure, delegate, and audit CA administration so that privileged operations follow least-privilege and accountability requirements.
author: orin-thomas
ms.author: orthomas
ms.topic: how-to
ms.date: 08/17/2026
ai-usage: ai-assisted
---

# Secure, delegate, and audit certification authority administration

Active Directory Certificate Services (AD CS) runs a certification authority (CA) that issues the digital certificates your organization trusts to identify users, devices, and services. Because a CA can create credentials that your entire environment trusts, a single over-privileged or compromised administrative account can both weaken CA policy and issue certificates.

A least-privilege operating model reduces that risk. It separates high-impact activities, controls enrollment on behalf of another identity, preserves CA recovery material, and produces audit evidence that you can review centrally.

This article describes how to define CA operating roles, protect the CA before you delegate work, scope certificate managers and enrollment agents, assess role separation, and configure auditing so that privileged operations stay accountable.

## Prerequisites

- A Windows Server 2025 computer with the AD CS Certification Authority role service installed.
- A nonproduction CA or a maintenance window for testing each change before you apply it to a production CA.
- Separate named administrative accounts and security groups. Don't use shared accounts to administer a CA.
- An account that's already authorized to administer the CA for CA configuration and backup operations. The current CA migration procedure requires CA-administrator access to back up and restore a CA.
- An approved location for CA backups, with access controls that protect both the backup files and any private-key passwords.
- A Windows Event Collector (WEC) or other approved monitoring design if you intend to centrally collect CA audit events.

For enterprise CAs, also identify the people or groups that administer certificate templates. Template administration and CA administration are separate control points. For template guidance, see [Manage certificate templates](manage-certificate-templates.md).

> [!IMPORTANT]
> A CA can create credentials that your organization trusts. Don't make permission, template, audit, or role-separation changes directly on a production CA without a change record, tested backup, and a rollback plan. A CA administrator can make changes that bypass lower-privilege CA controls, so host security and administrative-account controls remain essential.

## Define the CA operating roles

Create a written role assignment before you change CA configuration. Use one security group for each operational role, and use a different privileged account for each person when that person performs more than one function.

| Role | Purpose | Required boundary |
|---|---|---|
| CA administrator | Maintains the CA service, CA configuration, and CA recovery material. | Limit membership tightly. Treat CA and host administration as high privilege. |
| Certificate manager | Reviews, issues, denies, or revokes requests only within the organization's approved scope. | Define the permitted templates and requester populations. Don't use this role to administer the CA. |
| Enrollment agent | Uses an Enrollment Agent certificate to submit a request on behalf of another subject. | Treat the certificate as an impersonation capability. Limit the target templates and subject populations. |
| Auditor | Reviews CA audit evidence and monitoring results. | Don't give this role CA configuration or certificate-disposition authority merely to read audit evidence. |
| Backup and recovery custodian | Protects and tests CA backup material under the approved recovery process. | Separate custody of backup media and passwords where your policy requires it. The current CA backup procedure itself requires CA-administrator access. |
| Key recovery agent (KRA) | Decrypts archived encryption keys after an approved recovery request. | Keep KRA certificates and private keys separate from routine CA administration. |

An Enrollment Agent certificate is an enrollment control that you manage through certificate templates and issuance, not a CA permission. Likewise, backup and audit responsibilities aren't reasons to grant broad CA administration.

1. Create groups with names that identify their scope, such as `PKI-CA-Admins`, `PKI-Cert-Managers`, `PKI-Enrollment-Agents`, `PKI-Auditors`, and `PKI-CA-Backup`.
1. Add only named accounts to these groups. Avoid direct assignment to broad groups such as Domain Admins.
1. Record the owner, approved tasks, expiry or review date, and emergency-access process for each group.
1. Keep a separate, controlled emergency account. Require documented approval and review for every use of that account.

> [!NOTE]
> On an enterprise CA, the default CA administrator configuration includes the local Administrators group, the Enterprise Admins group, and the Domain Admins group. On a standalone CA, it includes the local Administrators group. Current Microsoft Learn documentation doesn't publish a Windows Server 2025 procedure for assigning CA permissions in the Certification Authority console, so use a tested organizational CA access-control baseline, record the resulting CA access control list, and verify both allowed and denied operations before you remove an existing administrator.

## Protect the CA before delegating work

Back up the CA before you change delegated access, templates, or audit configuration. You must use an account that's a CA administrator. Run the backup from an elevated PowerShell session on the CA during an approved maintenance window.

```powershell
$backupPath = Join-Path $env:ProgramData 'ADCS\Backups'
New-Item -ItemType Directory -Path $backupPath -Force | Out-Null
Backup-CARoleService -Path $backupPath
```

This command backs up both the CA database and the CA private key information. It produces a *CAName*.p12 file that holds the CA certificate and private key, and a database folder. Use the `-Password` parameter to supply, as a secure string, the password that protects the private key and certificate information, and use `-DatabaseOnly` when a change window needs a database-only backup. Protect the resulting files as sensitive recovery material: store the backup in an access-controlled location, deliver the password through a separate approved channel, and test restoration only on an isolated recovery system.

For command-line backup and recovery procedures, see [Migrate a Certification Authority](migrate-certification-authority.md) and [Backup-CARoleService](/powershell/module/adcsadministration/backup-caroleservice).

## Limit certificate manager and enrollment-agent scope

Don't use membership in a CA administrative group as a substitute for request approval controls. Establish the following boundaries in your CA operating procedure:

1. For every certificate manager, define the templates that the person can handle and the requesters for whom the person can act.
1. Require a positive and a negative authorization test for each certificate-manager group. The group must be able to process an approved test request and must be unable to process a request outside its documented scope.
1. Use dedicated Enrollment Agent certificates. Restrict enrollment for the Enrollment Agent template to the approved agent group, and don't make those certificates broadly available.
1. Define the templates and subject populations for which each enrollment agent can request certificates. Test both an allowed request and a request for an unauthorized template or subject.
1. Keep enrollment agents separate from certificate managers whenever possible. An enrollment agent that can also approve the request it submitted defeats the intended review boundary.

Microsoft Learn currently documents template administration and publishing, but doesn't publish a Windows Server 2025 step-by-step procedure for configuring certificate-manager restrictions or Enrollment Agent restrictions. Validate your CA's existing restriction configuration in a lab before you rely on it as the production control.

## Assess CA role separation

Role separation is an extra control that you can enable to stop one principal from performing more than one CA role. It doesn't replace CA access controls, protected administration, or separation of CA private-key access.

Use the following command to check the role information that the CA reports:

```cmd
certutil -CAInfo role
```

Before you rely on role separation:

1. Inventory every account and group that has CA, host, backup, audit, and enrollment-agent responsibilities.
1. Test the expected role assignments and an intentionally conflicting assignment on a nonproduction CA.
1. Confirm that an emergency-access process still works and that you audit its use.
1. Record the rollback path before you enforce the control.

> [!CAUTION]
> Microsoft Learn doesn't currently document a Windows Server 2025 procedure for enabling role separation or a supported `RoleSeparationEnabled` registry value. Don't apply an undocumented registry setting from a legacy procedure as this article's implementation step. If your organization uses role separation, validate the configuration and operational effects with current support guidance before enforcement.

## Configure CA auditing

CA audit-filter configuration and Advanced Audit Policy address different parts of the audit path. The CA audit filter selects CA operations for auditing. The **Audit Certification Services** advanced-audit subcategory controls operating-system generation of AD CS operation events. Configure both through your approved change process, then verify the resulting events on the CA before you forward them.

1. Create a dedicated Group Policy Object (GPO) for the AD CS server or servers.
1. In the Group Policy Management Editor, go to **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Advanced Audit Policy Configuration** > **Audit Policies** > **Object Access** > **Audit Certification Services**.
1. Select **Success** and **Failure**.
1. Link the GPO to the intended CA computers and validate the local Security log before you configure event forwarding.

To enable the documented full CA audit filter and restart the CA service, run the following commands from an elevated PowerShell session on the CA:

```powershell
certutil -setreg CA\AuditFilter 127
Restart-Service -Name certsvc
```

The service restart interrupts certificate services. Schedule it, notify dependent service owners, and confirm that the CA returns to service before continuing.

> [!CAUTION]
> Full auditing includes Start and Stop Active Directory Certificate Services. On a CA with a large database, that category can delay service restart. Review the operational effect in a nonproduction environment and use the CA auditing selection appropriate for your approved audit baseline.

As an alternative to the command, open the **Certification Authority** snap-in (`certsrv.msc` or from **Server Manager** > **Tools** > **Certification Authority**), open the context menu for the CA name, select **Properties**, select the **Auditing** tab, select the events to audit, and then select **Apply**. Use the same change record and validation whether you configure the audit filter by command or in the console.

Don't assume that a CA audit-filter setting enables operating-system audit generation by itself.

Use the following events as a focused monitoring baseline:

| Event ID | Monitor for |
|---|---|
| 4870 | Certificate Services revoked a certificate. |
| 4882 | The security permissions for Certificate Services changed. |
| 4885 | The audit filter for Certificate Services changed. |
| 4886 | Certificate Services received a certificate request. |
| 4887 | Certificate Services approved a certificate request and issued a certificate. |
| 4888 | Certificate Services denied a certificate request. |
| 4890 | The certificate manager settings for Certificate Services changed. |
| 4892 | A property of Certificate Services changed. |
| 4896 | Certificate Services deleted one or more rows from the certificate database. |
| 4897 | Role separation enabled. |

Certificate Services also records a request to publish a certificate revocation list (CRL) as event 4871 and a published CRL as event 4872. Run a controlled nonproduction revocation and CRL publication, record the events that your CA generates locally, and then create the collection rule. This process prevents an unverified event assumption from becoming a monitoring blind spot.

The current Windows Event Forwarding (WEF) guidance includes 4886, 4887, and 4888 in its baseline subscription. Forward the selected Security events to a WEC, confirm that they arrive, and integrate the collected output with your organization's monitoring platform according to its design. WEF doesn't enable auditing, increase local log capacity, or prevent local-event overwrite.

> [!IMPORTANT]
> Size and retain the local Security log so that collection outages don't overwrite CA audit evidence. Test the end-to-end path from event generation on the CA through collection and alerting. Don't rely solely on a collector to prove that the CA generated an event.

For WEF design and the current baseline subscription, see [Use Windows Event Forwarding to help with intrusion detection](/windows/security/operating-system-security/device-management/use-windows-event-forwarding-to-assist-in-intrusion-detection).

## Validate delegation and auditing

Perform this validation with nonproduction requests and a change record.

1. Sign in as a CA administrator and confirm that the account can perform the one approved CA configuration task. Confirm that a certificate-manager account can't perform that task.
1. Sign in as each certificate manager. Process an approved test request within the documented scope, then confirm that the CA denies a request outside the assigned template or requester scope.
1. Use a test Enrollment Agent certificate to submit one allowed request on behalf of an approved test subject. Confirm that a request for an unauthorized subject or template fails.
1. Sign in as an auditor and confirm that the account can view the required local or collected audit evidence without being able to change CA configuration or disposition requests.
1. Perform a controlled CA backup and confirm that the backup files are protected. Test restoration on an isolated recovery system, not on the production CA.
1. Generate a test request, an issuance or denial, a controlled CA configuration change, and a nonproduction revocation or CRL-publication operation. Confirm that the expected Security events appear locally and at the collector.
1. Review emergency-account membership and evidence of its last use. Remove temporary test access when validation is complete.

## Security considerations

- Use a hardened management host for CA administration. Avoid routine interactive sign-in to an issuing CA.
- Keep CA private keys, CA backups, KRA private keys, and their passwords under separate approved custody where possible.
- Review CA and template-administrator group membership on a defined schedule and immediately after personnel or role changes.
- Don't grant CA administration to an auditor, enrollment agent, or backup custodian only to simplify a workflow.
- Don't deploy unreviewed scripts or email handlers into the CA service. Collect events through a supported monitoring path instead.
- Keep audit-policy, CA-audit-filter, and event-collection changes in the same change record so that you can explain an audit gap.

## Troubleshoot delegation and audit collection

| Symptom | Action |
|---|---|
| A delegated account can perform more work than intended. | Remove the account from the broad group, review the CA access control list and template permissions, then repeat the negative authorization test. |
| A certificate manager can't process an expected request. | Verify the documented template and requester scope, then test with a known-good nonproduction request before changing permissions. |
| An enrollment agent can request for an unexpected subject or template. | Suspend use of the agent certificate, review the template and subject restrictions, and investigate issued certificates before restoring access. |
| CA audit events are absent. | Verify the CA audit filter, confirm that Certificate Services restarted after the change, verify the Advanced Audit Policy baseline, and check the local Security log before investigating WEF. |
| Events exist locally but not at the collector. | Check the WEF subscription, source connectivity, collector health, and local log retention. Treat a full or overwritten local log as a potential evidence gap. |

## Related content

- [What's the Certification Authority Role Service?](certification-authority-role.md)
- [Manage certificate templates](manage-certificate-templates.md)
- [Migrate a Certification Authority](migrate-certification-authority.md)
- [Backup-CARoleService](/powershell/module/adcsadministration/backup-caroleservice)
- [Restore-CARoleService](/powershell/module/adcsadministration/restore-caroleservice)
- [Appendix L: Events to monitor](../ad-ds/plan/appendix-l--events-to-monitor.md)
- [Configure Windows event collection](/defender-for-identity/deploy/configure-windows-event-collection)
- [Use Windows Event Forwarding to help with intrusion detection](/windows/security/operating-system-security/device-management/use-windows-event-forwarding-to-assist-in-intrusion-detection)
