---
title: Share devices with Hyper-V Windows virtual machines
description: See how to share devices with Hyper-V virtual machines. Find out how to give a virtual machine access to USB devices, audio, microphones, and mounted drives.
keywords: windows 10, windows 11, hyper-v
ms.custom: sfi-image-nochange
author: robinharwood
ms.author: roharwoo
ms.date: 01/21/2026
ms.topic: how-to
# customer intent: As a developer, I want to see how to share devices with Hyper-V virtual machines so that I can give my virtual machines access to USB devices, audio, microphones, and mounted drives.
---

# Share devices with your Hyper-V virtual machine

When you use Enhanced Session Mode in the Virtual Machine Connection (VMConnect) tool, you can connect to Hyper-V virtual machines (VMs) by using Remote Desktop Protocol (RDP). Not only does this capability improve your general VM viewing experience, using RDP also provides a way for the VM and your computer to share devices. This functionality is only available for Windows VMs.

Using RDP in Enhanced Session Mode offers many benefits:

- Makes VMs resizable and high-DPI aware
- Improves VM integration:
  - Shared clipboard
  - File sharing via dragging or copying and pasting
- Makes device sharing possible:
  - Microphone and speakers
  - USB devices
  - Data disks, including drive C
  - Printers

Because RDP is turned on by default in Windows, you probably already use RDP to connect to your Windows VMs. This article highlights some of the benefits and hidden options in the connection settings dialog. It shows you how to see your session type, enter Enhanced Session Mode, and configure your session settings.

## Check the session type

You can check your connection type by using the Enhanced Session Mode icon on the VMConnect toolbar. You can also use this button to switch between Basic Session Mode and Enhanced Session Mode.

:::image type="content" source="media/enhanced-session-mode/enhanced-session-mode-button-location.png" alt-text="Screenshot of VMConnect. On the toolbar, an icon is highlighted that indicates whether enhanced session mode is turned on.":::

| Icon | Connection state |
|:-----|:---------|
|:::image type="icon" source="media/enhanced-session-mode/enhanced-session-mode-basic.png" lightbox="media/enhanced-session-mode/enhanced-session-mode-basic.png"::: | You're currently running in Enhanced Session Mode. Selecting this icon reconnects you to your VM in Basic Mode. |
|:::image type="icon" source="media/enhanced-session-mode/enhanced-session-mode-connect.png" lightbox="media/enhanced-session-mode/enhanced-session-mode-connect.png"::: | You're currently running in Basic Session Mode, but Enhanced Session Mode is available. Selecting this icon reconnects you to your VM in Enhanced Session Mode. |
|:::image type="icon" source="media/enhanced-session-mode/enhanced-session-mode-stop.png" lightbox="media/enhanced-session-mode/enhanced-session-mode-stop.png"::: | You're currently running in Basic Session Mode. Enhanced Session Mode isn't available for this VM. |

## Configure a VM for Remote Desktop

Enhanced Session Mode requires Remote Desktop to be turned on in the VM. In the Settings app or Start menu, search for **Remote Desktop settings**. Turn on the **Enable Remote Desktop** toggle.

:::image type="content" source="media/enhanced-session-mode/remote-desktop-settings.png" alt-text="Screenshot of the Remote Desktop page in the Settings app. The Enable Remote Desktop toggle is in the on position.":::

Windows 10 (version 2004 and later) and Windows 11 require an extra setting. If the VMConnect window background doesn't display a sign-in prompt, disable Windows Hello sign-in:

1. Sign in to the VM in basic session mode.
1. Go to **Settings** > **Accounts** > **Sign-in options**.
1. Turn off **For improved security, only allow Windows Hello sign-in for Microsoft accounts on this device**.

   | Windows 11 | Windows 10 |
   |:----|:----|
   |:::image type="content" source="media/enhanced-session-mode/sign-in-options-windows-11.png" alt-text="Screenshot of the Sign-in options page in VMConnect in Windows 11. The toggle for requiring Windows Hello sign-in is highlighted." lightbox="media/enhanced-session-mode/sign-in-options-windows-11.png":::|:::image type="content" source="media/enhanced-session-mode/sign-in-options.png" alt-text="Screenshot of the Sign-in options page in Settings in Windows 10. The toggle for requiring Windows Hello sign-in is highlighted." lightbox="media/enhanced-session-mode/sign-in-options.png":::|

