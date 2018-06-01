---
title: Remote Desktop Services roles
description: Describes the components of a desktop hosting service.
ms.prod: windows-server-threshold
ms.technology: remote-desktop-services
ms.author: helohr
ms.date: 05/30/2018
ms.topic: article
author: heidilohr
manager: elizapo
---
# Remote Desktop Services roles

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This article describes the roles within a Remote Desktop Services environment.

## Remote Desktop Session Host

The Remote Desktop Session Host (RD Session Host) component provides a tenant's users with session-based desktops and remote applications. The desktops and applications can be accessed over the internet from any device running a capable remote desktop connection client.

The remote desktops and applications can be organized into collections of one or more RD Session Host servers, called "collections." The collections can be customized for specific groups of users within each tenant. For example, a collection could be created so that a tenant's accounting group can access accounting applications but the engineering group cannot access them.

The applications can be installed directly onto the RD Session Host servers. For larger deployments, we recommend streaming applications to the RD Session Host from an App-V server to reduce maintenance costs.

You can expand collections by adding RD Session Host server virtual machines to a collection farm with each RDSH virtual machine within a collection assigned to same availability set. This provides higher collection availability and increases scale to support more users or resource-heavy applications.

In most cases, RD Session Host servers are shared by multiple users simultaneously. Sharing servers like this most efficiently utilizes Azure resources for a desktop hosting solution. In this configuration, users must sign in to collections by using non-administrative accounts. In certain cases, some users want full administrative access to their remote desktop; this can be achieved by creating personal session desktop collections.

You can customize desktops even more by creating and uploading a virtual hard disk with the Windows Server OS that you can use as a template for creating new RD Session Host virtual machines.

For more information, see the following articles:

