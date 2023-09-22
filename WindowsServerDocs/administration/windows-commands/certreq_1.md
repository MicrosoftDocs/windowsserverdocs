---
title: certreq
description: Reference article for the certreq command, which requests certificates from a certification authority (CA), retrieves a response to a previous request from a CA, creates a new request from an .inf file, accepts and installs a response to a request, constructs a cross-certification or qualified subordination request from an existing CA certificate or request, and signs a cross-certification or qualified subordination request.
ms.topic: reference
ms.assetid: 7a04e51f-f395-4bff-b57a-0e9efcadf973
ms.author: wscontent
author: JasonGerend
manager: mtillman
ms.date: 09/21/2023
---

# certreq

The certreq command can be used to request certificates from a certification authority (CA), to retrieve a response to a previous request from a CA, to create a new request from an .inf file, to accept and install a response to a request, to construct a cross-certification or qualified subordination request from an existing CA certificate or request, and to sign a cross-certification or qualified subordination request.

> [!IMPORTANT]
> Earlier versions of the certreq command might not provide all of the options described here. To see the options supported based on specific versions of certreq, run the command-line help option, `certreq -v -?`.
>
> The certreq command doesn't support creating a new certificate request based on a Key Attestation template when in a CEP/CES environment.

> [!WARNING]
> The content for this topic is based on the default settings for Windows Server; for example, setting the key length to 2048, selecting Microsoft Software Key Storage Provider as the CSP, and using Secure Hash Algorithm 1 (SHA1). Evaluate these selections against the requirements of your company's security policy.

## Syntax

```
certreq [-submit] [options] [requestfilein [certfileout [certchainfileout [fullresponsefileOut]]]]
certreq -retrieve [options] requestid [certfileout [certchainfileout [fullresponsefileOut]]]
certreq -new [options] [policyfilein [requestfileout]]
certreq -accept [options] [certchainfilein | fullresponsefilein | certfilein]
certreq -sign [options] [requestfilein [requestfileout]]
certreq –enroll [options] templatename
certreq –enroll –cert certId [options] renew [reusekeys]
```

### Parameters

| Parameter | Description |
| -------- | ----------- |
| -submit | Submits a request to a certificate authority. |
| -retrieve `<requestid>` | Retrieves a response to a previous request from a certificate authority. |
| -new | Creates a new request from an .inf file. |
| -accept | Accepts and installs a response to a certificate request. |
| -policy | Sets the policy for a request. |
| -sign | Signs a cross-certification or qualified subordination request. |
| -enroll | Enrolls for or renews a certificate. |
| -? | Displays a list of certreq syntax, options, and descriptions. |
| `<parameter>` -? | Displays help for the parameter specified. |
| -v -? | Displays a verbose list of the certreq syntax, options, and descriptions. |

## Examples

### certreq -submit

To submit a basic certificate request:

```
certreq –submit certrequest.req certnew.cer certnew.pfx
```

#### Remarks

- This is the default certreq.exe parameter. If no option is specified at the command-line prompt, certreq.exe attempts to submit a certificate request to a certificate authority. You must specify a certificate request file when using the **–submit** option. If this parameter is omitted, a common **File Open** window appears, letting you select the appropriate certificate request file.

