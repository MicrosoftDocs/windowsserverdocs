---
title: Move and Resize the Hosted Cache (Optional)
description: This guide provides instructions on deploying BranchCache in hosted cache mode on computers running Windows Server 2016 and Windows 10
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: article
ms.assetid: bb0eb349-914d-4596-9140-d3aae7597d55
ms.author: lizross
author: eross-msft
---

# Move and Resize the Hosted Cache \(Optional\)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can use this procedure to move the hosted cache to the drive and folder that you prefer, and to specify the amount of disk space that the hosted cache server can use for the hosted cache.

This procedure is optional. If the default cache location \(%windir%\\ServiceProfiles\\NetworkService\\AppData\\Local\\PeerDistPub\) and size – which is 5% of the total hard disk space – are appropriate for your deployment, you do not need to change them.

You must be a member of the Administrators group to perform this procedure.

### To move and resize the hosted cache

1. Open Windows PowerShell with Administrator privileges.

2. Type the following command to move the hosted cache to another location on the local computer, and then press ENTER.

    > [!IMPORTANT]
    > Before running the following command, replace parameter values, such as –Path and –MoveTo, with values that are appropriate for your deployment.

    ``` 
    Set-BCCache -Path C:\datacache –MoveTo D:\datacache
    ``` 

3.  Type the following command to resize the hosted cache –specifically the datacache \- on the local computer. Press ENTER.

    > [!IMPORTANT]
    > Before running the following command, replace parameter values, such as \-Percentage, with values that are appropriate for your deployment.  

    ``` 
    Set-BCCache -Percentage 20
    ``` 

4.  To verify the hosted cache server configuration, type the following command and press ENTER.

    ``` 
    Get-BCStatus
    ``` 

    The results of the command display status for all aspects of your BranchCache installation. Following are a few of the BranchCache settings and the correct value for each item:

    -   DataCache | CacheFileDirectoryPath: Displays the hard disk location that matches the value you provided with the –MoveTo parameter of the SetBCCache command. For example, if you provided the value D:\\datacache, that value is displayed in the command output.

    -   DataCache | MaxCacheSizeAsPercentageOfDiskVolume: Displays the number that matches the value you provided with the –Percentage parameter of the SetBCCache command. For example, if you provided the value 20, that value is displayed in the command output.

To continue with this guide, see [Prehash and Preload Content on the Hosted Cache Server &#40;Optional&#41;](7-Bc-Prehash-Preload.md).