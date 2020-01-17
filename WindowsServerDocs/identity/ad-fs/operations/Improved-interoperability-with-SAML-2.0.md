---
ms.assetid: 80b5335b-fa02-4944-900c-5fe4f5c6111d
title: Improved interoperability with SAML 2.0
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---
# Improved interoperability with SAML 2.0



  
AD FS in Windows Server 2016 contains additional SAML protocol support, including support for importing trusts based on metadata that contains multiple entities.  This enables you to configure AD FS to participate in confederations such as InCommon Federation and other implementations conforming to the eGov 2.0 standard.   
  
The new capability is based on groups of relying party or claims provider trusts. Each group is an EntitiesDescriptor (<md:EntitiesDescriptor>) element as specified in the eGov 2.0 profile, containing one or many EntityDescriptor elements.  The groups have common authorization rules, and all other properties can be modified like individual trust objects.  
  
Once the trust groups are imported into AD FS, AD FS automatically updates the trusts as a group based on the metadata document.  
  
Enabling these scenarios is as simple as using the new PowerShell commandlets that Add and Remove AdfsClaimsProviderTrustsGroup and AdfsRelyingPartyTrustsGroup objects. This can be done using a metadata URL or a file, as shown in the examples below.  
  
Additionally, AD FS 2016 has support for the scoping parameter as described in the SAML Core specification, section 3.4.1.2. This element allows relying parties to specify one or more identity providers for an authentication request.  
  
## Examples  
  
```  
Add-AdfsClaimsProviderTrustsGroup -MetadataUrl "https://www.contosoconsortium.com/metadata/metadata.xml"   
```  
  
  
  
```  
Add-AdfsClaimsProviderTrustsGroup -MetadataFile "C:\metadata.xml"   
```  
  
## References  
  
The eGov 2.0 profile can be found [here.](https://kantarainitiative.org/confluence/download/attachments/60817482/kantara-report-egov-saml2-profile-2.0.pdf?version=1&modificationDate=1345580916000&api=v2)  
  
The SAML Core specification can be found [here.](https://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf)   


