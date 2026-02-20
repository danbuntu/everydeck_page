# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Page** is a minimal single-page web browser for Linux. It displays exactly one URL in fullscreen mode.

### Requirements
- JavaScript support required
- Linux only
- Launched from CLI with URL as argument: `page <url>`
- Absolute minimal RAM and CPU usage — this is the primary design constraint

### Technology Guidance

Prefer lightweight approaches over heavy frameworks. Good candidates for the rendering engine:
- **WebKitGTK** (C/Python) — lightweight, full JS support, GTK integration
- **Servo embeddings** or **CEF** if WebKit proves insufficient

Avoid Electron, Chromium-based solutions, or anything with a large runtime footprint.

## Implementation

Python 3 + WebKitGTK (via PyGObject). Single-file executable at `page`.

### Dependencies
- `python3`, `gir1.2-webkit2-4.1`, `python3-gi` (Ubuntu/Debian)
- Install all: `./install.sh`

### Usage
```
page <url>          # opens URL fullscreen
page example.com    # https:// is prepended automatically
```
