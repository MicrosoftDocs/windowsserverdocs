---
title: Migrate to MultiPoint Services in Windows Server 2016
description: Learn how to migrate from a previous version of MultiPoint Services  
ms.custom: na
ms.date: 07/29/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 16c217ad-700a-48a3-8398-4a7f7e9edb52
author: lizap
manager: dongill
ms.author: elizapo
---
# MultiPoint Services migration in Windows Server 2016
>Applies To: Windows Server 2016

You can migrate from a previous release of Windows Server 2016 MultiPoint Services to the RTM version of MultiPoint Services. The following information provides preparation information and migration and verification steps.

Migration documentation and tools ease the migration of server role settings and data from an existing server to a destination server that is running Windows Server 2016. By using the process described in this guide, you can simplify the migration process, reduce migration time, increase the accuracy of the migration process, and help eliminate possible conflicts that might otherwise occur during the migration process. 

## What to know before you begin
Before you begin the migration process, please note the following:

- The migration process does not automatically gather or record settings for applications on the MultiPoint Services role. You should create a customized migration plan for any applications that you want to migrate. This is also true when using the virtual desktops feature in MultiPoint Services.
- This guide does not provide guidance for moving data saved in user or shared folders on the MultiPoint server. This applies to regular stations and virtual desktop stations.
- This guide does not contain instructions on how to migrate when the source server is running multiple roles. If your server is running multiple roles, you need to design a custom migration procedure that is specific to your server environment, based on information provided in the role migration guides.
- This guide does not contain information for migrating Remote Desktop Services CALS. For this information, see [Migrate Remote Desktop Services Client Access Licenses (RDS CALs)](https://technet.microsoft.com/library/dd851844.aspx).

## Supported migration scenarios for MultiPoint Services in Windows Server 2016
The MultiPoint Service role services is available in Windows Server 2016 Standard and Datacenter. This migration guide describes how to migrate the Multipoint Services role services from a source server running Windows Server 2016 to a destination server running the same version.

## Scenarios that are not supported

The following migration scenarios are not supported:

- Migrating or upgrading from Windows MultiPoint Server 2012 and 2011.
- Migrating from a source server to a destination server that is running on operating system with a different system UI language installed.
- Migrating the MultiPoint Services role service from physical servers to virtual machines.
- Migrating any applications or application settings from the MultiPoint Server.

## The impact of migration on MultiPoint Services
Be aware that the MultiPoint Services role will not be available during the migration. Plan your data migration to occur during off-peak hours to minimize downtime and reduce impact to users. Notify users that the resources will be unavailable during that time.

## Migration information and steps
Use the following information to plan and carry out your MultiPoint Services migration:

- [Gather the information you need for the migration.](multipoint-services-migration-preparation.md)
- [Migrate the MultiPoint Services role service.](multipoint-services-migration-steps.md)
- [Validate the migration and do any post-migration clean-up tasks](multipoint-services-post-migration-steps.md)