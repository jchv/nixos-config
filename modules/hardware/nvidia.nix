{
  config = {
    hardware = {
      nvidia = {
        open = true;
        modesetting.enable = true;
      };
      opengl = {
        enable = true;
        driSupport32Bit = true;
      };
      i2c.enable = true;
    };
  };
}
