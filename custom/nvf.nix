{
  pkgs,
  lib,
  config,
  ...
}: let
  vert = "▌"; # alternatives │
  fold = " ";
  eob = " "; # suppress ~ at EndOfBuffer
  diff = "╱"; # alternatives = ⣿ ░ ─
  msgsep = "‾";
  foldopen = "▾";
  foldsep = "│";
  foldclose = "▸";
  horiz = "━";
  vertright = "┣";
in {
  vim = {
    options = {
      shiftwidth = 2;
      tabstop = 4;
      fcs = lib.concatStrings [
        "vert:${vert},"
        "fold:${fold},"
        "eob:${eob},"
        "diff:${diff},"
        "msgsep:${msgsep},"
        "foldopen:${foldopen},"
        "foldsep:${foldsep},"
        "foldclose:${foldclose},"
        "horiz:${horiz},"
        "vertright:${vertright},"
      ];
    };

    keymaps = [
      {
        key = "<A-Left>";
        mode = ["n"];
        silent = true;
        action = ":wincmd h<CR>";
        desc = "Switch window left";
      }
      {
        key = "<A-Right>";
        mode = ["n"];
        silent = true;
        action = ":wincmd l<CR>";
        desc = "Switch window right";
      }
      {
        key = "<A-Up>";
        mode = ["n"];
        silent = true;
        action = ":wincmd k<CR>";
        desc = "Switch window up";
      }
      {
        key = "<A-Down>";
        mode = ["n"];
        silent = true;
        action = ":wincmd j<CR>";
        desc = "Switch window down";
      }
      {
        key = "<C-Left>";
        mode = ["n"];
        silent = true;
        action = ":bp<CR>";
        desc = "Switch buffer left";
      }
      {
        key = "<C-Right>";
        mode = ["n"];
        silent = true;
        action = ":bn<CR>";
        desc = "Switch buffer right";
      }
      {
        key = "<leader>e";
        mode = "n";
        silent = true;
        action = ":Neotree action=focus source=filesystem position=left toggle reveal<CR>";
        desc = "Neotree toggle";
      }
      {
        key = "<leader>tt";
        mode = ["n"];
        silent = true;
        action = ":ToggleTerm size=15 direction=horizontal";
        desc = "Terminal toggle";
      }
      {
        key = "<esc>";
        mode = ["t"];
        silent = true;
        action = "<C-\><C-n>";
        desc = "Escape to normal mode from terminal";
      }
    ];

    theme = {
      enable = true;
      name = "tokyonight";
      style = "storm";
      # transparent = true;
    };

    statusline.lualine = {
      enable = true;
      activeSection.a = [
        ''
          {
            "mode",
            icons_enabled = true,
            separator = {
              left = '█',
              right = ''
            },
          }
        ''
        ''
          {
            "",
            draw_empty = true,
            separator = { left = '', right = '' }
          }
        ''
      ];
    };

    # terminal.toggleterm = {
    #   enable = true;
    #   lazygit.enable = true;
    #   lazygit.mappings.open = "<leader>tg";
    #   mappings = {
    #     open = "<c-/>";
    #   };
    #   setupOpts = {
    #     winbar.enabled = false;
    #     insert_mappings = true;
    #     terminal_mappings = true;
    #     shading_factor = -5;
    #   };
    # };

    telescope = {
      enable = true;
      mappings = {
        findFiles = "<leader><leader>";
        liveGrep = "<leader>/";
      };
    };

    session.nvim-session-manager = {
      enable = true;
    };

    autocomplete.nvim-cmp.enable = true;
    treesitter.enable = true;

    tabline.nvimBufferline = {
      enable = true;
      mappings = {
        closeCurrent = "<leader>bd";
      };
      setupOpts = {
        options = {
          numbers = "none";
          buffer_close_icon = "×";
          indicator = {
            style = "icon";
            icon = "▍";
          };
          offsets = [
            {
              filetype = "neo-tree";
              highlight = "Directory";
              separator = " ";
              text = "File Explorer";
              text_align = "center";
            }
          ];
          diagnostics = false;
        };
      };
    };

    languages = {
      enableLSP = true;
      enableTreesitter = true;
      enableFormat = true;

      nix.enable = true;
      lua.enable = true;
      clang.enable = true;
      python.enable = true;
      markdown.enable = true;
    };

    visuals = {
      indent-blankline.enable = true;
      nvim-web-devicons.enable = true;
      rainbow-delimiters.enable = true;
    };

    filetree.neo-tree = {
      enable = true;
      setupOpts = {
        add_blank_line_at_top = true;
        auto_clean_after_session_restore = true;
        git_status_async = true;
      };
    };

    binds = {
      whichKey = {
        enable = true;
        setupOpts = {
          preset = "classic";
          border = "shadow";
        };
      };
      cheatsheet.enable = true;
    };

    ui = {
      breadcrumbs.enable = false;
      breadcrumbs.navbuddy.enable = true;
      colorizer.enable = true;
      noice = {
        enable = true;
      };
    };

    utility.snacks-nvim.enable = true;
  };
}
