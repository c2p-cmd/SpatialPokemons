# Spatial Pokemon

## A VisionOS app for seeing your favourite animated Pokemons!

### Get Started:
1. Clone project:
```bash
git clone https://github.com/c2p-cmd/SpatialPokemons/
```

2. Open backend([pokemon_sprite_api](./pokemon_sprite_api/)) and run it
```shell
cd pokemon_sprite_api

# install requirements
pip3 install -r requirements.txt

# run app
cd app
uvicorn app:app --host 0.0.0.0 --port 8000 --reload
```

3. Open [visionOS App](./Pokemons/) in Xcode and run!

### Screenshots:

<table>
    <tr>
        <td>
        <img src="https://raw.githubusercontent.com/c2p-cmd/SpatialPokemons/main/readme_images/1.png" />
        </td>
        <td>
        <img src="https://raw.githubusercontent.com/c2p-cmd/SpatialPokemons/main/readme_images/2.png" />
        </td>
    <tr>
    <tr>
        <td>
        <img src="https://raw.githubusercontent.com/c2p-cmd/SpatialPokemons/main/readme_images/3.png" />
        </td>
        <td>
        <img src="https://raw.githubusercontent.com/c2p-cmd/SpatialPokemons/main/readme_images/4.png" />
        </td>
    <tr>
</table>

### Video:

<video src="https://raw.githubusercontent.com/c2p-cmd/SpatialPokemons/main/readme_images/playback.mp4"> </video>

### Credits
- [Pokemon API](https://pokeapi.co/docs/v2#pokemon)
- [kritimodi/GIF-Swift](https://github.com/kiritmodi2702/GIF-Swift/blob/master/GIF-Swift/iOSDevCenters%2BGIF.swift)