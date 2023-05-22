---
title: Troubleshoot Software Restriction Policies
description: Learn about common problems and their solutions when troubleshooting Software Restriction Policies (SRP) beginning with Windows Server 2008 and Windows Vista.
ms.topic: article
ms.author: jgerend
author: JasonGerend
ms.date: 04/01/2023
---
# Troubleshoot Software Restriction Policies

Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This article describes common problems and solutions when troubleshooting Software Restriction Policies (SRP) beginning with Windows Server 2008 and Windows Vista.

## Introduction

Software Restriction Policies (SRP) is Group Policy-based feature that identifies software programs running on computers in a domain and controls the ability of those programs to run. You use software restriction policies to create a highly restricted configuration for computers, in which you allow only identified applications to run. These applications are integrated with Microsoft Active Directory Domain Services and Group Policy but can also be configured on stand-alone computers. For more information about SRP, see [Software Restriction Policies](software-restriction-policies.md).

Beginning in Windows Server 2008 R2 and Windows 7, Windows AppLocker can be used instead of or in concert with SRP for a portion of your application control strategy.

### Windows cannot open a program

Users receive a message stating, "Windows cannot open this program because it has been prevented by a software restriction policy. For more information, open Event Viewer or contact your system administrator." Or, on the command line a message appears stating, "The system cannot execute the specified program."

**Cause:** The default security level (or a rule) was created so that the software program is set as **Disallowed** and as a result it doesn't start.

**Solution:** Look in the event log for an in-depth description of the message. The event log message indicates what software program is set as **Disallowed** and what rule is applied to the program.

### Modified software restriction policies aren't taking effect

**Cause:** Software restriction policies specified in a domain through Group Policy override any policy settings configured locally. When policies aren't taking effect, it might imply that there's a policy setting from the domain that's overriding your policy setting.

**Cause:** Group Policy might not have refreshed its policy settings. Group Policy applies changes to policy settings periodically; therefore, it's likely that the policy changes made in the directory haven't yet been refreshed.

**Solutions:**

- The computer on which you modify software restriction policies for the network must be able to contact a domain controller. Ensure the computer can contact a domain controller.

- Refresh policy by logging off of the network and then logging on to the network again. If any policy is applied through Group Policy, logging back in refreshes those policies.

- You can refresh policy settings with the command-line utility `gpupdate` or by logging off from and then logging back on to your computer. For best results, run `gpupdate`, and then sign out from and log back on to your computer. Generally, the security settings are refreshed every 90 minutes on a workstation or server and every 5 minutes on a domain controller. The settings are also refreshed every 16 hours, whether or not there are any changes. These settings are configurable, so refresh intervals can be different in each domain.

- Check which policies apply. Check domain level policies for **No Override** settings.

- Software restriction policies specified in a domain through Group Policy override any policies configured locally. Use `Gpresult` command-line tool to determine what the net effect of the policy is.  When policies aren't taking effect, it might imply that there's a policy from the domain that's overriding your local setting.

- If SRP and AppLocker policy settings are in the same GPO, AppLocker settings take precedence on Windows 7, Windows Server 2008 R2, and later versions. It's recommended to put SRP and AppLocker policy settings in different GPOs.

### After adding a rule through SRP, you can't sign-in to your computer

**Cause:** Your computer accesses many programs and files when it starts. You might have inadvertently set one of these programs or files to **Disallowed**. Because the computer can't access the program or file, it can't start properly.

**Solution:** Start the computer in Safe Mode, sign-in as a local administrator, and then change software restriction policies to allow the program or file to run.

### A new policy setting isn't applying to a specific file name extension

**Cause:** The filename extension isn't in the list of supported file types.

**Solution:** Add the filename extension to the list of file types supported by SRP.

Software restriction policies address the problem of regulating unknown or untrusted code. Software restriction policies are security settings to identify software and control its ability to run on a local computer, in a site, domain, or OU. You can implement these settings through a GPO.

### A default rule isn't restricting as expected

**Cause:** Rules applied in a particular sequence can cause specific rules to override default rules. SRP applies rules in the following sequence (from most specific to most general):

1. Hash rules

2. Certificate rules

3. Path rules

4. Internet Zone rules

5. Default rules

**Solution:** Evaluate the rules restricting the application and, if appropriate, remove all but the Default rule.

### Unable to discover which restrictions are applied

**Cause:** There's no apparent cause for the unexpected behavior. GPO refresh hasn't solved the issue; further investigation is needed.

**Solutions:**

- Investigate the System Event Log, filtering on source of "Software Restriction Policy." The entries explicitly state which rule is implemented for each application.

- Enable advanced logging.

- For more information about Software Restriction Policies, see [Determine Allow-Deny List and Application Inventory for Software Restriction Policies](software-restriction-policies.md) for more information.