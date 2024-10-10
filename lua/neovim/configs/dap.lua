local ok, dap = pcall(require, "dap")
if not ok then
	return
end
dap.configurations.typescript = {
	{
		type = "node2",
		name = "node attach",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
	},
}
dap.adapters.node2 = {
	type = "executable",
	command = "node-debug2-adapter",
	args = {},
}

require("dapui").setup()

local dap, dapui = require "dap", require "dapui"

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open {}
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close {}
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close {}
end
