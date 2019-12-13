---
title: Choose whether to install HGS in its own new forest or in an existing bastion forest
ms.custom: na
ms.prod: windows-server
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Choose whether to install HGS in its own dedicated forest or in an existing bastion forest

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016


The Active Directory forest for HGS is sensitive because its administrators have access to the keys that control shielded VMs. 
The default installation will set up a new forest dedicated for HGS and configure other dependencies. 
This option is recommended because the environment is self-contained and known to be secure when it is created. 

The only technical requirement for installing HGS in an existing forest is that it be added to the root domain; non-root domains are not supported. But there are also operational requirements and security-related best practices for using an existing forest. 
Suitable forests are purposely built to serve one sensitive function, such as the forest used by [Privileged Access Management for AD DS](https://docs.microsoft.com/microsoft-identity-manager/pam/privileged-identity-management-for-active-directory-domain-services) or an [Enhanced Security Administrative Environment (ESAE) forest](https://technet.microsoft.com/windows-server-docs/security/securing-privileged-access/securing-privileged-access-reference-material#ESAE_BM). 
Such forests usually exhibit the following characteristics:

- They have few admins (separate from fabric admins)
- They have a low number of logons
- They are not general-purpose in nature 

General purpose forests such as production forests are not suitable for use by HGS. 
Fabric forests are also unsuitable because HGS needs to be isolated from fabric administrators.

## Next step

Choose the installation option that best suits your environment:

- [Install HGS in its own dedicated forest](guarded-fabric-install-hgs-default.md)
- [Install HGS in an existing bastion forest](guarded-fabric-install-hgs-in-a-bastion-forest.md)


