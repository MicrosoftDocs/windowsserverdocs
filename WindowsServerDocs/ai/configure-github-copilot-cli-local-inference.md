---
title: GitHub Copilot CLI Local Inference Setup
description: Connect GitHub Copilot CLI on a Windows client to an OpenAI-compatible inference endpoint on Windows Server, and verify model access.
author: robinharwood
ms.author: roharwoo
ms.date: 09/25/2026
ms.topic: install-set-up-deploy
ms.service: windows-server
ai-usage: ai-assisted
#customer intent: As a developer or administrator, I want to connect GitHub Copilot CLI on a Windows client to an existing Windows Server inference endpoint so that I can access my organization's local model from my terminal.
---

# Connect GitHub Copilot CLI to a Windows Server inference endpoint

GitHub Copilot CLI is an AI coding agent that can send model requests from a supported Windows client to an OpenAI-compatible inference endpoint hosted on Windows Server. This configuration lets you use an organization-hosted model from your terminal while Windows Server centralizes model hosting and compute.

This article shows you how to configure the client connection and verify that the configured model responds. It doesn't deploy or secure the inference service.

## Prerequisites

- A client computer that runs a Windows version that GitHub Copilot CLI supports, with:
  - PowerShell 6 or later.
  - [Windows Package Manager (WinGet)](/windows/package-manager/winget/).
- An active GitHub Copilot subscription. If an organization or enterprise provides your subscription, its administrator must permit GitHub Copilot CLI.
- A trusted working directory from which to start GitHub Copilot CLI.
- An existing OpenAI-compatible endpoint on Windows Server that:
   - Is reachable from the client computer.
   - Requires authentication. This procedure applies to remote Windows Server connections. Reserve endpoints without authentication for loopback-only scenarios outside this procedure.
   - Listens only on the intended server network interface, allows inbound connections only from authorized client computers or subnets, and doesn't accept direct connections from the public internet.
   - Supports streaming and tool or function calling. OpenAI compatibility alone doesn't guarantee support for every GitHub Copilot CLI capability. Verify the endpoint and selected model capabilities with the endpoint operator.
- A Windows-client-to-Windows-Server network connection that has:
   - A DNS name for the Windows Server inference endpoint that resolves from the client computer.
   - A network route and firewall rules that permit only authorized clients or subnets to connect to the endpoint port.
   - An HTTPS certificate that the client trusts and whose subject name or subject alternative name matches the endpoint DNS name.
- The endpoint base URL, such as `https://inference.contoso.com/v1`.
- The endpoint credential and authentication type that the endpoint operator specifies.

## Install GitHub Copilot CLI

1. Open PowerShell.

1. Install the stable GitHub Copilot CLI package:

   ```powershell
   winget install GitHub.Copilot
   ```

1. Confirm that the installation succeeds:

   ```powershell
   copilot --version
   ```

   The command returns the installed GitHub Copilot CLI version.

## Get a model ID from the Windows Server inference endpoint

1. Set the base URL that the endpoint operator provided:

   ```powershell
   $BaseUrl = 'https://inference.contoso.com/v1'
   ```

1. Enter the API key or bearer token that the endpoint operator specifies. Use a short-lived, least-privilege credential. When your organization provides an approved secret-store command, use it to retrieve the credential instead of entering it directly. The following command converts the `SecureString` value to the plaintext `$endpointCredential` value, which remains in memory for this PowerShell session.

   ```powershell
   $secureEndpointCredential = Read-Host 'Enter the endpoint credential' -AsSecureString
   $endpointCredential = [System.Net.NetworkCredential]::new('', $secureEndpointCredential).Password
   ```

1. Send a `GET` request to `$BaseUrl/models`. Include `$endpointCredential` in an `Authorization: Bearer` header, and read each model ID from the response's `data` array:

   ```powershell
   $requestParameters = @{
      Uri = "$BaseUrl/models"
      Method = 'Get'
   }

   try {
      $requestParameters.Headers = @{ Authorization = "Bearer $endpointCredential" }
      $models = Invoke-RestMethod @requestParameters
      $models.data | Select-Object -ExpandProperty id
   }
   finally {
      $requestParameters.Headers = $null
   }
   ```

   The command returns one or more model IDs. Copy the exact ID of a model that supports streaming and tool or function calling.

## Configure the GitHub Copilot CLI provider and model

1. Set `$BaseUrl` to the Windows Server endpoint base URL and `$endpointCredential` to its API key or bearer token. In the same PowerShell session, set the provider type, endpoint base URL, and exact model ID. Replace `<MODEL_ID>` with an ID that the Windows Server endpoint returns.

   ```powershell
   $env:COPILOT_PROVIDER_TYPE = 'openai'
   $env:COPILOT_PROVIDER_BASE_URL = $BaseUrl
   $env:COPILOT_MODEL = '<MODEL_ID>'
   ```

   The `openai` provider type supports OpenAI-compatible endpoints, including vLLM.

1. Clear any provider authentication variables that the current PowerShell session inherited:

    ```powershell
    Remove-Item Env:COPILOT_PROVIDER_API_KEY, Env:COPILOT_PROVIDER_BEARER_TOKEN, Env:COPILOT_PROVIDER_API_KEY_COMMAND -ErrorAction SilentlyContinue
    ```