* [Easier user data management with user profile disks in Windows Server 2012](https://cloudblogs.microsoft.com/enterprisemobility/2012/11/13/easier-user-data-management-with-user-profile-disks-in-windows-server-2012/)
* [Getting started with App-V 5.0](https://docs.microsoft.com/microsoft-desktop-optimization-pack/appv-v5/getting-started-with-app-v-50--rtm)
* [Upload a generalized VHD and use it to create new VMs in Azure](https://docs.microsoft.com/azure/virtual-machines/windows/upload-generalized-managed?toc=%2Fazure%2Fvirtual-machines%2Fwindows%2Ftoc.json)

## Remote Desktop Connection Broker

The Remote Desktop Connection Broker (RD Connection Broker) role manages incoming remote desktop connections to collections of servers in Remote Desktop Session Host (RD Session Host) server farms. RD Connection Broker handles connections to both collections of full desktops and collections of remote apps. For new connections, RD Connection Broker can balance the load across the servers in the collection. For a session that was disconnected, RD Connection Broker reconnects the user to the correct RD Session Host server and the disconnected session, which already exists in the RD Session Host farm.

Single sign-on and application publishing support needs matching digital certificates to be installed on both the RD Connection Broker server and the client. For development and testing purposes, the digital certificate can be self-generated and self-signed. For a released service, you'll need a digital certificate from a trusted certification authority. The name of the certificate must be the internal Fully Qualified Domain Name (FQDN) of the RD Connection Broker virtual machine.

The Windows Server 2016 RD Connection Broker can be installed on the same virtual machine as AD DS to reduce cost. To provide a highly available service and to scale out to larger numbers of users, additional RD Connection Broker virtual machines in the same availability set can be added for create an RD Connection Broker cluster. To create an RD Connection Broker cluster, an Azure SQL Database must be deployed in the tenant's environment. If you want to use a Microsoft SQL Server AlwaysOn Availability Group, see the [Desktop Hosting Reference Architecture Guide for Windows Server](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/mt404690(v=ws.11)>).

For more information about Conection Broker, see [Use an Azure SQL database to enable high availability for your Connection Broker](Use-an-Azure-SQL-database-to-enable-high-availability-for-your-Connection-Broker.md).

## Remote Desktop Gateway

The Remote Desktop Gateway (RD Gateway) component enables tenant employees using client devices on public networks to securely access Windows desktops and applications hosted in Microsoft Azure's cloud services.

The RD Gateway component uses Secure Sockets Layer (SSL) to provide an encrypted communications channel between the clients and the server. The RD Gateway virtual machine must be accessible through a public IP address that allows inbound TCP connections to port 443. This lets the tenant's users connect from the internet using the HTTPS communications transport protocol. The RD Gateway virtual machine should also be accessible through a public IP address that allows inbound UDP connections to port 3391, which improves performance by letting users connect with the UDP protocol. The digital certificates installed on the server and client have to match for this to work. For development and testing purposes, this can be a self-generated and self-signed certificate. For a released service, the digital certificate must be obtained from a trusted certification authority. The name of the certificate must match the FQDN used to access RD Gateway, whether the FQDN is the public IP address' externally facing DNS name or the CNAME DNS record pointing to the public IP address.

For tenants with fewer users, the RD Web Access and RD Gateway roles can be combined on a single virtual machine to reduce cost. You can also add more RD Gateway virtual machines to an RD Gateway farm to provide a highly available service and scale out to more users. Virtual machines in larger RD Gateway farms should be configured in a load-balanced set. You aren't required to have IP affinity when using Remote Desktop Gateway on a Windows Server 2016 virtual machine, but it required if you're running it on a Windows Server 2012 R2 virtual machine.

For more information, see the following articles:

* [Deploying and configuring RD Gateway](https://social.technet.microsoft.com/wiki/contents/articles/10974.deploying-and-configuring-rd-gateway-in-windows-server-2012.aspx)
* [What's new in Windows Server 2012 R2 RD Gateway?](https://cloudblogs.microsoft.com/enterprisemobility/2013/03/14/whats-new-in-windows-server-2012-remote-desktop-gateway/#loadbalancing)

## Remote Desktop Web Access

The Remote Desktop Web Access (RD Web Access) component allows the tenant's employees to authenticate and access Windows desktops and applications hosted in Microsoft Azure through a website. You can use RD Web Access to publish Windows desktops and applications to a variety of Windows and non-Windows client devices. You can also selectively publish desktops or apps to specific users or groups.

The RD Web Access component requires installation of Internet Information Services (IIS). A Hypertext Transfer Protocol Secure (HTTPS) connection provides an encrypted communications channel between the clients and the RD Web server. The RD Web Access virtual machine must be accessible through a public IP address that allows inbound TCP connections to port 443 to allow the tenant's users to connect from the internet using the HTTPS communications transport protocol.

Matching digital certificates must be installed on the server and clients. For development and testing purposes, this can be a self-generated and self-signed certificate. For a released service, the digital certificate must be obtained from a trusted certification authority. The name of the certificate must match the Fully Qualified Domain Name (FQDN) that is used to access RD Web Access. Possible FQDNs include the externally facing DNS name for the public IP address and the CNAME DNS record pointing to the public IP address.

For tenants with fewer users, the RD Web Access and Remote Desktop Gateway workloads may be combined in a single virtual machine to reduce cost. You can also add additional RD Web virtual machines to an RD Web Access farm to increase service availability and scale out to more users. In an RD Web access farm with multiple virtual machines, the virtual machines must be configured in a load-balanced set.

For more information, see the following articles:

* [Deploying and Configuring RD Web Access](https://social.technet.microsoft.com/wiki/contents/articles/10758.deploying-and-configuring-rd-webaccess-in-windows-server-2012.aspx)
* [Publishing RemoteApps in Windows Server 2012 R2](https://social.technet.microsoft.com/wiki/contents/articles/10817.publishing-remoteapps-in-windows-server-2012.aspx)
* [Distribution of Remote Apps and Desktops in Windows Server 2012 R2](https://social.technet.microsoft.com/wiki/contents/articles/14488.distribution-of-remote-apps-and-desktops-in-windows-server-2012.aspx)

## Remote Desktop Licensing

Each tenant's environment includes an activated Remote Desktop Licensing server that lets users connect to the Remote Desktop Session Host (RD Session Host) servers that host the tenant's desktops and applications. For hosted environments, the licensing server is configured in per-user mode.

The service provider needs enough RDS Subscriber Access Licenses (SALs) to cover all authorized unique (not concurrent) users that sign in to the service each month. Service providers can purchase Microsoft Azure Infrastructure Services directly, and can purchase SALs through the Microsoft Service Provider Licensing Agreement (SPLA) program.  Customers who purchase a hosted desktop solution from a service provider must purchase the complete hosted solution (Azure and RDS) from the service provider.

Small tenants can reduce costs by combining the file server and RD Licensing components on a virtual machine in their environment. To provide higher service availability, tenants can deploy two RD License server virtual machines in the same availability set. All RD servers in the tenant's environment are associated with both RD License servers to keep users able to connect to new sessions if one of the servers goes down.

For more information, see the following articles:

* [Deploying Remote Desktop Licensing step-by-step guide](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd983943(v=ws.10)>)
* [Managing RDS Licensing using PowerShell on Windows Server 2012 R2](https://social.technet.microsoft.com/wiki/contents/articles/13293.managing-rds-licensing-using-powershell-on-windows-server-2012.aspx)
* [Generate per user CAL report](https://gallery.technet.microsoft.com/ScriptCenter/9739eaee-fb8a-4cb8-8456-7f138d175934/)
* [Microsoft Volume Licensing: licensing options for service providers](https://www.microsoft.com/licensing/licensing-programs/spla-program.aspx#tab=1)