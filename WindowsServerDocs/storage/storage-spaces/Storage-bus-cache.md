---
title: Storage bus cache on Storage Spaces 
description: Enable storage bus cache on standalone servers for better read and write performance
author: TinaWu-Msft
ms.author: tinawu
ms.service: #Required; service per approved list. slug assigned by ACOM.
ms.topic: tutorial #Required; leave this attribute/value as-is.
ms.date: 05/25/2021
ms.custom: template-tutorial #Required; leave this attribute/value as-is.
---

<!--
This template provides the basic structure of a tutorial article.
See the [tutorial guidance](contribute-how-to-mvc-tutorial.md) in the contributor guide.

To provide feedback on this template contact 
[the templates workgroup](mailto:templateswg@microsoft.com).
-->

<!-- 1. H1 
Required. Start with "Tutorial: ". Make the first word following "Tutorial: " a 
verb.
-->

# Tutorial: Enable storage bus cache with Storage Spaces on standalone servers 

<!-- 2. Introductory paragraph 
Required. Lead with a light intro that describes, in customer-friendly language, 
what the customer will learn, or do, or accomplish. Answer the fundamental “why 
would I want to do this?” question. Keep it short.
-->

If you are using Storage Spaces to manage a lot of frequently accessed and modified data, then this is a feature that you will want to learn more about! The storage bus cache (SBC) for standalone servers can return information and data to your customers fast, while maintaining storage efficiency and keeping the operational costs low. Take for example a SQL database or a mail hosting service, any application where performance is crucial, but storage efficiency is still prioritized. The admin would want a solution that balances resiliency (to combat data loss), speed (better user experience), and ease of management. Frequently accessed content will be cached so that reads return faster, while other content is efficiently stored and the system remains easily scalable.

Similar to its implementation for Storage Spaces Direct, this feature binds together faster media (e.g. SSD) with slower media (e.g. HDD), and reserves a portion (not the whole!) of the faster media tier for caching. If you are using simple spaces (no resiliency), both read and write caching is supported, any other resiliency setting will only have read caching capabilities for now. The best configuration is using the SBC in combination with ReFS [Mirror-accelerated parity](../refs/mirror-accelerated-parity.md). This set up maintains all the storage efficiency benefits of ReFS MAP and incorporates a read cache as a part of the faster media tier for better random read performance. Setup and maintenance is extremely streamlined, below is a step-by-step guide with screenshots to help you add this capability to your system and boost performance.

<!-- 3. Tutorial outline 
Required. Use the format provided in the list below.
-->

In this tutorial, you learn about:

> [!div class="checklist"]

> * What the storage bus cache is
> * How to enable the storage bus cache  
> * Managing the cache after deployment 

<!-- 4. Prerequisites 
Required. First prerequisite is a link to a free trial account if one exists. If there 
are no prerequisites, state that no prerequisites are needed for this tutorial.
-->

## Prerequisites

### ![Green checkmark icon.](media/nested-resiliency/supported.png) Consider storage bus cache if:

- Your cluster runs Windows Server 2022; and
- Your cluster has 2 media/ drive types (e.g. SSD + HDD or NVMe + HDD)
- Your cluster has failover cluster installed 

### ![Red X icon.](media/nested-resiliency/unsupported.png) You can't use storage bus cache if:

- Your cluster runs Windows Server 2016 or 2019; or
- Your cluster has an all flash configuration  

<!-- 5. H2s
Required. Give each H2 a heading that sets expectations for the content that follows. 
Follow the H2 headings with a sentence about how the section contributes to the whole.
-->

## Enable storage bus cache in PowerShell
<!-- Introduction paragraph -->

1. Import the module

```powerShell
Import-Module StorageBusCache 
```

1. Configure storage bus cache settings 

Default settings are recommended, skip this step to continue with the defaults. If configuration is needed, do so before enabling the storage bus cache. Refer to Feature overview section for information. 

```powerShell
#Change the cache provision mode
Set-StorageBusCache -ProvisionMode <Type>
#Change the shared cache percentage 
Set-StorageBusCache -SharedCachePercent <Value>
```

3. Check the drive status 

Ensure that all expected drives show up and are Healthy and True for CanPool

```PowerShell
Get-PhysicalDisk
```

4. Enable storage bus cache 

This step will: 
> [!div class="checklist"]
> * Create a storage pool with all the available drives
> * Bind the fast and slow media to form storage tiers
> * Add the storage bus cache with default or custom settings

You can run the cmdlet in Step 3 again to see the effects of enabling storage bus cache. The device usage and numbers will change accordingly. 

5. Check the storage bus cache state 

Check that the fields are correct and the Enabled field is now set to true. 

```PowerShell
Get-StorageBusCache 
```

## Create a volume 
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## Adjustments after enabling storage bus cache 
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## Clean up resources

If you're not going to continue to use this application, delete
<resources> with the following steps:

1. From the left-hand menu...
1. ...click Delete, type...and then click Delete

<!-- 7. Next steps
Required: A single link in the blue box format. Point to the next logical tutorial 
in a series, or, if there are no other tutorials, to some other cool thing the 
customer can do. 
-->

## Next steps

Advance to the next article to learn how to create...
> [!div class="nextstepaction"]
> [Next steps button](contribute-how-to-mvc-tutorial.md)

<!--
Remove all the comments in this template before you sign-off or merge to the 
main branch.
-->
