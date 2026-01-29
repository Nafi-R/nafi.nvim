-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    local function get_program_path()
      return coroutine.create(function(dap_run_co)
        local actions = require 'telescope.actions'
        local action_state = require 'telescope.actions.state'

        require('telescope.builtin').find_files {
          prompt_title = 'Select Executable (ELF/OUT)',
          no_ignore = true,
          hidden = true,
          find_command = { 'rg', '--files', '--no-ignore', '--hidden', '-g', '*.{elf,out,bin}' },
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              coroutine.resume(dap_run_co, selection[1])
            end)
            return true
          end,
        }
      end)
    end

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require('mason-nvim-dap').default_setup(config)
        end,
        cppdbg = function(config)
          require('mason-nvim-dap').default_setup(config)
          -- Alias cortex-debug to cppdbg
          local dap = require 'dap'
          dap.adapters['cortex-debug'] = dap.adapters.cppdbg
        end,
      },

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'cpptools', -- Add cpptools for C/C++ debugging
        'cortex-debug', -- Add cortex-debug
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Configure cortex-debug adapter
    dap.adapters['cortex-debug'] = {
      type = 'executable',
      command = 'node',
      args = {
        vim.fn.stdpath 'data' .. '/mason/packages/cortex-debug/extension/dist/debugadapter.js',
      },
    }

    -- Configure C/C++ debugging for STM32
    dap.configurations.c = {
      {
        name = 'STM32 U5 Debug (OpenOCD)',
        type = 'cortex-debug',
        request = 'launch',
        servertype = 'openocd',
        cwd = '${workspaceFolder}',
        executable = get_program_path,
        configFiles = { 'interface/stlink.cfg', 'target/stm32u5x.cfg' },
        searchDir = {
          'C:/ST/STM32CubeIDE_1.18.1/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.debug.openocd_2.3.100.202501240831/resources/openocd/st_scripts',
        },
        gdbPath = 'C:/Program Files (x86)/Arm GNU Toolchain arm-none-eabi/14.2 rel1/bin/arm-none-eabi-gdb.exe',
        openOCDPath = 'C:/ST/STM32CubeIDE_1.18.1/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.externaltools.openocd.win32_2.4.100.202501161620/tools/bin/openocd.exe',
        svdFile = 'C:/ST/STM32CubeIDE_1.18.1/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.productdb.debug_2.2.100.202502251557/resources/cmsis/STMicroelectronics_CMSIS_SVD/STM32U575.svd',
      },
      {
        name = 'STM32 H5 Debug (OpenOCD)',
        type = 'cortex-debug',
        request = 'launch',
        servertype = 'openocd',
        cwd = '${workspaceFolder}',
        executable = get_program_path,
        configFiles = { 'interface/stlink.cfg', 'target/stm32h5x.cfg' },
        searchDir = {
          'C:/ST/STM32CubeIDE_1.18.1/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.debug.openocd_2.3.100.202501240831/resources/openocd/st_scripts',
        },
        gdbPath = 'C:/Program Files (x86)/Arm GNU Toolchain arm-none-eabi/14.2 rel1/bin/arm-none-eabi-gdb.exe',
        openOCDPath = 'C:/ST/STM32CubeIDE_1.18.1/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.externaltools.openocd.win32_2.4.100.202501161620/tools/bin/openocd.exe',
      },
      {
        name = 'PS Harness - Download & Debug (Neovim)',
        type = 'cortex-debug',
        request = 'launch',
        servertype = 'openocd',
        cwd = '${workspaceFolder}',
        executable = '${workspaceFolder}/build/Harness/PS_Harness.out',
        configFiles = { '${workspaceFolder}/Tools/HarnessDebug.cfg' },
        searchDir = {
          'C:/ST/STM32CubeIDE_1.18.1/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.debug.openocd_2.3.100.202501240831/resources/openocd/st_scripts',
        },
        gdbPath = 'C:/Program Files (x86)/Arm GNU Toolchain arm-none-eabi/14.2 rel1/bin/arm-none-eabi-gdb.exe',
        openOCDPath = 'C:/ST/STM32CubeIDE_1.18.1/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.externaltools.openocd.win32_2.4.100.202501161620/tools/bin/openocd.exe',
        svdFile = 'C:/ST/STM32CubeIDE_1.18.1/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.productdb.debug_2.2.100.202502251557/resources/cmsis/STMicroelectronics_CMSIS_SVD/STM32U575.svd',
        postStartSessionCommands = {
          'monitor gdb_breakpoint_override hard',
          'tbreak main',
          'continue',
        },
        postResetCommands = {
          'tbreak main',
          'continue',
        },
      },
      {
        name = 'PS Harness - No Download (Neovim)',
        type = 'cortex-debug',
        request = 'launch',
        servertype = 'openocd',
        cwd = '${workspaceFolder}',
        executable = '${workspaceFolder}/build/Harness/PS_Harness.out',
        configFiles = { '${workspaceFolder}/Tools/HarnessDebug.cfg' },
        searchDir = {
          'C:/ST/STM32CubeIDE_1.18.1/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.debug.openocd_2.3.100.202501240831/resources/openocd/st_scripts',
        },
        gdbPath = 'C:/Program Files (x86)/Arm GNU Toolchain arm-none-eabi/14.2 rel1/bin/arm-none-eabi-gdb.exe',
        openOCDPath = 'C:/ST/STM32CubeIDE_1.18.1/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.externaltools.openocd.win32_2.4.100.202501161620/tools/bin/openocd.exe',
        svdFile = 'C:/ST/STM32CubeIDE_1.18.1/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.productdb.debug_2.2.100.202502251557/resources/cmsis/STMicroelectronics_CMSIS_SVD/STM32U575.svd',
        postStartSessionCommands = {
          'monitor gdb_breakpoint_override hard',
          'tbreak main',
          'continue',
        },
        postResetCommands = {
          'tbreak main',
          'continue',
        },
      },
    }
    -- Apply the same configuration to C++
    dap.configurations.cpp = dap.configurations.c

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
