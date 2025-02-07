---
title: Install a policy module with the Network Device Enrollment Service
description: Learn how to install, configure, and uninstall a policy module with the Network Device Enrollment Service.
author: meaghanlewis
ms.topic: how-to
ms.author: mosagie
ms.date: 02/06/2025
---

# Install a policy module with the Network Device Enrollment Service

[Network Device Enrollment Service(NDES) for Active Directory Certificate Services](/windows-server/identity/ad-cs/network-device-enrollment-service-overview) support a policy module that provides extra security for the Simple Certificate Enrollment Protocol (SCEP). Using a policy module the NDES requires extra authentication to ensure that the certificate is issued to the right user.

This article covers how-to install and configure a policy module with the Network Device Enrollment Service (NDES).

## Prerequisites

- NDES role service is installed
- NDES is configured
- Read [Use a policy module with Network Device Enrollment Service](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn473016(v=ws.11)#how-to-install-and-uninstall-the-policy-module)

## How to install and uninstall the policy module

Before you can install the policy module, you must first install and configure NDES, and verify that the service communicate successfully with an issuing certification authority.

If you have a software solution that includes the policy module, follow the installation and configuration instructions for the software rather than the instructions in this section. For example, Configuration Manager provides its own wizard, and the Configuration Manager Policy Module Setup wizard, to install and configure the policy module.

If there are no accompanying instructions, or you have developed your own policy module, use the following steps.

### Install and configure the policy module

1. Copy the .dll file for the policy module onto the server that runs the NDES.

1. Register the policy module by using the Regsvr32.exe command from an elevated command prompt.

    For example, if your policy module is named ndespol.dll, type **Regsvr32 ndespol.dll** and press ENTER.

1. Run the following Windows PowerShell cmdlets to update the registry path HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Cryptography\\MSCEP:

    ```powershell
    Item -Path HKLM:\SOFTWARE\Microsoft\Cryptography\MSCEP\Modules
    ```

    This command creates the new \\Modules key.

    ```powershell
    New-ItemProperty HKLM:\SOFTWARE\Microsoft\Cryptography\MSCEP\Modules\ -Name Policy -PropertyType String -Value "NDESPolicy.OTA.1"
    ```

    This command specifies the policy module name, using *NDESPolicy.OTA.1* as an example. Replace *NDESPolicy.OTA.1* with the name of your own policy module.

1. Restart Internet Information Services (IIS) by typing **IISReset** from an elevated command prompt.

The NDES supports only one registered policy module and after it's registered and configured, you can't choose whether to use it with the NDES; it's always used. To remove the policy module, you must manually uninstall it by updating the registry and unregistering the policy module.

>[!IMPORTANT]
> Removing the NDES role service does not uninstall the policy module.

### Uninstall the policy module

1. Run the following Windows PowerShell cmdlet to remove the registry settings:

    ```powershell
    Remove-Item -Path HKLM:\SOFTWARE\Microsoft\Cryptography\MSCEP\Modules -Recurse
    ```

1. From an elevated command prompt, run the regsvr32.exe command with the /u option to unregister the policy module.

    For example, if the policy module name is ndespol.dll, type **regsvr32 ndespol.dll /u** and press ENTER.

## Related content

- [What is Network Device Enrollment Service for Active Directory Certificate Services?](/windows-server/identity/ad-cs/network-device-enrollment-service-overview)
- [Configure Network Device Enrollment Service to use a domain user account](/windows-server/identity/ad-cs/create-domain-user-account-ndes-service-account)
- [Troubleshooting the NDES policy module in Microsoft Intune](/troubleshoot/mem/intune/certificates/troubleshoot-scep-certificate-ndes-policy-module)