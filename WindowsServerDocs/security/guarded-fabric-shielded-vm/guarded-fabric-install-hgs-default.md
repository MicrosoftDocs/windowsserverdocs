---
title: Install HGS in a new forest 
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Install HGS in a new forest 

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

## Add the HGS server role

Run the following commands in an elevated PowerShell session to add the HGS server role and install HGS.

[!INCLUDE [Install the HGS server role](../../../includes/guarded-fabric-install-hgs-server-role.md)] 

## Install HGS 

[!INCLUDE [Install HGS by default](../../../includes/install-hgs-default.md)] 

## Next steps

- For the next steps to set up TPM-based attestation, see [Initialize the HGS cluster using TPM mode in a new dedicated forest (default)](guarded-fabric-initialize-hgs-tpm-mode-default.md).
- For the next steps to set up host key attestation, see [Initialize the HGS cluster using key mode in a new dedicated forest (default)](guarded-fabric-initialize-hgs-key-mode-default.md).
- For the next steps to set up Admin-based attestation (deprecated in Windows Server 2019), see [Initialize the HGS cluster using AD mode in a new dedicated forest (default)](guarded-fabric-initialize-hgs-ad-mode-default.md).

## Next step

> [!div class="nextstepaction"]
> [Initialize HGS](guarded-fabric-initialize-hgs.md)


