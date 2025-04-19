{
  config,
  pkgs,
  inputs,
  ...
}:
{

  home.packages = with pkgs; [
    ripgrep
    nixfmt-rfc-style
  ];

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    globals.mapleader = " "; # Sets the leader key to space

    # colorschemes.catppuccin = {
    #   enable = true;
    #   settings = {
    #     transparent_background = true;
    #   };
    # };

    plugins = {
      which-key.enable = true;

      lualine.enable = true;

      web-devicons.enable = true;

      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
        window = {
          position = "right";
        };
        filesystem = {
          followCurrentFile = {
            enabled = true;
            leaveDirsOpen = false;
          };
        };
      };

      telescope = {
        enable = true;
        extensions = {
          live-grep-args = {
            enable = true;
            settings = {
              auto_quoting = true;
              mappings = {
                i = {
                  "<C-p>" = {
                    __raw = "require(\"telescope-live-grep-args.actions\").quote_prompt({ postfix = \" -t py \" })";
                  };
                };
              };
              theme = "dropdown";
            };
          };
        };
        settings = {
          pickers = {
            find_files = {
              theme = "dropdown";
            };
          };
        };
        keymaps = {
          # "<C-p>" = {
          #   action = "git_files";
          #   options = {
          #     desc = "Telescope Git Files";
          #   };
          # };
          "<leader>fg" = "live_grep_args";
          "<leader>ff" = "find_files";
          "<leader>fr" = "resume";
        };
      };

      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          ensure_installed = [
            "nix"
            "python"
            "javascript"
            "xml"
            "lua"
            "json"
            "css"
            "csv"
            "bash"
          ];
        };
      };

      treesitter-context.enable = true;
      treesitter-textobjects.enable = true;
      nvim-surround.enable = true;
      #      navic = {
      # enable = true;
      # settings = {
      #   lsp.auto_attach = true;
      # };
      #      };
      none-ls = {
        enable = true;
        sources = {
          diagnostics = {
            pylint.enable = true;
          };
          formatting = {
            isort.enable = true;
            black.enable = true;
            stylua.enable = true;
            codespell.enable = true;
            prettier.enable = true;
          };
        };
      };
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            nix = [ "nixfmt" ];
            # Conform will run multiple formatters sequentially
            python = [
              "isort"
              "black"
            ];
            # Use stop_after_first to run only the first available formatter
            javascript = {
              __unkeyed-1 = "prettierd";
              __unkeyed-2 = "prettier";
              stop_after_first = true;
            };
            # Use the "*" filetype to run formatters on all filetypes.
            "*" = [ "codespell" ];
            # Use the "_" filetype to run formatters on filetypes that don't
            # have other formatters configured.
          };
        };
      };

      lsp = {
        enable = true;
        servers = {
          pyright = {
            enable = true;
          };
        };
      };

      blink-cmp = {
        enable = true;
        settings = {
          keymap = {
            preset = "enter";
          };
        };
      };
      autoclose.enable = true;
      virt-column.enable = true;
      indent-blankline = {
        enable = true;
      };

    };
    colorschemes.onedark = {
      enable = true;
      settings = {
        style = "darker";
        transparent = true;
        term_colors = false;
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      # {
      #   plugin = pywal-nvim;
      #   config = ''lua require("pywal").setup()'';
      #
      # }
    ];

    opts = {
      number = true; # Show line numbers
      relativenumber = true; # Show relative line numbers

      shiftwidth = 2; # Tab width should be 2
    };

    extraConfigLua = ''
      -- Disable netrw file explorer
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Enable clipboard support in Neovim
      vim.opt.clipboard = "unnamedplus"  -- Use the system clipboard (with + register)

    '';

    keymaps = [
      {
        action = "<cmd>Neotree toggle<CR>";
        key = "<leader>e";
        options = {
          silent = true;
        };
      }
    ];

    autoCmd = [
      {
        command = "lua require('conform').format()";
        event = [
          "BufWritePre"
        ];
        pattern = [
          "*"
        ];
      }
    ];
  };
}
