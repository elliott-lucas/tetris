function lerp(a, b, t) return (1-t)*a + t*b end
function math.clamp(low, n, high) return math.min(math.max(low, n), high) end
function round(n) return math.floor(n+0.5) end

function rotateTable(tbl, amount)
	local rotated_table = {}
		for i=1, amount do
			for i=1,#tbl[1] do
				rotated_table[i] = {}
				local cellNo = 0;
				for j=#tbl, 1, -1 do
					cellNo = cellNo + 1;
					rotated_table[i][cellNo] = tbl[j][i]
				end
			end
		end
	return rotated_table;
end

-- function rotateTableAnti(tbl, amount)
                -- for i=1, 3 do
                                -- tbl = rotateTable(tbl)
                -- end
                -- return tbl
-- end
