# Install PixelPerfect Studio in ChatGPT

This guide is written for someone who has never installed a ChatGPT plugin before.

## Before you start

You need:
- A ChatGPT account.
- The ability to install and use plugins in that account.
- The PixelPerfect Studio ZIP file downloaded from this repository's Releases page.

**Important:** OpenAI can change which plans, accounts, and ChatGPT clients support plugin installation. If you do not see an installation option, the feature may not be available to your account or client. Do not buy another subscription just for this guide without checking current availability first.

## Step 1: Download the correct file

1. Open the [PixelPerfect Studio Releases page](https://github.com/pikadexofc/pixelperfect-studio/releases).
2. Open the latest stable release.
3. Find **PixelPerfect-Studio-Plugin-1.0.0.zip** under its Assets.
4. Tap or click the ZIP file to download it.
5. Keep the downloaded file as it is. **Do not unzip it.**

### Choose the release asset, not source code

GitHub may also show files named **Source code (zip)** and **Source code (tar.gz)**.

Do not download those. They are automatically generated repository snapshots, not the installable plugin package.

## Step 2: Open the plugin installation area

1. Open ChatGPT and sign in.
2. Open the Plugins area or the plugin installation page available in your account.
3. Choose the option to create, add, or install a plugin.
4. Continue until ChatGPT asks you to provide a plugin ZIP archive.

The exact labels can change as ChatGPT updates its interface. Follow the option that asks you to upload or import a plugin archive.

**Do not see a plugin installation option?** Check the current capabilities of your ChatGPT account and client. This is an account availability issue, not something fixed by renaming or extracting the ZIP.

## Step 3: Upload the plugin ZIP

1. Tap the upload or import button.
2. Open your device's Downloads folder if a file picker appears.
3. Select **PixelPerfect-Studio-Plugin-1.0.0.zip**.
4. Confirm the selection.
5. Wait for ChatGPT to check the archive.
6. Follow any confirmation prompts shown by ChatGPT.

Leave the ZIP compressed. Do not open it, extract it, or upload individual files from inside it.

## Step 4: Open a new conversation

1. Start a new ChatGPT conversation.
2. Select PixelPerfect Studio if your ChatGPT interface asks you to choose a plugin.
3. Make sure the plugin is enabled for that conversation.

If the plugin does not appear, revisit the installation area and check whether the archive import completed successfully.

## Step 5: Upload your image

Upload the poster, slide, cover, graphic, or other visual you want to reconstruct.

Then paste this prompt:

```text
Turn this image into editable layered HTML at its original size.

Separate every meaningful visual component into its own independently addressable layer. Extract source visuals where possible and generate individual PNG assets when needed. Identify the exact fonts or recover the visible letterforms if the fonts are unavailable.

Preserve the original composition and dimensions. Render and inspect the result, correct visible defects, and deliver only the final verified standalone HTML.
```

## Step 6: Download your result

When the reconstruction is finished, download the final standalone HTML file provided by PixelPerfect Studio.

Open that HTML file in a modern browser to view the fixed-size design.

The intended customer handoff is one standalone HTML file. You do not need to download a source-code repository, install Codex, open an IDE, or run terminal commands.

## If something goes wrong

### ChatGPT says the archive is invalid

- Check that you selected **PixelPerfect-Studio-Plugin-1.0.0.zip** from the release Assets.
- Do not use GitHub's **Source code (zip)** download.
- Do not extract or repackage the release ZIP.
- Download the release asset again if the file appears incomplete.

### The plugin installs but does not appear in a chat

- Start a fresh conversation.
- Look for the plugin selection or enable control.
- Confirm the installation is present in your ChatGPT account.
- Check whether your current ChatGPT client supports the feature.

### Image generation or rendering is unavailable

The plugin can only use capabilities exposed by the active ChatGPT session. It should tell you when a particular capability is unavailable and what could not be verified. It must not claim that an image was generated or a visual render was inspected if that did not happen.

### The HTML looks different on another device

Different browsers and installed fonts can render some details differently. The HTML preserves a fixed artboard rather than rearranging the design for mobile screens. Open it in a modern desktop browser when reviewing the full-size composition.

## Need help?

[Report an installation or usage issue](https://github.com/pikadexofc/pixelperfect-studio/issues/new)

[Download the latest release](https://github.com/pikadexofc/pixelperfect-studio/releases)

[**Fund the production**](https://mdzobaedislamshanto.supportkori.shop/)

A GitHub star is appreciated if PixelPerfect Studio helps your workflow. A star is not required to access the download.
