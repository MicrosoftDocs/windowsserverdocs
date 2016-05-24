---
title: Appendix: New Trust Wizard Pages
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: a9772a47-089c-4cf0-8eb1-cdf61b0d9511
author: Femila
---
# Appendix: New Trust Wizard Pages
  Understanding how user input is handled during the trust creation process will help you provide information when it is most necessary and help you better prepare for your specific procedure. This section explains the two most complex pages in the New Trust Wizard:  
  
-   **Direction of Trust**  
  
-   **Sides of Trust**  
  
## Direction of Trust  
 An administrator in one domain configures the **Direction of Trust** page in the New Trust Wizard to determine whether authentication requests should be routed from this domain to a specified domain, from the specified domain to this domain, or freely between both domains. The following trust direction options are available on the **Direction of Trust** page:  
  
-   **Two\-way**. A two\-way trust allows authentication requests that are sent by users in either domain or forest to be routed successfully to resources in either of the two domains or forests.  
  
-   **One\-way: incoming**. A one\-way, incoming trust allows authentication requests that are sent by users in your domain or forest \(the domain or forest where you started the New Trust Wizard\) to be routed successfully to resources in the other domain or forest.  
  
-   **One\-way: outgoing**. A one\-way, outgoing trust allows authentication requests that are sent by users in the other domain \(the domain or forest that you are indicating in the New Trust Wizard as the specified domain or forest\) to be routed successfully to resources in your domain or forest.  
  
 These options are explained in the following sections.  
  
### Wizard option—Two\-way  
 Use this option when you want to share resources equally between two domains or forests for all the users that reside in both domains or forests. A two\-way trust allows authentication requests that are sent by users in a trusted domain or forest to be routed successfully to the trusting domain or forest. Both domains or forests in the trust relationship are reciprocally trusting and trusted.  
  
> [!NOTE]  
>  Traditionally, documentation about domain and forest trusts have used the terms “trusting” and “trusted” to help administrators pinpoint the direction of the trust. Although this terminology is still used today to define and conceptualize how trusts work, it varies from the terminology that is used in the New Trust Wizard to help administrators determine the direction of trust. Instead, “incoming” and “outgoing” are used to indicate the direction of the trust, as described in the next sections.  
  
### Wizard option—One\-way: incoming  
 Use this option when you want to allow authentication requests to be routed from your domain or forest \(referred to as “this domain” or “this forest” in the wizard\) to resources residing in a second domain or forest \(referred to as “specified domain” or “specified forest” in the wizard\). “One\-way” in **One\-way: incoming** means that this selection will create a one\-way trust that can route authentications to resources in only one direction, while user access to those resources flows in the other direction. “Incoming” in **One\-way: incoming** refers to the direction of the trust itself, not the direction in which authentication requests will flow. In other words, as shown in the following illustration, a "one\-way incoming trust" means that your domain or forest will be the domain or forest that receives access to the resources in the other domain.  
  
 ![](../Image/Opad_1wayincomingc.gif)  
  
### Wizard option—One\-way: outgoing  
 Use this option when you want to allow authentication requests to be routed to your domain or forest \(referred to as “this domain” or “this forest” in the wizard\) from users residing in a second domain or forest \(referred to as “specified domain” or “specified forest” in the wizard\). “One\-way” in **One\-way: outgoing** means that this selection will create a one\-way trust that can route authentications to resources in only one direction, while user access to those resources flows in the other direction. “Outgoing” in **One\-way: outgoing** refers to the direction of the trust itself, not the direction in which authentication requests will flow. In other words, as shown in the following illustration, a "one\-way, outgoing trust" means that your domain or forest will provide access to resources that are located in your domain to users who are located in the other domain or forest.  
  
 ![](../Image/Opad_1wayoutgoingc.gif)  
  
## Sides of trust  
 In Windows NT 4.0 and Windows 2000, the only way to create trusts using the graphical user interface \(GUI\) was incrementally—one side of the trust at a time. When you create external trusts, shortcut trusts, realm trusts, or forest trusts in Windows Server 2003 and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you have the option to create each side of the trust separately or both sides of the trust simultaneously.  
  
### Wizard option—This domain only  
 Use this option when you want to create each side of the trust separately, which means that you must run the New Trust Wizard twice—once for each domain in the trust. Although the New Trust Wizard presents a different experience than previous version of Windows Server operating systems, this option provides behavior that is similar to the way that trusts were created in Windows NT 4.0 and Windows 2000. When you create trusts using this method, you must supply the same trust password for each domain. As a security best practice, all trust passwords should be strong passwords.  
  
### Wizard option—Both this domain and the specified domain  
 This option provides administrators who possess the appropriate domain credentials for both domains in the trust relationship with the option to quickly create both sides of a trust by completing a single instance of the New Trust Wizard. When you select this option, a strong trust password is automatically generated for you. For this selection to be successful, the administrator running the wizard must acquire the appropriate administrative credentials for each domain in the trust relationship  
  
  