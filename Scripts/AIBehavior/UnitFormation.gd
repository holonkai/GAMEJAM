class_name UnitFormation
extends Object
static func line(pos: Vector2, amount: int, max_per_line: int=6, spacing: float=20):
	#ngl just copied the tutorial, it just makes the units stand in a formation
	var n_lines= ceili(amount/float(max_per_line))
	var x_half = floori(max_per_line/2.0)
	if(max_per_line%2==0):
		x_half-=.5
	var y_half = floori(n_lines/2.0)
	if(n_lines%2==0):
		y_half-=.5
	var y= -spacing*y_half
	var remaining=amount
	var positions=[]
	for i in n_lines:
		var n=min(max_per_line,remaining)
		var x=spacing*(-x_half+(max_per_line-n)/2.0)
		for j in n:
			positions.append(pos+Vector2(x,y))
			x+=spacing
			remaining-=1
		y+= spacing
	return positions
	
	
