---
ms.assetid: 4ddb927d-d65e-491d-840a-16049c083d13
title: The role of attribute stores in AD FS
description: This article describes the role of attribute stores in Active Directory Federation Services (AD FS).
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
---


# The role of attribute stores
In Active Directory Federation Services (AD FS), the term *attribute stores* refers to directories or databases that an organization uses to store its user accounts and their attribute values. After it's configured in an identity provider organization, AD FS retrieves these attribute values from the store. It creates claims based on that information so that a web application or service that's hosted in a relying party organization can make the appropriate authorization decisions when a federated user (a user whose account is stored in the identity provider organization) tries to access the application or service.

For more information about how claims are generated, see [The role of claims](The-Role-of-Claims.md).

## How attribute stores fit in with your AD FS deployment goals
The location of the user attribute store and the location from which users authenticate determine how you design AD FS to support the user identities. Depending on where the attribute store is located and where users will access the application (in an intranet or on the internet), you might have one of these deployment goals:

- **Give your Active Directory users access to your claims-aware applications and services.** In this scenario, users in your organization access an application or service secured by AD FS when the users are signed in to Active Directory in the corporate intranet. The application or service can be your own or a partner's.

- **Give your Active Directory users access to the applications and services of other organizations.** In this scenario, users in your organization access an application or service secured by AD FS when the users are signed in to an attribute store in the corporate intranet and when they sign in remotely from the internet. The application or service can be your own or a partner's.

- **Give users in another organization access to your claims-aware applications and services.** In this scenario, user accounts in another organization that are located in an attribute store on that organization's corporate intranet must access an application secured by AD FS in your organization. This scenario also works when you need to give consumer-based user accounts that are located in an attribute store in your organization's perimeter network access to an application secured by AD FS in your organization.

Depending on attribute store placement and other requirements of your organization, you can combine several of these deployment goals to complete the design of your AD FS deployment.

## Attribute stores that AD FS supports
AD FS supports a wide range of directory and database stores. You can use them to extract administrator-defined attribute values and populate claims with those values. AD FS supports any of these directories or databases as attribute stores:

- Microsoft Entra Domain Services in Windows Server 2012 and 2012 R2, and in Windows Server 2016 and later

- All editions of SQL Server 2012, SQL Server 2014, and SQL Server 2016 and later

- Custom attribute stores
