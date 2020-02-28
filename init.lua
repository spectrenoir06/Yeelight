local socket = require("socket")
local class = require("middleclass")
local json = require("json")

local TCP_PORT = 55443

local Yeelight = class("Yeelight")

function Yeelight:initialize(t)
	self.ip = t.ip
	self.port = t.remote_port or TCP_PORT
	self.debug = t.debug or false

	self.tcp = assert(socket.connect(self.ip, self.port))
end

function Yeelight:setRGB(r,g,b, delay) -- r,g,b[0, 1]
	local mode = delay and "smooth" or "sudden"
	delay = delay or 0

	r = math.floor(r * 255)
	g = math.floor(g * 255)
	b = math.floor(b * 255)

	local rgb = math.floor(r * 65536 + g * 256 + b)

	self.tcp:send(json.encode({
		id = 1,
		method = "set_rgb",
		params = {rgb, mode, delay}
	}).."\r\n")
end

function Yeelight:setHSV(h, s, delay) -- h[0, 359], s[0, 100]
	local mode = delay and "smooth" or "sudden"
	delay = delay or 500

	self.tcp:send(json.encode({
		id = 1,
		method = "set_hsv",
		params = {h, s, mode, delay}
	}).."\r\n")
end

function Yeelight:setCT(temp, delay) -- temp[1700, 6500] kelvin
	local mode = delay and "smooth" or "sudden"
	delay = delay or 500

	self.tcp:send(json.encode({
		id = 1,
		method = "set_ct_abx",
		params = {temp, mode, delay}
	}).."\r\n")
end


function Yeelight:setPower(power, delay)
	local mode = delay and "smooth" or "sudden"
	delay = delay or 500

	self.tcp:send(json.encode({
		id = 1,
		method = "set_power",
		params = {power, mode, delay}
	}).."\r\n")
end

function Yeelight:setBright(bright, delay) -- bright[1, 100]
	local mode = delay and "smooth" or "sudden"
	delay = delay or 500

	self.tcp:send(json.encode({
		id = 1,
		method = "set_bright",
		params = {bright, mode, delay}
	}).."\r\n")
end

function Yeelight:toggle()
	self.tcp:send(json.encode({
		id = 1,
		method = "toggle",
		params = {}
	}).."\r\n")
end

return Yeelight
