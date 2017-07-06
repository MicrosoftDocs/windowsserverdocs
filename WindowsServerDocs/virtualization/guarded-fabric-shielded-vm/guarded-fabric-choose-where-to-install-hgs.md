---
title: Choose whether to install HGS in its own new forest or in an existing bastion forest
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 04/24/2017
---

# Choose whether to install HGS in its own new forest or in an existing bastion forest

The Active Directory forest for HGS is sensitive because its administrators have access to the keys that control shielded VMs. 
The default installation will set up a new forest for HGS and configure other dependencies. 
This option is recommended because the environment is self-contained and known to be secure when it is created. 

The only technical requirement for installing HGS in an existing forest is that it be added to the root domain; non-root domains are not supported. But there are also operational requirements and security-related best practices for using an existing forest. 
Suitable forests are purposely built to serve one sensitive function, such as the forest used by [Privileged Access Management for AD DS](https://docs.microsoft.com/microsoft-identity-manager/pam/privileged-identity-management-for-active-directory-domain-services) or an [Enhanced Security Administrative Environment (ESAE) forest](https://technet.microsoft.com/windows-server-docs/security/securing-privileged-access/securing-privileged-access-reference-material#ESAE_BM). 
Such forests usually exhibit the following characteristics:

- They have few admins (separate from fabric admins)
- They have a low number of logons
- They are not general-purpose in nature 

General purpose forests such as production forests are not suitable for use by HGS. 
Fabric forests are also unsuitable because HGS needs to be isolated from fabric administrators.

### Requirements for adding HGS to an existing forest

To add HGS to an existing bastion forest, it must be added to the root domain. 
Before you initialize HGS, you will need to join each target server of the HGS cluster to the root domain, and then add these objects:

-   A Group Managed Service Account (gMSA) that is configured for use on the machine(s) that host HGS.

-   Two Active Directory groups that you will use for Just Enough Administration (JEA). One group is for users who can perform HGS administration through JEA, and the other is for users who can only view HGS through JEA.

-   For setting up the cluster, either [prestaged cluster objects](http://go.microsoft.com/fwlink/?LinkId=746122) or, for the user who runs **Initialize-HgsServer**, permissions to prestage the cluster objects.




