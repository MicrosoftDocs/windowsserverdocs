---
title: Configure AD CS key archival and key recovery
titleSuffix: Windows Server
description: Configure AD CS key archival for recoverable encryption keys and use a separated recovery process on Windows Server 2025.
#customer intent: As an IT administrator, I want to configure key archival and recover private keys so that encrypted organizational data remains recoverable.
author: orin-thomas
ms.author: orthomas
ms.topic: how-to
ms.date: 08/17/2026
ai-usage: ai-assisted
---

# Configure AD CS key archival and recover private keys

Key archival is an escrow capability in Active Directory Certificate Services (AD CS) that stores a protected copy of a private encryption key on the certification authority (CA) so you can recover it later. Use key archival when loss of a private encryption key would make protected organizational data unrecoverable. By default, only encryption keys are eligible for archival.

Because key archival creates an additional protected copy of a private key, it must have stronger governance than ordinary certificate enrollment.

In this article, you configure a CA to issue Key Recovery Agent (KRA) certificates, enable private-key archival on an encryption template, and recover an archived key by using a separated retrieval and decryption process. You validate the process in a pilot before you enroll a production population.

> [!IMPORTANT]
> Key archival is for recoverable decryption or encryption keys. Don't use it to archive signing-only keys merely because they're private keys. A lost signing key doesn't prevent verification of existing signatures, and archiving it creates an unnecessary key-escrow risk.

## Prerequisites

- An enterprise CA on Windows Server 2025. Template-based issuance and the Key Recovery Agent template require an enterprise CA and Active Directory Domain Services.
- Membership in Domain Admins, or equivalent, to duplicate and administer certificate templates, and the AD CS management tools on the computer you use. This article uses Domain Admins for simplicity; in production, delegate the minimum required rights instead—template management through the AD Certificate Templates container, **Manage CA** (CA Administrator) to enable archival and assign KRA certificates, and **Issue and Manage Certificates** (Certificate Manager) to approve the KRA request.
- A nonproduction encryption certificate template and test data. Don't first test archival with production user data.
- Separate named accounts for CA administration, certificate-manager retrieval, KRA decryption, and recovery approval.
- An approved recovery request process that records the data owner, reason, approver, certificate identity, KRA identity, and disposition of temporary artifacts.
- A secured KRA workstation or profile that protects each KRA certificate and its private key.
- An approved, access-controlled location for encrypted recovery blobs and recovered PKCS #12 files.

The **Key Recovery Agent** template is an encryption template for a KRA subject. Don't confuse it with the **EFS Recovery Agent** template, which has a different purpose.

## Separate the recovery duties

Use separate people or accounts for retrieval and decryption. Assign the key recovery agent and certificate manager roles to different individuals. Permit the certificate manager to retrieve but not decrypt archived keys. Permit the key recovery agent to decrypt keys but not retrieve them.

| Activity | Responsible role | Boundary |
|---|---|---|
| Configure the CA and publish templates | CA administrator and template administrator | Don't give routine KRA accounts CA-administration access. |
| Approve a recovery request and retrieve the encrypted blob | Certificate manager | The retrieved blob remains encrypted to KRA certificate recipients. |
| Decrypt the recovery blob | Key Recovery Agent | The KRA uses its own KRA certificate and private key. |
| Receive and use the recovered key | Intended certificate subject | Import only into the approved user or computer context. |

Use dual authorization as an operational control. If the CA has multiple KRA certificates, it encrypts the archived private key once with each available KRA public key, so any authorized key recovery agent can recover the key. Additional KRA certificates provide recovery continuity. They're not a cryptographic quorum.

## Create and protect KRA certificates

Create a dedicated KRA certificate template from the default Key Recovery Agent template. Use the Certificate Templates snap-in to copy and modify the template and to control which accounts can read and enroll for it.

1. Create a KRA template with a clearly identifiable name, such as `Contoso Key Recovery Agent`.
1. Remove broad enrollment access. Grant **Read** and **Enroll** only to the dedicated KRA group.
1. Require an explicit certificate-manager approval in your KRA issuance process. Don't automatically enroll KRA certificates.
1. Publish the approved KRA template to the enterprise CA.
1. Manually enroll each approved KRA account for its KRA certificate.
1. Verify that each KRA certificate has a private key and that your key-custody policy protects it.
1. Record the certificate thumbprint, expiry date, custodian, and renewal date. Renew and validate a replacement before retiring an existing KRA certificate.

