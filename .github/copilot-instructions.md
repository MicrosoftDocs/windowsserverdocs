# Windows Server Documentation Repository

The Windows Server documentation repository contains Microsoft's technical
documentation for Windows Server that publishes to Microsoft Learn. This is a
documentation-only repository using Microsoft's OpenPublishing platform with
DocFX for building content.

Always reference these instructions first and fallback to search or bash commands
only when you encounter unexpected information that does not match the info here.

## Working Effectively

### Prerequisites and Setup

- Install Visual Studio Code
- Install the [Docs Authoring Pack extension](https://marketplace.visualstudio.com/items?itemName=docsmsft.docs-authoring-pack)
- Install Node.js and npm (for markdown tooling)
- Install markdownlint: `npm install -g markdownlint-cli2`
- Set up GitHub account with proper Microsoft organization access
- Fork and clone the repository: `git clone https://github.com/[your-fork]/windowsserverdocs-pr`
- Add upstream remote: `git remote add upstream https://github.com/MicrosoftDocs/windowsserverdocs-pr`

### Repository Structure

```text
WindowsServerDocs/                 # Main content directory
├── administration/               # Server administration topics
├── get-started/                  # Getting started guides  
├── identity/                     # Identity and access management
├── manage/                       # Management tools and features
├── networking/                   # Network configuration and features
├── remote/                       # Remote Desktop and access
├── security/                     # Security features and guidance
├── storage/                      # Storage technologies
├── troubleshoot/                 # Troubleshooting guides
├── virtualization/               # Hyper-V and virtualization
├── docfx.json                    # DocFX build configuration
└── breadcrumbs/toc.yml          # Navigation breadcrumbs

Contributor-guide/                # Contributor documentation
├── create-new-using-github.md    # Creating new articles
├── edit-existing-using-github.md # Editing existing content
├── github-browser-updates.md     # Making minor edits via web
└── metadata-requirements-for-articles.md # Required metadata

.vscode/settings.json             # VSCode configuration with markdown lint rules
.openpublishing.publish.config.json # OpenPublishing build configuration
```

### Content Validation and Quality

- **NEVER CANCEL**: Content validation takes 5-15 minutes. NEVER CANCEL.
  Set timeout to 30+ minutes.
- Run markdown linting: `markdownlint-cli2 "**/*.md" "#node_modules" --config .vscode/settings.json`
- Check individual files: `markdownlint-cli2 "path/to/file.md"`
- Validate markup renders correctly using VS Code preview (Ctrl+Shift+V)
- Check for broken links and proper metadata

### Git Workflow Commands

- Create new branch: `git checkout -b [branch-name]`
- Check status: `git status`  
- Stage changes: `git add .`
- Commit with message: `git commit -m "descriptive message"`
- Pull upstream changes: `git pull upstream main`
- Push to your fork: `git push origin [branch-name]`
- Create pull request via GitHub web interface

### Required Article Structure

Every article must include:

```markdown
---
title: Required. Article title for SEO and search results
description: Required. Article description for search results
author: Required. Your GitHub username
ms.author: Required. Your Microsoft alias  
ms.date: MM/DD/YYYY
ms.topic: [reference|how-to|overview|tutorial|get-started|concept]
---

# Article Title (same as title in metadata)

Article content in markdown format...
```

## Validation Scenarios

### Content Quality Checks

- Verify all metadata is present and correct
- Check that article follows Microsoft Style Guide
- Ensure links work and point to current content
- Validate code examples and PowerShell commands are accurate
- Test that images display correctly and have alt text

### Markdown Validation Steps

1. Run `markdownlint-cli2 "**/*.md" "#node_modules"` - takes 10-15 minutes.
   NEVER CANCEL.
2. Fix any linting errors found (line length, headers, etc.)
3. Preview content in VS Code to ensure proper rendering
4. Test links manually or with link checker tools

### Publishing Workflow Validation  

- Content must pass OpenPublishing validation
- Metadata must conform to Microsoft Learn standards
- No broken internal or external links
- All images must be properly referenced and accessible
- Articles must be added to appropriate TOC files

## Build and Publishing

### Microsoft OpenPublishing System

- **Build Process**: Uses Microsoft's OpenPublishing platform (no local build)
- **Build Time**: Publishing validation takes 10-20 minutes. NEVER CANCEL.
  Set timeout to 30+ minutes.
- **Validation**: Content goes through automated validation for:
  - Markdown syntax correctness
  - Link validation
  - Metadata completeness
  - Image accessibility
  - Style guide compliance

### Testing and Validation Commands

- **Markdown linting**: `markdownlint-cli2 "**/*.md" "#node_modules"`
  (15 minutes, NEVER CANCEL)
- **Single file check**: `markdownlint-cli2 "path/to/file.md"`
- **Git validation**: `git status && git diff` (check changes before commit)
- **Link validation**: Use VS Code Docs Authoring Pack link validator

## Key Content Areas

### Major Documentation Sections

- **Administration**: Windows commands, performance tuning, server management
- **Identity**: Active Directory, authentication, certificates  
- **Networking**: DNS, DHCP, VPN, network policies
- **Security**: Security baselines, encryption, access control
- **Storage**: File systems, Storage Spaces Direct, backup
- **Virtualization**: Hyper-V, containers, virtual machines
- **Get Started**: Installation, what's new, licensing

### Important Files to Know

- `docfx.json`: Main build configuration for DocFX
- `breadcrumbs/toc.yml`: Site navigation structure
- `index.yml`: Landing page configurations
- Individual `toc.yml` files: Section-specific navigation
- `.openpublishing.publish.config.json`: Publishing configuration

### Common Content Patterns

- **Reference articles**: Command syntax, parameters, examples
- **How-to guides**: Step-by-step procedures with screenshots
- **Conceptual overviews**: Feature explanations and architecture
- **Troubleshooting**: Problem identification and resolution steps

## Contributing Workflow

### For Microsoft Employees

1. Clone `windowsserverdocs-pr` (private repo)
2. Create feature branch
3. Make changes using VS Code with Docs Authoring Pack
4. Validate content with markdown linting
5. Test article rendering with VS Code preview
6. Create pull request for review

### For External Contributors  

1. Contribute to `windowsserverdocs` (public repo)
2. Fork repository to personal account
3. Make changes and create pull request
4. Microsoft team reviews and merges to private repo

### Pull Request Validation

- All markdown must pass linting without errors
- Links must be valid and accessible
- Metadata must be complete and correct
- Content must follow Microsoft Style Guide
- Images must have proper alt text and captions

## Troubleshooting Common Issues

### Build Failures

- Check markdown syntax with `markdownlint-cli2`
- Validate all required metadata is present
- Ensure no broken links or missing images
- Check that new files are added to appropriate TOC files

### Content Issues

- Verify adherence to Microsoft Writing Style Guide
- Check that code examples are tested and accurate
- Ensure proper use of includes and shared content
- Validate cross-references point to existing content

### Git Issues

- Sync with upstream regularly: `git pull upstream main`
- Resolve merge conflicts in VS Code
- Use descriptive commit messages
- Keep branches focused on single features or fixes

Remember: This is a documentation repository, not software. Focus on content
quality, accuracy, and adherence to Microsoft documentation standards rather
than traditional software development practices.
