## ComfyUI
```sh
git clone https://github.com/comfyanonymous/ComfyUI --depth=1
cd ComfyUI
nix flake init -t github:Nirlvy/nix-templates#comfyui

# use direnv
direnv allow
# or nix develop
nix develop
# then
comfyui
```
