---
title: Stage a DNSSEC Deployment
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 26a30d57-c1c3-4e08-bae9-68c959e91b22
author: vhorne
---
# Stage a DNSSEC Deployment
You can use the following guidance to gradually deploy DNSSEC on your network.  
  
## In this section  
[Identify goals](../Topic/Stage-a-DNSSEC-Deployment.md#goals)  
  
[DNSSEC pilot project](../Topic/Stage-a-DNSSEC-Deployment.md#poc)  
  
[DNSSEC staging](../Topic/Stage-a-DNSSEC-Deployment.md#prod)  
  
## <a name="goals"></a>Identify goals  
The first step in a DNSSEC\-staged deployment is to evaluate your goals. Based on these goals, decide if there are zones that benefit from zone signing and other zones that do not have to be signed with DNSSEC.  
  
Include preliminary goals if you start with a pilot deployment and any additional goals that you want to achieve when DNSSEC is deployed in a production environment. Some possible goals include:  
  
-   **Improved security**: Signing with DNSSEC can protect you from DNS spoofing attacks.  
  
-   **Compliance with corporate policies**: Signing some or all zones might be required by your organization.  
  
-   **Compliance with government mandates**: Signing some or all zones might be required by your government.  
  
-   **Proof of concept**: Deploying DNSSEC first in a test environment in order to learn about the technology and to evaluate it before deployment in a production environment in the future.  
  
## <a name="poc"></a>DNSSEC pilot project  
Start with a pilot project. A DNSSEC pilot project enables you to become more familiar with DNSSEC zone signing and administration before you deploy signed zones and configure secure name resolution policies in a larger environment.  
  
> [!NOTE]  
> In a MicrosoftActive Directory\-integrated multi\-master DNS environment, all primary, authoritative DNS servers distribute and share DNS information based on the Active Directory zone replication scope. Consequently, if you sign an Active Directory\-integrated zone on a DNS server that is also a domain controller, Active Directory will attempt to replicate the zone to other DNS servers in the zone replication scope. If other DNS servers are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or a later operating system, the zone will be also be signed on these servers. To limit the size of your pilot project, sign a zone that is file\-backed or has a relatively small zone replication scope.  
>   
> When a zone is signed with DNSSEC, the DNS server will explicitly block attempts to change the zone replication scope or zone type. This is primarily to avoid complexities related to key storage when DNSSEC signing keys are stored in Active Directory. To change the zone replication scope, you must first unsign the zone.  
  
Consider the following factors when you test DNSSEC in your environment:  
  
**Scope**: Begin with a small number of zones and resource records or with a small number of DNS servers and clients. This enables you to easily test the zone signing parameters that you plan to use and to make necessary adjustments. You might want to only use a lab environment to test DNSSEC before you deploy it in production. Before you deploy DNSSEC in a production environment, test a zone that is similar in size to a zone that is to be used in production so that you can evaluate the performance impact.  
  
**Validation testing**: To test DNSSEC validation, you must deploy trust anchors and configure the NRPT. You should verify that clients can resolve names in the signed zone when DNSSEC validation is successful, and that DNS resolution fails when DNSSEC validation is not successful. For more information about conditions that can cause DNS resolution to succeed or fail for a signed zone, see [DNS Clients](../Topic/DNS-Clients.md).  
  
**Administration**: A critical part of managing a DNSSEC deployment is performing a key rollover and deploying trust anchors. You should test these procedures as part of your DNSSEC pilot project. You can also transfer the Key Master role to a different DNS server as part of a disaster recovery simulation.  
  
**Performance testing**: Review network, disk, and processor usage on the DNS server before and after zone signing. Evaluate performance of the DNS server during zone signing and key rollover. Reload the DNS zone or restart the DNS Server service to review zone loading time.  
  
**Education**: It is important to provide your support personnel with information about how DNSSEC works, additional administrative tasks associated with signed zones, and procedures to help troubleshoot DNSSEC related issues. New tools and procedures might be developed to help you manage a DNSSEC deployment. DNSSEC related events are recorded in the DNS Server log in Event Viewer \(Custom Views\\Server Roles\\DNS Server\).  
  
**Best practices**: A DNSSEC pilot is ideal for starting a list of best practices for deployment, administration, and troubleshooting of DNSSEC\-signed zones.  
  
## <a name="prod"></a>DNSSEC staging  
To allow for staged migration of server operating systems, DNSSEC deployment does not require that all DNS servers are running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] or a later operating system to host a signed zone. Although it is recommended to have all DNS servers hosting the signed zone upgraded to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] before validation is enabled on resolvers, only one authoritative DNS server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is required.  
  
Only DNS servers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or a later operating system will host a signed copy of a zone that was signed using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Servers running earlier versions of Windows will host an unsigned version of the zone.  
  
In a mixed\-mode Active Directory environment, with some DNS servers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or a later operating system and some DNS servers running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or a previous operating system, the Active Directory schema must be upgraded before signing a DNS zone. Schema update will occur automatically if you promote a computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to be a domain controller. See  
  
For more information about updating the Active Directory schema, see [Active Directory Schema Update](http://technet.microsoft.com/library/cc755834.aspx)\(http:\/\/technet.microsoft.com\/library\/cc755834.aspx\).  
  
You can use the following steps to stage a DNSSEC deployment:  
  
1.  **Choose a zone**: Start by signing a single zone or only a few zones. The zones should be small enough to monitor easily, but of sufficient size to enable thorough testing.  
  
2.  **Choose a Key Master**: Select a primary, authoritative DNS server to be the Key Master for your zone. This is the server where you will initiate zone signing, and should be online at all times.  
  
3.  **Choose methods and settings**: Decide whether you want to use DNS Manager or Windows PowerShell to sign the zone, and document the DNSSEC parameter values that you use.  
  
4.  **Sign the zone**: Use the methods and settings that you have chosen to initiate zone signing on the Key Master and to monitor progress.  
  
5.  **Verify zone signing**: Verify that zone signing was successful on the Key Master. If the zone is Active Directory\-integrated, verify that replication of the signed zone is successful. If secondary servers are configured, verify that zone transfers are successful. Also verify that the zone functions as expected. Signing a zone with DNSSEC does not affect your ability to add, delete, or update resource records.  
  
6.  **Choose DNS clients**: Select which DNS clients will require that DNSSEC validation is performed for DNS queries in this zone. The choice of DNS clients also affects which DNS servers will require trust anchors. DNS clients that require validation must use DNS servers that have valid trust anchors for the zone.  
  
7.  **Deploy trust anchors**: Deploy trust anchors to all non\-authoritative DNS servers that will perform validation of DNS queries for the zone. If applicable, this includes deploying DS records to DNS registrars that manage parent DNS zones.  
  
8.  **Configure and deploy name resolution policy**: If desired, deploy name resolution policy in your environment. Configure the NRPT to require validation of DNS queries for the signed zone and deploy this policy only to DNS clients that use DNS servers that are capable of DNSSEC validation. If some authoritative DNS servers in your environment are not capable of hosting a signed version of the zone, ensure that these DNS servers are not queried when DNSSEC validation is required.  
  
9. **Verify name resolution policy**: Verify that NRPT settings are applied to DNS clients and that all DNS queries are successful.  
  
10. **Monitor and manage**: Review the impact that zone signing has on your DNS server and support infrastructure. Initiate the key rollover process or wait for automated key rollover to occur and verify that the zone is successfully re\-signed. Redistribute trust anchors as needed after key rollover.  
  
11. Scale out: When you are ready to deploy DNSSEC on a larger scale, add additional zones, servers, and clients. Repeat the previous steps in this section to verify that new zones are signed correctly and that your DNS infrastructure is operating as expected.  
  
## See also  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
[Why DNSSEC](../Topic/Why-DNSSEC.md)  
  
[DNSSEC Performance Considerations](../Topic/DNSSEC-Performance-Considerations.md)  
  
[DNSSEC Requirements](../Topic/DNSSEC-Requirements.md)  
  
