{config, pkgs, inputs, ...}:
{
  
  home.packages = with pkgs; [
    ripgrep
  ];

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

    programs.nixvim = {
	enable = true;
      globals.mapleader = " "; # Sets the leader key to space
    
      colorschemes.catppuccin.enable = true;

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
    };

    telescope  = {
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
  };

  opts = {
    number = true;         # Show line numbers
    relativenumber = true; # Show relative line numbers

    shiftwidth = 2;        # Tab width should be 2
  };


  extraConfigLua = ''
    -- Disable netrw file explorer
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Enable clipboard support in Neovim
    vim.opt.clipboard = "unnamedplus"  -- Use the system clipboard (with + register)

    vim.opt.termguicolors = false
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
      };
}
