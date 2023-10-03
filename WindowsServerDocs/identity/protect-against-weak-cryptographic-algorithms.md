---
title: Protecting against weak cryptographic algorithms
description: Learn how to protect against weak cryptographic algorithms in Windows and Windows Server
author: robinharwood
ms.topic: how-to
ms.author: gswashington
ms.date: 10/16/2023
---

# Protecting against weak cryptographic algorithms

A software update is available for all supported versions of Windows and Windows Server that enables deprecation of weak cryptographic algorithms. To use automatic updates from Microsoft as a means to be better protected from weak cryptographic algorithms, this software update must be downloaded and installed on computers that run the supported operating systems.

This software update is built-in to the Windows 8.1 and Windows Server 2012 R2 operating systems.

## What does this software update do?

This software update provides an administrator with greater control over the way RSA keys, hash algorithms, and non-RSA asymmetric key algorithms are blocked. This software update allows an administrator to:

- Define policies to selectively block cryptographic algorithms that override settings provided by the operating system.

- Opt-in or opt-out of each policy independently.

- Enable logging per policy (independent of other policies). Logging is off by default.

- Specify a location to which blocked certificates are copied.

- Set policies per algorithm and define hash algorithm policies and asymmetric algorithm policies as described in the following sections.

### Hash algorithm policies

- Define the name of the hash algorithm, such as MD5 or SHA1.
- Specify if the policy applies to certificates that chain to third-party root CAs, which excludes the enterprise certificates, or to apply the policy to all certificates.
- Specify a time before which the policy check is disabled (only applicable to code signing certificates used in time-stamped signed binaries).
- Define the type of certificates to which the policy applies, such as:
    - All certificates. Note: If the policy is enabled for all certificates, then an administrator cannot allow weak cryptographic algorithms for a specific Enhanced Key Usage (EKU), such as Server Authentication EKU or Code signing EKU.
    - Certificates that have the Server Authentication EKU.
    - Certificates that have the Code signing EKU.
    - Certificates that have the Time Stamping EKU.
    - Specify whether the policy applies only to signing certificates of binaries downloaded from web or to all binaries.
    - Specify code signing and time stamping certificates that are not blocked (such as those used in legacy code signing or time-stamping situations); the certificates are identified by using their SHA2 thumbprint.

### Asymmetric algorithm policies

- Define the algorithm name and minimum key size, such as RSA, DSA, and ECDSA.
- Specify if the policy applies to certificates that chain to third-party root CAs, which excludes the enterprise certificates, or if the policy applies to all certificates.
- Specify a time before which the policy check is disabled (for time-stamped files).
- Define the type of certificates to which the policy applies, such as:
    - All certificates. Note: If the policy is enabled for all certificates then an administrator cannot allow weak cryptographic algorithms for a specific EKU, such as Server Authentication EKU or Code signing EKU.
    - Certificates that have the Server Authentication EKU.
    - Certificates that have the Code signing EKU.
    - Certificates that have the Time Stamping EKU.
    - Specify whether the policy applies only to signing certificates of binaries downloaded from web or to all binaries.
    - Specify code signing and time stamping certificates that are not blocked (such as those used in legacy code signing or time-stamping situations); the certificates are identified by using their SHA2 thumbprint.

## How to configure policies for blocking cryptographic algorithms

The administrator sets cryptographic algorithm blocking policy in the following registry key:

HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Cryptography\\OID\\EncodingType 0\\CertDllCreateCertificateChainEngine\\Config

Use the following commands to display, configure, and remove the cryptographic algorithm blocking policy settings:

- `certutil -getreg chain`

- `certutil -setreg chain`

- `certutil -delreg chain`

The registry entries use the following syntax:

```
Weak<CryptoAlg><ConfigType><ValueType>
```

The following table lists registry values that can be set to modify default settings for cryptographic algorithm blocking policy. *\<CryptoAlg\>*, *\<ConfigType\>* and *\<ValueType\>* will be present in all names:

| Configuration Option | | Possible values |
| ----- | | ----- |
| CryptoAlg | | Md5; Sha1; Rsa; Dsa; Ecdsa |
| ConfigType | | **ThirdParty:** Policy is only applied to certificates under third-party roots; **All:** Policy is applied to all certs, even under enterprise roots. |
| ValueType | | **Flags:** REG_DWORD data type that can be set to disable the hash algorithm or enable a minimum key length. For more information, see the following table.; **MinBitLength:**  REG_DWORD data type that specifies the minimum public key length in bits. **Note:** MinBitLengh is only applicable to key algorithms policy. **AfterTime:** REG_BINARY data type that contains an 8 byte FILETIME. The weak crypto algorithm check is disabled for time stamped files before this time. This configuration value isn’t applicable to timestamp chains. **Sha256Allow:** REG_SZ or REG_MULTI_SZ data type that contains the list of certificate SHA256 thumbprints (ASCII_HEX formatted) identifying weak certificates to be explicitly allowed. Non ASCII_HEX characters in the string are skipped, which allows embedded spaces.|

