---
title: Disable weak cryptographic algorithms in certificate validation on Windows and Windows Server
description: Enhance Windows security by disabling weak crypto algorithms including MD5, SHA1, and RSA 1024-bit keys through comprehensive policy configuration and logging setup.
#customer intent: As a Windows administrator, I want to disable weak cryptographic algorithms like MD5 and SHA1 so that I can improve my organization's security posture and prevent certificates with weak signatures from being accepted.
author: robinharwood
ms.topic: how-to
ms.author: roharwoo
ms.date: 07/16/2025
ms.custom:
  - ai-gen-docs-bap
  - ai-gen-description
  - ai-seo-date:07/16/2025
ai-usage: ai-assisted
---

# Disable weak cryptographic algorithms in certificate validation

This article describes how to disable weak cryptographic algorithms using policies on Windows and Windows Server. These policies only apply to X.509 certificate validation - when Windows checks digital certificates for TLS connections, code signing, and other security scenarios.

You can configure Windows to reject certificates that use outdated algorithms like MD5 and SHA1, or RSA keys that are too short to be secure. Rejecting weak certificates helps protect your environment from certificates that could easily be compromised or forged. Using these policies, you can:

- Opt-in or opt-out of each policy independently.

- Enable logging per policy (independent of other policies). Logging is off by default.

- Specify a location to which disabled certificates are copied.

- Configure policies for both hash algorithms and asymmetric algorithms.

## Policy syntax

The cryptographic algorithm policy is defined in the Windows registry and set using the _Registry Editor_ or `certutil`. The administrator sets the policy in the following registry key:

```reg
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\OID\EncodingType 0\CertDllCreateCertificateChainEngine\Config
```

Policies are defined using the following syntax:

`Weak<CryptoAlg><ConfigType><ValueType>`

`CryptoAlg`, `ConfigType`, and `ValueType` are present in all policy names.

For example, `WeakMD5ThirdPartyFlags` or `WeakRSAAllMinBitLength`.

For each policy, the following values can be set:

- `CryptoAlg` possible values:
  - **Md5** - MD5 hash algorithm.
  - **Sha1** - SHA1 hash algorithm.
  - **Rsa** - RSA asymmetric algorithm.
  - **Dsa** - DSA asymmetric algorithm.
  - **Ecdsa** - ECDSA asymmetric algorithm.

- `ConfigType` possible values:
  - **ThirdParty** - Policy is only applied to certificates under third-party roots.
  - **All** - Policy is applied to all certs, even under enterprise roots.

- `ValueType` possible values:

  - **Flags** - `REG_DWORD` data type that can be set to disable the hash algorithm or enable a minimum key length. A breakdown of how to calculate the flags is provided in the next section.

  - **MinBitLength** - `REG_DWORD` data type that specifies the minimum public key length in bits. `MinBitLength` is only applicable to key algorithms policy. Specified as a decimal value of the minimum key length in bits. For example, 1024 represents a minimum key length of 1,024 bits.

  - **AfterTime** - `REG_BINARY` data type that contains an 8-byte FILETIME. The weak crypto algorithm check is disabled for time-stamped files before this time. This configuration value isn’t applicable to timestamp chains.

  - **Sha256Allow** - `REG_SZ` or `REG_MULTI_SZ` data type that contains the list of certificate SHA256 thumbprints (ASCII_HEX formatted) identifying weak certificates to be explicitly allowed. Non ASCII_HEX characters in the string are skipped, which allows embedded spaces.

### Value type flags

To define the flags for a weak cryptographic algorithm policy, you can use the following `REG_DWORD` values. These flags are used to enable or disable specific behaviors for the cryptographic algorithm policies.

You can combine these flags using a bitwise OR operation to create a composite flag value that represents multiple behaviors.

For example, to enable logging and disable the algorithm for all EKUs, you can combine the `CERT_CHAIN_ENABLE_WEAK_LOGGING_FLAG` and `CERT_CHAIN_DISABLE_ALL_EKU_WEAK_FLAG` flags. To combine these flags, you would set the value to `0x80010004` (which is `0x80000000 | 0x00010000 | 0x00000004`).

