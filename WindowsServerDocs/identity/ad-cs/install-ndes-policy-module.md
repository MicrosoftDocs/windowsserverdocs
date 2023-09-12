---
title: Install and configure a policy module with the Network Device Enrollment Service
description: Learn how to install, configure, and uninstall a policy module with the Network Device Enrollment Service.
author: robinharwood
ms.topic: overview
ms.author: gswashington
ms.date: 09/21/2023
---

# Install and configure a policy module with the Network Device Enrollment Service

Applies To: Windows Server 2012 R2

In Windows Server 2012 R2 the Active Directory Certificate Services (AD CS) Network Device Enrollment Service (NDES) supports a policy module that provides additional security for the Simple Certificate Enrollment Protocol (SCEP). This enhancement lets an organization or mobile device management solution address the issue described in [CERT Vulnerability Note VU\#971035](https://www.kb.cert.org/vuls/id/971035) titled, “Simple Certificate Enrollment Protocol (SCEP) does not strongly authenticate certificate requests.” For more information on how the policy module works and to learn about deployment options for NDES and a policy module, see [Using a Policy Module with the Network Device Enrollment Service](/using-policy-module-ndes.md)

For more information about using the policy module with Configuration Manager, see [Certificate Profiles in Configuration Manager](https://technet.microsoft.com/library/dn261202.aspx) in the System Center 2012 Configuration Manager Documentation Library.

For developer information about how to create your own policy module, see [INDESPolicy interface](https://msdn.microsoft.com/en-us/library/windows/desktop/dn383665\(v=vs.85\).aspx) on MSDN.

## How to install and uninstall the policy module

Before you can install the policy module, you must first install and configure the Network Device Enrollment Service, and verify that this can communicate successfully with an issuing certification authority. For more information, see [Network Device Enrollment Service Guidance](hh831498\(v=ws.11\).md).

If you've obtained a software solution that includes the policy module, follow the installation and configuration instructions that accompany this software rather than the instructions in this section. For example, System Center 2012 R2 Configuration Manager provides its own wizard, the Configuration Manager Policy Module Setup wizard, to install and configure the policy module.

If there are no accompanying instructions, or you have developed your own policy module, use the following procedures.

## To install and configure the policy module

1. Copy the .dll file for the policy module onto the server that runs the Network Device Enrollment Service.

1. Register the policy module by using the Regsvr32.exe command from an elevated command prompt.

    For example, if your policy module is named ndespol.dll, type **Regsvr32 ndespol.dll** and press ENTER.

1. Run the following Windows PowerShell cmdlets to update the registry path HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Cryptography\\MSCEP:

    ```
    Item -Path HKLM:\SOFTWARE\Microsoft\Cryptography\MSCEP\Modules
    ```

    This command creates the new \\Modules key.

    ```
    New-ItemProperty HKLM:\SOFTWARE\Microsoft\Cryptography\MSCEP\Modules\ -Name Policy -PropertyType String -Value "NDESPolicy.OTA.1"
    ```

    This command specifies the policy module name, using *NDESPolicy.OTA.1* as an example. Replace *NDESPolicy.OTA.1* with the name of your own policy module.

1. Restart Internet Information Services (IIS) by typing **IISReset** from an elevated command prompt.

The Network Device Enrollment Service supports only one registered policy module and after it's registered and configured, you can't choose whether to use it with the Network Device Enrollment Service; it's always used. To remove the policy module, you must manually uninstall it by updating the registry and unregistering the policy module.

>[!IMPORTANT]
> Removing the Network Device Enrollment Service role service does not uninstall the policy module.

### To uninstall the policy module

1. Run the following Windows PowerShell cmdlet to remove the registry settings:

    ```
    Remove-Item -Path HKLM:\SOFTWARE\Microsoft\Cryptography\MSCEP\Modules -Recurse
    ```

1. From an elevated command prompt, run the regsvr32.exe command with the /u option to unregister the policy module.

    For example, if the policy module name is ndespol.dll, type **regsvr32 ndespol.dll /u** and press ENTER.

## Related content

[Windows Server Security Forum](https://aka.ms/adcsforum)

[Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

[Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

[Windows PKI Blog](https://blogs.technet.com/b/pki/)