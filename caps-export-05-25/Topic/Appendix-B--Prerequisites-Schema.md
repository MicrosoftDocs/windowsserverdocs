---
title: Appendix B: Prerequisites Schema
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 170dfdca-1c10-4759-99d6-be280f768e11
author: jaimeo
---
# Appendix B: Prerequisites Schema
[!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2 uses an XML file, **prerequisites.xml**, to define the prerequisites for an installation. This schema is described in the following table:  
  
|Schema Element|Description|  
|------------------|---------------|  
|PrereqResults|Root element.|  
|Result|The result of a single prerequisite check. There can be 0…*n***Result** elements, one for each prerequisite. In addition, the **Result** element has a**StatusCode** attribute. The possible values of **StatusCode** are **0** \(Success\), **1** \(Error\), **2** \(Warning\).|  
|Status|The localized description of the status code.|  
|Check|The product or component that is to be checked.|  
|Components|The component\(s\) for which this prerequisite applies. There can be 0…*n***Component** elements in a Components element.|  
|Component|One of the component\(s\) for which this prerequisite applies.|  
|Description|The description of the problem.|  
|Resolution|How the customer can resolve the problem.|  
  
The following is an example of a prerequisites.xml file:  
  
```  
<?xml version="1.0" encoding="utf-8"?>  
<PrereqResults>  
    <Result StatusCode="0">  
        <Status>Passed</Status>  
        <Check>Windows Server 2008 Server</Check>  
        <Components>  
            <Component>Windows Server Update Services</Component>  
        </Components>  
    </Result>  
    <Result StatusCode="1">  
        <Status>Failed</Status>  
        <Check>SQL Server 2008</Check>  
        <Components>  
            <Component>Windows Server Update Services</Component>  
        </Components>  
        <Description>SQL Server 2005 or later not detected</Description>  
        <Resolution>Download the required version from http://www.microsoft.com/downloads/</Resolution>  
    </Result>  
    <Result StatusCode="1">  
        <Status>Warning</Status>  
        <Check>SQLINSTANCE_NAME</Check>  
        <Components>  
            <Component>Windows Server Update Services</Component>  
        </Components>  
       <Description>This database version cannot be upgraded. Version is too old. </Description>  
        <Resolution>Choose another location for the database to keep this one otherwise this database will be overridden. </Resolution>  
    </Result>  
    …  
</PrereqResults>  
```  
  
