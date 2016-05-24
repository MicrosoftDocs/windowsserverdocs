---
title: Requirements for Conversion to Microsoft Azure
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 34dd30dc-66c9-419c-a043-8674a3997f76
author: cwatsonmsft
---
# Requirements for Conversion to Microsoft Azure
MVMC performs virtual machine conversions to VHDs and uploads the disks to Microsoft Azure Blob storage when the following conditions are met:  
  
-   You have added a management certificate for Microsoft Azure that can be used for authentication with your subscription ID on Microsoft Azure.  
  
    For instructions, see [Create and Upload a Management Certificate for Azure](http://msdn.microsoft.com/library/windowsazure/gg551722.aspx). The management certificate is added to a Microsoft Azure subscription.  
  
    > [!NOTE]  
    > Certificates have a thumbprint that provides a means to identify them in an unambiguous way. MVMC uses this thumbprint along with the subscription ID for uploading the converted VHDs to the Microsoft Azure blob storage.  
  
    To use the subscription identifier and the thumbprint when you are prompted in MVMC, sign in to the [Microsoft Azure Management Portal](http://manage.windowsazure.com/), and click **Settings**. You should see a list of management certificates with the associated subscription identifier and the certificate thumbprint.  
  
-   The Microsoft Azure management certificate is imported to the following two stores: **Certificates \- Current Users**>**Personal** and **Certificates \- Current Users**>**Trusted Root Certification Authorities**.  
  
-   You have a storage account to upload and store the converted VHDs in Microsoft Azure. Before you use MVMC to perform conversions, ensure that a storage account is created in Microsoft Azure.  
  
    For instructions, see [How to Create a Storage Account](http://www.windowsazure.com/manage/services/storage/how-to-create-a-storage-account/).  
  
To convert and upload to Microsoft Azure, you have to install Windows PowerShell Runtime 3.0 on the source machine on which MVMC is running.  
  
In addition to these requirements, see the “Windows Virtual Machines” section within “Requirements for Conversion to Hyper\-V Destination” earlier in this guide for requirements to convert and upload disks to Microsoft Azure, when the upload disks are attached to an online Windows virtual machine.  
  
> [!IMPORTANT]  
> The following Linux versions are supported by MVMC when migrating to Windows Hyper\-V, but not for migrating to Microsoft Azure:  
>   
> -   Red Hat Enterprise Linux versions 5.8 and previous versions  
> -   CentOS Linux versions 5.8 and previous versions  
> -   Oracle Linux versions 5.8 and previous versions  
  
