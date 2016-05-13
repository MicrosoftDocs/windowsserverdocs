---
title: Provide Your Active Directory Users Access to the Applications and Services of Other Organizations
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f93c1659-355a-4440-8c06-a9a5823db9b3
---
# Provide Your Active Directory Users Access to the Applications and Services of Other Organizations
This [!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)] deployment goal builds on the goal in [Provide Your Active Directory Users Access to Your Claims-Aware Applications and Services](Provide-Your-Active-Directory-Users-Access-to-Your-Claims-Aware-Applications-and-Services.md).

When you are an administrator in the account partner organization and you have a deployment goal to provide federated access for employees to hosted resources in another organization:

-   Employees who are logged on to an Active Directory domain in the corporate network can use single\-sign\-on \(SSO\) functionality to access multiple Web\-based applications or services, which are secured by [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)], when the applications or services are in a different organization. For more information, see [Federated Web SSO Design](Federated-Web-SSO-Design.md).

    For example, Fabrikam may want corporate network employees to have federated access to Web services that are hosted in Contoso.

-   Remote employees who are logged on to an Active Directory domain can obtain [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] tokens from the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] in your organization to gain federated access to [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)]–secured Web\-based applications or services that are hosted in another organization.

    For example, Fabrikam may want its remote employees to have federated access to [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)]–secured services that are hosted in Contoso, without requiring the Fabrikam employees to be on the Fabrikam corporate network.

In addition to the foundational components that are described in [Provide Your Active Directory Users Access to Your Claims-Aware Applications and Services](Provide-Your-Active-Directory-Users-Access-to-Your-Claims-Aware-Applications-and-Services.md) and that are shaded in the following illustration, the following components are required for this deployment goal:

-   **Account partner [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)]:** Employees that access the federated service or application from the Internet can use this [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] component to perform authentication. By default, this component performs forms authentication, but it can also perform basic authentication. You can also configure this component to perform Secure Sockets Layer \(SSL\) client authentication if employees at your organization have certificates to present. For more information, see [Where to Place a Federation Server Proxy](Where-to-Place-a-Federation-Server-Proxy.md).

-   **Perimeter DNS:** This implementation of Domain Name System \(DNS\) provides the host names for the perimeter network. For more information about how to configure perimeter DNS for a [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)], see [Name Resolution Requirements for Federation Server Proxies](Name-Resolution-Requirements-for-Federation-Server-Proxies.md).

-   **Remote employee:** The remote employee accesses a Web\-based application \(through a supported Web browser\) or a Web\-based service \(through an application\), using valid credentials from the corporate network, while the employee is offsite using the Internet. The employee's client computer in the remote location communicates directly with the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] to generate a token and authenticate to the application or service.

After reviewing the information in the linked topics, you can begin deploying this goal by following the steps in [Checklist: Implementing a Federated Web SSO Design](Checklist--Implementing-a-Federated-Web-SSO-Design.md).

The following illustration shows each of the required components for this [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] deployment goal.

![](media/50af4837-31e0-451f-a942-e705c2300065.gif)


