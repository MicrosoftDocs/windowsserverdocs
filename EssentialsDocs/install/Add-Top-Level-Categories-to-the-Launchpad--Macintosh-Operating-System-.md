---
title: "Add Top-Level Categories to the Launchpad (Macintosh Operating System)"
ms.custom: na
ms.date: 10/03/2012
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: ee2173c3-e464-4001-9f43-6d926a575092
caps.latest.revision: 6
author: DonGill
manager: stevenka
translation.priority.ht: 
  - de-at
  - de-de
  - es-es
  - fr-be
  - fr-fr
  - it-ch
  - it-it
  - ja-jp
  - ko-kr
  - pt-br
  - ru-ru
  - zh-cn
  - zh-hk
  - zh-tw
---
# Add Top-Level Categories to the Launchpad (Macintosh Operating System)
You can add top-level categories to the Launchpad on a computer running the Macintosh operating system. To create a Launchpad add-in that adds top-level categories, you can use a combination of information from this page and from the topic titled “How-to: Add Tasks and Categories to the Launchpad” in the [Windows Server Solutions SDK](http://go.microsoft.com/fwlink/?LinkID=248648).  
  
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
 [Creating and Customizing the Image](../install/Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](../install/Additional-Customizations.md)   
 [Preparing the Image for Deployment](../install/Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](../install/Testing-the-Customer-Experience.md)