- To request a certificate by specifying the SAN attribute, see the *How to use the certreq.exe utility to create and submit a certificate request* section of Microsoft Knowledge Base article 931351 [How to add a Subject Alternative Name to a secure LDAP certificate](https://support.microsoft.com/kb/931351).

### certreq -retrieve

To retrieve certificate ID 20 and to create a certificate file (.cer), named *MyCertificate*:

```
certreq -retrieve 20 MyCertificate.cer
```

#### Remarks

- Use certreq -retrieve *requestid* to retrieve the certificate after the certificate authority has issued it. The *requestid* PKC can be a decimal or hex with 0x prefix and it can be a certificate serial number with no 0x prefix. You can also use it to retrieve any certificate that has ever been issued by the certificate authority, including revoked or expired certificates, without considering if the certificate's request was ever in the pending state.

- If you submit a request to the certificate authority, the policy module of the certificate authority might leave the request in a pending state and return the *requestid* to the certreq caller for display. Eventually, the certificate authority's administrator issues the certificate or deny the request.

### certreq -new

To create a new request:

```
[newrequest]
; At least one value must be set in this section
subject = CN=W2K8-BO-DC.contoso2.com
```

The following are some of the possible sections that may be added to the INF file:

#### [newrequest]

This area of the INF file is mandatory for any new certificate request templates, and must include at least one parameter with a value.

| Key<sup>1</sup> | Description | Value<sup>2</sup> | Example |
| --- | ---------- | ----- | ------- |
| Subject | Several apps rely on the subject information in a certificate. We recommend specifying a value for this key. If the subject isn't set here, we recommend you include a subject name as part of the subject alternative name certificate extension. | Relative Distinguished Name string values | Subject = CN=computer1.contoso.com Subject=CN=John Smith,CN=Users,DC=Contoso,DC=com |
| Exportable | If set to TRUE, the private key can be exported with the certificate. To ensure a high level of security, private keys shouldn't be exportable; however, in some cases, it might be required if several computers or users must share the same private key. | `true | false` | `Exportable = TRUE`. CNG keys can distinguish between this and plaintext exportable. CAPI1 keys can't. |
| ExportableEncrypted | Specifies whether the private key should be set to be exportable. | `true | false` | `ExportableEncrypted = true`<p>**Tip:** Not all public key sizes and algorithms work with all hash algorithms. The specified CSP must also support the specified hash algorithm. To see the list of supported hash algorithms, you can run the command: `certutil -oid 1 | findstr pwszCNGAlgid | findstr /v CryptOIDInfo` |
| HashAlgorithm | Hash Algorithm to be used for this request. | `Sha256, sha384, sha512, sha1, md5, md4, md2` | `HashAlgorithm = sha1`. To see the list of supported hash algorithms use: certutil -oid 1 \| findstr pwszCNGAlgid \| findstr /v CryptOIDInfo|
| KeyAlgorithm| The algorithm that's used by the service provider to generate a public and private key pair.| `RSA, DH, DSA, ECDH_P256, ECDH_P521, ECDSA_P256, ECDSA_P384, ECDSA_P521` | `KeyAlgorithm = RSA` |
| KeyContainer | We don't recommend setting this parameter for new requests where new key material is generated. The key container is automatically generated and maintained by the system.<p>For requests where the existing key material should be used, this value can be set to the key-container name of the existing key. Use the `certutil –key` command to display the list of available key containers for the machine context. Use the `certutil –key –user` command for the current user's context.| Random string value<p>**Tip:** Use double quotes around any INF key value that has blanks or special characters to avoid potential INF parsing issues. | `KeyContainer = {C347BD28-7F69-4090-AA16-BC58CF4D749C}` |
| KeyLength | Defines the length of the public and private key. The key length has an impact on the security level of the certificate. Greater key length usually provides a higher security level; however, some applications may have limitations regarding the key length. | Any valid key length that is supported by the cryptographic service provider. | `KeyLength = 2048` |
| KeySpec | Determines if the key can be used for signatures, for Exchange (encryption), or for both. | `AT_NONE, AT_SIGNATURE, AT_KEYEXCHANGE` | `KeySpec = AT_KEYEXCHANGE` |
| KeyUsage | Defines what the certificate key should be used for. | <ul><li>`CERT_DIGITAL_SIGNATURE_KEY_USAGE -- 80 (128)`</li><li>`CERT_NON_REPUDIATION_KEY_USAGE -- 40 (64)`</li><li>`CERT_KEY_ENCIPHERMENT_KEY_USAGE -- 20 (32)`</li><li>`CERT_DATA_ENCIPHERMENT_KEY_USAGE -- 10 (16)`</li><li>`CERT_KEY_AGREEMENT_KEY_USAGE -- 8`</li><li>`CERT_KEY_CERT_SIGN_KEY_USAGE -- 4`</li><li>`CERT_OFFLINE_CRL_SIGN_KEY_USAGE -- 2`</li><li>`CERT_CRL_SIGN_KEY_USAGE -- 2`</li><li>`CERT_ENCIPHER_ONLY_KEY_USAGE -- 1`</li><li>`CERT_DECIPHER_ONLY_KEY_USAGE -- 8000 (32768)`</li></ul> | `KeyUsage = CERT_DIGITAL_SIGNATURE_KEY_USAGE | CERT_KEY_ENCIPHERMENT_KEY_USAGE`<p>**Tip:** Multiple values use a pipe (\|) symbol separator. Ensure that you use double-quotes when using multiple values to avoid INF parsing issues. The values shown are hexadecimal (decimal) values for each bit definition. Older syntax can also be used: a single hexadecimal value with multiple bits set, instead of the symbolic representation. For example, `KeyUsage = 0xa0`. |
| KeyUsageProperty | Retrieves a value that identifies the specific purpose for which a private key can be used. | <ul><li>`NCRYPT_ALLOW_DECRYPT_FLAG -- 1`</li><li>`NCRYPT_ALLOW_SIGNING_FLAG -- 2`</li><li>`NCRYPT_ALLOW_KEY_AGREEMENT_FLAG -- 4`</li><li>`NCRYPT_ALLOW_ALL_USAGES -- ffffff (16777215)`</li></ul> | `KeyUsageProperty = NCRYPT_ALLOW_DECRYPT_FLAG | NCRYPT_ALLOW_SIGNING_FLAG` |
| MachineKeySet | This key is important when you need to create certificates that are owned by the machine and not a user. The key material that is generated is maintained in the security context of the security principal (user or computer account) that has created the request. When an administrator creates a certificate request on behalf of a computer, the key material must be created in the machine's security context and not the administrator's security context. Otherwise, the machine couldn't access its private key since it would be in the administrator's security context. | `true | false`. The default is false. | `MachineKeySet = true` |
| NotBefore | Specifies a date or date and time before which the request can't be issued. `NotBefore` can be used with `ValidityPeriod` and `ValidityPeriodUnits`. | Date or date and time | `NotBefore = 7/24/2012 10:31 AM`<p>**Tip:** `NotBefore` and `NotAfter` are for R`equestType=cert` only. Date parsing attempts to be locale-sensitive. Using month names will disambiguate and should work in every locale. |
| NotAfter | Specifies a date or date and time after which the request can't be issued. `NotAfter` can't be used with `ValidityPeriod` or `ValidityPeriodUnits`. | Date or date and time | `NotAfter = 9/23/2014 10:31 AM`<p>**Tip:** `NotBefore` and `NotAfter` are for `RequestType=cert` only. Date parsing attempts to be locale-sensitive. Using month names will disambiguate and should work in every locale. |
| PrivateKeyArchive | The PrivateKeyArchive setting works only if the corresponding RequestType is set to CMC because only the Certificate Management Messages over CMS (CMC) request format allows for securely transferring the requester's private key to the CA for key archival. | `true | false` | `PrivateKeyArchive = true` |
| EncryptionAlgorithm | The encryption algorithm to use. | Possible options vary, depending on the operating system version and the set of installed cryptographic providers. To see the list of available algorithms, run the command: `certutil -oid 2 | findstr pwszCNGAlgid`. The specified CSP used must also support the specified symmetric encryption algorithm and length. | `EncryptionAlgorithm = 3des` |
| EncryptionLength | Length of encryption algorithm to use. | Any length allowed by the specified EncryptionAlgorithm. | `EncryptionLength = 128` |
| ProviderName | The provider name is the display name of the CSP. | If you don't know the provider name of the CSP you're using, run `certutil –csplist` from a command line. The command displays the names of all CSPs that are available on the local system | `ProviderName = Microsoft RSA SChannel Cryptographic Provider` |
| ProviderType | The provider type is used to select specific providers based on specific algorithm capability such as RSA Full. | If you don't know the provider type of the CSP you're using, run `certutil –csplist` from a command-line prompt. The command displays the provider type of all CSPs that are available on the local system. | `ProviderType = 1` |
| RenewalCert | If you need to renew a certificate that exists on the system where the certificate request is generated, you must specify its certificate hash as the value for this key. | The certificate hash of any certificate that is available at the computer where the certificate request is created. If you don't know the certificate hash, use the Certificates MMC Snap-In and look at the certificate that should be renewed. Open the certificate properties and see the `Thumbprint` attribute of the certificate. Certificate renewal requires either a `PKCS#7` or a `CMC` request format. | `RenewalCert = 4EDF274BD2919C6E9EC6A522F0F3B153E9B1582D` |
| RequesterName | Makes the request to enroll on behalf of another user request. The request must also be signed with an Enrollment Agent certificate, or the CA rejects the request. Use the `-cert` option to specify the enrollment agent certificate. The requester name can be specified for certificate requests if the `RequestType` is set to `PKCS#7` or `CMC`. If the `RequestType` is set to `PKCS#10`, this key is ignored. The `Requestername` can only be set as part of the request. You can't manipulate the `Requestername` in a pending request. | `Domain\User` | `Requestername = Contoso\BSmith` |
| RequestType | Determines the standard that is used to generate and send the certificate request. | <ul><li>`PKCS10 -- 1`</li><li>`PKCS7 -- 2`</li><li>`CMC -- 3`</li><li>`Cert -- 4`</li><li>`SCEP -- fd00 (64768)`</li></ul>**Tip:** This option indicates a self-signed or self-issued certificate. It doesn't generate a request, but rather a new certificate and then installs the certificate. Self-signed is the default. Specify a signing cert by using the –cert option to create a self-issued certificate that isn't self-signed. | `RequestType = CMC` |
| SecurityDescriptor | Contains the security information associated with securable objects. For most securable objects, you can specify an object's security descriptor in the function call that creates the object.Strings based on [security descriptor definition language](/windows/win32/secauthz/security-descriptor-definition-language).<p>**Tip:** This is relevant only for machine context non-smart card keys. | `SecurityDescriptor = D:P(A;;GA;;;SY)(A;;GA;;;BA)` |
| AlternateSignatureAlgorithm | Specifies and retrieves a Boolean value that indicates whether the signature algorithm object identifier (OID) for a PKCS#10 request or certificate signature is discrete or combined. | `true | false` | `AlternateSignatureAlgorithm = false`<p>For an RSA signature, `false` indicates a `Pkcs1 v1.5`, while `true` indicates a `v2.1` signature. |
| Silent | By default, this option allows the CSP access to the interactive user desktop and request information such as a smart card PIN from the user. If this key is set to TRUE, the CSP must not interact with the desktop and will be blocked from displaying any user interface to the user. | `true | false` | `Silent = true` |
| SMIME | If this parameter is set to TRUE, an extension with the object identifier value 1.2.840.113549.1.9.15 is added to the request. The number of object identifiers depends on the operating system version installed and CSP capability, which refers to symmetric encryption algorithms that may be used by Secure Multipurpose Internet Mail Extensions (S/MIME) applications such as Outlook. | `true | false` | `SMIME = true` |
| UseExistingKeySet | This parameter is used to specify that an existing key pair should be used in building a certificate request. If this key is set to TRUE, you must also specify a value for the RenewalCert key or the KeyContainer name. You must not set the Exportable key because you can't change the properties of an existing key. In this case, no key material is generated when the certificate request is built. | `true | false` | `UseExistingKeySet = true` |
| KeyProtection | Specifies a value that indicates how a private key is protected before use. | <ul><li>`XCN_NCRYPT_UI_NO_PROTCTION_FLAG -- 0`</li><li>`XCN_NCRYPT_UI_PROTECT_KEY_FLAG -- 1`</li><li>`XCN_NCRYPT_UI_FORCE_HIGH_PROTECTION_FLAG -- 2`</li></ul> | `KeyProtection = NCRYPT_UI_FORCE_HIGH_PROTECTION_FLAG` |
| SuppressDefaults | Specifies a Boolean value that indicates whether the default extensions and attributes are included in the request. The defaults are represented by their object identifiers (OIDs). | `true | false` | `SuppressDefaults = true` |
| FriendlyName | A friendly name for the new certificate. | Text | `FriendlyName = Server1` |
| ValidityPeriodUnits | Specifies many units that are to be used with ValidityPeriod. Note: This is used only when the `request type=cert`. | Numeric | `ValidityPeriodUnits = 3` |
| ValidityPeriod | ValidityPeriod must be a US English plural time period. Note: This is used only when the request type=cert. | `Years |  Months | Weeks | Days | Hours | Minutes | Seconds` | `ValidityPeriod = Years` |

<sup>1</sup>Parameter to the left of the equal sign (=)

<sup>2</sup>Parameter to the right of the equal sign (=)

#### [Extensions]

This section is optional.

| Extension OID | Definition | Example |
| ------------- | ---------- | ----- | ------- |
| 2.5.29.17 | | 2.5.29.17 = {text} |
| *continue* | | `continue = UPN=User@Domain.com&` |
| *continue* | | `continue = EMail=User@Domain.com&` |
| *continue* | | `continue = DNS=host.domain.com&` |
| *continue* | | `continue = DirectoryName=CN=Name,DC=Domain,DC=com&` |
| *continue* | | `continue = URL=<http://host.domain.com/default.html&>` |
| *continue* | | `continue = IPAddress=10.0.0.1&` |
| *continue* | | `continue = RegisteredId=1.2.3.4.5&` |
| *continue* | | `continue = 1.2.3.4.6.1={utf8}String&` |
| *continue* | | `continue = 1.2.3.4.6.2={octet}AAECAwQFBgc=&` |
| *continue* | | `continue = 1.2.3.4.6.2={octet}{hex}00 01 02 03 04 05 06 07&` |
| *continue* | | `continue = 1.2.3.4.6.3={asn}BAgAAQIDBAUGBw==&` |
| *continue* | | `continue = 1.2.3.4.6.3={hex}04 08 00 01 02 03 04 05 06 07` |
| 2.5.29.37 | | `2.5.29.37={text}` |
| *continue* | | `continue = 1.3.6.1.5.5.7` |
| *continue* | | `continue = 1.3.6.1.5.5.7.3.1` |
| 2.5.29.19 | | `{text}ca=0pathlength=3` |
| Critical | | `Critical=2.5.29.19` |
| KeySpec | | <ul><li>`AT_NONE -- 0`</li><li>`AT_SIGNATURE -- 2`</li><li>`AT_KEYEXCHANGE -- 1`</ul></li> |
| RequestType | | <ul><li>`PKCS10 -- 1`</li><li>`PKCS7 -- 2`</li><li>`CMC -- 3`</li><li>`Cert -- 4`</li><li>`SCEP -- fd00 (64768)`</li></ul> |
| KeyUsage | | <ul><li>`CERT_DIGITAL_SIGNATURE_KEY_USAGE -- 80 (128)`</li><li>`CERT_NON_REPUDIATION_KEY_USAGE -- 40 (64)`</li><li>`CERT_KEY_ENCIPHERMENT_KEY_USAGE -- 20 (32)`</li><li>`CERT_DATA_ENCIPHERMENT_KEY_USAGE -- 10 (16)`</li><li>`CERT_KEY_AGREEMENT_KEY_USAGE -- 8`</li><li>`CERT_KEY_CERT_SIGN_KEY_USAGE -- 4`</li><li>`CERT_OFFLINE_CRL_SIGN_KEY_USAGE -- 2`</li><li>`CERT_CRL_SIGN_KEY_USAGE -- 2`</li><li>`CERT_ENCIPHER_ONLY_KEY_USAGE -- 1`</li><li>`CERT_DECIPHER_ONLY_KEY_USAGE -- 8000 (32768)`</li></ul> |
| KeyUsageProperty | | <ul><li>`NCRYPT_ALLOW_DECRYPT_FLAG -- 1`</li><li>`NCRYPT_ALLOW_SIGNING_FLAG -- 2`</li><li>`NCRYPT_ALLOW_KEY_AGREEMENT_FLAG -- 4`</li><li>`NCRYPT_ALLOW_ALL_USAGES -- ffffff (16777215)`</li></ul> |
| KeyProtection | | <ul><li>`NCRYPT_UI_NO_PROTECTION_FLAG -- 0`</li><li>`NCRYPT_UI_PROTECT_KEY_FLAG -- 1`</li><li>`NCRYPT_UI_FORCE_HIGH_PROTECTION_FLAG -- 2`</li></ul> |
| SubjectNameFlags | template | <ul><li>`CT_FLAG_SUBJECT_REQUIRE_COMMON_NAME -- 40000000 (1073741824)`</li><li>`CT_FLAG_SUBJECT_REQUIRE_DIRECTORY_PATH -- 80000000 (2147483648)`</li><li>`CT_FLAG_SUBJECT_REQUIRE_DNS_AS_CN -- 10000000 (268435456)`</li><li>`CT_FLAG_SUBJECT_REQUIRE_EMAIL -- 20000000 (536870912)`</li><li>`CT_FLAG_OLD_CERT_SUPPLIES_SUBJECT_AND_ALT_NAME -- 8`</li><li>`CT_FLAG_SUBJECT_ALT_REQUIRE_DIRECTORY_GUID -- 1000000 (16777216)`</li><li>`CT_FLAG_SUBJECT_ALT_REQUIRE_DNS -- 8000000 (134217728)`</li><li>`CT_FLAG_SUBJECT_ALT_REQUIRE_DOMAIN_DNS -- 400000 (4194304)`</li><li>`CT_FLAG_SUBJECT_ALT_REQUIRE_EMAIL -- 4000000 (67108864)`</li><li>`CT_FLAG_SUBJECT_ALT_REQUIRE_SPN -- 800000 (8388608)`</li><li>`CT_FLAG_SUBJECT_ALT_REQUIRE_UPN -- 2000000 (33554432)`</li></ul> |
| X500NameFlags | | <ul><li>`CERT_NAME_STR_NONE -- 0`</li><li>`CERT_OID_NAME_STR -- 2`</li><li>`CERT_X500_NAME_STR -- 3`</li><li>`CERT_NAME_STR_SEMICOLON_FLAG -- 40000000 (1073741824)`</li><li>`CERT_NAME_STR_NO_PLUS_FLAG -- 20000000 (536870912)`</li><li>`CERT_NAME_STR_NO_QUOTING_FLAG -- 10000000 (268435456)`</li><li>`CERT_NAME_STR_CRLF_FLAG -- 8000000 (134217728)`</li><li>`CERT_NAME_STR_COMMA_FLAG -- 4000000 (67108864)`</li><li>`CERT_NAME_STR_REVERSE_FLAG -- 2000000 (33554432)`</li><li>`CERT_NAME_STR_FORWARD_FLAG -- 1000000 (16777216)`</li><li>`CERT_NAME_STR_DISABLE_IE4_UTF8_FLAG -- 10000 (65536)`</li><li>`CERT_NAME_STR_ENABLE_T61_UNICODE_FLAG -- 20000 (131072)`</li><li>`CERT_NAME_STR_ENABLE_UTF8_UNICODE_FLAG -- 40000 (262144)`</li><li>`CERT_NAME_STR_FORCE_UTF8_DIR_STR_FLAG -- 80000 (524288)`</li><li>`CERT_NAME_STR_DISABLE_UTF8_DIR_STR_FLAG -- 100000 (1048576)`</li><li>`CERT_NAME_STR_ENABLE_PUNYCODE_FLAG -- 200000 (2097152)`</li></ul> |

> [!NOTE]
> `SubjectNameFlags` allows the INF file to specify which **Subject** and **SubjectAltName** extension fields should be auto-populated by certreq based on the current user or current machine properties: DNS name, UPN, and so on. Using the literal template means the template name flags are used instead. This allows a single INF file to be used in multiple contexts to generate requests with context-specific subject information.
>
> `X500NameFlags` specifies the flags to be passed directly to `CertStrToName` API when the `Subject INF keys` value is converted to an ASN.1 encoded Distinguished **Name**.

#### Example

To create a policy file (.inf) in Notepad and save it as *requestconfig.inf*:

```
[NewRequest]
Subject = CN=<FQDN of computer you are creating the certificate>
Exportable = TRUE
KeyLength = 2048
KeySpec = 1
KeyUsage = 0xf0
MachineKeySet = TRUE
[RequestAttributes]
CertificateTemplate=WebServer
[Extensions]
OID = 1.3.6.1.5.5.7.3.1
OID = 1.3.6.1.5.5.7.3.2
```

On the computer for which you're requesting a certificate:

```
certreq –new requestconfig.inf certrequest.req
```

To use the [Strings] section syntax for OIDs and other difficult to interpret data. The new {text} syntax example for EKU extension, which uses a comma separated list of OIDs:

```
[Version]
Signature=$Windows NT$

[Strings]
szOID_ENHANCED_KEY_USAGE = 2.5.29.37
szOID_PKIX_KP_SERVER_AUTH = 1.3.6.1.5.5.7.3.1
szOID_PKIX_KP_CLIENT_AUTH = 1.3.6.1.5.5.7.3.2

[NewRequest]
Subject = CN=TestSelfSignedCert
Requesttype = Cert

[Extensions]
%szOID_ENHANCED_KEY_USAGE%={text}%szOID_PKIX_KP_SERVER_AUTH%,
_continue_ = %szOID_PKIX_KP_CLIENT_AUTH%
```

To specify a Subject Alternate Name (SAN), add it in the [Extensions] section of your INF. For example:

```
[Version]
Signature=$Windows NT$
 
[Strings]
szOID_ENHANCED_KEY_USAGE = 2.5.29.37
szOID_PKIX_KP_SERVER_AUTH = 1.3.6.1.5.5.7.3.1
szOID_PKIX_KP_CLIENT_AUTH = 1.3.6.1.5.5.7.3.2

[NewRequest]
Subject = CN=TestSelfSignedCert
Requesttype = Cert

[Extensions]
2.5.29.17 = "{text}"
_continue_ = "DNS=example.com"
_continue_ = "DNS=www.example.com"
_continue_ = "IP Address=192.168.1.1"
```

In this example, `2.5.29.17` is the OID defining the SAN. To specify multiple SANs, the `_continue_` extension OID is used, which lets you separate and specify each SAN extension.

### certreq -accept

The `–accept` parameter links the previously generated private key with the issued certificate and removes the pending certificate request from the system where the certificate is requested (if there's a matching request).

To manually accept a certificate:

```
certreq -accept certnew.cer
```

> [!WARNING]
> Using the `-accept` parameter with the `-user` and `–machine` options indicates whether the installing certificate should be installed in **user** or **machine** context. If there's an outstanding request in either context that matches the public key being installed, then these options aren't needed. If there is no outstanding request, then one of these must be specified.

### certreq -policy

The policy.inf file is a configuration file that defines the constraints applied to a CA certification, when a qualified subordination is defined.

To build a cross certificate request:

```
certreq -policy certsrv.req policy.inf newcertsrv.req
```

Using `certreq -policy` without any other parameter opens a dialog window, allowing you to select the requested file (.req, .cmc, .txt, .der, .cer or .crt). After you select the requested file and click **Open**, another dialog window opens, allowing you to select the policy.inf file.

#### Examples

Find an example of the policy.inf file in the [CAPolicy.inf Syntax](../../networking/core-network-guide/cncg/server-certs/prepare-the-capolicy-inf-file.md).

### certreq -sign

To create a new certificate request, sign it, and to submit it:

```
certreq -new policyfile.inf myrequest.req
certreq -sign myrequest.req myrequest.req
certreq -submit myrequest_sign.req myrequest_cert.cer
```

#### Remarks

- Using `certreq -sign` without any other parameter it opens a dialog window so you can select the requested file (req, cmc, txt, der, cer or crt).

- Signing the qualified subordination request may require **Enterprise Administrator** credentials. This is a best practice for issuing signing certificates for qualified subordination.

- The certificate used to sign the qualified subordination request uses the qualified subordination template. Enterprise Administrators have to sign the request or grant user permissions to the individuals signing the certificate.

- You might be required to have additional personnel sign the CMC request after you. This depends on the assurance level associated with the qualified subordination.

- If the parent CA of the qualified subordinate CA you're installing is offline, you must obtain the CA certificate for the qualified subordinate CA from the offline parent. If the parent CA is online, specify the CA certificate for the qualified subordinate CA during the **Certificate Services Installation** wizard.

### certreq -enroll

You can use this comment to enroll or renew your certificates.

#### Examples

To enroll a certificate, using the *WebServer* template, and by selecting the policy server using U/I:

```
certreq -enroll –machine –policyserver * WebServer
```

To renew a certificate using a serial number:

```
certreq –enroll -machine –cert 61 2d 3c fe 00 00 00 00 00 05 renew
```

You can only renew valid certificates. Expired certificates can't be renewed and must be replaced with a new certificate.

## Options

| Options | Description |
| ------- | ----------- |
| -any | `Force ICertRequest::Submit` to determine encoding type.|
| -attrib `<attributestring>` | Specifies the **Name** and **Value** string pairs, separated by a colon.<p>Separate **Name** and **Value** string pairs using `\n` (for example, Name1:value1\nName2:value2). |
| -binary | Formats output files as binary instead of base64-encoded. |
| -policyserver `<policyserver>` | ldap: `<path>`<br>Insert the URI or unique ID for a computer running the Certificate Enrollment Policy web service.<p>To specify that you would like to use a request file by browsing, just use a minus (-) sign for `<policyserver>`. |
| -config `<ConfigString>` | Processes the operation by using the CA specified in the configuration string, which is **CAHostName\CAName**. For an https:\\\ connection, specify the enrollment server URI. For the local machine store CA, use a minus (-) sign. |
| -anonymous | Use anonymous credentials for Certificate Enrollment web services. |
| -kerberos | Use Kerberos (domain) credentials for Certificate Enrollment web services. |
| -clientcertificate `<ClientCertId>` | You can replace the `<ClientCertId>` with a certificate thumbprint, CN, EKU, template, email, UPN, or the new `name=value` syntax. |
| -username `<username>` | Used with Certificate Enrollment web services. You can substitute `<username>` with the SAM name or **domain\user** value. This option is for use with the `-p` option. |
| -p `<password>` | Used with Certificate Enrollment web services. Substitute `<password>` with the actual user's password. This option is for use with the `-username` option. |
| -user | Configures the `-user` context for a new certificate request or specifies the context for a certificate acceptance. This is the default context, if none is specified in the INF or template. |
| -machine | Configures a new certificate request or specifies the context for an a certificate acceptance for the machine context. For new requests it must be consistent with the MachineKeyset INF key and the template context. If this option isn't specified and the template doesn't set a context, then the default is the user context. |
| -crl | Includes certificate revocation lists (CRLs) in the output to the base64-encoded PKCS #7 file specified by `certchainfileout` or to the base64-encoded file specified by `requestfileout`. |
| -rpc | Instructs Active Directory Certificate Services (AD CS) to use a remote procedure call (RPC) server connection instead of Distributed COM. |
| -adminforcemachine | Use the Key Service or impersonation to submit the request from Local System context. Requires that the user invoking this option be a member of Local Administrators. |
| -renewonbehalfof | Submit a renewal on behalf of the subject identified in the signing certificate. This sets CR_IN_ROBO when calling [ICertRequest::Submit method](/windows/win32/api/certcli/nf-certcli-icertrequest-submit) |
| -f | Force existing files to be overwritten. This also bypasses caching templates and policy. |
| -q | Use silent mode; suppress all interactive prompts. |
| -unicode | Writes Unicode output when standard output is redirected or piped to another command, which helps when invoked from Windows PowerShell scripts. |
| -unicodetext | Sends Unicode output when writing base64 text encoded data blobs to files. |

## Formats

| Formats | Description |
| ------- | ----------- |
| requestfilein | Base64-encoded or binary input file name: PKCS #10 certificate request, CMS certificate request, PKCS #7 certificate renewal request, X.509 certificate to be cross-certified, or KeyGen tag format certificate request. |
| requestfileout | Base64-encoded output file name. |
| certfileout | Base64-encoded X-509 file name. |
| PKCS10fileout | For use with the `certreq -policy` parameter only. Base64-encoded PKCS10 output file name. |
| certchainfileout | Base64-encoded PKCS #7 file name. |
| fullresponsefileout | Base64-encoded full response file name. |
| policyfilein | For use with the `certreq -policy` parameter only. INF file containing a textual representation of extensions used to qualify a request. |

## Additional Resources

The following articles contain examples of certreq usage:

- [How to add a subject alternative name to a secure LDAP certificate](https://support.microsoft.com/help/931351/how-to-add-a-subject-alternative-name-to-a-secure-ldap-certificate)

- [Test Lab Guide: Deploying an AD CS Two-Tier PKI Hierarchy](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831348(v=ws.11))

- [Appendix 3: Certreq.exe Syntax](/previous-versions/windows/it-pro/windows-server-2003/cc736326(v=ws.10))

- [How to create a web server SSL certificate manually](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/how-to-create-a-web-server-ssl-certificate-manually/ba-p/1128529)

- [Certificate Enrollment for System Center Operations Manager Agent](/system-center/scom/plan-planning-agent-deployment)

- [Active Directory Certificate Services Overview](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831740(v=ws.11))

- [How to enable LDAP over SSL with a third-party certification authority](https://support.microsoft.com/help/321051/how-to-enable-ldap-over-ssl-with-a-third-party-certification-authority)
