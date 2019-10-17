---
ms.assetid: d8e61aa4-8e4b-4097-83ca-70cf61366b75
title: Delegating Administration by Using OU Objects
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Delegating Administration by Using OU Objects

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can use organizational units (OUs) to delegate the administration of objects, such as users or computers, within the OU to a designated individual or group. To delegate administration by using an OU, place the individual or group to which you are delegating administrative rights into a group, place the set of objects to be controlled into an OU, and then delegate administrative tasks for the OU to that group.  
  
Active Directory Domain Services (AD DS) enables you to control the administrative tasks that can be delegated at a very detailed level. For example, you can assign one group to have full control of all objects in an OU; assign another group the rights only to create, delete, and manage user accounts in the OU; and then assign a third group the right only to reset user account passwords. You can make these permissions inheritable so that they apply to any OUs that are placed in subtrees of the original OU.  
  
Default OUs and containers are created during the installation of AD DS and are controlled by service administrators. It is best if service administrators continue to control these containers. If you need to delegate control over objects in the directory, create additional OUs and place the objects in these OUs. Delegate control over these OUs to the appropriate data administrators. This makes it possible to delegate control over objects in the directory without changing the default control given to the service administrators.  
  
The forest owner determines the level of authority that is delegated to an OU owner. This can range from the ability to create and manipulate objects within the OU to only being allowed to control a single attribute of a single type of object in the OU. Granting a user the ability to create an object in the OU implicitly grants that user the ability to manipulate any attribute of any object that the user creates. In addition, if the object that is created is a container, the user implicitly has the ability to create and manipulate any objects that are placed in the container.  
  
## In this section  
  
-   [Delegating Administration of Default Containers and OUs](../../ad-ds/plan/Delegating-Administration-of-Default-Containers-and-OUs.md)  
  
-   [Delegating Administration of Account OUs and Resource OUs](../../ad-ds/plan/Delegating-Administration-of-Account-OUs-and-Resource-OUs.md)  
  


