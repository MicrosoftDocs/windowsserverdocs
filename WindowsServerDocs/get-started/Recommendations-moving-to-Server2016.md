---
title: Recommendations for moving to Windows Server 2016
description: "Recommendations for moving to Windows Server 2016."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.date: 10/18/2016
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 74aa1da3-7076-4a1f-ad5b-9e17bd46dba2
author: jaimeo
ms.author: jaimeo
manager: dongill
ms.localizationpriority: medium
---
# Recommendations for moving to Windows Server 2016

>Applies To: Windows Server 2016


|If you are running:|Windows Server 2012 R2 or Windows Server 2012|Windows Server 2008 R2 or Windows Server 2008|  
|-------------------|----------|--------------|--------------|---------------------------------------|  
|**Windows Server role infrastructure**|Choose either upgrade or migration depending on [specific role guidance](https://technet.microsoft.com/windowsserver/jj554790).|- To take advantage of new features in Windows Server 2016, deploy new hardware, or install Windows Server 2016 in a virtual machine on an existing host. Some new features work best on a Windows Server 2016 physical host running Hyper-V. <br>- Follow [specific role guidance](https://technet.microsoft.com/windowsserver/jj554790).|
|**Microsoft server management and application workloads**|- Application upgrades should include *migration* to Windows Server 2016. See the [compatibility list](Server-Application-Compatibility.md). <br>- Upgrades to Windows Server 2016 only (i.e., without upgrading applications) should use application-specific guidance.|- To take advantage of new features in Windows Server 2016, deploy new hardware, or install Windows Server 2016 in a virtual machine on an existing host. Some new features work best on a Windows Server 2016 physical host running Hyper-V. Follow migration guides as applicable. <br>- Or, remain on your current OS and run in a virtual machine running on a Windows Server 2016 host, or Microsoft Azure. Contact your EA reseller, TAM, or Microsoft for extended support options through [Software Assurance](https://www.microsoft.com/Licensing/licensing-programs/software-assurance-default.aspx).|
|**ISV application workloads**|- Upgrades to Windows Server 2016 should use application-specific guidance. <br>- For more information on Windows Server compatibility with non-Microsoft applications, visit the [Windows Server Logo Certification portal](https://msdn.microsoft.com/enterprisecloudcertified).|- To take advantage of new features in Windows Server 2016, deploy new hardware, or install Windows Server 2016 in a virtual machine on an existing host. Some new features work best on a Windows Server 2016 physical host running Hyper-V. Follow migration guides as applicable. <br>- Or, remain on your current OS and run in a virtual machine running on a Windows Server 2016 host, or Microsoft Azure. Contact your EA reseller, TAM, or Microsoft for extended support options through [Software Assurance](https://www.microsoft.com/Licensing/licensing-programs/software-assurance-default.aspx).|
|**Custom application workloads**|- Consult with application developers on compatibility with Windows Server 2016 and upgrade guidance. <br>- Leverage Microsoft Azure to test application on Windows Server 2016 prior to switch. <br>- See complete options in the next section.|- Consult with your application developers on compatibility with Windows Server 2016 and upgrade guidance. <br>- Leverage Microsoft Azure to test your application on Windows Server 2016 prior to switch. <br>- To take advantage of new features in Windows Server 2016, deploy new hardware, or install Windows Server 2016 in a virtual machine on an existing host. Some new features work best on a Windows Server 2016 physical host running Hyper-V. <br>- See complete options in the next section.|

## Complete options for moving servers running custom or "in-house" applications on older versions of Windows Server to Windows Server 2016

There are more options than ever before to help you and your customers take advantage of features in Windows Server 2016, with minimal impact to your current services and workloads.

- Try out the latest operating system with your application by downloading the evaluation version of [Windows Server](https://www.microsoft.com/evalcenter/evaluate-windows-server-2016) for testing on your premises. Once testing is complete and quality confirmed, you can perform a simple license conversion with a retail license key (requires restarting).

- [Microsoft Azure](https://azure.microsoft.com) can also be used on a trial basis for testing to ensure your custom application will work on the latest server operating system. Once testing is complete and quality confirmed, [migrate to the latest Windows Server version](https://docs.microsoft.com/windows-server/get-started/installation-and-upgrade#upgrade) on your premises. 

- Or alternatively, once testing is complete and quality confirmed, [Microsoft Azure](https://azure.microsoft.com) can be used as the permanent location for your custom application or service. This allows the old server to remain available until you are ready to switch over to the new server in Azure.

    - If you already have Software Assurance for Windows Server, save money by deploying with the [Azure Hybrid Use Benefit](https://azure.microsoft.com/pricing/hybrid-use-benefit/). 

- In most cases, [Microsoft Azure](https://azure.microsoft.com) can be used to host the same application on the older version of Windows Server that it is running on today. Migrate the application and workload to a virtual machine with the operating system of your choice by using [Azure Marketplace](https://azure.microsoft.com/marketplace/) images.

    - If you already have Software Assurance for Windows Server, save money by deploying with the [Azure Hybrid Use Benefit](https://azure.microsoft.com/pricing/hybrid-use-benefit/). 

- The [Software Assurance](https://www.microsoft.com/Licensing/licensing-programs/software-assurance-default.aspx) program for Windows Server provides new version rights benefits. Along with a list of other benefits, servers with Software Assurance can be upgraded to the latest version of Window Server when the time is right, without having to purchase a new license. 

## Additional resources

- [Features removed or deprecated in Windows Server 2016](deprecated-features.md)
- For general server upgrade and migration options, visit [Upgrade and conversion options for Windows Server 2016](Supported-Upgrade-Paths.md).
- For more information on product lifecycle and support levels, see the [Support Lifecycle Policy FAQ](https://support.microsoft.com/help/17140/support-lifecycle-policy-faq).

