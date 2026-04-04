# Item Categories

Item categories define how an asset is expected to behave within the engine.

These are not just labels — they are **behavioral contracts**.  
Choosing the correct category ensures compatibility with systems, performance expectations, and mod interoperability.

> If unsure, choose the category based on what the object **does**, not what it looks like.

---

## NONE

Fallback category.

- Automatically treated as **MISC**
- Used when:
  - A category is missing
  - An error occurs in configuration

This should not be used intentionally.

---

## SMALL_BLOCKS

Core building units.

- Grid-aligned (typically 1x1 or smaller)
- Highly repeatable
- Used to construct most player-built structures

**Examples:**
- Cubes
- Panels
- Structural pieces

---

## LARGE_BLOCKS

Space-filling assets for performance and layout.

- Represent large areas with a single object
- Reduce object count
- Used for environment blocking and structure shells

**Examples:**
- Buildings
- Large terrain sections

---

## BASE_PLATES

Foundational surfaces.

- Ground, floors, ceilings
- Typically static and non-movable
- Organized separately for convenience

**Examples:**
- Roads
- Foundations
- Concrete slabs

---

## PREFABS

Pre-configured asset compositions.

- Collections of multiple assets
- Do **not** include world state (time, weather, etc.)
- Function like reusable saved builds

**Examples:**
- Houses
- Street sections
- Prebuilt systems

---

## DOORS_WINDOWS

Structured interactive elements.

- Limited, predictable behavior
- Designed for specific placements (frames/openings)
- Not fully moddable like contraptions

**Examples:**
- Doors
- Windows
- Breakable panels

---

## PROPS

Decorative or static objects.

- Visually distinct
- Minimal or no interaction
- Not part of gameplay systems

**Examples:**
- Furniture
- Decorative machinery

---

## CONTRAPTIONS

Behavior-driven systems.

- Core gameplay objects
- Defined by logic and functionality
- Highly moddable via API and scripting

**Examples:**
- Hoppers
- Generators
- Explosives
- Machines

---

## PHYSICS_OBJECTS

Physics-driven entities.

- Intended to move, collide, and react
- Governed primarily by physics simulation
- Not system-driven like contraptions

**Examples:**
- Barrels
- Balls
- Debris

---

## DECALS

Surface detail layers.

- Applied onto other objects
- Used to break visual repetition
- Can be static or dynamic

**Examples:**
- Graffiti
- Hazard markings
- Labels

---

## SPAWNABLES

Temporary or consumable objects.

- Spawned and removed during gameplay
- Often tied to resource or gameplay loops
- May or may not use physics

**Examples:**
- Food
- Ammo
- Tools
- Weapons

---

## SPAWNERS

Invisible logic controllers.

- Visible in editor, hidden in-game
- Define spawning rules and data
- Responsible for creating spawnables

**Examples:**
- Loot spawners
- Resource nodes
- Item generators

---

## MISC

Catch-all category.

- For edge cases or uncategorized assets
- Used when no other category fits

> If too many assets end up here, the category system is being misused.
