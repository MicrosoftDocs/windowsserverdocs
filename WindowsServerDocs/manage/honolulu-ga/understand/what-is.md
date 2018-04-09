---
title: What is Windows Admin Center
description: What is Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/05/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# What is Windows Admin Center?

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

<b>Windows Admin Center</b> is a locally deployed, browser-based, management tool set that enables on-premises administration of Windows Servers with no Azure or cloud dependency. Windows Admin Center gives IT Admins full control over all aspects of their server infrastructure, and is particularly useful for management on private networks that are not connected to the Internet.

Windows Admin Center is the modern evolution of "in-box" management tools, like Server Manager and MMC. It is complementary to System Center and Operations Management Suite, and is not intended to replace these products and services.

![](../../media/honolulu-ga/wac-deploy-graphic.png)

## How does Windows Admin Center work?

Windows Admin Center runs in a web browser, and manages Windows Server 2016, Windows Server 2012 R2, and Windows 10 targets through the <b>Windows Admin Center gateway</b> that can be installed on Windows Server 2016 or Windows 10. The gateway manages servers via Remote PowerShell and WMI over WinRM.  The gateway is included with Windows Admin Center in a single lightweight .msi package that you can [download from this page](https://aka.ms/WindowsAdminCenter).

Publishing the gateway web server to DNS, and configuring any corresponding corporate firewalls to make the web server visible, can allow you to access Windows Admin Center from the public internet, enabling you to connect to, and manage, your servers from anywhere with Microsoft Edge or Google Chrome (note, compatibility with other modern browsers has not been evaluated at this time).

![](../../media/honolulu-ga/spacer1.png)![](../../media/honolulu-ga/architecture.png)

## What does Windows Admin Center do?

### Simplified server management

<table>
    <tr>
        <td style="vertical-align: top;">
            <img src="../../media/honolulu-ga/what-is-icon1.png" width="300" alt="Icon representing app window"> 
        </td>
        <td style="vertical-align: top;">
Windows Admin Center consolidates your many distinct tools into one clean, simple, powerful interface.  Rather than switching between several different tools and contexts, you can see a holistic overview of your resources and dig into the granular details.  Over time, the Windows Admin Center ecosystem will grow to support increasingly broader and deeper management functionality.
        </td>
    </tr>
</table>

### Illuminate your datacenter infrastructure

<table>
    <tr>
        <td style="vertical-align: top;">
            <img src="../../media/honolulu-ga/what-is-icon2.png" width="300" alt="Icon representing app window"> 
        </td>
        <td style="vertical-align: top;">
With Windows Admin Center, you can connect to all the important parts of your infrastructure, including Windows Server 2016 and 2012 R2, as well as Microsoft Hyper-V Server 2016 and 2012 R2.  Windows Admin Center allows you to manage servers, failover clusters, hyper-converged clusters, and virtual machines from the same console.
        </td>
    </tr>
</table>

### The tools you know, reimagined

<table>
    <tr>
        <td style="vertical-align: top;">
            <img src="../../media/honolulu-ga/what-is-icon3.png" width="300" alt="Icon representing app window"> 
        </td>
        <td style="vertical-align: top;">
We've constructed Windows Admin Center to provide the core familiar tools you have used in the past, all in one package.  From Firewall rules to Windows Update, Certificate Manager to File Explorer, now you can connect to a machine and do your work from one place.
        </td>
    </tr>
</table>

### Manage your Hyper-converged Infrastructure

<table>
    <tr>
        <td style="vertical-align: top;">
            <img src="../../media/honolulu-ga/what-is-icon4.png" width="300" alt="Icon representing app window"> 
        </td>
        <td style="vertical-align: top;">
Windows Admin Center's radically simplified, powerful GUI enables you to configure and manage your hyper-converged clusters.  You can see cluster-wide alerts and get an easy look at the inventory and health of the compute and storage resources of your cluster.
        </td>
    </tr>
</table>

