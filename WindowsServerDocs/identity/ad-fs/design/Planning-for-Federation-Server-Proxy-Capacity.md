---
ms.assetid: 3ecb6e87-17f1-4d38-97d2-9c4d52b7cf39
title: Planning for Federation Server Proxy Capacity
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Planning for Federation Server Proxy Capacity

Capacity planning for federation server proxies helps you estimate:  
  
-   The appropriate hardware requirements for each federation server proxy.  
  
-   The number of federation servers and federation server proxies to place in each organization.  
  
Federation server proxies redirect security tokens from a protected federation server in the corporate network to federated users. The purpose of deploying a federation server proxy is to allow external users to connect to a federation server. It does not actually sign tokens or write to data in the AD FS configuration database. Therefore, the hardware requirements for the federation server proxy are usually lower than the hardware requirements for a federation server.  
  
Because every request to a federation server proxy results in a request to a federation server or federation server farm, capacity planning for federation servers and federation server proxies must be performed in parallel.  
  
Estimating the peak sign\-ins per second for the federation server proxy requires an understanding of the usage patterns of the federated users that will be signing in through the federation server proxy. In many deployments, the federated users who sign in using the federation server proxy are located on the Internet. You can estimate the peak sign\-ins per second by looking at the usage patterns of these federated users on the existing Web applications that will be protected by AD FS.  
  
> [!NOTE]  
> For production deployments, we recommend a minimum of two federation server proxies for each federation server farm instance you deploy.  
  
## Estimate the number of federation server proxies required for your organization  
Before you can estimate the number of AD FS federation server proxy machines required, you will first need to determine the total number of federation servers that you will deploy in your organization. For more information about how to do this, see [Planning for Federation Server Capacity](Planning-for-Federation-Server-Capacity.md).  
  
Once you have decided on the number of federation servers, multiply this number of servers by the percentage of incoming federated authentication requests that you expect will be made from external users \(located outside of the corporate network\). The value of this calculation will provide you with the estimated number of federation server proxies that will handle the incoming authentication requests for your external users.  
  
For example, if the number of recommended federation servers is 3, and you expect that the total number of authentication requests that will be made from external users will be approximately 60% of the total number of federated authentication requests, your calculation would equal 1.8 \(3 X .60\) which you can round up to 2.  Therefore, in this case, you would need to deploy two federation server proxy machines to accommodate the load of external user authentication requests for the three federation servers.  
  
In tests performed by the AD FS product team, the overall CPU utilization on each federation server proxy was found to be significantly lower than the CPU utilization that was observed on the federation servers for the same farm.  In one test, while one federation server CPU was indicating that it was completely saturated, the CPU for a federation server proxy providing proxy services for that same farm was observed at only 20% utilization. Therefore, our tests revealed that the load on the CPU of a federation server proxy, which uses similar hardware specifications as discussed earlier in this section, could reasonably handle the processing load for approximately three federation servers.  
  
However, for fault tolerance purposes, we recommend a minimum of two federation server proxies for each federation server farm you deploy.  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
