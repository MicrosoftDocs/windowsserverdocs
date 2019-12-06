---
ms.assetid: ceb9ce18-5a94-4166-9edd-2685b81fc15f
title: Deploy Claims Across Forests
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Deploy Claims Across Forests

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

In  Windows Server 2012 , a claim type is an assertion about the object with which it's associated. Claim types are defined per forest in Active Directory. There are many scenarios where a security principal may need to traverse a trust boundary to access resources in a trusted forest. Cross-forest claims transformation in  Windows Server 2012  enables you to transform egress and ingress claims that traverse forests so that the claims are recognized and accepted in the trusting and trusted forests. Some of the real-world scenarios for transformation of claims are:  
  
-   Trusting forests can use claim transformation as a guard against elevation of privilege by filtering the incoming claims with specific values.  
  
    Trusting forests can also issue claims for principals coming over a trust boundary if the trusted forest does not support or issue any claims.  
  
-   Trusted forests can use claim transformation to prevent certain claim types and claims with certain values from going out to the trusting forest.  
  
-   You can also use claim transformation to map different claim types between trusting and trusted forests. This can be used to generalize the claim-type, the claim value, or both. Without this, you need to standardize the data between the forests before you can use the claims. Generalizing claims between the trusting and trusted forests reduces the IT costs.  
  
## Claim transformation rules  
The transformation rule language syntax divides a single rule into two main parts: a series of condition statements and the issue statement. Each condition statement has two subcomponents: the claim identifier and the condition. The issue statement contains keywords, delimiters, and an issue expression. The condition statement optionally begins with a claim identifier variable, which represents the matched input claim. The condition checks for the expression. If the input claim does not match the condition, then the transformation engine ignores the issue statement and evaluates the next input claim against the transformation rule. If all conditions match the input claim, it processes the issue statement.  
  
For detailed information on claim rules language, see [Claims Transformation Rules Language](Claims-Transformation-Rules-Language.md).  
  
## Linking claim transformation policies to forests  
There are two components involved in setting up claim transformation policies: claim transformation policy objects and the transformation link. The policy objects live in the configuration naming context in a forest, and they contain mapping information for the claims. The link specifies which trusting and trusted forests the mapping applies to.  
  
It is important to understand if the forest is the trusting or trusted forest because this is basis for linking transformation policy objects. For example, the trusted forest is the forest that contains user accounts that require access. The trusting forest is the forest that contains resources that you want to give users access to. Claims travel in the same direction as the security principal that requires access. For example, if there is a one-way trust from the contoso.com forest to the adatum.com forest, the claims will flow from adatum.com to contoso.com, which allows users from adatum.com to access resources in contoso.com.  
  
By default, a trusted forest allows all outgoing claims to pass, and a trusting forest drops all incoming claims that it receives.  
  
## In this scenario  
The following guidance is available for this scenario:  
  
-   [Deploy Claims Across Forests &#40;Demonstration Steps&#41;](Deploy-Claims-Across-Forests--Demonstration-Steps-.md)  
  
-   [Claims Transformation Rules Language](Claims-Transformation-Rules-Language.md)  
  
## <a name="BKMK_NEW"></a>Roles and features included in this scenario  
The following table lists the roles and features that are part of this scenario and describes how they support it.  
  
|Role/feature|How it supports this scenario|  
|-----------------|---------------------------------|  
|Active Directory Domain Services|In this scenario, you are required to set up two Active Directory forests with a two-way trust. You have claims in both forests. You also set central access policies on the trusting forest where the resources reside.|  
|File and Storage Services role|In this scenario, the data classification is applied to the resources on the file servers. The central access policy is applied to the folder where you want to grant user access. After transformation, the claim grants user access to resources based on the central access policy that is applied to the folder on the file server.|  
  


