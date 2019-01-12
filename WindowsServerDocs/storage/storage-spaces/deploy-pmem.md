---
title: Understand and Deploy Persistent Memory
description: Detailed info on what persistent memory is and how to set it up with storage spaces direct in Windows Server 2019.
keywords: Storage Spaces Direct,persistent memory,pmem, storage, S2D
ms.assetid: 
ms.prod: 
ms.author: adagashe
ms.technology: storage-spaces
ms.topic: article
author: adagashe
ms.date: 1/11/2019 
ms.localizationpriority: 
---
---
# Understand and deploy persistent memory

>Applies to: Windows Server 2019

Persistent Memory (or PMem) is a new type of memory technology that delivers a unique combination of affordable large capacity and persistence. This topic provides background on PMem and the steps to deploy it with Windows Server 2019with Storage Spaces Direct.

## Background

PMem is a type of non-volatile DRAM (NVDIMM) that has the speed of DRAM, but retains its memory content through power cycles. Because of this, resuming from where you left off is significantly faster, since the content of your RAM doesn't need to be reloaded. Another unique characteristic is that PMem is byte addressable, which means you can also use it as storage (which is why you may hear PMem being referred to as storage-class memory).

To see some of these benefits, let's look at the

## See also

- [Storage Spaces Direct overview](storage-spaces-direct-overview.md)