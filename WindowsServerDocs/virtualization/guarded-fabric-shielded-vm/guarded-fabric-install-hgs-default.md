---
title: Install HGS in a new forest 
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 07/05/2017
---

# Install HGS in a new forest 

>[!div class="step-by-step"]
[« Prepare for HGS](guarded-fabric-prepare-for-hgs.md)
[Initialize HGS »](guarded-fabric-initialize-hgs.md)

## Add the HGS server role

[!INCLUDE [Install the HGS server role](../../../includes/guarded-fabric-install-hgs-server-role.md)] 

## Install HGS 

The Host Guardian Service should be installed in a separate Active Directory forest than the Hyper-V hosts and fabric managers.
If a secure bastion forest is not already available in your environment, follow these steps to have HGS set up one for you.

Ensure that the HGS machine is **not** joined to a domain before you start.

1.  In an elevated Windows PowerShell console, run the following commands to install the Host Guardian Service and configure its domain.
The password you specify here will only apply to the Directory Services Restore Mode password for Active Directory; it will *not* change your admin account's login password.
You may provide any domain name of your choosing to the `-HgsDomainName` parameter.

    ```powershell
    $adminPassword = ConvertTo-SecureString -AsPlainText '<password>' -Force

    Install-HgsServer -HgsDomainName 'relecloud.com' -SafeModeAdministratorPassword $adminPassword -Restart
    ```

2.  After the computer restarts, log in as the domain administrator.

## Next steps

- For the next steps to set up TPM-based attestation, see [Initialize the HGS cluster using TPM mode in a new dedicated forest (default)](guarded-fabric-initialize-hgs-tpm-mode-default.md).
- For the next steps to set up Admin-based attestation, see [Initialize the HGS cluster using AD mode in a new dedicated forest (default)](guarded-fabric-initialize-hgs-ad-mode-default.md).




