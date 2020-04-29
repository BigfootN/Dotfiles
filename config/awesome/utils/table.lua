---------------
-- functions --
---------------

local table_length = function(table)
    local ret = 0

    for _ in pairs(table) do
        ret = ret + 1
    end

    return ret
end

function table_equals(table_a, table_b)
    local ret = false

    if (table_a ~= nil) and (table_b ~= nil) then
        if (table_length(table_a) == table_length(table_b)) then
            ret = true
            for k, v in pairs(table_b) do
                if (table_a[k] ~= table_b[k]) then
                    ret = false
                    break
                end
            end
        end
    end

    return ret
end