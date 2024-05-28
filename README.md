## Запуск сервисов

1. Расчет полигонов пешей доступности выполняется с использованием Valhalla (https://github.com/valhalla/valhalla), 
которую нужно поднять как локальный сервис.


Предварительно необходимо скачать osm данные, например отсюда: https://download.geofabrik.de/russia.html в формате .osm.pbf

Рекомендую скачивать и выполнять дальнейший расчет не сразу для всей страны, а по федеральным округам.

2. Загруженные osm данные необходимо разместить в корне проекта, в директории osm_data

3. Скрипт start_all.sh запустит сервис на портах 8002-8010, свой порт для каждого округа. Каждые 3 секунды скрипт опрашивает сервис на предмет того, запустился ли он. В зависимости от размера карты на это требуется разное время, для центрального округа около 25 мин. Сейчас в скрипте запуск ЦФО происходит отдельно, после всех остальных, так как иначе у меня комп не тянет)

```bash
sudo bash start_all.sh
```

Запуск сервиса только для одного региона:
```bash
sudo bash start_dfo.sh
docker compose up -d valhalla_dfo
```

## Usage

Пример обращения к сервису:

```python
import json
import requests
from shapely.geometry import Polygon


lat, lng = 55.764658, 37.48852
max_walk_time = 30
port = '8010'
payload = {
        "locations": [{"lat": lat, "lon": lng}],
        "costing": "pedestrian",
        "denoise": "0.11",
        "generalize": "0",
        "contours": [{"time": max_walk_time}],
        "polygons": True,
    }
request = f"http://localhost:{port}/isochrone?json={json.dumps(payload)}"
isochrone = requests.get(request, timeout=100).json()
geom = isochrone["features"][0]["geometry"]
coords = geom["coordinates"][0]
polygon_geom = Polygon(coords)
```

Скорость пешехода в сервисе принмается равной 5.1 км/ч = 83.3 м/мин, исходя из этого задаем max_walk_time в минутах.
