{config, pkgs, ...}:

{
  imports = [home-modules/neovim];
  # Let Home Manager install and manage itself
  programs.home-manager.enable=true;

  home.username = "cornholio";
  home.homeDirectory = "/home/cornholio";

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    # Utilities
    ripgrep

    # Dropbox client
    maestral
    maestral-gui

    # Languages
    ## Haskell
    ghc

    ## Python
    python3

    ## Latex
    # texlive.combined.scheme-full

    ## Java
    # jdk17

    # Editors (and operating systems)
    # neovim
    emacs

    # Browser
    firefox

    # Passwords
    keepassxc

    # Theme (modularize with GTK!)
    dconf

    # Video playback
    mpv

    # PDF viewer
    zathura

    # torrent
    # transmission-gtk

    # Other
    # libreoffice

    # AI
    codex
    claude-code
  ];


  systemd.user.services.maestral = {
    Unit.Description = "Maestral daemon";
    Install.WantedBy = ["default.target"];
    Service = {
      ExecStart = "${pkgs.maestral}/bin/maestral start -f";
      ExecStop = "${pkgs.maestral}/bin/maestral stop";
      Restart = "on-failure";
      Nice = 10;
    };
  };


  xdg.enable = true;

  home.sessionVariables = {
    EDITOR="nvim";
    BROWSER="firefox";

    # XDG workarounds
    ## Less
    LESSHISTFILE="${config.xdg.configHome}/less";
    LESSKEY="${config.xdg.configHome}/less/keys";

    ICEAUTHORITY="${config.xdg.cacheHome}/ICEAuthority";

    ## Bash
    HISTFILE="${config.xdg.stateHome}/bash/history";

    ## Haskell
    CABAL_CONFIG="${config.xdg.configHome}/cabal/config";
    CABAL_DIR="${config.xdg.cacheHome}/cabal";
    STACK_ROOT="${config.xdg.cacheHome}/stack";

    ## Python
    PYTHONPYCACHEPREFIX="${config.xdg.cacheHome}/python";
    PYTHONUSERBASE="${config.xdg.dataHome}/python";

  };

  programs.xmobar.enable = true;

  home.file ={
    # Out of store symlinks for frequently changing configs
    # "${config.xdg.configHome}/alacritty".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/alacritty;
    # "${config.xdg.configHome}/keepassxc".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/keepassxc;
    # "${config.xdg.configHome}/fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/fish/config.fish;
    # "${config.xdg.configHome}/fish/functions".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/fish/functions;
    "${config.xdg.configHome}/alacritty".source = ./dotfiles/alacritty;
    "${config.xdg.configHome}/fish/config.fish".source = ./dotfiles/fish/config.fish;
    "${config.xdg.configHome}/fish/functions".source = ./dotfiles/fish/functions;
    "${config.xdg.configHome}/keepassxc".source = ./dotfiles/keepassxc;
    "${config.xdg.configHome}/xmonad".source = ./dotfiles/xmonad;
    "${config.xdg.configHome}/xmobar".source = ./dotfiles/xmobar;
};



  # Shell configurations
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "ls --color";
      mv = "mv -i";
      rebuild = "sudo nixos-rebuild switch --flake";
    };
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    autocd = true;
    defaultKeymap = "emacs";
      # dotDir = "${config.xdg.configHome}/zsh";
      # Annoying home-prepend issues don't allow the above
      dotDir = ".config/zsh";
      history = {
      # Long history
      extended = true;
      path= "${config.xdg.dataHome}/zsh/history";
    };

    zplug = {
      enable = true;
      zplugHome = "${config.xdg.dataHome}/zplug";
      plugins = [
        { name = "plugins/git"; tags = [ from:oh-my-zsh ]; }
        { name = "plugins/colored-man-pages"; tags = [ from:oh-my-zsh ]; }
        { name = "themes/xiong-chiamiov-plus"; tags = [ from:oh-my-zsh ]; }
      ];
    };
    initContent = ''
       function up_widget {
         BUFFER="cd .."
         zle accept-line
       }
       zle -N up_widget

       function prev_widget {
         BUFFER="cd $OLDPWD"
         zle acce-tline
       }
       zle -N prev_widget

       # Go to parent directory
       bindkey "^k" up_widget
       # Return to previous directory
       bindkey "^b" prev_widget
    '';
  };

  programs.rofi = {
    font = "Fira Code Regular 12";
    theme = "gruvbox-dark-soft";
  };

  # programs.alacritty = {
  #   enable = true;
  #   settings = (builtins.readFile ./dotfiles/alacritty/alacritty.toml);
  # };

  # programs.fish ={
  #   enable = true;
  #   interactiveShellInit =''
  #     set fish_greeting # disable greeting
  #   '';
  # };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true; 
  };


  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      # Neovim integration
      asvetliakov.vscode-neovim
      # Themes
      dracula-theme.theme-dracula
      # Language extensions
      redhat.java
      # Jupyter stuff
      ms-toolsai.jupyter
      ms-toolsai.vscode-jupyter-cell-tags
    ];
  };

  # Theme

  ## GTK
  ## https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    # theme = {
    #   name = "palenight";
    #   package = pkgs.palenight-theme;
    # };

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
    };
  };

  home.sessionVariables.GTK_THEME = "palenight";

  ## QT: Inherit from GTK
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

}
