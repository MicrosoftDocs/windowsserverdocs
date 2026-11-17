---
title: Connect Visual Studio Code to a Windows Server Token factory endpoint
description: Connect Visual Studio Code on a Windows client to an OpenAI-compatible Windows Server Token factory endpoint, and verify model access.
ms.topic: install-set-up-deploy
author: robinharwood
ms.author: roharwoo
ms.service: windows-server
ms.date: 11/16/2026
ai-usage: ai-assisted

#customer intent: As a developer, I want to connect Visual Studio Code on a Windows client to an existing Windows Server Token factory endpoint so that I can use my organization's model in chat.
---

# Connect Visual Studio Code to a Windows Server Token factory endpoint

Visual Studio Code can connect the **Chat** view on a Windows client to an OpenAI-compatible token factory endpoint hosted on Windows Server. This configuration lets you use an organization-hosted model in Visual Studio Code while Windows Server centralizes model hosting and compute.

In this article, you add an existing Windows Server Token factory endpoint as a custom endpoint in Visual Studio Code, select its model, and verify that the model responds. The procedure doesn't deploy or secure the token factory endpoint.

## Prerequisites

- [Download the current stable release of Visual Studio Code](https://code.visualstudio.com/download), and ensure that you can access the **Chat** view.
- An existing Windows Server Token factory endpoint that supports the OpenAI-compatible Chat Completions API and is reachable from the computer running Visual Studio Code.
- Network connectivity from the Windows 11 client to the server and endpoint port. Configure Windows Firewall and any intervening firewall or proxy to permit the connection. Configure the endpoint to listen on a network interface that remote clients can reach, not only on a loopback address.
- A Domain Name System (DNS) record that the Windows 11 client can resolve to the Windows Server host.
- A valid TLS certificate that the Windows 11 client trusts and whose subject name or subject alternative name matches the host name in the endpoint URL.
- Endpoint access controls that permit the Windows 11 client to call the Chat Completions route. Obtain any required API key or token from the endpoint administrator.
- A trusted HTTPS URL, such as `https://<server-name>:<port>/v1/chat/completions`.
- The exact model ID; a model display name, which Visual Studio Code shows in the **language model picker**; context limits; and supported capabilities from the endpoint owner or model documentation.
- The authentication header requirements for the endpoint.
- If your organization manages GitHub Copilot, it must enable the **Bring Your Own Language Model Key in VS Code** policy. For more information, see [Bring your own language model key in VS Code](https://code.visualstudio.com/docs/agent-customization/language-models#_bring-your-own-language-model-key).

You don't need a GitHub account or a GitHub Copilot plan to use a bring-your-own-key model in chat. The custom endpoint doesn't provide features that depend on the GitHub Copilot service, including inline suggestions, semantic search, and embeddings.

## Add the Windows Server Token factory endpoint

Visual Studio Code connects to the Windows Server Token factory through its OpenAI-compatible endpoint URL.

1. In Visual Studio Code, open the **Chat** view.
1. Open the **language model picker**, and then select **Manage Language Models** (**gear icon**).

   You can also open the **Command Palette** and run **Chat: Manage Language Models**.

1. In the **Language Models** editor, select **Add Models**, and then select **Custom Endpoint**.
1. Enter a group name. This name identifies the endpoint's models in the **language model picker** and the **Language Models** editor.
1. Enter the model display name and the API key for the endpoint.
1. For the API type, select **Chat Completions**.
1. In the `chatLanguageModels.json` file that Visual Studio Code opens, configure the model properties, and then save the file.

   Use the endpoint and model documentation to set the properties. At minimum, confirm the following values:

   | Property | Value |
   |---|---|
   | `id` | The exact model ID that the endpoint expects. |
   | `name` | The model display name that Visual Studio Code shows in the **language model picker**. |
   | `url` | The full route, such as `https://<server-name>:<port>/v1/chat/completions`. |
   | `apiType` | `chat-completions` |
   | `toolCalling` | `true` only if the endpoint and model support tool calling. |
   | `vision` | `true` only if the endpoint and model support image input. |
   | `maxInputTokens` | The model's supported maximum input token count. |
   | `maxOutputTokens` | The model's supported maximum output token count. |

   Keep the generated `apiKey` input reference instead of placing the API key directly in `chatLanguageModels.json`. Visual Studio Code sends the key in an `Authorization: Bearer <api-key>` header by default for Chat Completions custom endpoints.

   If the endpoint requires a different authentication header, configure the model's `requestHeaders` property and use the `${apiKey}` token as the header value. Don't place a raw secret in the configuration file. For the supported properties and authentication behavior, see [Custom Endpoint configuration reference](https://code.visualstudio.com/docs/agent-customization/language-models#_custom-endpoint-configuration-reference).

## Select and verify the token factory model

1. Return to the **Chat** view and open the **language model picker**.
1. Select the model under the group name that you configured.
1. Enter a short test prompt, such as:

   ```text
   Reply with one sentence that confirms you received this request.
   ```

1. Confirm that the **Chat** view displays a response from the selected model.
1. If you have access to the inference endpoint logs, confirm that the endpoint received the request for the configured model ID.

The configuration is working when the selected model returns a response and the endpoint records the request.

> [!NOTE]
> A model must support tool calling to be available for agents in chat. Don't set `toolCalling` to `true` unless the endpoint and model support that capability.

## Troubleshoot the Visual Studio Code connection to the Windows Server Token factory endpoint

| Issue | What to check |
|---|---|
| **Custom Endpoint** isn't available | Update to the current stable release of Visual Studio Code. If your organization manages GitHub Copilot, confirm that your organization enables the bring-your-own-key policy. |
| The model doesn't appear in the model picker | Save `chatLanguageModels.json`, and then restart Visual Studio Code. In a workspace in **Restricted Mode**, trust the workspace to restore the full model list. For agent use, also confirm that the model supports tool calling and that `toolCalling` is `true`. |
| The endpoint returns an authentication error | Confirm that the API key is current and that its authentication header matches the endpoint requirements. If the endpoint requires another header, configure `requestHeaders` with the `${apiKey}` token. |
| The endpoint returns a route or API error | Confirm that `apiType` is `chat-completions` and that `url` contains the full Chat Completions route, including `/v1/chat/completions` when the endpoint exposes that route. |
| A remote client can't connect to the endpoint | Confirm that the Windows 11 client can resolve the server host name and reach the endpoint port. Check the endpoint listener address, Windows Firewall, and any intervening firewall or proxy. |
| A remote endpoint returns a TLS or certificate error | Confirm that the certificate is valid, that the Windows 11 client trusts it, and that it covers the host name in the endpoint URL. |
| The endpoint denies a remote client | Confirm that the endpoint access controls permit the client to call the Chat Completions route and that the configured credential has access to the requested model. |
| The request reaches the endpoint but inference fails | Confirm that the model ID exactly matches the endpoint's model ID and that the endpoint supports the requested model capabilities. Review the endpoint logs for the request failure. |

## Related content

- [AI language models in Visual Studio Code](https://code.visualstudio.com/docs/agent-customization/language-models)
