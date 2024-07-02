from pydantic import BaseModel
from typing import Optional

class AnimatedSprite(BaseModel):
    back_default: Optional[str]
    back_female: Optional[str]

    back_shiny: Optional[str]
    back_shiny_female: Optional[str]

    front_default: Optional[str]
    front_female: Optional[str]

    front_shiny: Optional[str]
    front_shiny_female: Optional[str]

class PokemonCries(BaseModel):
    latest: Optional[str]
    legacy: Optional[str]

class PokemonModel(BaseModel):
    name: str
    animated_sprites: AnimatedSprite
    cries: PokemonCries