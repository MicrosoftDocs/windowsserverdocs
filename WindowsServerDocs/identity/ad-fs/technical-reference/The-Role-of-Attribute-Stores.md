---
ms.assetid: 4ddb927d-d65e-491d-840a-16049c083d13
title: The Role of Attribute Stores
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---


# The Role of Attribute Stores
Active Directory Federation Services uses the term “attribute stores” to refer to directories or databases that an organization uses to store its user accounts and their associated attribute values. After it is configured in an identity provider organization, AD FS retrieves these attribute values from the store and creates claims based on that information so that a Web application or service that is hosted in a relying party organization can make the appropriate authorization decisions whenever a federated user \(a user whose account is stored in the identity provider organization\) attempts to access the application or service.  
  
For more information about how claims are generated, see [The Role of Claims](The-Role-of-Claims.md).  
  
## How attribute stores fit in with your AD FS deployment goals  
The location of the user attribute store and the location from which users authenticate determine how you design AD FS to support the user identities. Depending on where the attribute store is located and where users will access the application \(in an intranet or on the Internet\), you can use one of the following deployment goals:  
  
-   [Provide Your Active Directory Users Access to Your Claims-Aware Applications and Services](https://technet.microsoft.com/library/dd807071.aspx)—In this goal, users in your organization access an AD FS–secured application or service \(either your own application or service or a partner’s application or service\) when the users are logged on to Active Directory in the corporate intranet.  
  
-   [Provide Your Active Directory Users Access to the Applications and Services of Other Organizations](https://technet.microsoft.com/library/dd807123.aspx)—In this goal, users in your organization access an AD FS–secured application or service \(either your own application or service or a partner’s application or service\) when the users are logged on to an attribute store in the corporate intranet and when they log on remotely from the Internet.  
  
-   [Provide Users in Another Organization Access to Your Claims-Aware Applications and Services](https://technet.microsoft.com/library/dd807099.aspx)—In this goal, user accounts in another organization that are located in an attribute store on that organization’s corporate intranet must access an AD FS–secured application in your organization. This goal also works when consumer\-based user accounts that are located in an attribute store in your organization’s perimeter network must be provided with access to an AD FS–secured application in your organization.  
  
Depending on attribute store placement and other requirements of your organization, you can combine several of these deployment goals to complete the design of your AD FS deployment.  
  
## Attribute stores that are supported by AD FS  
AD FS supports a wide range of directory and database stores that you can use for extracting administrator\-defined attribute values and populating claims with those values. AD FS supports any of the following directories or databases as attribute stores:  
  
-   Active Directory in Windows Server 2003, Active Directory Domain Services \(AD DS\) in Windows Server 2008, AD DS in Windows Server 2012 and 2012 R2, and Windows Server 2016. 
  
-   All editions of Microsoft SQL Server 2005, SQL Server 2008, SQL Server 2012, SQL Server 2014, and SQL Server 2016  
  
-   Custom attribute stores  
  

