--[[
HouseScript by houseofkraft
]]--

-- This is a entirely new programming language for ComputerCraft

local args = { ... }

local vars = {}
if args[1] == "-hs" then
	if #args < 2 then
		printError("Usage: housescript -hs <file>")
		error()
	end
	local f = args[2]
    file = fs.open(f, "r")
    for k,v in pairs(file.readLine()) do
    	if v:find("sys.print") then
    		if v == "sys.print(" then
    			printError(f..":"..tostring(k)..": ) expected, (to close sys.print on line "..tostring(k)..")")
    			error()
    		elseif v == "sys.print)" then
    			printError(f..":"..tostring(k)..": expected ()")
    			error()
    		end    
    		local s = v:sub(12, #v)
    		print(s)
    	elseif v == "sys.shutdown()" then
    		os.shutdown()
    	elseif v == "io.clear()" then
    		term.clear()
    	elseif v == "sys.reboot()" then
    		os.reboot()
        elseif v:find("**") then
        	-- Comment symbol, do nothing
        elseif v:find("str") then
        	local var = v:sub(4, #v)
        	for i = 1, #v do
        		local n = v:sub(i, i)
        		if n == "=" then
        			nC = i - 1
        		end
        	end
        	local data = v:sub(nC, #v)
        	vars[var] = tostring(data)
        end
    end
end
