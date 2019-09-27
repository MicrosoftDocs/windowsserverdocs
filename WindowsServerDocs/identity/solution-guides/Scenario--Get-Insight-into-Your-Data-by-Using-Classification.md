---
ms.assetid: ad3f0480-99f7-428a-ab33-6d165a440840
title: Scenario Get Insight into Your Data by Using Classification
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Scenario: Get Insight into Your Data by Using Classification

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Reliance on data and storage resources has continued to grow in importance for most organizations. IT administrators face the growing challenge of overseeing larger and more complex storage infrastructures, while simultaneously being tasked with the responsibility to ensure that total cost-of-ownership is maintained at reasonable levels. Managing storage resources is not only about the volume or availability of data; it is also about enforcing company policies and knowing how storage is consumed to enable efficient utilization and compliance to mitigate risk. File Classification Infrastructure provides insight into your data by automating classification processes so that you can manage your data more effectively. The following classification methods are available with File Classification Infrastructure: manual, programmatic, and automatic. This topic focuses on the automatic file classification method.  
  
## <a name="BKMK_OVER"></a>Scenario description  
File Classification Infrastructure uses classification rules to automatically scan files and classify them according to the contents of the file. Classification properties are defined centrally in Active Directory so that these definitions can be shared across file servers in the organization. You can create classification rules that scan files for a standard string or for a string that matches a pattern (regular expression). When a configured classification parameter is found in a file, that file is classified as configured in the classification rule. Some examples of classification rules include:  
  
-   Classify any file that contains the string "Contoso Confidential" as having high business impact  
  
-   Classify any file that contains at least 10 social security numbers as having personally identifiable information  
  
When a file is classified, you can use a file management task to take action on any files that are classified a specific way. The actions in a file management task include protecting the rights associated with the file, expiring the file, and running a custom action (such as posting information to a web service).  
  
You can find planning information for configuring automatic file classification in [Plan for Automatic File Classification](assetId:///e3c3bb4b-3034-42b7-b391-8ef5f5851955).  
  
You can find steps for how to automatically classify files in [Deploy Automatic File Classification &#40;Demonstration Steps&#41;](Deploy-Automatic-File-Classification--Demonstration-Steps-.md).  
  
## In this scenario  
This scenario is part of the Dynamic Access Control scenario. For additional information about Dynamic Access Control, see:  
  
-   [Dynamic Access Control: Scenario Overview](Dynamic-Access-Control--Scenario-Overview.md)  
  
## <a name="BKMK_APP"></a>Practical applications  
File Classification Infrastructure in  Windows Server 2012  contributes to Dynamic Access Control by enabling business data owners to easily classify and label data. The classification information that is stored in the central access policy allows you to define access policies for data classes that are critical to business.  
  
## <a name="BKMK_NEW"></a>Features included in this scenario  
The following table lists the features that are part of this scenario and describes how they support it.  
  
|Feature|How it supports this scenario|  
|-----------|---------------------------------|  
|[File Server Resource Manager Overview](https://technet.microsoft.com/library/hh831701.aspx)|File Classification Infrastructure is a feature that is included in File Server Resource Manager.|  
|[File and Storage Services Overview](https://technet.microsoft.com/library/hh831487.aspx)|File Server Resource Manager is a feature that is included with the File Services server role.|  
  


