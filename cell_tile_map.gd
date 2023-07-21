extends TileMap

# セルサイズ
var cell_size := Vector2(tile_set.tile_size) * transform.get_scale()

# 表示サイズ
@onready var viewport_size := get_viewport_rect().size
# タイルマップ
@onready var tile_map: Vector2i = (viewport_size / cell_size).ceil()


# セルリストを初期化します
# incidenceは生成割合です
func reset(incidence := 0.5) -> void:
	# 各セルをランダムで生成します
	for x in tile_map.x:
		for y in tile_map.y:
			# 乱数が生成割合以下の場合は生成しません
			if (randf() < incidence): continue

			_add_cell(Vector2i(x, y))


# 各セルを更新します
func update() -> void:
	# 現在のセルの状態を取得します
	var cells = _get_cells_state()

	# セルの状態を更新します
	for key in cells:
		# 周りのセルが何個生きているカウントします
		var lives = 0

		# 周囲のセルを調べます
		for dy in range(-1, 2):
			for dx in range(-1, 2):
				if dy == 0 && dx == 0: continue

				# 画面恥は繋がっているものとして座標を更新します
				var x := int(key.x + dx + tile_map.x) % int(tile_map.x)
				var y := int(key.y + dy + tile_map.y) % int(tile_map.y)
				var target_map := Vector2i(x, y)

				if cells[target_map]:
					lives += 1

		# セルを更新します
		if !cells[key] && lives == 3:
			_add_cell(key)
		elif cells[key] && (lives <= 1 || lives >= 4):
			_erase_cell(key)


# セルを生成します
func _add_cell(coords: Vector2i) -> void:
	set_cell(0, coords, 0, Vector2i(0, 0))


# セルを削除します
func _erase_cell(coords: Vector2i) -> void:
	erase_cell(0, coords)


# 各セル座標上にセルが存在するかどうかの状態を取得します
func _get_cells_state() -> Dictionary:
	var dict := {}

	# セル座標をkey, セルの存在をvalueとして登録します
	for x in tile_map.x:
		for y in tile_map.y:
			var coords := Vector2i(x, y)
			dict[coords] = get_cell_alternative_tile(0, coords) >= 0

	return dict
