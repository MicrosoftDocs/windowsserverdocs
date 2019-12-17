---
title: Troubleshooting Windows volume activation
description: Lists resources that provide information about best practices for volume activation, and information about troubleshooting activation issues
ms.topic: troubleshooting
ms.date: 09/24/2019
ms.technology: server-general
author: Teresa-Motiv
ms.author: v-tea
manager: dcscontentpm
ms.localizationpriority: medium
---

# Troubleshooting Windows volume activation

Product activation is the process of validating software after it's installed on a specific computer. Activation confirms that the product is genuine (not a fraudulent copy) and that the product key or serial number is valid and has not been compromised or revoked. Activation also establishes a link or relationship between the product key and the installation.

Volume activation is the process of activating volume-licensed products. To become a volume licensing customer, an organization must set up a volume licensing agreement with Microsoft. Microsoft offers customized volume licensing programs that accommodate the organization's size and purchasing preference. For more information, see the [Microsoft Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx).

The [Windows Server 2016 Activation Guide](server-2016-activation.md) focuses on the Key Management Service (KMS) activation technology. This section addresses common issues and provides troubleshooting guidelines for KMS and several other volume activation technologies.

## Best practices for volume activation

The following articles provide technical information and best practices for Microsoft's volume activation technologies.

### Key Management Service (KMS)

- [Plan for volume activation](https://docs.microsoft.com/windows/deployment/volume-activation/plan-for-volume-activation-client)
- [Understanding KMS](https://docs.microsoft.com/previous-versions/tn-archive/ff793434(v=technet.10))
- [Deploying KMS Activation](https://docs.microsoft.com/previous-versions/tn-archive/ff793409%28v=technet.10%29)
- [Configuring KMS Hosts](https://docs.microsoft.com/previous-versions/tn-archive/ff793407%28v%3dtechnet.10%29)
- [Configuring DNS](https://docs.microsoft.com/previous-versions/tn-archive/ff793405%28v%3dtechnet.10%29)
- [Activate using Key Management Service](https://docs.microsoft.com/windows/deployment/volume-activation/activate-using-key-management-service-vamt)

### Active Directory-based activation (ADBA)

- [Deploy Active-Directory-based Activation](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn502534%28v%3Dws.11%29)
- [Activate using Active Directory-based activation](https://docs.microsoft.com/windows/deployment/volume-activation/activate-using-active-directory-based-activation-client)
- [Active Directory-Based Activation overview](https://docs.microsoft.com/windows/deployment/volume-activation/active-directory-based-activation-overview)

### Multiple Activation Key (MAK) activation

- [Using MAK Activation](https://docs.microsoft.com/previous-versions/tn-archive/ff793438%28v=technet.10%29)
- [Understanding MAK Activation](https://docs.microsoft.com/previous-versions/tn-archive/ff793435%28v%3dtechnet.10%29)
- [Activating MAK Clients](https://docs.microsoft.com/previous-versions/tn-archive/ff793398%28v%3dtechnet.10%29)

### Subscription activation

- [Windows 10 Subscription Activation](https://docs.microsoft.com/windows/deployment/windows-10-subscription-activation)
- [Deploy Windows 10 Enterprise licenses](https://docs.microsoft.com/windows/deployment/deploy-enterprise-licenses)
- [Windows 10 Enterprise E3 in CSP](https://docs.microsoft.com/windows/deployment/windows-10-enterprise-e3-overview)

## Resources for troubleshooting activation issues

The following articles provide guidelines and information about tools for troubleshooting volume activation issues:

- [Guidelines for troubleshooting the Key Management Service (KMS)](activation-troubleshoot-kms-general.md)
- [Slmgr.vbs options for obtaining volume activation information](activation-slmgr-vbs-options.md)
- [Example: Troubleshooting ADBA clients that do not activate](activation-troubleshoot-adba-clients.md)

The following articles provide guidance for addressing more specific activation issues:

- [Resolving common activation error codes](activation-error-codes.md)
- [KMS activation: known issues](activation-troubleshoot-KMS-issues.md)
- [MAK activation: known issues](activation-troubleshoot-MAK-issues.md)
- [Guidelines for troubleshooting DNS-related activation issues](common-troubleshooting-procedures-kms-dns.md)
- [How to rebuild the Tokens.dat file](activation-rebuild-tokens-dat-file.md)
