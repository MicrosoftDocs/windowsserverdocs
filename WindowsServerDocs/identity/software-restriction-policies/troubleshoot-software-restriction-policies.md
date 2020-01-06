---
title: Troubleshoot Software Restriction Policies
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-software-restriction-policies
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4fd53736-03e7-4bf9-ba90-d1212d93e19a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Troubleshoot Software Restriction Policies

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic describes common problems and their solutions when troubleshooting Software Restriction Policies (SRP) beginning with Windows Server 2008 and Windows Vista.

## Introduction
Software Restriction Policies (SRP) is Group Policy-based feature that identifies software programs running on computers in a domain, and controls the ability of those programs to run. You use software restriction policies to create a highly restricted configuration for computers, in which you allow only specifically identified applications to run. These are integrated with Microsoft Active Directory Domain Services and Group Policy but can also be configured on stand-alone computers. For more information about SRP, see the [Software Restriction Policies](software-restriction-policies.md).

Beginning with  Windows Server 2008 R2  and  Windows 7 , Windows AppLocker can be used instead of or in concert with SRP for a portion of your application control strategy.

### Windows cannot open a program
Users receive a message that says "Windows cannot open this program because it has been prevented by a software restriction policy. For more information, open Event Viewer or contact your system administrator." Or, on the command line, a message says "The system cannot execute the specified program."

**Cause:** The default security level (or a rule) was created so that the software program is set as **Disallowed**, and as a result it will not start.

**Solution:** Look in the event log for an in-depth description of the message. The event log message indicates what software program is set as **Disallowed** and what rule is applied to the program.

### Modified software restriction policies are not taking effect
**Cause:** Software restriction policies that are specified in a domain through Group Policy override any policy settings that are configured locally. This might imply that there is a policy setting from the domain that is overriding your policy setting.

**Cause:** Group Policy might not have refreshed its policy settings. Group Policy applies changes to policy settings periodically; therefore, it is likely that the policy changes that were made in the directory have not yet been refreshed.

**Solutions:**

1.  The computer on which you modify software restriction policies for the network must be able to contact a domain controller. Ensure the computer can contact a domain controller.

2.  Refresh policy by logging off of the network and then logging on to the network again. If any policy is applied through Group Policy, logging back in will refresh those policies.

3.  You can refresh policy settings with the command-line utility gpupdate or by logging off from and then logging back on to your computer. For best results, run gpupdate, and then log off from and log back on to your computer. Generally, the security settings are refreshed every 90 minutes on a workstation or server and every 5 minutes on a domain controller. The settings are also refreshed every 16 hours, whether or not there are any changes. These are configurable settings so refresh intervals might be different in each domain.

4.  Check which policies apply. Check domain level policies for **No Override** settings.

5.  Software restriction policies that are specified in a domain through Group Policy override any policies that are configured locally. Use Gpresult command-line tool to determine what the net effect of the policy is. This might imply that there is a policy from the domain that is overriding your local setting.

6.  If SRP and AppLocker policy settings are in the same GPO, AppLocker settings will take precedence on  Windows 7 ,  Windows Server 2008 R2 , and later. It is recommended to put SRP and AppLocker policy settings in different GPOs.

### After adding a rule through SRP, you cannot log on to your computer
**Cause:** Your computer accesses many programs and files when it starts. You might have inadvertently set one of these programs or files to **Disallowed**. Because the computer cannot access the program or file, it cannot start properly.

**Solution:** Start the computer in Safe Mode, log on as a local administrator, and then change software restriction policies to allow the program or file to run.

### A new policy setting is not applying to a specific file name extension
**Cause:** The filename extension is not in the list of supported file types.

**Solution:** Add the filename extension to the list of file types supported by SRP.

Software restriction policies address the problem of regulating unknown or untrusted code. Software restriction policies are security settings to identify software and control its ability to run on a local computer, in a site, domain, or OU and can be implemented through a GPO.

### A default rule is not restricting as expected
**Cause:** Rules which are applied in a particular order which can cause default rules to be overridden by specific rules. SRP applies rules in the following order (most specific to general):

1.  Hash rules

2.  Certificate rules

3.  Path rules

4.  Internet Zone rules

5.  Default rules

**Solution:** Evaluate the rules restricting the application and, if appropriate, remove all but the Default rule.

### Unable to discover which restrictions are applied
**Cause:** There is no apparent cause for the unexpected behavior, and GPO refresh has not solved the issue so further investigation is necessary.

**Solutions:**

1.  Investigate the System Event Log, filtering on source of "Software Restriction Policy." The entries explicitly state which rule is implemented for each application.

2.  Enable advanced logging. See [Determine Allow-Deny List and Application Inventory for Software Restriction Policies](software-restriction-policies.md) for more information.


