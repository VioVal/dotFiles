# The work laptop. Same as the old laptop's configuration.nix, except:
# niri + Noctalia instead of GNOME, and no LaTeX (Overleaf now).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan (copy it from the new laptop's /etc/nixos).
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Login screen, then niri with Noctalia on top.
  services.displayManager.gdm.enable = true;
  programs.niri.enable = true;

  # Keyboard layout. niri reads it from here as long as its own xkb section is empty.
  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "es";

  # GNOME switched these on by itself; niri doesn't.
  # Noctalia needs the first three for its Bluetooth, battery and power-profile widgets.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false; # radio starts off; switch it on in Noctalia
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.udisks2.enable = true; # USB sticks
  services.gvfs.enable = true; # trash and mounts in the file manager
  services.avahi = { # finds network printers
    enable = true;
    nssmdns4 = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."vioval" = {
    isNormalUser = true;
    description = "Chris";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
       kitty
       zsh
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Desktop
    noctalia
    xwayland-satellite # niri starts it when an X11 app opens
    brightnessctl # niri's default brightness keys call it
    nautilus # file manager (GNOME's Files)

    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    kitty
    vscode
    cargo
    rustc
    zip
    unzip
    git
    gh
    discord-ptb
    prismlauncher
    unityhub
    (python3.withPackages (ps: with ps; [
      matplotlib
      seaborn
      numpy
      pandas
      requests
      prometheus-api-client
      python-dateutil
      influxdb-client
      dateparser
      pyarrow            # core/formatter.py writes parquet
      rich               # cli/main.py
      click              # cli/main.py
      jupyterlab
    ]))

  ];

  programs.nix-ld.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
