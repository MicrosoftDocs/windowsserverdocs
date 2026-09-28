---
title: Intelligent Terminal Windows Server Endpoint
description: Connect Intelligent Terminal Preview on a supported Windows client to an OpenAI-compatible endpoint that your organization manages and hosts on Windows Server.
ms.topic: install-set-up-deploy
ms.service: windows-server
author: robinharwood
ms.author: roharwoo
ms.date: 09/25/2026
ai-usage: ai-assisted

#customer intent: As a Windows Server administrator or developer, I want to connect Intelligent Terminal on a supported Windows client to a model endpoint that my organization hosts on Windows Server so that I can use command assistance with that model.
---

# Connect Intelligent Terminal Preview on a Windows client to a Windows Server model endpoint

Intelligent Terminal Preview is an experimental terminal application based on Windows Terminal that provides an agent pane for command assistance. A distributed configuration lets you use a model that your organization manages and hosts on Windows Server while running Intelligent Terminal Preview and its agent on a supported Windows client. The client sends requests to the OpenAI-compatible inference endpoint over the network, so the model doesn't run on the client device.

This procedure installs Intelligent Terminal Preview on the Windows client, connects GitHub Copilot CLI or OpenCode to the Windows Server-hosted endpoint, selects the model, and verifies command assistance. The procedure doesn't deploy or configure the inference endpoint on Windows Server.

<!-- Publish this article only when Intelligent Terminal Preview is publicly revealed and available. -->

> [!IMPORTANT]
> Intelligent Terminal is currently in PREVIEW. This information relates to a prerelease product that Microsoft might substantially modify before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here. Intelligent Terminal Preview is experimental. Don't use Intelligent Terminal Preview in production.

## Is Intelligent Terminal Preview supported on Windows Server?

Product documentation doesn't explicitly list Windows Server as a supported client OS. This procedure runs Intelligent Terminal Preview on a documented supported Windows client and uses Windows Server only to host the endpoint.

## Prerequisites for connecting Intelligent Terminal Preview to a Windows Server-hosted endpoint

- A Windows client device that runs Windows 10, version 2004 (build 19041) or later, with [Windows Package Manager](/windows/package-manager/winget/) available for the current user. Intelligent Terminal Preview uses a per-user desktop MSIX package.
- An installation of GitHub Copilot CLI or OpenCode that Intelligent Terminal Preview can access. These two agents support custom OpenAI-compatible providers. Complete any sign-in, subscription, or organizational-policy requirements for the agent you select.
- An existing OpenAI-compatible Chat Completions endpoint that runs on Windows Server and requires authentication for remote connections. Configure the endpoint to accept connections from the Windows client instead of listening only on `localhost`.
- Network connectivity from the Windows client to the endpoint. DNS must resolve the endpoint hostname, and the endpoint's TCP port must be open through Windows Defender Firewall and any intervening network firewalls. Configure the endpoint to listen only on the intended Windows Server network interface, restrict inbound firewall rules to authorized client addresses or subnets, and don't expose the endpoint directly to the public internet.
- The OpenAI-compatible base URL, including the API root such as `/v1`, and the exact model ID that the endpoint expects.
- A short-lived, least-privilege API key that the endpoint requires. Rotate the key according to your organization's policy, and revoke it when you no longer use the endpoint. This procedure doesn't cover other authentication methods.
- HTTPS for the remote connection. The Windows client must trust the endpoint's TLS certificate, and the endpoint hostname must match the certificate.

## Install Intelligent Terminal Preview on the Windows client

1. Open PowerShell as the user who will run Intelligent Terminal Preview.

1. Install the `Microsoft.IntelligentTerminal` package:

   ```powershell
   winget install --id Microsoft.IntelligentTerminal --exact
   ```

   WinGet installs Intelligent Terminal Preview as a separate app alongside Windows Terminal.

1. Start **Intelligent Terminal** from the Start menu.

1. On first launch, select **GitHub Copilot** or **OpenCode** as the agent, and complete the agent's setup prompts.

