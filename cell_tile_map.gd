extends TileMap

# セルサイズ
var cell_size := Vector2(tile_set.tile_size) * transform.get_scale()

# 表示サイズ
@onready var viewport_size := get_viewport_rect().size
# タイルマップ
@onready var tile_map: Vector2i = (viewport_size / cell_size).ceil()


# セットアップ処理です
func _ready() -> void:
	# セルリストを初期化します
	reset()


# セルリストを初期化します
# incidenceは生成割合です
func reset(incidence := 0.5) -> void:
	# 各セルをランダムで生成します
	for x in tile_map.x:
		for y in tile_map.y:
			# 乱数が生成割合以下の場合は生成しません
			if (randf() < incidence): continue

			_add_cell(Vector2i(x, y))


# セルを生成します
func _add_cell(coords: Vector2i) -> void:
	set_cell(0, coords, 0, Vector2i(0, 0))
