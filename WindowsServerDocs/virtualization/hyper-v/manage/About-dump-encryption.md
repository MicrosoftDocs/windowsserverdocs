---
title: About dump encryption
description: "Describes how to encrypt dump files and troubleshoot encryption."
ms.prod: windows-server
manager: dongill
ms.topic: article
author: larsiwer
ms.asset: b78ab493-e7c3-41f5-ab36-29397f086f32
ms.author: kathydav
ms.date: 11/03/2016
---

# About dump encryption
Dump encryption can be used to encrypt crash dumps and live dumps generated for a system. The dumps are encrypted using a symmetric encryption key which is generated for each dump. This key itself is then encrypted using the public key specified by the trusted administrator of the host (crash dump encryption key protector). This ensures that only someone having the matching private key can decrypt and therefore access contents of the dump. This capability is leveraged in a guarded fabric.
Note: If you configure dump encryption, also disable Windows Error Reporting. WER cannot read encrypted crash dumps.

## Configuring dump encryption
### Manual configuration
To turn on dump encryption using the registry, configure the following registry values under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl`

| Value Name | Type | Value |
| ---------- | ---- | ----- |
| DumpEncryptionEnabled | DWORD | 1 to enable dump encryption, 0 to disable dump encryption |
| EncryptionCertificates\Certificate.1::PublicKey | Binary | Public key (RSA, 2048 Bit) that should be used for encrypting dumps. This has to be formatted as [BCRYPT_RSAKEY_BLOB](https://msdn.microsoft.com/library/windows/desktop/aa375531(v=vs.85).aspx). |
| EncryptionCertificates\Certificate.1::Thumbprint | String | Certificate thumbprint to allow automatic lookup of private key in the local certificate store when decrypting a crash dump. |


### Configuration using script
To simplify configuration, a [sample script](https://github.com/Microsoft/Virtualization-Documentation/tree/live/hyperv-tools/DumpEncryption) is available to enable dump encryption based on a public key from a certificate.

1. In a trusted environment: Create a certificate with a 2048 Bit RSA key and export the public certificate
2. On target hosts: Import the public certificate to the local certificate store
3. Run the sample configuration script 
    ```
    .\Set-DumpEncryptionConfiguration.ps1 -Certificate (Cert:\CurrentUser\My\093568AB328DF385544FAFD57EE53D73EFAAF519) -Force
    ```

## Decrypting encrypted dumps
To decrypt an existing encrypted dump file, you need to download and install the Debugging Tools for Windows. This tool set contains KernelDumpDecrypt.exe which can be used to decrypt an encrypted dump file.
If the certificate including the private key is present in the current user's certificate store, the dump file can be decrypted by calling

```
    KernelDumpDecrypt.exe memory.dmp memory_decr.dmp
```
After decryption, tools like WinDbg can open the decrypted dump file.

## Troubleshooting dump encryption
If dump encryption is enabled on a system but no dumps are being generated, please check the system's `System` event log for `Kernel-IO` event 1207. When dump encryption cannot be initialized, this event is created and dumps are disabled.

| Detailed error message | Steps to mitigate |
| ---------------------- | ----------------- |
| Public Key or Thumbprint registry missing | Check if both registry values exist in the expected location |
| Invalid Public Key | Make sure that the public key stored in the PublicKey registry value is stored as [BCRYPT_RSAKEY_BLOB](https://msdn.microsoft.com/library/windows/desktop/aa375531(v=vs.85).aspx). |
| Unsupported Public Key Size | Currently, only 2048 Bit RSA keys are supported. Configure a key that matches this requirement |

Also check if the value `GuardedHost` under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl\ForceDumpsDisabled` is set to a value other than 0. This disables crash dumps completely. If this is the case, set it to 0.
