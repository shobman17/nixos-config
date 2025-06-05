{config, pkgs, lib, ...}: {

  programs.terminator = {
    
    enable = true;

    config = {

      global_config = {
        borderless = true;
        window_state = "maximise";
        handle_size = 0;
      };

      profiles.default = {
        copy_on_selection = true;
        use_theme_colors = true;
        bold_is_bright = true;
        background_type = "transparent";
        background_darkness = 0.89;
        scrollbar_position = "hidden";
        show_titlebar = false;
        # use_system_font = false;
        # font = "SauceCodePro-Nerd-Font-Regular 11";
      };

    };
  };

  programs.alacritty = {
    enable = false;
    settings = {
        window.decorations = "None";
        window.startup_mode = "Maximized";
        scrolling.history = 1000;
    };

  };

  programs.kitty = {
    enable = true;
    settings = {
      hide_window_decorations = true;
      scrollback_lines = 2000;
      window_margin_width = 5;
      cursor_trail = 0;
      cursor_trail_start_thresold = 30;
    };
  };

  programs.starship = {
    enable = false;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      

      palette = "rose_pine";

      palettes.gruvbox_dark = {
        color_fg0 = "#fbf1c7";
        color_bg1 = "#3c3836";
        color_bg3 = "#665c54";
        color_blue = "#458588";
        color_aqua = "#689d6a";
        color_green = "#98971a";
        color_orange = "#d65d0e";
        color_purple = "#b16286";
        color_red = "#cc241d";
        color_yellow = "#d79921";
      };
      
      palettes.rose_pine = {
        color_text = "#e0def4";
        color_overlay = "#26233a";
        color_muted = "#6e6a86";
        color_rose = "#ebbcba";
        color_pine = "#31748f";
        color_green = "#31748f";
        color_iris = "#c4a7e7";
        color_gold = "#f6c177";
        color_love = "#eb6f92";
        color_foam = "#9ccfd8";
      };

      format = lib.concatStrings [
        "[](magenta)"
        "$os"
        "$username"
        "[](bg:color_foam fg:magenta)"
        "$directory"
        "[](fg:color_foam bg:color_pine)"
        "$git_branch"
        "$git_status"
        "[](fg:color_pine bg:color_rose)"
        "$c"
        "$rust"
        "$golang"
        "$nodejs"
        "$php"
        "$java"
        "$kotlin"
        "$haskell"
        "$python"
        "[](fg:color_rose bg:color_muted)"
        "$docker_context"
        "$conda"
        "[](fg:color_muted bg:color_overlay)"
        "$time"
        "[ ](fg:color_overlay)"
        "$line_break$character"
      ];

      os = {
        disabled = false;
        style = "bg:magenta fg:color_text";
      };

      os.symbols = {
        NixOS ="󱄅 ";
      # Windows = "󰍲 "
      # Ubuntu = "󰕈 "
      # SUSE = " "
      # Raspbian = "󰐿 "
      # Mint = "󰣭"
      # Macos = "󰀵"
      # Manjaro = ""
      # Linux = "󰌽"
      # Gentoo = "󰣨"
      # Fedora = "󰣛"
      # Alpine = ""
      # Amazon = ""
      # Android = ""
      # Arch = "󰣇"
      # Artix = "󰣇"
      # EndeavourOS = ""
      # CentOS = ""
      # Debian = "󰣚"
      # Redhat = "󱄛"
      # RedHatEnterprise = "󱄛"
      # Pop = ""
      };
      
      username = {
        show_always = true;
        style_user = "bg:magenta fg:color_text";
        style_root = "bg:magenta fg:color_text";
        format = "[ $user ]($style)";
      };
      
      directory = {
        style = "fg:color_text bg:color_foam";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      directory.substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = "󰝚 ";
        "Pictures" = " ";
        "Developer" = "󰲋 ";
      };
      
      git_branch = {
        symbol = " ";
        style = "bg:color_pine";
        format = "[[ $symbol $branch ](fg:color_text bg:color_pine)]($style)";
      };

      git_status = {
        style = "bg:color_pine";
        format = "[[($all_status$ahead_behind )](fg:color_text bg:color_pine)]($style)";
      };

      # [nodejs]
      # symbol = ""
      # style = "bg:color_rose"
      # format = '[[ $symbol( $version) ](fg:color_text bg:color_rose)]($style)'
      # 
      # [c]
      # symbol = " "
      # style = "bg:color_rose"
      # format = '[[ $symbol( $version) ](fg:color_text bg:color_rose)]($style)'
      # 
      # [rust]
      # symbol = ""
      # style = "bg:color_rose"
      # format = '[[ $symbol( $version) ](fg:color_text bg:color_rose)]($style)'
      # 
      # [golang]
      # symbol = ""
      # style = "bg:color_rose"
      # format = '[[ $symbol( $version) ](fg:color_text bg:color_rose)]($style)'
      # 
      # [php]
      # symbol = ""
      # style = "bg:color_rose"
      # format = '[[ $symbol( $version) ](fg:color_text bg:color_rose)]($style)'
      # 
      # [java]
      # symbol = ""
      # style = "bg:color_rose"
      # format = '[[ $symbol( $version) ](fg:color_text bg:color_rose)]($style)'
      # 
      # [kotlin]
      # symbol = ""
      # style = "bg:color_rose"
      # format = '[[ $symbol( $version) ](fg:color_text bg:color_rose)]($style)'
      # 
      # [haskell]
      # symbol = ""
      # style = "bg:color_rose"
      # format = '[[ $symbol( $version) ](fg:color_text bg:color_rose)]($style)'
      # 
      # [python]
      # symbol = ""
      # style = "bg:color_rose"
      # format = '[[ $symbol( $version) ](fg:color_text bg:color_rose)]($style)'
      # 
      # [docker_context]
      # symbol = ""
      # style = "bg:color_muted"
      # format = '[[ $symbol( $context) ](fg:#83a598 bg:color_muted)]($style)'
      # 
      # [conda]
      # style = "bg:color_muted"
      # format = '[[ $symbol( $environment) ](fg:#83a598 bg:color_muted)]($style)'
      
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_overlay";
        format = "[[  $time ](fg:color_text bg:color_overlay)]($style)";
      };

      line_break = {
        disabled = false;
      };

      character = {
        disabled = false;
        success_symbol = "[ ](bold fg:color_green)";
        error_symbol = "[ ](bold fg:color_love)";
      };

      command_timeout = 100;
      # format = lib.concatStrings [
      #   "$username"
      #   "$directory"
      #   "$git_branch"
      #   "$shell"
      #   "$character"
      # ];


      # os = {
      #   disabled = false;
      #   symbols = {
      #     NixOS ="󱄅  ";
      #   };
      # };

      # username = {
      #   show_always = true;
      # };

      # command_timeout = 20;

      # git_status = {
      #   disabled = true;
      # };

      # character = {
      #   success_symbol = "[ ](bold green)";
      #   error_symbol = "[ ](bold red)";
      # };

      # directory = {
      #   truncation_symbol = ".../";
      # };

      # shell = {
      #   disabled = false;
      # };

    };
  };


  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      wassup = "ps auxcf";
      abd = "docker start ajit_build_dev && docker exec -w /home/ajit/ajit-toolchain -it ajit_build_dev bash";
      abd_dev = "$EDITOR /home/shob/Desktop/acads/BTP/repos/StudentRepo/students/";
      nc_dev = "$EDITOR /home/shob/nixos-config/";
      nrs = "sudo nixos-rebuild switch";
      hms = "home-manager -b bck switch";
      nfu = "nix flake update --flake /home/shob/nixos-config";
      vivado_dev = "nix develop path:/home/shob/nix-environments#xilinx-vitis";
      full_upgrade = "nfu && nrs && hms";
      ns="nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --preview-window=right:60% --scheme history";
    };

    sessionVariables = {
      VISUAL = "neovide";
      EDITOR = "nvim";
      TERMINAL = "kitty";
      BROWSER = "browsers";
      TEST_FAKE = 1;
      AJIT_SERIAL_UART = "/dev/ttyUSB0";
      AJIT_DEBUG_UART = "/dev/ttyUSB1";
    };

    initExtra = ''
      
      # Load __git_ps1 bash command.
      . /home/shob/.nix-profile/share/git/contrib/completion/git-prompt.sh
      # Also load git command completions for bash.
      . /home/shob/.nix-profile/share/git/contrib/completion/git-completion.bash

      # Show git branch status in terminal shell.
      export PS1='\[\e[1;31m\](\u)\[\e[1;34m\][\w]\[\e[0;33m\]$(__git_ps1 "(%s)")\[\e[0;36m\][$(date +%H:%M)]\[\e[0m\]\\$ '
    '';
  };
 
}
