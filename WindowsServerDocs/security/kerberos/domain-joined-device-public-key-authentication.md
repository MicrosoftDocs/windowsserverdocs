---
title: Domain-joined Device Public Key Authentication
ms.custom: na
ms.prod: windows-server
ms.topic: article
ms.assetid: 7bd17803-6e42-4a3b-803f-e47c74725813
manager: alanth
author: michikos
ms.technology: security-authentication
ms.date: 08/18/2017
---

# Domain-joined Device Public Key Authentication

>Applies to: Windows Server 2016, Windows 10

Kerberos added support for domain-joined devices to sign-in using a certificate beginning with Windows Server 2012 and Windows 8. This change allows 3rd party vendors to create solutions to provision and initialize certificates for domain-joined devices to use for domain authentication. 

## Automatic public key provisioning

Beginning with Windows 10 version 1507 and Windows Server 2016, domain-joined devices automatically provision a bound public key to a Windows Server 2016 domain controller (DC). Once a key is provisioned, then Windows can use public key authentication to the domain.

### Key generation
If the device is running Credential Guard, then a public/private key pair is created protected by Credential Guard. 

If Credential Guard is not available and a TPM is, then a public/private key pair is created protected by the TPM. 

If neither is available, then a key pair is not generated and the device can only authenticate using password.

### Provisioning computer account public key
When Windows starts up, it checks if a public key is provisioned for its computer account. If not, then it generates a bound public key and configures it for its account in AD using a Windows Server 2016 or higher DC. If all the DCs are down-level, then no key is provisioned.

### Configuring device to only use public key
If the Group Policy setting **Support for device authentication using certificate** is set to **Force**, then the device needs to find a DC that runs Windows Server 2016 or later to authenticate. The setting is under Administrative Templates > System > Kerberos.

### Configuring device to only use password
If the Group Policy setting **Support for device authentication using certificate** is disabled, then password is always used. The setting is under Administrative Templates > System > Kerberos.

## Domain-joined device authentication using public key
When Windows has a certificate for the domain-joined device, Kerberos first authenticates using the certificate and on failure retries with password. This allows the device to authenticate to down-level DCs.

Since the automatically provisioned public keys have a self-signed certificate, certificate validation fails on domain controllers that do not support Key Trust account mapping. By default, Windows retries authentication using the device's domain password.


