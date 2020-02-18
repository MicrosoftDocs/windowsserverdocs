---
ms.assetid: fde99b44-cb9f-49bf-b888-edaeabe6b88d
title: Virtualized Domain Controller Cloning Test Guidance for Application Vendors
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Virtualized Domain Controller Cloning Test Guidance for Application Vendors

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic explains what application vendors should consider to help ensure their application continues to work as expected after the virtualized domain controller (DC) cloning process completes. It covers those aspects of the cloning process that interest application vendors and scenarios that may warrant additional testing. Application vendors who have validated that their application works on virtualized domain controllers that have been cloned are encouraged to list the name of the application in the Community Content at the bottom of this topic, along with a link to your organization's web site where users can learn more about the validation.

## Overview of virtualized DC cloning
The virtualized domain controller cloning process is described in detail in [Introduction to Active Directory Domain Services (AD DS) Virtualization (Level 100)](https://docs.microsoft.com/windows-server/identity/ad-ds/introduction-to-active-directory-domain-services-ad-ds-virtualization-level-100) and [Virtualized Domain Controller Technical Reference (Level 300)](https://docs.microsoft.com/windows-server/identity/ad-ds/deploy/virtual-dc/virtualized-domain-controller-technical-reference--level-300-). From an application vendor's perspective, these are some considerations to take into account when assessing the impact of cloning to your application:

-   The original computer is not destroyed. It remains on the network, interacting with clients. Unlike a rename where the DNS records of the original computer are removed, the original records for the source domain controller remain.

-   During the cloning process, the new computer is initially running for a brief period of time under the identity of the old computer until the cloning process is initiated and makes the necessary changes. Applications that create records about the host should ensure that the cloned computer does not overwrite records about the original host during the cloning process.

-   Cloning is a specific deployment capability for only virtualized domain controllers, not a general purpose extension to clone other server roles. Some server roles are specifically not supported for cloning:

    -   Dynamic Host Configuration Protocol (DHCP)

    -   Active Directory Certificate Services (AD CS)

    -   Active Directory Lightweight Directory Services (AD LDS)

-   As part of the cloning process, the entire VM that represents the original DC is copied, so any application state on that VM is also copied. Validate that the application adapts to this change in state of the local host on the cloned DC, or if any intervention is required, such as a service restart.

-   As part of cloning, the new DC gets a new machine identity and provisions itself as a replica DC in the topology. Validate whether the application depends on the machine identity, such as its name, account, SID, and so on. Does it automatically adapt to the change of machine identity on the clone? If that application caches data, ensure that it does not rely on machine identity data that may be cached.

## What is interesting for Application Vendors?

### CustomDCCloneAllowList.xml
A domain controller that runs your application or service cannot be cloned until the application or service is either:

-   Added to the CustomDCCloneAllowList.xml file by using the Get-ADDCCloningExcludedApplicationList Windows PowerShell cmdlet

-Or-

-   Removed from the domain controller

The first time the user runs the Get-ADDCCloningExcludedApplicationList cmdlet, it returns a list of services and applications that are running on the domain controller but are not in the default list of services and applications that are supported for cloning. By default, your service or application will not be listed. To add your service or application to the list of applications and services that can be safely cloned, the user runs Get-ADDCCloningExcludedApplicationList cmdlet again with the -GenerateXML option in order to add it to the CustomDCCloneAllowList.xml file. For more information, see [Step 2: Run Get-ADDCCloningExcludedApplicationList cmdlet](https://docs.microsoft.com/powershell/module/addsadministration/get-addccloningexcludedapplicationlist).

### Distributed System Interactions
Usually services isolated to the local computer either pass or fail when participating in cloning. Distributed services have to be concerned about having two instances of the host computer on the network simultaneously for a brief period of time. This may manifest as a service instance trying to pull information from a partner system where the clone has registered as the new vendor of the identity. Or both instances of the service may push information into the AD DS database at the same time with different results. For example, it is not deterministic which computer will be communicated with when two computers that have Windows Testing Technologies (WTT) service are on the network with the domain controller.

For the distributed DNS Server service, the cloning process carefully avoids overwriting the DNS records of the source domain controller when the clone domain controller starts with a new IP address.

You should not rely on the computer to remove all of the old identity until the end of cloning. After the new domain controller is promoted inside the new context, select Sysprep providers are run to clean up the additional state of the computer. For example, it is at this point the old certificates of the computer are removed and the cryptography secrets that the computer can access are changed.

The greatest factor that varies the timing of the cloning is how many objects there are to replicate from the PDC. Older media increases the time required to complete cloning.

Because your service or application is unknown, it is left running. The cloning process does not change the state of non-Windows services.

Additionally, the new computer has a different IP address than the original computer. These behaviors may cause side effects to your service or application depending on how the service or application behaves in this environment.

## Additional scenarios suggested for testing

### Cloning Failure
Service vendors should test this scenario because when cloning fails the computer boots into Directory Services Repair Mode (DSRM), a form of Safe Mode. At this point the computer has not completed cloning. Some state may have changed and some state may remain from the original domain controller. Test this scenario to understand what impact it can have on your application.

To induce a cloning failure, try to clone a domain controller without granting it permission to be cloned. In this case, the computer will have only changed the IP addresses and still have the majority of its state from the original domain controller. For more information about granting a domain controller permission to be cloned, see [Step 1: Grant the source virtualized domain controller the permission to be cloned](https://docs.microsoft.com/windows-server/identity/ad-ds/get-started/virtual-dc/virtualized-domain-controller-deployment-and-configuration).

### PDC emulator cloning
Service and application vendors should test this scenario because there is an additional reboot when the PDC emulator is cloned. In addition, the majority of cloning is performed under a temporary identity to allow the new clone to interact with the PDC emulator during the cloning process.

### Writable versus read-only domain controllers
Service and application vendors should test cloning by using the same type of domain controller (that is, on a writable or read-only domain controller) that service is planned to run on.
