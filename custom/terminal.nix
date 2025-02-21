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
    enable = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      
      format = lib.concatStrings [
        "$os"
        "$username"
        "$all"
      ];

      os = {
        disabled = false;
        symbols = {
          NixOS ="󱄅  ";
        };
      };

      username = {
        show_always = true;
      };

      command_timeout = 20;

      git_status = {
        disabled = true;
      };

    };
  };


  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      wassup = "ps auxcf";
    };

    sessionVariables = {
      TERMINAL = "kitty";
      BROWSER = "brave";
      TEST_FAKE = 1;
    };

    initExtra = ''
      
      # Load __git_ps1 bash command.
      # . /home/shob/.nix-profile/share/git/contrib/completion/git-prompt.sh
      # Also load git command completions for bash.
      # . /home/shob/.nix-profile/share/git/contrib/completion/git-completion.bash

      # Show git branch status in terminal shell.
      # export PS1='\[\e[1;31m\](\u)\[\e[1;34m\][\w]\[\e[0;33m\]$(__git_ps1 "(%s)")\[\e[0m\]\\$ '
    '';
  };
 
}
