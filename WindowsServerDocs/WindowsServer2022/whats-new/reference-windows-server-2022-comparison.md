---
title: Comparison of Windows Server 2022 to previous editions
description: Compare the new features of Windows Server 2022 to the older versions.
ms.topic: how-to
author: IngridAtMicrosoft
ms.author: inhenkel
manager: femila
ms.date: 06/17/2021
ms.prod: windows-server
---

# Comparison of Windows Server 2019 to Windows Server 2022

## Secured-core server

| Windows Server 2019 | Windows Server 2022 |
| --- | --- |
| 2019 | Windows defender System Guard provides system intergrity against firmware attacks. |
| 2019 | Virtualization-based security (VBS) isolates critical parts of the system from advanced malware. |
| 2019 | VBS features such as HVCI and Credential Guard prevent entire class of vulnerabilities and better protect sensitive assets like credentials.|
| 2019 | Trusted Platform Module (TPM 2.0) provides hardware root-of-trust used as a secured foundation.|
| 2019 | Collaboration with ecosystem partners to simplify security enablement.|
| 2019 | Windows Admin Center provides easy access to configure Secured-core Server.|

## Secure Connectivity

| Windows Server 2019 | Windows Server 2022 |
| --- | --- |
| 2019 | Faster and more secure encrypted HTTPS connections `do what?` |
| 2019 | TLS 1.3 is enabled by default on Windows Server 2022 |
| 2019 | Encrypted DNS name resolution requests with DoH `do what?` |
| 2019 | SMB AES-256 encryption is now available.|
| 2019 | East-West SMB encryption controls are included for internal cluster communications.|
| 2019 | SMB uses industry standard encryption.|

## Hybrid Capabilities with Azure Arc

| Windows Server 2019 | Windows Server 2022 |
| --- | --- |
| 2019 | Azure Arc enabled Windows Servers allow for domain agnostic virtual machines. |
| 2019 | You have the ability to search inventory at-scale with a unified management experience and consistent VM extensions. |
| 2019 | The built-in security baseline with Role-based Access Control (RBAC) facilitates compliance across environments.|

## Administration

| Windows Server 2019 | Windows Server 2022 |
| --- | --- |
| 2019 | Windows Admin Center (WAC) allows you to manage Windows Servers with edge-local or hosted in Azure support. |
| 2019 | Azure Automanage for Windows Server virutal machines includes backup, Security center, monitoring, update management, an Azure automation account, change tracking and inventory, configuration managment, log analytics. Security patches are applied without reboot to protect against critical security threats.|

## Application platform

| Windows Server 2019 | Windows Server 2022 |
| --- | --- |
| 2019 | SQL Server has 48 TB of highly optimized memory for large memory systems, 64 sockets and 2048 logical processors, and Intel Secured Guard Extension (SGX) on Intel Ice Lake allows for confidential computing on isolated apps. |
| 2019 | The Container tool in WAC makes it easy to containerize application.  You can containerize ASP.Net, Web Deploy, .NET and MSI applications. |
| 2019 | You can deploy containerized application to AKS and AKS on Azure Stack HCI directly from Windows Admin Center.|
| 2019 | There is no need to write Docker and YAML files.  Windows Admin Center does that for you. |
