extends Node


# セットアップ処理です
func _ready() -> void:
	# セルリストを初期化します
	$CellTileMap.reset()


func _on_timer_timeout() -> void:
	# セルを更新します
	$CellTileMap.update()
