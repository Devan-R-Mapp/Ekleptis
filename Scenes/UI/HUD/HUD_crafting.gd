extends CanvasLayer

var page = 1
var orePrice
var mercuryPrice
var towerOwned = false



func _ready():
	pass

func _on_prev_pressed():
	swap_page_prev()


func _on_next_pressed():
	swap_page_next()

func _on_buy_pressed():
	if page == 1:
		orePrice = 1
		mercuryPrice = 0
		#if Global.orePrice >= orePrice && Global.mercuryPrice >= mercuryPrice:
		if towerOwned == false:
			buy()
		pass
	
func swap_page_prev():
	if page == 1:
		page = 2
	if page == 2:
		page = 1
		
func swap_page_next():
	if page == 1:
		page = 2
	if page == 2:
		page = 1
		
func buy():
	pass