The following REG\_DWORD values can be set as flags in Weak*\<CryptoAlg\>\<ConfigType\>*Flags:

- **CERT_CHAIN_ENABLE_WEAK_SETTINGS_FLAG (0x80000000) flag**
    -  (0x80000000)	If this flag is not set, then all other flags and registry values are ignored for this Weak<CryptoAlg><ConfigType>.
    - If the administrator sets this flag for its Weak<CryptoAlg><ConfigType>, then, the corresponding settings provided for the operating system are ignored.
    - If this flag is set in Weak<CryptoAlg>AllFlags:
        - Then the resultant Weak<CryptoAlg>ThirdPartyFlags will be a combination of the Weak<CryptoAlg>Thirdparty and Weak<CryptoAlg>AllFlags defined. However, logging flags won't be updated. That is, “ThirdPartyFlags |= AllFlags & ~( CERT_CHAIN_ENABLE_WEAK_LOGGING_FLAG | CERT_CHAIN_ENABLE_ONLY_WEAK_LOGGING_FLAG);”
        - Resultant "Weak<CryptoAlg>"ThirdPartyAfterTime" will be earliest ("Weak"<CryptoAlg>"AllAfterTime", "Weak"<CryptoAlg>"ThirdPartyAfterTime"). (Note: Only applicable if "Weak"<CryptoAlg>"AllAfterTime" is defined and nonzero.)
        - Resultant "Weak"<KeyCryptoAlg>"ThirdPartyMinBitLength" will be largest ("Weak"<KeyCryptoAlg>"AllMinBitLength", "Weak"<KeyCryptoAlg>"ThirdPartyMinBitLength")

- **CERT_CHAIN_ENABLE_WEAK_LOGGING_FLAG (0x00000004) flag**
    - 	This flag is set to enable the logging of weak certificates to the directory identified by CERT_CHAIN_WEAK_SIGNATURE_LOG_DIR_VALUE_NAME.

- **CERT_CHAIN_ENABLE_ONLY_WEAK_LOGGING_FLAG (0x00000008) flag**
        - This flag is set to only log weak certificates to the directory identified by CERT_CHAIN_WEAK_SIGNATURE_LOG_DIR_VALUE_NAME. Weak signature errors are not returned.

In addition to setting the CERT\_CHAIN\_ENABLE\_WEAK\_SETTINGS\_FLAG flag described in the preceding table, the following flags corresponding to the EKU must be set to disable weak signature or enable weak hash hygiene checks:

- **CERT_CHAIN_DISABLE_ALL_EKU_WEAK_FLAG (0x00010000) flag**
    - Disables the algorithm corresponding to that policy for all EKUs.

- **CERT_CHAIN_DISABLE_OPT_IN_SERVER_AUTH_WEAK_FLAG (0x00040000)**
    - Disables the algorithm corresponding to that policy for ServerAuth EKUs for applications that opt into this change using CERT_CHAIN_OPT_IN_WEAK_SIGNATURE.

- **CERT_CHAIN_DISABLE_SERVER_AUTH_WEAK_FLAG (0x00100000) flag**
    - Disables the algorithm corresponding to that policy for ServerAuth EKUs.

- **CERT_CHAIN_DISABLE_CODE_SIGNING_WEAK_FLAG (0x00400000) flag**
    - Disables the algorithm corresponding to that policy for code signing EKUs.

- **CERT_CHAIN_DISABLE_MOTW_CODE_SIGNING_WEAK_FLAG (0x00800000) flag**
    - Disables the algorithm corresponding to that policy for code signing EKUs only when the binary is downloaded from the web.

- **CERT_CHAIN_DISABLE_TIMESTAMP_WEAK_FLAG (0x04000000) flag**
    - Disables the algorithm corresponding to that policy for timestamp EKUs.

- **CERT_CHAIN_DISABLE_MOTW_TIMESTAMP_WEAK_FLAG (0x08000000) flag**
    -  (0x08000000)	Disables the algorithm corresponding to that policy for timestamp EKUs only when the binary is downloaded from the web.

## Updating client registry settings through Group Policy

