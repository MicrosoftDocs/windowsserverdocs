---
title: Verify Configuration After NPS Changes
description: You can use this topic to verify Windows Server 2016 Network Policy Server configuration after an IP address or name change to the server.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: fc77450e-2af1-47ba-bb23-1fd36d9efdbf
ms.author: lizross 
author: eross-msft
---

# Verify Configuration After NPS Changes

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to verify NPS configuration after an IP address or name change to the server.

## Verify Configuration After an NPS IP Address Change

There might be circumstances where you need to change the IP address of an NPS or proxy, such as when you move the server to a different IP subnet. 

If you change an NPS or proxy IP address, it is necessary to reconfigure portions of your NPS deployment. 

Use the following general guidelines to assist you in verifying that an IP address change does not interrupt network access authentication, authorization, or accounting on your network for NPS RADIUS servers and RADIUS proxy servers.

You must be a member of **Administrators**, or equivalent, to perform these procedures.

### To verify configuration after an NPS IP address change

1. Reconfigure all RADIUS clients, such as wireless access points and VPN servers, with the new IP address of the NPS.

2. If the NPS is a member of a remote RADIUS server group, reconfigure the NPS proxy with the new IP address of the NPS.

3. If you have configured the NPS to use SQL Server logging, verify that connectivity between the computer running SQL Server and the NPS is still functioning properly.

4. If you have deployed IPsec to secure RADIUS traffic between your NPS and an NPS proxy or other servers or devices, reconfigure the IPsec policy or the connection security rule in Windows Firewall with Advanced Security to use the new IP address of the NPS.

5. If the NPS is multihomed and you have configured the server to bind to a specific network adapter, reconfigure NPS port settings with the new IP address.

### To verify configuration after an NPS proxy IP address change

1. Reconfigure all RADIUS clients, such as wireless access points and VPN servers, with the new IP address of the NPS proxy.

2. If the NPS proxy is multihomed and you have configured the proxy to bind to a specific network adapter, reconfigure NPS port settings with the new IP address.

3. Reconfigure all members of all remote RADIUS server groups with the proxy server IP address. To accomplish this task, at each NPS that has the NPS proxy configured as a RADIUS client:

	a. Double-click **NPS (Local)**, double-click **RADIUS Clients and Servers**, click **RADIUS Clients**, and then in the details pane, double-click the RADIUS client that you want to change.

	b. In RADIUS client **Properties**, in **Address \(IP or DNS\)**, type the new IP address of the NPS proxy.

4. If you have configured the NPS proxy to use SQL Server logging, verify that connectivity between the computer running SQL Server and the NPS proxy is still functioning properly.

## Verify Configuration After Renaming an NPS

There might be circumstances when you need to change the name of an NPS or proxy, such as when you redesign the naming conventions for your servers.

If you change an NPS or proxy name, it is necessary to reconfigure portions of your NPS deployment. 

Use the following general guidelines to assist you in verifying that a server name change does not interrupt network access authentication, authorization, or accounting.

You must be a member of **Administrators**, or equivalent, to perform this procedure.

### To verify configuration after an NPS or proxy name change

1. If the NPS is a member of a remote RADIUS server group and the group is configured with computer names rather than IP addresses, reconfigure the remote RADIUS server group with the new NPS name.

2. If certificate-based authentication methods are deployed at the NPS, the name change invalidates the server certificate. You can request a new certificate from the certification authority (CA) administrator or, if the computer is a domain member computer and you autoenroll certificates to domain members, you can refresh Group Policy to obtain a new certificate through autoenrollment. To refresh Group Policy:

	a. Open Command Prompt or Windows PowerShell.

	b. Type **gpupdate**, and then press ENTER.


3. After you have a new server certificate, request that the CA administrator revoke the old certificate. 

     After the old certificate is revoked, NPS continues to use it until the old certificate expires. By default, the old certificate remains valid for a maximum time of one week and 10 hours. This time period might be different depending on whether the Certificate Revocation List (CRL) expiry and the Transport Layer Security (TLS) cache time expiry have been modified from their defaults. The default CRL expiry is one week; the default TLS cache time expiry is 10 hours. 

     If you want to configure NPS to use the new certificate immediately, however, you can manually reconfigure network policies with the new certificate.

4. After the old certificate expires, NPS automatically begins using the new certificate. 

5. If you have configured the NPS to use SQL Server logging, verify that connectivity between the computer running SQL Server and the NPS is still functioning properly.

