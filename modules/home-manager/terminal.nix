{config, pkgs, ...}: {

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


  programs.bash = {
    enable = true;
    enableCompletion = true;
    sessionVariables = {
      
    };
    initExtra = ''

      export EDITOR="nvim";
      export TERMINAL="kitty";
      export BROWSER="brave";
      export QT_QPA_PLATFORM="wayland";

      export NIXPKGS_ALLOW_UNFREE=1;
      
      # Load __git_ps1 bash command.
      . /home/shob/.nix-profile/share/git/contrib/completion/git-prompt.sh
      # Also load git command completions for bash.
      . /home/shob/.nix-profile/share/git/contrib/completion/git-completion.bash

      # Show git branch status in terminal shell.
      export PS1='\[\e[1;31m\](\u)\[\e[1;34m\][\w]\[\e[0;33m\]$(__git_ps1 "(%s)")\[\e[0m\]\\$ '
      # export PS1='$(tput bold)$(tput setaf 11)$(tput setab 3) \u $(tput sgr0)$(tput setaf 3)$(tput setab 11) \w $(tput setaf 11)$(tput setab 0)$(tput sgr0)$(__git_ps1 " $(tput setaf 6)%s$(tput sgr0) ") '

      # Create a separate prompt for distrobox
      # Check if the current host has a container_ID
      if (env | grep -iq 'CONTAINER_ID'); then 
      # Customize PS1 for distrobox
        PS1='\e[1;31m[$CONTAINER_ID]\e[1;34m(\w)\e[0m]\$ ' 
      fi

      # View all processes in a fancy way
      alias wassup="ps auxcf"
    '';
  };
 
}
