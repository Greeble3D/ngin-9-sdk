# NGIN#9 SDK Addon

This addon supports content development and export operations for NGIN#9.

> Full documentation is available in: `res://guides`

---

## Purpose

- Provides SDK-side support for **export operations**
- Handles **minor tasks not performed by the main game client**
- Complements (does not replace) the in-game SDK tools

---

## Core Workflow

- Most content creation is handled in the game client:
  - **Workshop → SDK**
- The client has direct access to engine classes, allowing it to:
  - Generate `.cfg` files
  - Build spawn tables
  - Ensure consistency across systems

- While configs can be edited manually:
  - This is **not recommended**
  - Use the in-client tools for reliability and consistency

---

## Creating Config Files

- In the SDK file tree:
  - **Double-click any supported file**
- This will:
  - Automatically create a matching `.cfg` file
- Then:
  - Select an appropriate **template**
  - Fill in required values

> Templates are the primary method for creating valid mod content.

---

## Mod Development Philosophy

- Mods should be built using:
  - **Predefined templates**
  - **Structured workflows**
- Avoid ad-hoc or manual configuration when possible

- Goals:
  - Consistency
  - Stability
  - Ease of use for modders

---

## Scripting Rules

- **Lua is the primary scripting language**
  - Uses the official API
  - Safe and controlled

- **GDScript is restricted**
  - Disabled by default in client-side plugins
  - Must be explicitly enabled by the user

> This restriction exists for security and stability.

---

## Summary

- Use the **game client SDK tools** for content creation
- Use this addon for:
  - Export operations
  - Supporting tasks outside the client
- Follow templates and API boundaries
- Avoid direct manipulation unless necessary
