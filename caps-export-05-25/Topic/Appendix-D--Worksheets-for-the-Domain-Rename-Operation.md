---
title: Appendix D: Worksheets for the Domain Rename Operation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: afe622ac-e2d4-4977-849a-e6d89b84dd87
author: Femila
---
# Appendix D: Worksheets for the Domain Rename Operation
  This section includes worksheets in suggested formats that you can to gather information about your Active Directory infrastructure. You can use these worksheets to prepare for the domain rename operation and to track progress as you perform the operation.  
  
## Worksheet 1: Domain Name Change Information  
 You can use this worksheet to create a list of name changes that will be completed during your domain rename operation. List changes for all forests and domains and all application directory partitions.  
  
||Old NetBIOS name|Old DNS name|New NetBIOS name|New DNS name|  
|-|----------------------|------------------|----------------------|------------------|  
|1|||||  
|2|||||  
|3|||||  
|4|||||  
|5|||||  
  
## Worksheet 2: Trust Information  
 You can use this worksheet to document all trust relationships \(for shortcut trusts and external trusts\) and the status of each trust that has to be created or removed during the domain rename operation.  
  
||Trusting domain name|Trusted domain name|Trust direction|Trust type|Date created\/removed|  
|-|--------------------------|-------------------------|---------------------|----------------|---------------------------|  
|1||||||  
|2||||||  
|3||||||  
|4||||||  
|5||||||  
  
## Worksheet 3: DNS Zone Information  
 You can use this worksheet to list all Domain Name System \(DNS\) zones that must be added in preparation for the domain rename operation.  
  
||DNS zone name|Add\/remove|Completed?|Date\/time|  
|-|-------------------|-----------------|----------------|----------------|  
|1|||||  
|2|||||  
|3|||||  
|4|||||  
|5|||||  
  
## Worksheet 4: DFSN, Folder Redirection, and Roaming Profiles  
 You can use this worksheet to document all domain Distributed File System Namespaces \(DFSN\) paths, including the paths that are used by folder redirection and roaming profiles. All domain DFSN paths will require reconfiguration after the domain rename operation is complete.  
  
||Domain name|Old domain DFSN path|New domain DFSN path|Server share path for folder redirection and roaming profiles|Group Policy<br /><br /> updated?<br /><br /> Date\/time?|DFSN fixed?<br /><br /> Date\/time?|  
|-|-----------------|--------------------------|--------------------------|-------------------------------------------------------------------|-----------------------------------------------|---------------------------------|  
|1|||||||  
|2|||||||  
|3|||||||  
|4|||||||  
|5|||||||  
  
## Worksheet 5: Domain Controller Information  
 You can use this worksheet to document information about specific domain controllers, including information about operations master roles \(also known as flexible single master operations or FSMO roles\).  
  
||Domain|DC name|IP address|FSMO roles<br /><br /> held by DC|CRL expiry|Execute<br /><br /> successfully?|Automatic restart?|Dcdiag notes|  
|-|------------|-------------|----------------|-------------------------------|----------------|-------------------------------|------------------------|------------------|  
|1|||||||||  
|2|||||||||  
|3|||||||||  
|4|||||||||  
|5|||||||||  
  
## Worksheet 6: Domain Rename Execution Readiness  
 You can use this worksheet to track the readiness of domains, forests, and application partitions before the beginning of the domain rename operation. You can also use the information in this worksheet to check the forest description before you proceed.  
  
||Domain\/application partition|Run Dcdiag?|Backed up?|DNS zone ready?|  
|-|-----------------------------------|-----------------|----------------|---------------------|  
|1|||||  
|2|||||  
|3|||||  
|4|||||  
|5|||||  
  
## Worksheet 7: Certification Authority \(CA\) Information  
 You can use this worksheet when you enable certificate enrollment in a renamed domain.  
  
||Old DNS name of CA|New DNS name of CA|Alias created?<br /><br /> Date\/time|Certificate<br /><br /> enrollment<br /><br /> enabled?|CDP and<br /><br /> AIA extensions<br /><br /> flexible?|Subordinate<br /><br /> and issuing<br /><br /> CA certs<br /><br /> renewed?|Group Policy<br /><br /> updated?|  
|-|------------------------|------------------------|-----------------------------------|---------------------------------------------|----------------------------------------------|-----------------------------------------------------------|-------------------------------|  
|1||||||||  
|2||||||||  
|3||||||||  
|4||||||||  
|5||||||||  
  
  