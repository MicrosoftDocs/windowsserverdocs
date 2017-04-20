---
title: dfsutil Property
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 376eaec9-59bd-42dd-a602-4ab65b2b82cd
robots: noindex,nofollow
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# dfsutil Property

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The **dfsutil property** command displays or modifies the properties of a folder target \(link target\) or namespace server \(root target\).



## Syntax

```
dfsutil property Sitecosting | RootScalability | ABE | Insite | TargetfailBack | SD | State | TTL | PriorityRank | PriorityClass | Comment | /?
```

### Parameters

|Parameter|Description|
|-------|--------|
|dfsutil Property Sitecosting|Displays or modifies site costing for a namespace.|
|dfsutil Property RootScalability|Displays or modifies the namsespace polling mode.|
|dfsutil Property ABE|Enable\/Disable\/View ABE property of a namespace.|
|dfsutil Property Insite|Displays or modifies the in\-site property.|
|dfsutil Property TargetfailBack)|Displays or modifies client fail back.|
|dfsutil Property SD]|Set\/Get Security Information on the folder.|
|dfsutil Property State|Displays or modifies a folder target or namespace server.|
|dfsutil Property TTL|Displays or changes client referral caching.|
|dfsutil Property PriorityRank|Displays or changes the ordering method \(priority rank\).|
|dfsutil Property PriorityClass|Displays or changes the target priority.|
|dfsutil Property Comment|Sets or displays the comment for a namespace or link.|
|\/?|Displays help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples
To TBD, type:

```
dfsutil property 
```

To view help for this command, type:

```
dfsutil property /?
```

## additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)

-   [dfsutil](dfsutil.md)


