if BEGIN then
    -- colorified search word
    COLOREDARG = "\27[31m"..ARGS.."\27[34m"
    
    -- count lines in the results file
    resfile = io.open(".sfvf", "r")
    L = 1 
    while resfile and resfile:read("*line") do
        L = L + 1
    end
    if resfile then resfile:close() end

    -- open results file for output
    resfile = assert(io.open(".sfvf", "a"))
end

-- search a line for a word and change it to a colorified version
R,res = R:gsub(ARGS,COLOREDARG)
if res ~= 0 then
    outline = (L .. ".\t" .. NR .. '\t\27[32m' .. DATA .. '\27[34m\t' .. R  .. '\27[0m');
    print (outline)
    resfile:write(outline.."\n")
    L = L + 1
end

if END then
    resfile:close()
end
