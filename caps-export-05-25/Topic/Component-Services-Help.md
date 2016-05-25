---
title: Component Services Help
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bea59cc7-f384-408b-838b-29105439cfeb
author: femila
---
# Component Services Help
Component Services focuses on the administration of COM\+ applications. Developers use COM\+ to develop distributed applications. Administrators use Component Services to manage those applications. An administrator receives a COM\+ application file from a developer and then uses Component Services to deploy that application on a server computer. Next, the administrator configures permissions for the application, as well as other settings.  
  
As an administrator, you can deploy and administer COM\+ applications in two primary ways. You can use the Component Services snap\-in in Microsoft Management Console \(MMC\), or you can write scripts to automate deployment and administration. As an alternative to using the Component Services MMC snap\-in, you can automate any of the tasks by writing code that uses administration objects that are provided through the COMAdmin Library dynamic\-link library \(DLL\). For a description of how to use these objects, see "Automating COM\+ Administration" on COM\+ General Tasks \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=66607](http://go.microsoft.com/fwlink/?LinkId=66607)\).  
  
For complete Component Services resources for developers, see COM\+ \(Component Services\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=66575](http://go.microsoft.com/fwlink/?LinkId=66575)\).  
  
This topic provides an overview of the most commonly performed Component Services tasks and related concepts.  
  
## Component Services application types  
Most Component Services administrative tasks involve deploying applications and components on the network and ensuring high performance and security for the deployed applications and components. The tasks that you perform depend on the type of application that you are working with and the services that the application uses.  
  
> [!NOTE]  
> The topics that are included here cover only a portion of the settings that you can configure with the Component Services snap\-in. Settings that are not covered in a topic should be configured only by someone with a thorough knowledge of the implementation of the component or application. Typically, these settings — which are discussed at COM\+ \(Component Services\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=66575](http://go.microsoft.com/fwlink/?LinkId=66575)\) — are made by the developer before the application is delivered for installation and deployment.  
  
Applications that you administer with the Component Services snap\-in fall into one of two categories: COM applications and COM\+ applications. These terms are used in topics where settings may vary depending on the type of application.  
  
### COM applications  
The idea of Component Object Model \(COM\) applications is not at all new. "COM" is simply the term that is used to refer to groups of COM components that were developed to work together. An example of a COM application is Microsoft® Office Excel®, which consists of a primary executable and accompanying application extension DLLs for the spell checker, Microsoft Visual Basic® functionality, and so on.  
  
### COM\+ applications  
COM\+ applications are groups of COM components that were developed and configured together to make use of COM\+ services such as transactions, queuing, role\-based security, and so on. Some of what differentiates a COM\+ application is written into the component code, and other differentiation is defined through the Component Services snap\-in.  
  
COM\+ applications can be divided into two types, each with distinct administrative needs. The two types of applications are COM\+ server applicationsand COM\+ library applications. COM\+ server applications run in their own process space. For example, a server application might consist of a group of DLLs that encapsulate payroll processing. COM\+ library applications consist of components that were developed to run in a hosting application's process. For example, in a library application, you might group DLLs that provide services to other application components and DLLs that can share security characteristics of those components.  
  
## Administrative tasks overview  
Administrative tasks that you perform with Component Services fall into four broad categories:  
  
-   Configuring your system for Component Services  
  
-   Making initial services settings  
  
-   Installing and configuring COM\+ applications  
  
-   Monitoring and tuning component services  
  
> [!NOTE]  
> While this topic examines tasks that are necessary or common, there are other tasks that you might perform as the need arises. For a more complete view of all tasks, see the documentation for the task areas that you are administering.  
  
### Configuring your system for Component Services  
When you are getting started with COM\+, there are a few customization tasks that you must perform before you can use the services with your network. For example, you must start by setting administrative security by assigning a user or group to the Administrator role of the System Application with Component Services. For more information, see [Configure the System for Component Services](http://technet.microsoft.com/library/cc754505.aspx).  
  
### Making initial services settings  
When you have completed basic Component Services configuration for the characteristics of your network, your next task might be to adjust settings that are specific to the types of applications and services that you want to use on the network.  
  
Examples of the types of settings that you might configure include the following:  
  
-   To ensure security for components that are not configured into COM\+ applications — that is, COM applications or COM components that are deployed independently — you may need to make specific COM security settings for those computers. \(COM\+ applications, on the other hand, can be designed to take advantage of role\-based security.\) For more information, see [Manage DCOM Applications](http://technet.microsoft.com/library/cc772031.aspx).  
  
-   If your applications use distributed transactions, specify whether the Microsoft Distributed Transaction Coordinator \(DTC\) starts manually or automatically on each computer that runs it. Also, if transactions are used with Windows Clustering, you must configure the network appropriately. For more information, see [Manage Distributed Transactions](http://technet.microsoft.com/library/cc771891.aspx).  
  
### Installing and configuring COM\+ applications  
A COM\+ application must be configured with settings that are specific to the services that it needs to use. After you configure the settings for the application, you can install its client\-side and server\-side portions to computers on the network. The following are examples of the types of tasks that you might perform to install and configure COM\+ applications:  
  
-   Before you can configure settings that govern how the COM\+ application behaves on the network, install the application on a staging computer where you can configure it. For more information, see [Understanding COM\+ Application Installation](http://technet.microsoft.com/library/cc732533.aspx).  
  
-   To ensure that the COM\+ application participates appropriately in your network's security scheme \(that is, there is access both to the application and to other resources are appropriate to the needs of your network\), you may have to add users to the application's roles and set the application's security identity. For more information, see [Set Application\-specific COM Security Configuration](http://technet.microsoft.com/library/cc772275.aspx).  
  
-   When you have configured the COM\+ application with respect to security and the services that it needs to use, you must deploy its client\-side and server\-side portions to production computers across your network. For more information, see [Manage COM\+ Applications](http://technet.microsoft.com/library/cc770344.aspx).  
  
### Monitoring and tuning Component Services  
When you have deployed components that use Component Services, you can track those services to watch for performance enhancement opportunities and to handle failures. In some cases, changes that you make to these settings — particularly to achieve more\-thorough monitoring — may actually decrease performance.  
  
The following are examples of the types of tasks that you might perform to monitor and tune your components and applications:  
  
-   Installing upgrades when they become available.  
  
-   To enhance your control of security — for example, to keep objects from being accidentally or maliciously released — you can use reference tracking to make additional security checks and keep track of additional information.  
  
-   If applications participate in distributed transactions, you can monitor performance by viewing transaction status, messages, and statistics. Also, you may be able to increase system performance by changing the size or location of the log file that stores transaction statistics.  
  
For tasks related to monitoring and tuning that are not included here, see COM\+ General Tasks \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=66607](http://go.microsoft.com/fwlink/?LinkId=66607)\)  
  
