---
title: Manage User Data with Folder Redirection and Roaming User Profiles in Windows
description: Discover how Folder Redirection and Roaming User Profiles centralize user data and synchronize profiles across devices.
ms.topic: overview
author: robinharwood
ms.author: roharwoo
ms.date: 03/20/2023
#customer intent: As a Windows Server administrator, I want to understand the features and benefits of Folder Redirection, Offline Files, and Roaming User Profiles, so that I can effectively manage user data and profiles in my organization.
---

# Manage user data with Folder Redirection and Roaming User Profiles in Windows

Managing user data and profiles efficiently is critical for organizations of all sizes. This article provides an overview of Folder Redirection and Roaming User Profiles, technologies that help administrators centralize data, improve user experience, and ensure seamless access to files and settings across devices. You'll also learn about new features, practical applications, and deployment considerations to optimize your IT environment.

- **Folder Redirection** enables users and administrators to redirect the path of a known folder to a new location, manually or by using Group Policy. The new location can be a folder on the local computer or a directory on a file share. Users interact with files in the redirected folder as if it still existed on the local drive. For example, you can redirect the Documents folder, which is usually stored on a local drive, to a network location. The files in the folder are then available to the user from any computer on the network.

- **Roaming User Profiles** redirects user profiles to a file share so that users receive the same operating system and application settings on multiple computers. When a user signs in to a computer by using an account that's set up with a file share as the profile path, the user's profile loads to the local computer and merges with the local profile, if present. When the user signs out of the computer, the local copy of their profile, including any changes, merges with the server copy of the profile. Typically, a network administrator enables Roaming User Profiles on domain accounts.

## Benefits of Folder Redirection, Offline Files, and Roaming User Profiles

Administrators can use Folder Redirection, Offline Files, and Roaming User Profiles to centralize storage for user data and settings. These features let users access their data while offline or in the event of a network or server outage. These features can also accomplish these specific applications:

- Centralize data from client computers for administrative tasks, such as using a server-based backup tool to back up user folders and settings.

- Enable users to continue accessing network files, even if there is a network or server outage.

- Optimize bandwidth usage and enhance the experience of users in branch offices who access files and folders that are hosted by corporate servers located offsite.

- Enable mobile users to access network files while working offline or over slow networks.

## Primary computers for Folder Redirection and Roaming User Profiles

Primary computers enables you to limit the use of Folder Redirection, Roaming User Profiles, or both to only a user's primary computers.

You can designate a set of computers, known as primary computers, for each domain user, which enables you to control which computers use Folder Redirection, Roaming User Profiles, or both. Designating primary computers is a simple and powerful method to associate user data and settings with particular computers or devices, simplify administrator oversight, improve data security, and help protect user profiles from corruption.

There are four major benefits to designating primary computers for users:

- The administrator can specify which computers users can use to access their redirected data and settings. For example, the administrator can choose to roam user data and settings between a user's desktop and laptop, and to not roam the information when that user logs on to any other computer, such as a conference room computer.

- Designating primary computers reduces the security and privacy risk of leaving residual personal or corporate data on computers where the user has logged on. For example, a general manager who logs on to an employee's computer for temporary access does not leave behind any personal or corporate data.

- Primary computers enable the administrator to mitigate the risk of an improperly configured or otherwise corrupt profile, which could result from roaming between differently configured systems, such as between x86-based and x64-based computers.

- The amount of time required for a user's first sign-in on a non-primary computer, such as a server, is faster because the user's roaming user profile and/or redirected folders are not downloaded. Sign-out times are also reduced, because changes to the user profile do not need to be uploaded to the file share.

### What is the behavior of a primary computer?

To limit downloading private user data to primary computers, the Folder Redirection and Roaming User Profiles technologies perform the following logic checks when a user signs in to a computer:

- The Windows operating system checks the new Group Policy settings (**Download roaming profiles on primary computers only** and **Redirect folders on primary computers only**) to determine if the **msDS-Primary-Computer** attribute in Active Directory Domain Services (AD DS) should influence the decision to roam the user's profile or apply Folder Redirection.

- If the policy setting enables primary computer support, Windows verifies that the AD DS schema supports the **msDS-Primary-Computer** attribute. If it does, Windows determines if the computer that the user is logging on to is designated as a primary computer for the user as follows:

  - If the computer is one of the user's primary computers, Windows applies the Roaming User Profiles and Folder Redirection settings.

  - If the computer isn't one of the user's primary computers, Windows loads the user's cached local profile, if present, or it creates a new local profile. Windows also removes any existing redirected folders according to the removal action that was specified by the previously applied Group Policy setting, which is retained in the local Folder Redirection configuration.

For more information, see [Deploy primary computers for Folder Redirection and Roaming User Profiles](deploy-primary-computers.md)

## Related content

Learn more about Folder Redirection, Offline Files, and Roaming User Profiles in the following articles:

- [Folder Redirection using Group Policy](folder-redirection-using-group-policy.md)

- [Deploy Folder Redirection with offline files](deploy-folder-redirection.md)

- [Enable Background File Synchronization on Metered Networks in Windows and Windows Server](enable-background-synchronization.md)

- [Enable Always Offline mode for faster access to files](enable-always-offline.md)

- [Deploy Roaming User Profiles](deploy-roaming-user-profiles.md)

- [Deploy primary computers for Folder Redirection and Roaming User Profiles](deploy-primary-computers.md)

- [Enable optimized moves of redirected folders](enable-optimized-moving.md)
