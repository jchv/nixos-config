{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; with libsForQt5; [
    ];
  };
}
