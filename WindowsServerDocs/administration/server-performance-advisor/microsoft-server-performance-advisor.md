---
title: Microsoft Server Performance Advisor
description: Microsoft Server Performance Advisor
ms.assetid: 468ebcb3-9eaf-477c-ab10-e3f1b3ce63dc
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
ms.topic: article
ms.prod: windows-server
ms.technology: manage
---
# Microsoft Server Performance Advisor

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Download Microsoft Server Performance Advisor (SPA) to help diagnose performance issues in a Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008 deployment. SPA generates comprehensive diagnostic reports and charts and provides recommendations to help you quickly analyze issues and develop corrective actions.

-   [Overview of Server Performance Advisor](#bkmk-aboutspa)

-   [Download Server Performance Advisor](#bkmk-downloadspa)

-   [Server Performance Advisor User's Guide](server-performance-advisor-users-guide.md)

-   [Server Performance Advisor Pack Development Guide](server-performance-advisor-pack-development-guide.md)

## <a href="" id="bkmk-aboutspa"></a>Overview of Server Performance Advisor

Server Performance Advisor is composed of two parts, the SPA framework and the SPA Advisor Packs.

### The Server Performance Advisor framework

The engine that is responsible for collecting data that is designated by the advisor packs, writing the collected data into a Microsoft SQL Server database, creating an IT-friendly environment to run scripts for SPA Advisor Packs, and showing the final reports. You only need to install the SPA framework on the SPA console. The SPA console can either be installed on a standalone computer to remotely access the servers under test or be installed on a server under test.

### Server Performance Advisor Packs

SPA Advisor Packs are the center of all tuning rules, which consist of a series of metadata and SQL script files. SPA ships with the following Advisor Packs:

-   The Core OS advisor pack analyzes the performance of general operating system functions, independent of specialized server roles.

-   The Internet Information Server (IIS) advisor pack tracks the performance of IIS.

-   The Hyper-V Advisor Pack analyzes the general performance of the Hyper-V server role.

    **Note**
    The Hyper-V Advisor Pack does not analyze guest operating systems.

     

-   The active directory advisor pack analyzes the general performance of the active directory role.

SPA also offers an extensible model for non-Microsoft developers to write advisor packs to suit their needs.

**Note**
SPA cannot understand all hardware and user scenario contexts. You should use the recommendations that are provided by the tool to help you make decisions and understand the consequences of any potential changes that are made to the servers.

 

## <a href="" id="bkmk-downloadspa"></a>Download Server Performance Advisor


Use the following links to download Server Performance Advisor for Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008:

-   [Microsoft Server Performance Advisor 3.1 (32-bit)](https://go.microsoft.com/fwlink/p/?linkid=327751)

-   [Microsoft Server Performance Advisor 3.1 (64-bit)](https://go.microsoft.com/fwlink/p/?linkid=327752)

You can extract the files in the CAB file by using the following commands:

-   for the x86 version: `extrac32.exe /e /a /l  d:\SPA   d:\SPA\SPAPlus\_x86.cab`

-   for the x64 version: `extrac32.exe /e /a /l  d:\SPA   d:\SPA\SPAPlus\_amd64.cab`

**Caution**
When you extract the .cab file, SPA must preserve the hierarchical directory structure to function correctly. Depending on the CAB tools that are installed on your server, extraction may result in a non-operational directory structure. To retain the hierarchical directory structure, you can use a CAB extraction utility tool that extracts a file directory structure.

If the CAB extraction tool properly extracted the files, subfolders will automatically appear in the extraction target folder.

### SPA prerequisites

The SPA Console requires that the following software is installed:

-   Microsoft .NET Framework 4

-   SQL Server 2008 R2 Express SP1 or Microsoft SQL Server 2008 R2 SP1

Newer versions may be compatible. Any known product incompatibilities with SPA Console will be noted.
