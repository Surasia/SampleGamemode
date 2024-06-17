# Empty Lua Project for Halo Infinite

This repository contains the necessary files to pack into a Halo Infinite gamemode. 
- `src/Empty.bin_lua`: Source code for an empty lua gamemode.
- `src/Empty.bin.xml`: Deserialized BOND container for gamemode metadata.

### Packing the Gamemode

[Soupstream's InfiniteVariantTool](https://github.com/soupstream/InfiniteVariantTool/releases/latest) allows for the bundling of lua scripts and the serialization of BOND files. 
- Packing the luabundle: `InfiniteVariantToolCLI luabundle pack .\src\Empty.bin_lua`
- Packing the BOND: `InfiniteVariantToolCLI bond pack .\src\Empty.bin.xml`