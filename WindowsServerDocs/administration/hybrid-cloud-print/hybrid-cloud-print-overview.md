---
title: Windows Server Hybrid Cloud Print overview
description: Hybrid Cloud Print allows IT Pros to support print requirements for BYOD or domain joined devices.  
ms.prod: w10
ms.mktglfcycl: manage
ms.sitesec: library
ms.pagetype: store
ms.technology: server-general
author: TrudyHa
ms.author: TrudyHa
ms.date: 10/16/2017
---

# Windows Server Hybrid Cloud Print overview

**Applies to**
-   Windows Server 2016

## What is Hybrid Cloud Print?
**Hybrid Cloud Print** is a new feature for Windows Server 2016 available through **Features on Demand**. It allows IT professionals to support print requirements for people who bring their own devices, or use devices joined to your Azure Active Directory. This includes mobile devices such as Windows phone, laptops, or tablets running either Windows 10 or Windows Mobile. It provides printing support from anywhere people have access to the Internet.

For IT Admins, **Hybrid Cloud Print** provides secure user access to on-premises printers by using Azure's multi-factor authentication to validate user access. Single sign-on (SSO) functionality simplifies the user experience. **Hybrid Cloud Print** is built on Windows **Print Server** role, giving IT Pros an experience that is similar to managing printers and user access security.

**Hybrid Cloud Print** allows people in your organization to print from the devices they use to complete their work - even when they are away from their desk or workplace.

**Hybrid Cloud Print** is supported in Windows 10 Creators Update and Windows 10 S.
 
## Feature summary
**Hybrid Cloud Print** consists of two main server-side components: **Discovery** service, and **Windows Print** service.
- **Discovery** service endpoint running on an IIS service supporting Mopria Alliance industry standard for printer discovery in the cloud.
- **Windows Print** service endpoint running on an IIS service supporting industry standard Internet Printing Protocol (IPP) to ensure the broadest client OS support.

## Deployment
**Hybrid Cloud Print** supports a couple of different deployment options depending on where your organization requires user authentication. Here's what a deployment could look like:

![A diagram showing a graphic depiction of the Hybrid Cloud Print solution](../media/hybrid-cloud-print/wshcp-deployment-options.png)

*Hybrid Cloud Print solution diagram*

The diagram shows:
- **Hybrid Cloud Print** using Azure Active Directory as the user identity provider. 
- **Windows Print** service and **Discovery** service endpoints are registered with Azure Active Directory to enable the client device to retrieve the required user authentication token to use against these services. 
- An MDM service, such as **Microsoft Intune**, provisions the client device with policies needed to connect Azure Active Directory to **Windows Print** service and **Discovery** service.

This table has more info on the elements in the diagram.  

| Element | Description |
| ------- | ----------- |
| Azure Active Directory  | Provides and controls user identity and authorization functionality |
| Active Directory        | Provides and controls user identity and authorization functionality |
| Azure AD Connect  | Synchronizes user credentials between Azure AD and on-premises AD. |
| MDM Service (Intune) | Provides device policy provisioning functionality to ensure client device (BYOD device) complies with corporate policies. |
| Azure AD Proxy | Provides a long-lived connection that is established from behind your firewall to Azure to allow specific configured application traffic to flow from the Internet into the corporate network. |
| Azure Web App | The core of Hybrid Cloud Print solution. Provides the required web endpoints to discover printers and send print content for non-domain joined devices. |
| BYOD device / Windows Print Server Spooler / Printer | These are as-is. No change in functionality in the deployment. |

There are two ways to install **Hybrid Cloud Print**:
- **Features on Demand** - See [Configure Features on Demand in Windows Server](https://docs.microsoft.com/windows-server/administration/server-manager/configure-features-on-demand-in-windows-server) to learn more about adding and removing role and feature files. 
- **Windows Server 2016 Settings** - Administrators can go to **Settings** -> **Apps** -> **Manage optional features** -> **Add a feature** and search for the Features on Demand package 
- PowerShell commands - In a PowerShell administrator window, run these commands:

```PowerShell
    Install-Module -Name PublishCloudPrinter
    Import-Module PublishCloudPrinter
    ```
