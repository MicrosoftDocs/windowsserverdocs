---
title: Use live migration with workgroup clusters
description: Gives overview of live migration functionality in Windows Server 2016.
ms.topic: article
ms.author: mosagie
author: meaghanlewis
ms.date: 04/17/2024
---

# Use live migration with workgroup clusters

>Applies to: Windows Server 2025

This article describes how to move a virtual machine by doing a live migration with hosts using workgroup clusters. Workgroup clusters are a type of Failover Cluster that don't use Active Directory, and instead have servers that are joined by workgroup. A live migration moves running virtual machines between Hyper-V hosts without any noticeable downtime.

Workgroup clusters were introduced in Windows Server 2016. Live migration wasn't supported, until now, in Windows Server 2025. Learn about how virtual machine live migration works with workgroup clusters under the hood and follow along to perform your own live migration.

## Prerequisites

The following prerequisites must be met in order to live migrate hosts using workgroup clusters:

- A workgroup cluster with two or more nodes exists
- A local user account on each server node with an identical username and password.

## Do a live migration with Hyper-V workgroup clusters

Confirm that you have already created a workgroup cluster with two or more nodes. Then, follow the steps in this section to do a live migration between Hyper-V hosts.

### Step 1: Install the Hyper-V role

The Hyper-V role must be installed on the source and destination servers and set up for live migrations. If you haven't already installed this role, do it now before continuing.

1. Enable virtualization
1. Enable nested virtualization on source host.


### Step 2

### Step : Confirm live migration successful

### Step : Confirm storage was successfully migrated