Expand the following sections to see a description of the flags that can be set for weak cryptographic algorithm policies:

<details>
<summary>Enable weak cryptographic settings</summary>

The `CERT_CHAIN_ENABLE_WEAK_SETTINGS_FLAG` flag is used to enable or disable weak cryptographic algorithm settings for a specific cryptographic algorithm policy. This flag is essential for controlling how weak algorithms are handled in the certificate chain building process.

Hexadecimal value: `0x80000000`

Here are some examples to illustrate how the `CERT_CHAIN_ENABLE_WEAK_SETTINGS_FLAG` (0x80000000) flag affects policy behavior:

- If this flag is **not set** for a given `Weak<CryptoAlg><ConfigType>Flags` policy, all other flags and registry values for that policy are ignored. For example, if you configure other flags for `WeakMD5ThirdPartyFlags` but don't set `0x80000000`, those settings have no effect.

- When an administrator **sets this flag** for a specific `Weak<CryptoAlg><ConfigType>Flags` policy, the policy settings defined in the registry override the default operating system behavior for that cryptographic algorithm and configuration type.

- If the flag is set in `Weak<CryptoAlg>AllFlags` policy, the resulting `Weak<CryptoAlg>ThirdPartyFlags` is a combination of the values defined in both `Weak<CryptoAlg>ThirdPartyFlags` and `Weak<CryptoAlg>AllFlags`, except for logging-related flags, which aren't combined. For example, the effective third-party flags are calculated as:  
    `ThirdPartyFlags |= AllFlags & ~(CERT_CHAIN_ENABLE_WEAK_LOGGING_FLAG | CERT_CHAIN_ENABLE_ONLY_WEAK_LOGGING_FLAG);`

- For time-based and key length settings, the resultant `Weak<CryptoAlg>ThirdPartyAfterTime` is the earliest value between `Weak<CryptoAlg>AllAfterTime` and `Weak<CryptoAlg>ThirdPartyAfterTime` (if both are defined and nonzero). Similarly, the resultant `Weak<KeyCryptoAlg>ThirdPartyMinBitLength` is the largest value between `Weak<KeyCryptoAlg>AllMinBitLength` and `Weak<KeyCryptoAlg>ThirdPartyMinBitLength`.

These examples show how the flag determines whether custom policy settings are applied. The example also explains how combined values are calculated when both "All" and "ThirdParty" configurations are defined.

</details>

<details>
<summary>Enable logging</summary>

When this flag is set, weak certificates that are identified during the certificate chain building process are logged to the directory specified by the `CERT_CHAIN_WEAK_SIGNATURE_LOG_DIR_VALUE_NAME` registry value. Logging allows administrators to review and take action on weak certificates that might pose security risks.

Hexadecimal value: `0x00000004`

</details>

<details>

<summary>Audit only logging</summary>

When the `CERT_CHAIN_ENABLE_ONLY_WEAK_LOGGING_FLAG` flag is set, only weak signature errors are logged, and no chain building errors are returned. In this mode, weak signature errors aren't returned, allowing for an audit-only mode where weak certificates are logged without affecting the chain building process.

Hexadecimal value: `0x00000008`

</details>

<details>

<summary>Disable all EKUs</summary>

The `CERT_CHAIN_DISABLE_ALL_EKU_WEAK_FLAG` flag is used to disable the algorithm corresponding to the policy for all Enhanced Key Usages (EKUs). This means that the specified cryptographic algorithm won't be used for any certificates, regardless of their EKU.

Hexadecimal value: `0x00010000`

</details>

<details>
<summary>Disable Opt-In Server Authentication EKUs</summary>

The `CERT_CHAIN_DISABLE_OPT_IN_SERVER_AUTH_WEAK_FLAG` flag is used to disable the algorithm corresponding to the policy for Server Authentication EKUs, but only for applications that opt into this change using the `CERT_CHAIN_OPT_IN_WEAK_SIGNATURE` setting. The weak signature policy enables administrators to exercise more granular control over the applications affected.

Hexadecimal value: `0x00040000`

</details>