## Add the Windows Server-hosted endpoint in Intelligent Terminal Preview

1. Open the Intelligent Terminal dropdown menu, and then select **Settings**.

1. In **Settings**, select **Agents**.

1. Confirm that you selected **GitHub Copilot** or **OpenCode** as the agent. In Intelligent Terminal Preview, the **GitHub Copilot** label represents the installed GitHub Copilot CLI agent/provider. Other built-in agents don't support the shared custom OpenAI-compatible provider in Intelligent Terminal Preview.

1. Expand **Custom endpoint or local model**, and then select **Add New**.

1. Enter the endpoint settings:

   | Setting | Value |
   | --- | --- |
   | **Base URL** | The OpenAI-compatible API root, such as `https://inference.contoso.com/v1`. Don't enter the full `/chat/completions` route. |
   | **Model ID** | The exact model name that the endpoint expects. |
   | **API key (optional)** | Enter the API key that the endpoint requires. Don't use a keyless endpoint for remote connections. |

   Intelligent Terminal Preview stores an API key in Windows Credential Manager rather than in its settings file. To rotate the key, remove the custom endpoint and add it again with the replacement key. When you no longer use the endpoint, remove the custom endpoint and revoke its API key at the endpoint.

1. Select **Add and Select**.

   Intelligent Terminal Preview adds the model and selects it as the current model. In the model picker, a custom model appears as `<model-id> (BYOK)`, where `BYOK` means bring your own key.

## Verify the Intelligent Terminal Preview Windows Server-hosted endpoint configuration

1. Close **Settings**, and then press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>.</kbd> to open the **Agent Pane**.

1. Enter `/model` to open the model picker, and confirm that the model picker shows `<model-id> (BYOK)` as the current model. Select the model if another model is active.

1. Enter this low-risk test prompt:

   ```text
   Suggest a PowerShell command that lists running services without changing the system. Explain the command, but don't run it.
   ```

1. Confirm that the **Agent Pane** displays a response and identifies the model that you configured. A response verifies that the agent you selected can send a Chat Completions request to the endpoint and receive output from that model.

> [!IMPORTANT]
> Don't turn on automatic approval while you evaluate a model. Before you run a command that the model generates, verify the executable, parameters, paths, current directory, target systems, required privileges, and expected changes. Use the least-privileged account that can complete the task, and don't run a command that you don't understand. Intelligent Terminal Preview can present a command for you to run, insert, copy, or dismiss; treat your approval as the final safety boundary.

## Troubleshoot connections to the Intelligent Terminal Preview Windows Server-hosted endpoint

| Issue | Resolution |
| --- | --- |
| **Custom endpoint or local model** reports that it doesn't support the selected agent | Select GitHub Copilot or OpenCode under **Agents**. Saved custom endpoints remain available when you switch to a supported agent. |
| **Add and Select** isn't available | Enter both the OpenAI-compatible API root in **Base URL** and the exact model name in **Model ID**. |
| The agent can't connect to the endpoint | From the Windows client, confirm DNS resolution, TCP port access, firewall rules, the `/v1` API root, and TLS certificate trust. On Windows Server, confirm that the endpoint listens on the expected network interface and port. Don't append `/chat/completions` to **Base URL**. |
| The endpoint returns an authentication error | Confirm that the endpoint accepts API-key authentication and that the key is current. If Intelligent Terminal reports a missing API key, remove the custom endpoint and add it again with the key. |
| The endpoint rejects the model | Confirm that **Model ID** exactly matches the identifier that the endpoint expects. Intelligent Terminal doesn't discover or correct model IDs in this flow. |
| The endpoint accepts the connection but the prompt fails | Confirm that the endpoint implements the OpenAI-compatible Chat Completions request that the selected agent uses. Review the endpoint logs for unsupported request fields, streaming responses, tool calls, or model capabilities. |

For product updates and current limitations, see the [Intelligent Terminal repository](https://github.com/microsoft/intelligent-terminal) and [Intelligent Terminal releases](https://github.com/microsoft/intelligent-terminal/releases).