---
title: Network Policy Server Best Practices
description: This topic provides best practices for deploying and managing Network Policy Server in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 90e544bd-e826-4093-8c3b-6a6fc2dfd1d6
ms.author: lizross 
author: eross-msft
---

# Network Policy Server Best Practices

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn about best practices for deploying and managing Network Policy Server \(NPS\).

The following sections provide best practices for different aspects of your NPS deployment.

## Accounting

Following are the best practices for NPS logging.

There are two types of accounting, or logging, in NPS:

- Event logging for NPS. You can use event logging to record NPS events in the system and security event logs. This is used primarily for auditing and troubleshooting connection attempts.

- Logging user authentication and accounting requests. You can log user authentication and accounting requests to log files in text format or database format, or you can log to a stored procedure in a SQL Server 2000 database. Request logging is used primarily for connection analysis and billing purposes, and is also useful as a security investigation tool, providing you with a method of tracking down the activity of an attacker.

To make the most effective use of NPS logging:

- Turn on logging \(initially\) for both authentication and accounting records. Modify these selections after you have determined what is appropriate for your environment.

- Ensure that event logging is configured with a capacity that is sufficient to maintain your logs.

- Back up all log files on a regular basis because they cannot be recreated when they are damaged or deleted.

- Use the RADIUS Class attribute to both track usage and simplify the identification of which department or user to charge for usage. Although the automatically generated Class attribute is unique for each request, duplicate records might exist in cases where the reply to the access server is lost and the request is resent. You might need to delete duplicate requests from your logs to accurately track usage.

- If your network access servers and RADIUS proxy servers periodically send fictional connection request messages to NPS to verify that the NPS is online, use the **ping user-name** registry setting. This setting configures NPS to automatically reject these false connection requests without processing them. In addition, NPS does not record transactions involving the fictional user name in any log files, which makes the event log easier to interpret.

- Disable NAS Notification Forwarding. You can disable the forwarding of start and stop messages from network access servers (NASs) to members of a remote RADIUS server group THAT IS configured in NPS. For more information, see [Disable NAS Notification Forwarding](nps-disable-nas-notifications.md).

For more information, see [Configure Network Policy Server Accounting](nps-accounting-configure.md).