After you issue and configure at least one KRA certificate on the CA, verify the CA's KRA information:

```cmd
certutil -config "CAHostName\CAName" -CAInfo kracount
certutil -config "CAHostName\CAName" -CAInfo kra
certutil -config "CAHostName\CAName" -CAInfo kraused
```

`kracount` reports the KRA certificate count, `kra` reports a configured KRA certificate, and `kraused` reports the used KRA certificate count.

> [!CAUTION]
> Current Microsoft documentation doesn't publish a detailed Windows Server 2025 procedure for the CA **Recovery Agents** configuration page. Configure the CA with the approved KRA certificate or certificates through a lab-validated CA administration procedure, and then use the preceding `certutil -CAInfo` commands to record the configured state. Don't infer the current configuration from a legacy console screenshot.

Choose the number of KRA certificates that your recovery continuity requires. Because the CA encrypts an archived key to each KRA public key that it uses, a single available KRA private key is enough to recover that key.

## Configure an encryption template for archival

Duplicate an encryption-capable template for a narrow pilot population. Enable the template's private-key-archival requirement and grant enrollment only to the pilot group.

1. Start with an encryption-use template that matches the protected-data scenario.
1. Configure the duplicate template to require private-key archival.
1. Restrict **Read** and **Enroll** to the pilot users or computers. Don't add broad groups.
1. Publish the template to the pilot CA.
1. Enroll a test subject only after the CA has a valid KRA configuration.

To archive a key, the CA must have issued at least one KRA certificate. During enrollment, the client encrypts the private key to the CA exchange certificate, and the CA then encrypts that key with each available KRA public key and stores the result in the certificate database.

An archival request isn't a standalone PKCS #10 request. You can use only a CMC request for key archival, because only the Certificate Management Messages over CMS (CMC) format securely transfers the requester's private key to the CA. The CMC message uses a CMS signature and can carry a PKCS #10 inner request.

The following nonproduction request example uses the documented `PrivateKeyArchive` setting. Replace the subject and template with values approved for your pilot.

```ini
[NewRequest]
Subject = "CN=Key archival pilot user"
RequestType = CMC
PrivateKeyArchive = TRUE

[RequestAttributes]
CertificateTemplate = ContosoEncryptionArchive
```

Create, submit, and accept the request from the intended test subject context:

```cmd
certreq -new KeyArchival.inf KeyArchival.req
certreq -submit -config "CAHostName\CAName" KeyArchival.req KeyArchival.cer
certreq -accept KeyArchival.cer
```

Confirm that the request uses CMC before you rely on the result:

```cmd
certutil -dump KeyArchival.req
```

`PrivateKeyArchive = TRUE` works only when `RequestType = CMC`. The CA doesn't retroactively archive a certificate that it issued before you configured the template and CA for archival.

## Retrieve and recover an archived key

Use a controlled recovery request and keep the retrieval and decryption stages separate.

1. The certificate manager approves the request under the organization's recovery process and identifies the archived certificate by using a supported search token. Supported tokens are the certificate common name, certificate serial number, certificate SHA-1 hash (thumbprint), certificate key ID SHA-1 hash (subject key identifier), requester name in `domain\user` form, and user principal name (UPN).
1. The certificate manager retrieves an encrypted recovery blob. The blob is a PKCS #7 file that contains the KRA certificate, the user certificate chain, and the private key that remains encrypted to the KRA certificates. Keep it encrypted when it leaves the certificate-manager workstation.

   ```cmd
   certutil -config "CAHostName\CAName" -GetKey "user@contoso.com" ".\Recovery\Case-1042.rec"
   ```

   Narrow the search token until it matches one certificate. If several candidates match, or if you omit the output file, `certutil` generates a recovery script instead of a single blob. When one candidate matches, `certutil` truncates the extension you supply and appends a certificate-specific string and the `.rec` extension, so confirm the file name that the command reports.

1. Transfer the `.rec` file to the KRA through the approved, auditable recovery channel. Don't place it in a general file share or send it through unprotected email.
1. On the KRA workstation, sign in to the account that holds the matching KRA certificate and private key. Decrypt the recovery blob into a protected PKCS #12 file:

   ```cmd
   certutil -RecoverKey ".\Recovery\<generated-recovery-file>.rec" ".\Recovery\Case-1042.pfx"
   ```

   If the CA encrypted the blob to more than one KRA certificate, you can add a recipient index after the output file to select a specific recipient.