<details>
<summary>Disabled Server Authentication EKUs</summary>

The `CERT_CHAIN_DISABLE_SERVER_AUTH_WEAK_FLAG` flag is used to disable the algorithm corresponding to the policy for Server Authentication EKUs. Meaning the specified cryptographic algorithm won't be used for any certificates with Server Authentication EKUs, regardless of whether applications opt in or not.

Hexadecimal value: `0x00100000`

</details>

<details>
<summary>Disable Code Signing EKUs</summary>

The `CERT_CHAIN_DISABLE_CODE_SIGNING_WEAK_FLAG` flag is used to disable the algorithm corresponding to the policy for code signing Enhanced Key Usages (EKUs). Meaning the specified cryptographic algorithm won't be used for any code signing certificates.

Hexadecimal value: `0x00400000`

</details>

<details>
<summary>Disable Code Signing EKUs for binaries downloaded from the web</summary>

The `CERT_CHAIN_DISABLE_MOTW_CODE_SIGNING_WEAK_FLAG` flag is used to disable the algorithm corresponding to the policy for code signing EKUs, but only when the binary is downloaded from the web.

Hexadecimal value: `0x00800000`

</details>

<details>
<summary>Disable Timestamp EKUs</summary>

The `CERT_CHAIN_DISABLE_TIMESTAMP_WEAK_FLAG` flag is used to disable the algorithm corresponding to the policy for timestamp Enhanced Key Usages (EKUs). Meaning the specified cryptographic algorithm won't be used for any timestamp certificates.

Hexadecimal value: `0x04000000`

</details>

<details>
<summary>Disable Timestamp EKUs for binaries downloaded from the web</summary>

The `CERT_CHAIN_DISABLE_MOTW_TIMESTAMP_WEAK_FLAG` flag is used to disable the algorithm corresponding to the policy for timestamp EKUs, but only when the binary is downloaded from the web.

Hexadecimal value: `0x08000000`

</details>

## Prerequisites

To configure weak cryptographic algorithm policies, you need the following prerequisites:

- Local administrative access to modify registry settings.

- (Optional) A designated log directory if enabling logging for weak certificate detection.

You also need to have the following information ready to configure the policies:

- The name of the cryptographic algorithm (for example, MD5, SHA256, RSA, DSA, ECDSA).

- For asymmetric algorithms, the minimum key size required (for example, 1,024 bits for RSA).

- Whether the policy should apply to certificates that chain to third-party root CAs or to all certificates.

- The time before which the policy check is disabled (for code signing certificates used in time-stamped signed binaries).

- The types of certificates or Enhanced Key Usages (EKUs) the policy applies to, such as:

  - All certificates

  - Server Authentication EKU

  - Code Signing EKU
  
  - Time Stamping EKU

- Whether the policy applies only to binaries downloaded from the web or to all binaries.

- Any exceptions for specific code signing or time stamping certificates, identified by their SHA2 thumbprint.

## Configure a weak cryptographic algorithm policy

To configure a weak cryptographic algorithm policy, you can use the `certutil` command-line tool or modify the Windows registry directly. Select the method that best suits your needs.

### [Certutil](#tab/certutil)

To configure a weak cryptographic algorithm policy, you can use the `certutil -setreg chain` command-line tool. This tool allows you to display, configure, and remove weak cryptographic algorithm policy settings. To learn more about the `certutil` command-line tool, see [certutil](../../administration/windows-commands/certutil.md).

To configure a weak cryptographic algorithm policy, follow these steps:

