---
title: Planning Network Access Groups
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3692b2be-fcca-4760-994e-e6e77dc22048
---
# Planning Network Access Groups
A network access group \(NAG\) is used to identify users and computers that have permission to access an isolated server. The server is configured with firewall rules that allow only network connections that are authenticated as originating from a computer, and optionally a user, whose accounts are members of its NAG. A member of the isolated domain can belong to as many NAGs as required.

Minimize the number of NAGs to limit the complexity of the solution. You need one NAG for each server isolation group to restrict the computers or users that are granted access. You can optionally split the NAG into two different groups: one for authorized computers and one for authorized users.

The NAGs that you create and populate become active by referencing them in the **Users and Computers** tab of the firewall rules in the GPO assigned to the isolated servers. The GPO must also contain connection security rules that require authentication to supply the credentials checked for NAG membership.

For the Woodgrove Bank scenario, access to the computers running SQL Server that support the WGBank application are restricted to the WGBank front\-end servers and to approved administrative users logged on to specific authorized administrative computers. They are also only accessed by the approved admin users and the service account that is used to the run the WGBank front end service.

|NAG Name|NAG Member Users, Computers, or Groups|Description|
|------------|------------------------------------------|---------------|
|CG\_NAG\_*ServerRole*\_Users|Svr1AdminA<br /><br />Svr1AdminB<br /><br />Group\_AppUsers<br /><br />AppSvcAccount|This group is for all users who are authorized to make inbound IPsec connections to the isolated servers in this zone.|
|CG\_NAG\_*ServerRole*\_Computers|Desktop1<br /><br />Desktop2<br /><br />AdminDT1<br /><br />AppAdminDT1|This group contains all computers that are authorized to make inbound IPsec connections to the isolated servers in this zone.|

> [!NOTE]
> Membership in a NAG does not control the level of IPsec traffic protection. The IKE negotiation is only aware of whether the computer or user passed or failed the Kerberos V5 authentication process. The connection security rules in the applied GPO control the security methods that are used for protecting traffic and are independent of the identity being authenticated by Kerberos V5.

**Next:**[Planning the GPOs](Planning-the-GPOs.md)


