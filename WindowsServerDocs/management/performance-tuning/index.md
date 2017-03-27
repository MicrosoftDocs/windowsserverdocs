---
title: Performance Tuning Guidelines for Windows Server 2016
description: Performance Tuning Guidelines for Windows Server 2016
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: performance-tuning-guide
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 467384e2-3644-498e-a2ff-46692c0c0dc1
author: phstee
ms.author: phstee
ms.date: 10/31/2016
---


# Performance Tuning Guidelines for Windows Server 2016

When you run a server system in your organization, you might have business needs that are not met by using the default settings. For example, you might need the lowest possible energy consumption, or the lowest possible latency, or the maximum possible throughput on your server. This topic provides a set of guidelines that you can use to tune the server settings in Windows Server 2016 and obtain incremental performance or energy efficiency gains, especially when the nature of the workload varies little over time.

To have the most impact, your tuning changes should consider the hardware, the workload, the power budgets, and the performance goals of your server. This topic describes important tuning considerations and settings that can result in improved performance or energy efficiency. It also describes each setting and its potential effect to help you make an informed decision about its relevance to your system, workload, performance, and energy usage goals.

**Note**  
Registry settings and tuning parameters changed significantly between versions of Windows Server. Be sure to use the latest tuning guidelines to avoid unexpected results.

# What's New in the Latest Tuning Guide

This section describes what changes are in the Windows Server 2016 edition of the Performance Tuning Guide:

**Configuration considerations added for new Nano installation-type**
    - Details about Nano can be found [here](https://technet.microsoft.com/en-us/windows-server-docs/compute/nano-server/getting-started-with-nano-server)

**Sections added:**

    - Software Defined Networking, including RAS and SLB configuration guidance

    - Storage Spaces Direct

    - Powershell, including module authoring and scripting for performance

    - Storage Replication  

    - HTTP1.1 and HTTP2

    - Containers

    - Powershell


**Sections changes:**

    - Performance Tuning for Workloads removed, pointers to relevant resources added to Resources section

    - Significant changes to the Hyper-V section

    - Removal of dedicated storage sections, in favor of Storage Spaces Direct section and canonical Technet content

    - Removal of dedicated networking section, in favor of canonical Technet content  

    - Resource links updated, dead links removed

    - Several changes to Active Directory sections

    - Updates to file server sections

    - Updates to Web Server guidance

    - Updates for power tuning
