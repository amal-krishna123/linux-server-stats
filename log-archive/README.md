# Log Archive CLI Tool

A lightweight, automated Bash utility designed to archive and compress system or application log directories. This tool optimizes server storage space by bundling logs into highly compressed `.tar.gz` files, moving them to a secure centralized archive directory, and maintaining a chronological audit history.

## How It Works



The script follows a sequential, failure-resistant pipeline:
1. **Input Validation:** Verifies that a target log directory was provided as a command-line argument and confirms its structural existence.
2. **Dynamic Timestamping:** Generates an immutable tracking ID based on the execution date and exact time.
3. **Isolation Compression:** Changes context to the target directory to prevent nesting absolute file paths, then runs a high-ratio gzip compression stream.
4. **Audit Logging:** Appends a historical log entry tracking the archival action to an internal tracking registry.

## Features

- **Dynamic Argument Ingestion:** Accepts any arbitrary directory path directly from the command line interface.
- **Collision-Proof Filenames:** Appends human-readable timestamps formatted to the second (`YYYYMMDD_HHMMSS`) to prevent archiving overrides.
- **Storage Optimization:** Leverages native Unix `tar` and `gzip` utilities to reduce plaintext log sizes by up to 90%.
- **Persistent History Log:** Keeps a clean tracking log file tracking execution timestamps and generated archive filenames.

## Prerequisites

The tool functions out-of-the-box on any Unix-like subsystem (Linux, macOS, WSL) and relies entirely on standard system binaries:
- `bash` (Version 4.0+)
- `tar`
- `gzip`

## Installation & Setup

1. Navigate to your local project directory or clone your repository:
   ```bash
   cd ~/your-project-directory
