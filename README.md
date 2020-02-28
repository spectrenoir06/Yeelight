


- light:initialize{ip = "192.168.1.1}
- light:setRGB(red, greed, blue, delay) -- red, green, blue[0, 255]
- light:setHSV(hue, saturation, delay) -- hue[0, 359], saturation[0, 100]
- light:setCT(temp, delay) -- temp[1700, 6500] kelvin
- light:setPower(power, delay) -- power["on", "off"]
- light:setBright(bright, delay) -- bright[1, 100]
- light:toggle()
