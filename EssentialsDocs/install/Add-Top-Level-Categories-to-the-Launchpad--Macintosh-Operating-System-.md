---
title: "Add Top-Level Categories to the Launchpad (Macintosh Operating System)"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ee2173c3-e464-4001-9f43-6d926a575092
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Add Top-Level Categories to the Launchpad (Macintosh Operating System)

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

You can add top-level categories to the Launchpad on a computer running the Macintosh operating system. To create a Launchpad add-in that adds top-level categories, you can use a combination of information from this page and from the topic titled How-to: Add Tasks and Categories to the Launchpad? in the [Windows Server Solutions SDK](https://go.microsoft.com/fwlink/?LinkID=248648).  
  
 The following example shows how you can specify your Launchpad entry to be a top-level category in the .launchpad file:  
  
```  
  
<?xml version="1.0" encoding="utf-8" ?>  
<LaunchPad resFile="Localizable">  
   <Category id="Microsoft.Launchpad.HomeCategory" name="SampleAddin"  image="SampleImage01.png">  
      <Task id="Microsoft.Launchpad.SampleAddin.Pictures"   
          name="Pictures"       
           src="smb://%ServerAddress%/Pictures"   
         image="SampleImage02.png"/>  
   </Category>  
</LaunchPad>  
```  
  
 For the entry to be a top-level category, the Id attribute of the Category element must be "Microsoft.Launchpad.HomeCategory".  
  
## See Also  
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)