1. Configure the authentication method that the endpoint operator specified:

   - For standard OpenAI API-key authentication, use an organization-approved secret-store command whenever one is available:

      ```powershell
      $env:COPILOT_PROVIDER_API_KEY_COMMAND = '<APPROVED_SECRET_STORE_COMMAND>'
      ```

     The command must retrieve the credential from an approved secret store, output only the credential, and not log or persist it. `COPILOT_PROVIDER_API_KEY_COMMAND` takes precedence over `COPILOT_PROVIDER_API_KEY`.

   - If no approved secret-store command is available, set the API key directly as a short-lived fallback for the current PowerShell session:

      ```powershell
      $env:COPILOT_PROVIDER_API_KEY = $endpointCredential
      ```

   - For bearer-token authentication, set the bearer token:

      ```powershell
      $env:COPILOT_PROVIDER_BEARER_TOKEN = $endpointCredential
      ```

   > [!IMPORTANT]
   > Don't put API keys in scripts, source control, or command examples. `copilot` and any processes that it starts inherit provider authentication environment variables. Use short-lived, least-privilege credentials, and remove the variables after you exit GitHub Copilot CLI.

1. Review the supported provider variables in your installed version:

   ```powershell
   copilot help providers
   ```

## Start and verify GitHub Copilot CLI

1. Change to a directory whose files you trust:

   ```powershell
   Set-Location 'C:\path\to\trusted-project'
   ```

> [!IMPORTANT]
> If you stop before you start `copilot`, or an earlier command fails, remove the provider authentication variables, clear the request headers, and dispose the secure credential before you close PowerShell:
>
> ```powershell
> if ($requestParameters) {
>    $requestParameters.Headers = $null
> }
>
> Remove-Item Env:COPILOT_PROVIDER_API_KEY, Env:COPILOT_PROVIDER_BEARER_TOKEN, Env:COPILOT_PROVIDER_API_KEY_COMMAND -ErrorAction SilentlyContinue
>
> if ($secureEndpointCredential) {
>    $secureEndpointCredential.Dispose()
> }
> ```
>
> Close the PowerShell session after the cleanup runs. The immutable plaintext `$endpointCredential` string remains in memory until the process exits.

1. Start GitHub Copilot CLI and run the verification steps in a `try` block so that PowerShell removes provider authentication environment variables and disposes the `SecureString` value when you exit or the command fails:

   ```powershell
   try {
      copilot
   }
   finally {
      if ($requestParameters) {
         $requestParameters.Headers = $null
      }

      Remove-Item Env:COPILOT_PROVIDER_API_KEY, Env:COPILOT_PROVIDER_BEARER_TOKEN, Env:COPILOT_PROVIDER_API_KEY_COMMAND -ErrorAction SilentlyContinue

      if ($secureEndpointCredential) {
         $secureEndpointCredential.Dispose()
      }
   }
   ```

1. Confirm the trusted-directory prompt. Trust the directory for future sessions only if you control its contents and expect it to remain trusted.

1. If GitHub Copilot CLI prompts you, enter `/login` and follow the instructions to authenticate to GitHub. GitHub authentication is separate from the API key that authenticates to the inference endpoint.

1. Enter this test prompt:

   ```text
   Reply with exactly: Local inference test succeeded
   ```

   The configured model on the Windows Server endpoint returns `Local inference test succeeded` without a provider, authentication, or model compatibility error. After you exit GitHub Copilot CLI, PowerShell runs the `finally` block. PowerShell can't reliably erase the immutable plaintext `$endpointCredential` string from memory, so close the PowerShell session after the command completes to release the process memory.

## Troubleshoot GitHub Copilot CLI connections to a Windows Server inference endpoint

| Issue | What to check |
|---|---|
| The models request can't reach the endpoint | Verify the endpoint base URL, DNS resolution, port, network route, service status, and TLS certificate trust. The base URL should include the API prefix that the endpoint operator provides, such as `/v1`. |
| The models request returns `401` or `403` | Verify that the credential is valid. For API-key authentication, prefer `COPILOT_PROVIDER_API_KEY_COMMAND` with an approved secret-store command. Use `COPILOT_PROVIDER_API_KEY` only as a short-lived fallback. For bearer-token authentication, set `COPILOT_PROVIDER_BEARER_TOKEN`, as the endpoint operator specifies. |
| GitHub Copilot CLI uses a different provider or model | Set the provider type, base URL, model, and selected authentication variable in the same PowerShell session that starts `copilot`. Use the exact model ID that the endpoint returns. Also check `$HOME\.copilot\providers.json`; that file's provider or model declarations take precedence over the `COPILOT_PROVIDER_*` variables. |
| GitHub Copilot CLI can't find the model | Query `$BaseUrl/models` again and compare the `COPILOT_MODEL` value with the `id` value that the endpoint returns, including capitalization and punctuation. |
| The prompt fails after the endpoint accepts the request | Confirm that the model and endpoint support both streaming and tool or function calling. Review the endpoint logs for an unsupported request field, tool schema, context limit, or response format. |

## Related content

- [About GitHub Copilot CLI](https://docs.github.com/copilot/concepts/agents/copilot-cli/about-copilot-cli)
- [Installing GitHub Copilot CLI](https://docs.github.com/copilot/how-tos/copilot-cli/set-up-copilot-cli/install-copilot-cli)
- [GitHub Copilot CLI command reference](https://docs.github.com/copilot/reference/copilot-cli-reference/cli-command-reference)