1. Determine the cryptographic algorithm you want to disable and the configuration type (for example, third-party or all) using the flags and values described in the [Policy syntax](#policy-syntax) section. Perform a bitwise OR operation to combine the flags as needed and record the resulting value.

1. Open a command prompt with administrative privileges.

1. To create a new weak cryptographic algorithm flag-based policy, use the following command:

   ```cmd
   certutil -setreg chain\Weak<CryptoAlg><ConfigType>Flags <value>
   ```

   Replace `<CryptoAlg>`, `<ConfigType>`, and `<value>` with the appropriate values for your policy.

   For example, to disable MD5 for all SSL server auth certs under third-party   root CAs, you can use the following commands:

   ```cmd
   certutil -setreg chain\WeakMD5ThirdPartyFlags 0x80100000
   ```

1. To create a new asymmetric algorithm policy, use the following command:

   ```cmd
   certutil -setreg chain\Weak<CryptoAlg><ConfigType>MinBitLength <value>
   ```

   Replace `<CryptoAlg>`, `<ConfigType>`, and `<value>` with   the appropriate values for your policy.

   For example, to disable RSA 1024 under third-party root CAs, you can use the   following commands:

   ```cmd
   certutil -setreg chain\WeakRSAThirdPartyMinBitLength 1024
   ```

1. To create a new time-based policy, use the following command:

   ```cmd
   certutil -setreg chain\Weak<CryptoAlg><ConfigType>AfterTime <value>
   ```

   Replace `<CryptoAlg>`, `<ConfigType>`, and `<value>` with   the appropriate values for your policy.

   For example, to disable MD5 for all SSL server auth certs under third-party root CAs before March 1, 2009, you can use the following commands:

   ```cmd
   certutil -setreg chain\WeakMD5ThirdPartyAfterTime @03/01/2009
   ```

### [Registry Editor](#tab/registry)

To configure a weak cryptographic algorithm policy using the Windows Registry Editor, follow these steps:

1. Determine the cryptographic algorithm you want to disable and the configuration type (for example, third-party or all) using the flags and values described in the [Policy syntax](#policy-syntax) section. Perform a bitwise OR operation to combine the flags as needed and record the resulting value.

1. Open the Registry Editor by typing `regedit` in the Run dialog (Win + R) or in a command prompt with administrative privileges.

1. Navigate to the following registry key:

   ```reg
   HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\OID\EncodingType 0\CertDllCreateCertificateChainEngine\Config
   ```

1. To create a new weak cryptographic algorithm flag-based policy, right-click on the `Config` key, select **New**, and then select **DWORD (32-bit) Value**. Name the new value using the following syntax:

   `Weak<CryptoAlg><ConfigType>Flags`

   Replace `<CryptoAlg>`, and `<ConfigType>` with the appropriate values for your policy.

   For example, to disable MD5 for all SSL server auth certs under third-party root CAs, create a new DWORD value named `WeakMD5ThirdPartyFlags`.

1. To set the value for the new policy, open the newly created DWORD value and enter the appropriate hexadecimal value. For example, to disable all SSL server auth certs, set the value to `0x80100000`.

1. To create a new asymmetric algorithm policy, right-click on the `Config` key, select **New**, and then select **DWORD (32-bit) Value**. Name the new value using the following syntax:

   `Weak<CryptoAlg><ConfigType>MinBitLength`

   Replace `<CryptoAlg>`, and `<ConfigType>` with the appropriate values for your policy.

   For example, to disable RSA 1024 under third-party root CAs, create a new DWORD value named `WeakRSAThirdPartyMinBitLength`.

1. To set the value for the new policy, open the newly created DWORD value and enter the appropriate minimum key length in bits using a decimal base value. For example, to disable RSA 1024, set the value to `1024`.

1. To create a new time-based policy, first convert the date to a FILETIME format.

   For example, to convert March 1, 2009, to FILETIME format, you can use the following PowerShell command:

   ```powershell
   [System.DateTime]::Parse("03/01/2009").ToFileTime() | Format-Hex
   ```

   This command returns a hexadecimal value that represents the FILETIME.

1. Right-click the `Config` key, select **New**, and then select **Binary Value**. Name the new value using the following syntax:

   `Weak<CryptoAlg><ConfigType>AfterTime`

   Replace `<CryptoAlg>`, and `<ConfigType>` with the appropriate values for your policy.

   Enter the hexadecimal value you obtained in the previous step as the value for the new policy. For example, to disable MD5 for all SSL server auth certs under third-party root CAs before March 1, 2009, create a new binary value named `WeakMD5ThirdPartyAfterTime` and set its value to the hexadecimal representation of the FILETIME `00 C0 29 B8 43 9A C9 01`.

---

## View configured policies

To view the currently configured weak cryptographic algorithm policies, you can use the `certutil` command-line tool or the Windows Registry Editor. Select the method that best suits your needs.

### [Certutil](#tab/certutil)

To view the currently configured weak cryptographic algorithm policies using the `certutil` command-line tool, follow these steps:

1. Open a command prompt with administrative privileges.

1. To see the default operating system behavior for weak cryptographic algorithms, run the following command:

   ```cmd
   certutil -getreg chain\default
   ```

1. To view the currently configured weak cryptographic algorithm policies, run the following command:

   ```cmd
   certutil -getreg chain\Weak<CryptoAlg><ConfigType>Flags
   ```

   Replace `<CryptoAlg>` and `<ConfigType>` with the appropriate values for your policy.

   For example, to view the MD5 third-party flags, you can use the following command:

   ```cmd
   certutil -getreg chain\WeakMD5ThirdPartyFlags
   ```

1. To view all configured weak cryptographic algorithm policies, you can run the following command:

   ```cmd
   certutil -getreg chain
   ```

### [Registry Editor](#tab/registry)

To view the currently configured weak cryptographic algorithm policies using the Windows Registry Editor, follow these steps:

1. Open the Registry Editor by typing `regedit` in the Run dialog (Win + R) or in a command prompt with administrative privileges.

1. Navigate to the following registry key:

   ```reg
   HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\OID\EncodingType 0\CertDllCreateCertificateChainEngine\Config
   ```

1. To view the currently configured weak cryptographic algorithm policies, look for values that match the naming convention `Weak<CryptoAlg><ConfigType>Flags`, `Weak<CryptoAlg><ConfigType>MinBitLength`, or `Weak<CryptoAlg><ConfigType>AfterTime`.

   For example, to view the MD5 third-party flags, look for a value named `WeakMD5ThirdPartyFlags`.

1. To view the default operating system behavior for weak cryptographic algorithms, look for the `Default` key under the `Config` key.

---

## Enable logging

The _Weak Crypto_ framework in Windows provides a mechanism for logging weak cryptographic certificates. This mechanism allows administrators to monitor and take action on certificates that are considered weak according to the configured settings.

You can enable logging using the `certutil` command-line tool or by directly modifying the Windows registry. Select the method that best suits your needs.

### [Certutil](#tab/certutil)

To enable logging for weak cryptographic certificates using the `certutil` command-line tool, follow these steps:

1. Create a log directory where the weak certificates are logged. For example, create a directory at `C:\Log` and ensure it has the correct permissions.

1. To  set the logging directory, use the following command:

   ```cmd
   certutil -setreg chain\WeakSignatureLogDir c:\log
   ```

1. To enable logging, set the logging flag for an existing weak crypto policy. Combine the `CERT_CHAIN_ENABLE_WEAK_LOGGING_FLAG` (0x00000004) or `CERT_CHAIN_ENABLE_ONLY_WEAK_LOGGING_FLAG` (0x00000008) with the existing flags for the policy. For example, to enable logging for all EKU weak MD5 third-party certs, you can use the following command:

    ```cmd
    certutil -setreg chain\WeakMD5ThirdPartyFlags 0x80010004
    ```

### [Registry Editor](#tab/registry)

To enable logging for weak cryptographic certificates using the Windows Registry Editor, follow these steps:

1. Create a log directory where the weak certificates are logged. For example, create a directory at `C:\Log` and ensure it has the correct permissions.

1. Navigate to the following registry key:

   ```reg
   HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\OID\EncodingType 0\CertDllCreateCertificateChainEngine\Config
   ```

1. To enable logging, set the logging flag for an existing weak crypto policy. Combine the `CERT_CHAIN_ENABLE_WEAK_LOGGING_FLAG` (0x00000004) or `CERT_CHAIN_ENABLE_ONLY_WEAK_LOGGING_FLAG` (0x00000008) with the existing flags for the policy. For example, to enable logging for all EKU weak MD5 third-party certs, create or modify the DWORD value named `WeakMD5ThirdPartyFlags` and set it the value to hexadecimal value `0x80010004`.

---
