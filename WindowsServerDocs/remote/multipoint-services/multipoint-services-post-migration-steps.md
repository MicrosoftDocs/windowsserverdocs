---
title: MultiPoint Services - post-migration tasks
description: Learn how to validate and close out your migration to MultiPoint Services
ms.custom: na
ms.date: 07/29/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1497cae0-071e-467d-89b8-a7050815d7de
author: lizap
manager: dongill
---
# MultiPoint Services - post-migration tasks

>Applies To: Windows Server 2016

After you migrate to MultiPoint Services in Windows Server 2016, use the following information to validate the migration and to perform clean-up steps.

## Validate the migration by running a pilot program

You can validate your MultiPoint Services migration by creating a pilot project in the production environment. Run the pilot project on the servers before you put the migrated role services into production to verify that your deployment works as you expect. Consider limiting the number of connections at first, slowly increasing the number of users accessing MultiPoint Services.

> [!NOTE] 
> Always use test accounts to test the migration. Use an account with administrative privileges and an account for a valid user.

## Retire the source server
After you validate your migration, you can shut down or disconnect the source server from your network. If the server was domain-joined, remove it from the domain before you disconnect it.

