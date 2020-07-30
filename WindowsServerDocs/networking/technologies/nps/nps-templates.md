---
title: NPS Templates
description: This topic provides an overview of Network Policy Server Templates in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: fdfc0df1-21c7-492c-9fad-38fe9c7d935a
ms.author: lizross 
author: eross-msft
---

# NPS Templates

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

Network Policy Server \(NPS\) templates allow you to create configuration elements, such as Remote Authentication Dial-In User Service \(RADIUS\) clients or shared secrets, that you can reuse on the local NPS and export for use on other NPSs.

NPS templates are designed to reduce the amount of time and cost that it takes to configure NPS on one or more servers. The following NPS template types are available for configuration in Templates Management:

- Shared Secrets
- RADIUS Clients
- Remote RADIUS Servers
- IP Filters
- Remediation Server Groups

Configuring a template is different than configuring the NPS directly. Creating a template does not affect the NPS's functionality. It is only when you select the template in the appropriate location in the NPS console that the template affects the NPS functionality. 

For example, if you configure a RADIUS client in the NPS console under RADIUS Clients and Servers, you have altered the NPS configuration and taken one step in configuring NPS to communicate with one of your network access servers \(NAS's\). \(The next step would be to configure the NAS to communicate with NPS.\) However, if you configure a new RADIUS Clients template in the NPS console under **Templates Management** rather than creating a new RADIUS client under **RADIUS Clients and Servers**, you have created a template, but you have not altered the NPS functionality yet. To alter the NPS functionality, you must select the template from the correct location in the NPS console.

## Creating templates

To create a template, open the NPS console, right-click a template type, such as **IP Filters**, and then click **New**. A new template properties dialog box opens that allows you to configure your template.

## Using templates locally

You can use a template that you've created in **Templates Management** by navigating to a location in the NPS console where the template can be applied. For example, if you create a new Shared Secrets template that you want to apply to a RADIUS client configuration, in **RADIUS Clients and Servers** and **RADIUS Clients**, open the RADIUS client properties. In **Select an existing Shared Secrets template**, select the template you previously created from the list of available templates.

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).
