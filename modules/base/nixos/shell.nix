{
  config = {
    # Zshell
    programs.zsh = {
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "man"
        ];
        theme = "agnoster";
      };
    };
  };
}