- To provide failover and redundancy with SQL Server logging, place two computers running SQL Server on different subnets. Use the SQL Server **Create Publication Wizard** to set up database replication between the two servers. For more information, see [SQL Server Technical Documentation](https://msdn.microsoft.com/library/ms130214.aspx) and [SQL Server Replication](https://msdn.microsoft.com/library/ms151198.aspx).

## Authentication

Following are the best practices for authentication.

- Use certificate-based authentication methods such as Protected Extensible Authentication Protocol \(PEAP\) and Extensible Authentication Protocol \(EAP\) for strong authentication. Do not use password-only authentication methods because they are vulnerable to a variety of attacks and are not secure. For secure wireless authentication, using PEAP\-MS\-CHAP v2 is recommended, because the NPS proves its identity to wireless clients by using a server certificate, while users prove their identity with their user name and password.  For more information about using NPS in your wireless deployment, see [Deploy Password-Based 802.1X Authenticated Wireless Access](https://technet.microsoft.com/windows-server-docs/networking/core-network-guide/cncg/wireless/a-deploy-8021x-wireless-access).
- Deploy your own certification authority \(CA\) with Active Directory&reg; Certificate Services \(AD CS\) when you use strong certificate-based authentication methods, such as PEAP and EAP, that require the use of a server certificate on NPSs. You can also use your CA to enroll computer certificates and user certificates. For more information on deploying server certificates to NPS and Remote Access servers, see [Deploy Server Certificates for 802.1X Wired and Wireless Deployments](https://technet.microsoft.com/windows-server-docs/networking/core-network-guide/cncg/server-certs/deploy-server-certificates-for-802.1x-wired-and-wireless-deployments).

> [!IMPORTANT]
> Network Policy Server (NPS) does not support the use of the Extended ASCII characters within passwords.

## Client computer configuration

Following are the best practices for client computer configuration.

- Automatically configure all of your domain member 802.1X client computers by using Group Policy. For more information, see the section "Configure Wireless Network (IEEE 802.11) Policies" in the topic [Wireless Access Deployment](https://technet.microsoft.com/windows-server-docs/networking/core-network-guide/cncg/wireless/e-wireless-access-deployment#bkmk_policies).

## Installation suggestions

Following are the best practices for installing NPS.

- Before installing NPS, install and test each of your network access servers using local authentication methods before you configure them as RADIUS clients in NPS.

- After you install and configure NPS, save the configuration by using the Windows PowerShell command [Export-NpsConfiguration](https://technet.microsoft.com/library/jj872749.aspx). Save the NPS configuration with this command each time you reconfigure the NPS.

>[!CAUTION]
>- The exported NPS configuration file contains unencrypted shared secrets for RADIUS clients and members of remote RADIUS server groups. Because of this, make sure that you save the file to a secure location.
>- The export process does not include logging settings for Microsoft SQL Server in the exported file. If you import the exported file to another NPS, you must manually configure SQL Server Logging on the new server.

## Performance tuning NPS

Following are the best practices for performance tuning NPS.

- To optimize NPS authentication and authorization response times and minimize network traffic, install NPS on a domain controller.

- When universal principal names \(UPNs\) or Windows Server 2008 and Windows Server 2003 domains are used, NPS uses the global catalog to authenticate users. To minimize the time it takes to do this, install NPS on either a global catalog server or a server that is on the same subnet as the global catalog server.

- When you have remote RADIUS server groups configured and, in NPS Connection Request Policies, you clear the **Record accounting information on the servers in the following remote RADIUS server group** check box, these groups are still sent network access server \(NAS\) start and stop notification messages. This creates unnecessary network traffic. To eliminate this traffic, disable NAS notification forwarding for individual servers in each remote RADIUS server group by clearing the **Forward network start and stop notifications to this server** check box.

## Using NPS in large organizations

Following are the best practices for using NPS in large organizations.

- If you are using network policies to restrict access for all but certain groups, create a universal group for all of the users for whom you want to allow access, and then create a network policy that grants access for this universal group. Do not put all of your users directly into the universal group, especially if you have a large number of them on your network. Instead, create separate groups that are members of the universal group, and add users to those groups.

- Use a user principal name to refer to users whenever possible. A user can have the same user principal name regardless of domain membership. This practice provides scalability that might be required in organizations with a large number of domains.

- If you installed Network Policy Server \(NPS\) on a computer other than a domain controller and the NPS is receiving a large number of authentication requests per second, you can improve NPS performance by increasing the number of concurrent authentications allowed between the NPS and the domain controller. For more information, see [Increase Concurrent Authentications Processed by NPS](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-concurrent-auth).

## Security issues

Following are the best practices for reducing security issues.

When you are administering a NPS remotely, do not send sensitive or confidential data (for example, shared secrets or passwords) over the network in plaintext. There are two recommended methods for remote administration of NPSs:

- Use Remote Desktop Services to access the NPS. When you use Remote Desktop Services, data is not sent between client and server. Only the user interface of the server (for example, the operating system desktop and NPS console image) is sent to the Remote Desktop Services client, which is named Remote Desktop Connection in Windows&reg; 10. The client sends keyboard and mouse input, which is processed locally by the server that has Remote Desktop Services enabled. When Remote Desktop Services users log on, they can view only their individual client sessions, which are managed by the server and are independent of each other. In addition, Remote Desktop Connection provides 128-bit encryption between client and server.

- Use Internet Protocol security (IPsec) to encrypt confidential data. You can use IPsec to encrypt communication between the NPS and the remote client computer that you are using to administer NPS. To administer the server remotely, you can install the [Remote Server Administration Tools for Windows 10](https://www.microsoft.com/download/details.aspx?id=45520) on the client computer. After installation, use the Microsoft Management Console (MMC) to add the NPS snap-in to the console.

>[!IMPORTANT]
>You can install Remote Server Administration Tools for Windows 10 only on the full release of Windows 10 Professional or Windows 10 Enterprise.

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).

