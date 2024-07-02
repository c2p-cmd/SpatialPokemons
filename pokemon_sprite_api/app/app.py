from fastapi import FastAPI
from fastapi.responses import Response

from schema import *

import uvicorn
import requests

app = FastAPI()

@app.get("/")
def read_root():
    return "Okay!"

@app.get("/sprites", response_model=PokemonModel)
def get_pokemon_sprite(pokemon: str):
    if len(pokemon) == 0:
        return Response("Not valid", status_code=400)
    try:
        response = requests.get(f"https://pokeapi.co/api/v2/pokemon/{pokemon.lower().replace(' ', '-')}")
        if response.status_code != 200:
            raise Exception("Server error!")
        
        body = response.json()
        name = body['name']
        animated_sprites = AnimatedSprite(**body['sprites']['other']['showdown'])
        cries = PokemonCries(**body['cries'])

        pokemon_model = PokemonModel(name=name, animated_sprites=animated_sprites, cries=cries)

        return pokemon_model
    except Exception as e:
        print(e)
        return Response(f"Oops! {e}", status_code=400)

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8080, reload=True)