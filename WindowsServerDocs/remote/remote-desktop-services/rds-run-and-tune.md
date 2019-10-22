---
title: RDS - Run and tune
description: Provides management information for Remote Desktop Services.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: spatnaik
ms.date: 02/08/2017  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 79909767-a4c3-4ecf-8d3f-77d37a663153
author: spatnaik
manager: scottman
---
# Run and tune your Remote Desktop Services environment

Tuning your deployment takes time and requires instrumentation and monitoring. Use the processes below to refine your Remote Desktop deployment, keep it running and enable scaling out (and in) as needed. 

It's a good practice to continually assess the metrics and balance against running costs.

## Management and monitoring

CHeck out [Manage users in your RDS collection](rds-user-management.md) for information about how to manage access to your desktops and remote resources.

Use **Microsoft Operations Management Suite (OMS)** to monitor Remote Desktop deployments for potential bottlenecks and manage them using one of the following ways: 

- **Server Manager**: Use the RD management tool that is built in to Windows Server to manage deployments with up to 500 concurrent remote end-users. 
- **PowerShell**: Use the RD PowerShell module, also built into Windows Server, to manage deployments with up to 5000 concurrent remote end-users.

## Scale: Bigger, better, faster

With visibility into the deployment, you can control scale with more precision. Easily add or remove Remote Desktop host servers based on scale needs. 

Remote Desktop deployments that are built on Azure can make use of Azure services, like Azure SQL, to scale automatically on demand.

## Automation: Script for success

Maintaining a running, highly scaled application involves repeating operations on a regular basis. Use Remote Desktop Services PowerShell cmdlets and WMI providers to develop scripts that can be run on multiple deployments when needed. Run Best Practice Analyzer (BPA) rules for Remote Desktop Services on your deployments to tune your deployments.

## Load testing: Avoid surprises

Load test the deployment with both stress tests and simulation of real-life usage. Vary the load size to avoid surprises! Ensure that responsiveness meets user requirements, and that the entire system is resilient. Create load tests with simulation tools, like LoginVSI, that check your deployment's ability to meet the users' needs. 