The following procedure shows how to configure the registry settings on all domain-joined machines using GPUpdate. For more details, see [Configure a Registry Item](https://technet.microsoft.com/library/cc753092.aspx).

#### To update client registry settings

1.  On a domain controller, open Group Policy Management Editor.

    1.  Open MMC, select **File**, click **Add/Remove Snap ins**, and select **Group Policy Management Editor**.

        ![](images/Dn375961.f2209918-76d6-491f-9c2a-da47f8b5cac7(WS.11).jpeg)

    1.  Select **Add** to start the Group Policy Wizard.

        ![](images/Dn375961.2273ad1f-d865-46b0-bb19-d3dced74ab1f(WS.11).jpeg)

    1.  Select **Browse**, click **Default Domain Policy**, select **OK**, and select **Finish**.

        ![](images/Dn375961.fd9baf0e-7cbf-41a8-89c2-b95614ca99a8(WS.11).jpeg)

1.  Expand Default Domain Policy|Computer Configuration|Preferences|Windows Settings|Registry.

    1.  Right-select **Registry**, select **New**, and select **Registry Item**.

        ![](images/Dn375961.ecfc3c5d-0f60-4ba0-8689-1276d0e44719(WS.11).jpeg)

    1.  In the New Registry Properties, select **Browse** to select the required Key path.

        ![](images/Dn375961.c08f35f1-1877-4cab-af21-cc2527c6be12(WS.11).jpeg)

    1.  Select the registry path. For example:

        SOFTWARE\\Microsoft\\Cryptography\\OID\\EncodingType 0\\CertDllCreateCertificateChainEngine\\Config

    1.  If the registry value name is already present select the registry value too, for example, **WeakMD5ThirdPartyAfterTime**.

        ![](images/Dn375961.71d3f7c9-cab8-4fe7-a480-9a8c66f0be63(WS.11).jpeg)

    1.  If the registry entry is new, select the key location, enter the registry value name, select the appropriate value type, and enter required data.

        ![](images/Dn375961.f0ac1868-9f39-4670-8205-6bc4e0965c1d(WS.11).jpeg)

1.  Select **Apply** and **OK**. If necessary, run gpupdate /force on domain-joined computers to have the policy setting change be applied immediately.

1.  For binary values like **AfterTime**, it is recommended to first apply the value using CertUtil command or in a test computer and then export the values and import them to a domain controller.

    For example, if an administrator needs to apply **WeakMD5ThirdPartyAfterTime**, which is of type REG\_BINARY to a date such as 1/1/2010, the administrator can execute the following CertUtil command on a domain controller. The command updates the registry with the correct binary value. After updating the registry, follow the previous steps to apply to the same value to domain-joined computers using Group Policy.

    ```
    Certutil -setreg chain\WeakMD5ThirdPartyAfterTime  @1/1/2010
    ```

## Examples

The following example disables MD5 for all SSL server auth certs under third-party root CAs, but allows signed binaries before March 1, 2009 to be accepted. Not applicable to other EKUs. Logging is also enabled, and the message “Setting logging directory section” will appear.

```
Certutil –setreg chain\Default\WeakMd5ThirdPartyFlags 0x80100004
Certutil –setreg chain\Default\WeakMd5ThirdPartyAfterTime @03/01/2009
```

The following example disables RSA 1024 for all timestamp certs under third-party root CAs, but allows signed binaries before March, 2013 to be accepted. Not applicable to other EKUs.

```
Certutil –setreg chain\Default\WeakRSAThirdPartyFlags 0x84000000
Certutil –setreg chain\Default\WeakRSAThirdPartyMinBitLength 1024
Certutil –setreg chain\Default\WeakRSAThirdPartyAfterTime @3/1/2013

```

### Setting logging directory and enabling logging

Weak Crypto framework provides a mechanism where administrators can set a log directory for all the certs which are considered weak according to settings.

To enable logging, an administrator can set a logging directory either by adding a registry entry or executing certutil command as follows (c:\\Log should be created and with correct permissions) along with weak crypto settings:

```
Certutil -setreg chain\WeakSignatureLogDir c:\log
```

Or updating registry directly:

HKLM\\SOFTWARE\\Microsoft\\Cryptography\\OID\\EncodingType 0\\CertDllCreateCertificateChainEngine\\Config\\WeakSignatureLogDir

Update the flags to enable logging CERT\_CHAIN\_ENABLE\_WEAK\_LOGGING\_FLAG (0x00000004), as in the following example, where weak crypto is applied for all EKUs and the weak MD5 third-party certificates are logged to c:\\log.

```
Certutil -setreg chain\WeakMD5ThirdPartyFlags  0x80010004
```

### Logging with Audit only Mode

Weak crypto framework also provides a feature for an administrator to have logging only without any chain building errors returned. To set this, users need to include CERT\_CHAIN\_ENABLE\_ONLY\_WEAK\_LOGGING\_FLAG (0x00000008). For example, to enable audit only mode for all EKU weak MD5 Third-party certs:

```
Certutil -setreg chain\WeakSignatureLogDir c:\log
```

and

```
Certutil -setreg chain\WeakMD5ThirdPartyFlags  0x80010008
```
