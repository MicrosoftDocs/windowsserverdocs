---
title: RDS and OneDrive for Business in non-persistent environments
description: Learn about a solution from FSLogix to support OneDrive for Business in non-persistent RDS environments
ms.prod: windows-server-threshold
ms.technology: remote-desktop-services
ms.mktglfcycl: manage
ms.sitesec: library
author: lizap
ms.localizationpriority: low
ms.date: 10/18/2017
---
# Dealing with OneDrive for Business in non-persistent environments 

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

We’ve heard from customers that the lack of OneDrive for Business support within non-persistent (pooled) RDS environments is a problem. The officially supported solution is to use the OneDrive for Business web experience.  

[RDS Gurus](http://rdsgurus.com/) recently published a report on [FSLogix’s Office 365 Container](https://fslogix.com/products/office-365-container), a third-party solution that lets users in non-persistent RDS environments use the OneDrive for Business native sync client, instead of the web experience. FSLogix’s O365 Containers roam a user’s OneDrive for Business local cache so that it does not need to be completely resynced each time a user logs on to a session. FSLogix’s O365 Containers provides a user experience comparable to that of a persistent or local environment. For example, users can access their OneDrive for Business files in File Explorer.  


RDS Gurus tested FSLogix’s O365 Containers with OneDrive for Business in both on-premise and Azure RDS environments for non-persistent sessions on RDSH, focusing on user experience performance as the system becomes loaded with other "noisy neighbors." They found that "FSLogix Office 365 Container works well for OneDrive for Business. … Most importantly, because the local cache is stored in the FSLogix container, it follows the user as the user roams."  


You can read more about the results and conclusions on the [RDS Gurus blog](http://www.rdsgurus.com/onedrive-for-business-performance-in-non-persistent-environments-using-fslogixs-office-365-containers/). 
