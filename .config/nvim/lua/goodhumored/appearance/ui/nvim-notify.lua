return {
	"rcarriga/nvim-notify",
	opts = {
		timeout = 2000, -- Время жизни уведомлений (2 секунды)
		background_colour = "#000000", -- Для корректной прозрачности
		top_down = false, -- Новые уведомления появляются снизу
		-- Ограничение размера для nvim-notify (для совместимости)
		maximum_width = 0.3,
		maximum_height = 5,
	},
}