1. When `certutil` prompts you during recovery, protect the PKCS #12 file with an organization-approved password. Transfer the password through a separate approved channel.
1. Import the recovered key only into the intended subject context. Confirm that the intended subject can decrypt the approved test data.
1. Securely remove the temporary recovery blob and recovered PKCS #12 file according to the organization's data-handling standard. Keep the audit record, not the portable key material.

> [!NOTE]
> `certutil -GetKey` retrieves encrypted recovery material; it doesn't give the certificate manager a usable private key. `certutil -RecoverKey` requires the matching KRA certificate and private key. `certutil -GetKey` also accepts a `recover` option that retrieves and recovers in one step, but that option requires KRA certificates and private keys on the computer that runs it. Keep the stages separate so that retrieval alone can't produce a usable key.

Don't supply the PKCS #12 password on a command line, where a shell history or process-auditing record can capture it. The recovered key remains in a password-protected PKCS #12 file, and you must give the recipient the password through a secure out-of-band mechanism.

## Validate the archival and recovery process

Complete this validation before enrolling a production population.

1. Confirm that the CA reports the intended KRA configuration by running `certutil -CAInfo kracount` and `certutil -CAInfo kra`.
1. Issue a new nonproduction encryption certificate from the archival-enabled template and record its request ID, serial number, subject key identifier, and thumbprint.
1. Encrypt nonproduction test data with the new certificate.
1. Have a certificate manager retrieve the encrypted recovery blob without providing KRA private-key access.
1. Have a different KRA decrypt the blob and deliver the recovered key to the intended test subject through the approved process.
1. Import the recovered key in the intended context and decrypt the test data.
1. Try the same process with a certificate issued before you enabled archival. Confirm that it has no archived key material.
1. Review the recovery request, retrieval, decryption, transfer, import, and temporary-artifact disposal records.

## Security considerations for key archival and recovery

- Treat KRA private keys, archived-key recovery blobs, and recovered PKCS #12 files as high-value secrets.
- Keep KRA enrollment manual and individually approved. Don't use autoenrollment for KRA certificates.
- Preserve sufficient KRA coverage for previously archived certificates before you retire or destroy a KRA private key.
- Use recovery cases and periodic drills to test continuity. A successful KRA certificate enrollment alone doesn't prove that you can recover archived data.
- Don't use `certutil -exportPFX` as a substitute for CA key recovery. It exports a key already accessible in a local certificate store; it doesn't retrieve an archived key from the CA.
- Use `certutil` as an administrator diagnostic, not a production-code dependency. Check locally available options by running `certutil -?` or `certutil <parameter> -?`.

## Troubleshoot key archival and recovery

| Symptom | Action |
|---|---|
| The CA reports no KRA certificates. | Issue and configure at least one KRA certificate, and then verify the CA by running `certutil -CAInfo kracount` and `certutil -CAInfo kra`. |
| The request doesn't archive a key. | Confirm that the request is CMC, not a standalone PKCS #10 request, and that you use `PrivateKeyArchive = TRUE` with `RequestType = CMC`. |
| `certutil -GetKey` doesn't return archived material. | Confirm that the CA issued the certificate after you enabled archival and that the selected search token identifies the intended certificate. |
| The certificate manager can retrieve a blob but can't use the private key. | Expect this behavior when you separate duties. Transfer the encrypted blob to the KRA; don't give the certificate manager KRA private-key access. |
| `certutil -RecoverKey` fails. | Confirm that the KRA profile contains the matching KRA certificate and private key, and that the CA produced the recovery blob for a KRA certificate available to that agent. |

## Related content

- [Certificate template concepts in Windows Server](certificate-template-concepts.md)
- [Manage certificate templates](manage-certificate-templates.md)
- [Key Recovery Server](/windows/win32/seccertenroll/about-key-recovery-server)
- [CMC key archival request](/windows/win32/seccertenroll/cmc-key-archival-request)
- [Certreq](/windows-server/administration/windows-commands/certreq_1)
- [Certutil](/windows-server/administration/windows-commands/certutil)
