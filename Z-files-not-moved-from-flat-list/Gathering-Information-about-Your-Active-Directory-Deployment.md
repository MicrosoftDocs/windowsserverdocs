---
title: Gathering Information about Your Active Directory Deployment
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b22a0f1a-7b09-4f4a-a0ae-84ac8081656c
---
# Gathering Information about Your Active Directory Deployment
Active Directory is another important item about which you must gather information. You must understand the forest structure. This includes domain layout, organizational unit (OU) architecture, and site topology. This information makes it possible to know where computers are currently placed, their configuration, and the impact of changes to Active Directory that result from implementing [!INCLUDE[wfas](includes/wfas_md.md)]. Review the following list for information needed:

-   **Names and number of forests**. The forest (not the domain) is the security boundary in an Active Directory implementation. You must understand the current Active Directory architecture to determine the most effective strategy for deploying your firewall and connection security rules using Group Policy. It also enables you to understand which computers can be isolated and how best to accomplish the required degree of isolation.

-   **Names and number of domains**. Authentication in server and domain isolation uses the IKE negotiation process with the Kerberos V5 protocol. This protocol assumes that computers are domain members.

-   **Number and types of trusts**. Trusts affect the logical boundaries of domain isolation and define whether IKE negotiation can occur between computers in different Active Directory domains.

-   **Names and number of sites**. Site architecture is usually aligned with the network topology. Understanding how sites are defined in Active Directory will help provide insight into replication and other details. Site architecture can provide a better understanding of the current Active Directory deployment.

-   **OU structure**. OUs are logical constructs and can therefore be molded to fit many different requirements and goals. The OU structure is an ideal place to examine how Group Policy is currently used and how the OUs are laid out. You do not have to redesign an already implemented OU structure in order to effectively deploy firewall and connection security policy, but an understanding of the structure helps you know what WMI or group filtering is required to apply each GPO to the correct computers.

-   **Existing IPsec policy**. Because this project culminates in the implementation of IPsec policy, you must understand how the network currently uses IPsec (if at all). [!INCLUDE[wfas](includes/wfas_md.md)] connection security rules for [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)], [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)], [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], and [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] are not compatible with earlier versions of Windows. If you already have IPsec policies deployed to computers running Windows XP and Windows Server 2003 in your organization, you must ensure that the new IPsec policies you deploy enable computers using either the old or new IPsec policies to communicate with each other.

**Next:**[Gathering Information about Your Computers](Gathering-Information-about-Your-Computers.md)


