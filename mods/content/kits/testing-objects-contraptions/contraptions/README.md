# How to Mod Contraptions

### Object Names Are Important

Object names, in many cases, determine how an object behaves. You can tell if an object is named for operation if the first word is followed by an underscore. Example:

Activator_1

In cases where two words are used, the convention is:

TwoWords_<value>

---

### Pay Attention to Physics Layers and Node Metadata

Area3D, RigidBody3D, and StaticBody3D each have different layers assigned based on their operation. If these are not set correctly, you may see strange behavior in the editor, such as objects flying toward the camera when selected. This is caused by raycasts hitting unintended colliders, snapping the object closer with every frame.

### Node Metadata

Node metadata (found at the bottom of the Inspector) can be used to store small configuration values or behavioral directives.

This is commonly used to define how a node participates in a system without requiring additional scripts.

**Example:**

A button may include metadata such as:

- `activate = 1`
- `activate = 2`

This allows the button to specify which activation channel it responds to, enabling multiple independent interactions within the same object.

> Metadata is optional and non-binding — systems can choose to read and interpret it as needed.

### Simply Mod for Best Results

Each included item is a base example of its class setup (e.g., Grenade, Hopper).

For consistent results, simply:
- Swap out meshes  
- Modify colliders  
- Follow the existing conventions when adding anything new  

Build by modifying existing objects rather than starting from scratch. Building from scratch is not recommended until you are very familiar with the modding system.
