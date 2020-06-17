# def convert_length(length, unit_from,unit_to)
# 	units = {'m' => 1.0, 'ft'=> 3.28, 'in'=> 39.37}
# 	(length / units[unit_from] * units[unit_to]).round(2)
# end

	UNITS = {m: 1.0, ft: 3.28, in: 39.37}
def convert_length(length, from: :m, to: :m)
		(length / UNITS[from] * UNITS[to]).round(2)
end
#round(2)..四捨五入

def convert_length_2(length, unit_from,unit_to)
	units = {'m' => 1.0, 'cm' => 100, 'mm' => 1000 }
	(length / units[unit_from] * units[unit_to]).round(2)
end

