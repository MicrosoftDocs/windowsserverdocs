---
title: Windows Admin Center related management solutions
description: How Windows Admin Center compares with and complements other Microsoft monitoring and management solutions/products (Project Honolulu)
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 04/05/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Related management solutions from Microsoft

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

## Windows Admin Center
[Windows Admin Center](windows-admin-center.md) is the evolution of traditional in-box server management tools, for situations where you might have used Remote Desktop (RDP) to connect to a server and troubleshoot or configure a server. It is not intended to replace other existing Microsoft management solutions, rather it complements these solutions, as described in each the section below. 

## Remote Server Administration Tools (RSAT)
[Remote Server Administration Tools (RSAT)](https://support.microsoft.com/help/2693643/remote-server-administration-tools-rsat-for-windows-operating-systems) is a collection of GUI and PowerShell tools to manage optional roles and features in Windows Server. RSAT has many capabilities which are not in Windows Admin Center. Some of the most commonly used tools in RSAT may be added to Windows Admin Center in the future, and any new Windows Server role or feature which requires a GUI for management will be in Windows Admin Center.

## System Center
[System Center](https://www.microsoft.com/cloud-platform/system-center) is an on-premises datacenter management solution for deployment, configuration, management, monitoring of your entire datacenter. System Center lets you see the status of all the machines in your environment, while Windows Admin Center lets you drill down into a specific server to manage or troubleshoot it with more granular tools.

## Operations Management Suite
[Operations Management Suite](https://www.microsoft.com/cloud-platform/operations-management-suite) is a collection of management services entirely hosted in Azure that can be used to manage servers both in the cloud and on-premises. Operations Management Suite allows you to monitor and analyze resource performance, as well as automate manual processes. Windows Admin Center is a customer-deployed solution that provides additional tools at the single-server/single-cluster level and complements the multi-machine cloud-hosted capabilities of Operations Management Suite.

## Intune
[Intune](https://www.microsoft.com/cloud-platform/microsoft-intune) is a cloud-based enterprise mobility management service that enables you to manage iOS, Android, Windows, and macOS devices, based on a set of policies. Intune focuses on enabling you to secure company information by controlling how your workforce accesses and shares information. In contrast, Windows Admin Center is not policy-driven, but enables ad-hoc management of Windows 10 and Windows Server machines, using remote PowerShell and WMI over WinRM.

## Azure Stack
[Azure Stack](https://azure.microsoft.com/overview/azure-stack/) is a hybrid cloud platform that lets you deliver Azure services from your datacenter. Azure Stack is managed using PowerShell or the administrator portal, which is similar to the traditional Azure portal used to access and manage traditional Azure services. Windows Admin Center is not intended to manage the Azure Stack infrastructure, but can be used to manage Azure IaaS virtual machines (running Windows Server 2016, 2012 R2, or 2012) or troubleshoot individual physical servers deployed in your Azure Stack environment. 