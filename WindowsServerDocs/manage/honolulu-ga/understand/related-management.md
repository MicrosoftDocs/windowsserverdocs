---
title: Windows Admin Center related management solutions
description: "How Windows Admin Center compares with and complements other Microsoft monitoring and management solutions/products"
ms.technology: windows-server-threshold
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.manager: samli
ms.date: 04/12/2018
---

# Related management solutions

[Windows Admin Center](windows-admin-center.md) is the evolution of traditional in-box server management tools, for situations where you might have used RDP to connect to a server and troubleshoot or configure a server. It is not intended to replace any of the existing Microsoft management solutions, rather it complements these solutions. 

[System Center](https://www.microsoft.com/cloud-platform/system-center) is an on-premises datacenter management solution for deployment, configuration, management, monitoring of your entire datacenter. System Center lets you see the status of all the machines in your environment, while Windows Admin Center lets you drill down into a specific server to manage or troubleshoot it with more granular tools.

[Operations Management Suite](https://www.microsoft.com/cloud-platform/operations-management-suite) is a collection of management services entirely hosted in Azure that can be used to manage servers both in the cloud and on-premises. Operations Mangament Suite allows you to monitor and analyze resource performance, as well as automate manual processes. Windows Admin Center provides additional tools at the single-server/single-cluster level and doesn't provide the multi-machine

[Intune](https://www.microsoft.com/cloud-platform/microsoft-intune) is a cloud-based enterprise mobility management service that enables you to manage iOS, Android, Windows, and macOS devices, based on a set of policies. Intune focuses on enabling you to secure company information by controlling how your workforce accesses and shares information. In contrast, Windows Admin Center manages only Windows 10 and Windows Server machines, using remote PowerShell and WMI over WinRm.

[Azure Stack](https://azure.microsoft.com/overview/azure-stack/) is a hybrid cloud platform that lets you deliver Azure services from your datacenter. Azure Stack is managed using PowerShell or the administrator portal, which is similar to the traditional Azure portal used to access and manage traditional Azure services. Windows Admin Center is not intended to manage the Azure Stack infrastructure, but can be used to manage Azure IaaS Virtual Machines (running Windows Server 2016, 2012R2, or 2012) or troubleshoot individual physical servers deployed in your Azure Stack environment. 