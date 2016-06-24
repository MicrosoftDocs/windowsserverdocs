---
title: Server Isolation GPOs
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e71bfc70-9b67-43af-9759-35691accb678
---
# Server Isolation GPOs
Each set of computers that have different users or computers accessing them require a separate server isolation zone. Each zone requires one GPO for each version of Windows running on computers in the zone. The Woodgrove Bank example has an isolation zone for their computers that run SQL Server. The server isolation zone is logically considered part of the encryption zone. Therefore, server isolation zone GPOs must also include rules for encrypting all isolated server traffic. Woodgrove Bank copied the encryption zone GPOs to serve as a starting point, and renamed them to reflect their new purpose.

All of the computer accounts for computers in the SQL Server server isolation zone are added to the group CG_SRVISO_WGBANK_SQL. This group is granted Read and Apply Group Policy permissions in on the GPOs described in this section. The GPOs are only for server versions of Windows. Client computers are not expected to be members of the server isolation zone, although they can access the servers in the zone by being a member of a network access group (NAG) for the zone.

## GPO_SRVISO_WS2008
This GPO is identical to the GPO_DOMISO_Encryption_WS2008 GPO with the following changes:

-   The firewall rule that enforces encryption is modified to include the NAGs on the **Users and Computers** tab of the rule. The NAGs granted permission include CG_NAG_SQL_Users and CG_NAG_SQL_Computers.

    > [!IMPORTANT]
    > Earlier versions of Windows support only computer-based authentication. If you specify that user authentication is mandatory, only users on computers that are running Windows 8,  Windows 7 , Windows Vista,  Windows Server 2012 ,  Windows Server 2008 R2  or  Windows Server 2008  can connect.

**Next:**[Planning GPO Deployment](Planning-GPO-Deployment.md)


