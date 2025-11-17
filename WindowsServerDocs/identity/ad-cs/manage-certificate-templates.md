---
title: Manage certificate templates in Windows Server
description: This article describes how to manage Active Directory Certificate Services certificate templates in Windows Server.
author: Orin-Thomas
ms.topic: how-to
ms.author: orthomas
ms.date: 02/18/2024
---

# Manage certificate templates

Certificate Templates are managed through the Certificate Templates Microsoft Management Console (MMC) snap-in. You can use this snap-in to manage Active Directory Certificate Services (AD CS) both locally and remotely.

## How to manage templates

You must be a member of Domain Admins to access and administer certificate templates for a domain. To add this snap-in, install the AD CS management tools on the management computer. The AD CS management tools are part of the Remote Server Administration Tools (RSAT). You can install the management tools on a Windows Server computer by running the following PowerShell command from an elevated PowerShell session:

```powershell
Install-WindowsFeature RSAT-ADCS
```

To configure an MMC to use the Certificate Templates snap-in:

1. Right click Start, click Run, and then type mmc.
1. On the File menu, click Add/Remove Snap-in.
1. On the Add and Remove Snap-ins dialog box, double-click the Certificate Templates snap-in to add it to the list. Click OK.

## Create a new certificate template

You can create a new certificate template by duplicating an existing template and using the existing template's properties as the default for the new template. Review the list of default certificate templates, and examine their properties to identify the existing certificate template that most closely meets your needs. Membership in Domain Admins, or equivalent, is the minimum required to complete this procedure.

To create a new certificate template:

1. Open the Certificate Templates snap-in and connect to the AC CS Enterprise root or subordinate server.
1. Right-click the template to copy from, and then click Duplicate Template.
1. Choose the minimum operating system version of AD CS Certificate Authority (CA) that you want to support. Currently the most recent version of Windows Server that you can select is Windows Server 2016. You can also select the minimum recipient operating system for the certificate template, with the most recent version being Windows 10/Windows Server 2016.
1. Provide a name for the certificate template and configure the template settings.

## Delete a certificate template

You can delete a certificate template when you no longer want it to be available for use. When you delete a certificate template, certificates based on the template can no longer be issued. Template deletions affect all CAs in a forest. Certificate templates cannot be recovered once they are deleted. Membership in Domain Admins or Enterprise Admins, or equivalent, is required to delete a certificate template.

To delete a certificate template, perform the following steps:

1. Open an MMC with the Certificate Templates snap-in.
1. Right-click the template you want to delete, and then click Delete.
1. Click Yes to confirm that you want to delete the template.

## Rename a certificate template

The names of default certificate templates cannot be changed. Administrators can change the names of custom certificate templates. The template name is the common name attribute of the certificate template object in Active Directory Domain Services (AD DS). Only that template object is updated if the template name is changed. If the modified template was previously published to issuing certification authorities (CAs) or added to a superseded templates list, then those actions must be repeated to maintain the consistency of the public key infrastructure (PKI) environment.

To change a certificate template name:

1. Open the Certificate Templates snap-in and connect to the AD CS CA.
1. Select the certificate template you want to modify. On the Action menu, click Change Names.
1. Type a new name in the Template name box or the Template display name box, or both.
1. Click OK to save changes.

If the modified template is already published to issuing CAs, remove the template from Certificate Templates on those issuing CAs, then restart these issuing CA computers, and then add the renamed template to the issuing CAs. If another template supersedes the modified template, then update the superseding template by adding the modified template to the list of superseded templates.

## Deploying certificate templates to a CA

When you create an enterprise certification authority (CA), certificate templates are stored in Active Directory Domain Services (AD DS) and can be made available to all enterprise CAs in the forest. Any newly created certificate templates will be replicated automatically to all domain controllers in the enterprise.

To configure a CA to issue certificates based on a certificate template, perform the following steps:

1. Open the Certification Authority snap-in, and double-click the name of the CA.
1. Right-click Certificate Templates, click New, and then click Certificate Template to Issue.
1. Select the certificate template, and click OK.

## Remove a certificate template from a CA

It may be necessary to remove a certificate template from a certification authority (CA). For example, if you need to avoid confusion when adding a newer version of the certificate template.

To remove a certificate template from a CA:

1. Open the Certification Authority snap-in.
1. In the console tree, click Certificate Templates.
1. In the details pane, right-click the certificate template that you want to delete, and then click Delete.

You cannot remove the built in certificate templates.
