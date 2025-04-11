{
  description = "A collection of flake templates";

  outputs =
    { self }:
    {
      templates = {

        comfyui = {
          path = ./comfyui;
          description = "comfyui env";
          welcomeText = ''
            - run `direnv allow` or `nix develop`
            - then run `comfyui`
          '';
        };

        python = {
          path = ./python;
          description = "python env";
        };

        python-cuda = {
          path = ./python-cuda;
          description = "python and cuda env";
        };

      };
    };
}