1. Sign out of the VM or reboot it before you close the VMConnect window.

   To verify, check that the VMConnect window displays an Enhanced Session Mode sign-in prompt after reconnecting.

## Share drives and devices

You can find the device sharing capabilities of Enhanced Session Mode in the connection dialog that opens when you connect to a VM:

:::image type="content" source="media/enhanced-session-mode/enhanced-session-mode-default-view.png" alt-text="Screenshot of the connection dialog. Below the size, which is set to 1366 by 768 pixels, a Show Options button is visible.":::

By default, Enhanced Session Mode provides VMs with access to the following resources:

- Clipboard
- Printers
- Audio playback (to host speakers)

To share devices with your VM or to change the default settings:

1. In VMConnect, select the virtual machine that you want to connect to.

1. Select **Show Options**.

   :::image type="content" source="media/enhanced-session-mode/enhanced-session-mode-show-options.png" alt-text="Screenshot of the connection dialog. The Show Options button is highlighted.":::

1. Select **Local Resources**, and then adjust the settings.

   :::image type="content" source="media/enhanced-session-mode/enhanced-session-mode-local-resources.png" alt-text="Screenshot of the connection dialog. The Local Resources tab is highlighted.":::

   To verify, check that elected resources are available after connecting to the VM.

### Share storage and USB devices

Enhanced Session Mode also supports sharing additional device types, such as:

| Device type | Examples |
|-------------|----------|
| Storage | Local drives (including C:), removable drives |
| USB devices | Flash drives, external storage |
| Security devices | Smart cards, Windows Hello companion devices |

To share these devices with a VM:

1. Under **Local devices and resources**, select **More**.

   :::image type="content" source="media/enhanced-session-mode/enhanced-session-mode-more-devices.png" alt-text="Screenshot of the Local Resources tab of the connection dialog. Under local devices and resources, the More button is highlighted.":::

1. Select the devices that you want to share with the VM. The system drive, which is drive C on Windows, is especially helpful for file sharing.

   :::image type="content" source="media/enhanced-session-mode/enhanced-session-mode-drives-usb.png" alt-text="Screenshot of the Local Resources page. In a list of devices, the line for Smart cards is selected.":::

   To verify, check that shared drives appear under **This PC** in File Explorer within the VM.

### Share audio devices (speakers and microphones)

By default, VMs transfer audio to the host machine using the currently selected audio device. You can configure the following audio settings:

| Setting | Options |
|---------|--------|
| Remote audio playback | Play on this computer, Play on remote computer, Do not play |
| Remote audio recording | Record from this computer (microphone pass-through), Do not record |

To change audio settings:

1. Select **Settings** to configure remote audio settings.

   :::image type="content" source="media/enhanced-session-mode/enhanced-session-mode-audio.png" alt-text="Screenshot of the Local Resources tab of the connection dialog. Under Remote audio, the Settings button is highlighted.":::

1. Configure audio and microphone settings.

   :::image type="content" source="media/enhanced-session-mode/enhanced-session-mode-audio-settings.png" alt-text="Screenshot of the Audio settings page. Remote audio is set to play on this computer, and remote audio recording is turned off.":::

   For local VMs, **Play on this computer** and **Play on remote computer** produce the same result.

   To verify, check that audio plays through the configured device, and microphone input is detected if recording is enabled.

## Reopen the connection settings

If you don't see the connection dialog or the **Show Options** button, try opening VMConnect independently from either the Windows menu or the command line as an administrator.

```PowerShell
vmconnect.exe
```

VMConnect opens and displays the connection dialog with **Show Options** available.
