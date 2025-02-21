{
  config = {
    programs.ssh = {
      startAgent = true;
      enableAskPassword = true;
    };
  };
}
