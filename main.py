from PIL import Image, ImageDraw
import sys
import pyocr
import pyocr.builders
import re
import math
import json

class Pokemon:
    pokemon_table = json.load(open("pokemon.json"))

    def __init__(self, id):
        self.level = 0
        self.cp = 0
        self.hp = 0
        self.data = self.pokemon_table[id]
        self.name = self.data["Name"]
        self.nickname = ""
        self.base_stamina = self.data["BaseStamina"]
        self.base_attack = self.data["BaseAttack"]
        self.base_defence = self.data["BaseDefense"]

arc_table = [0.0940000,0.1351374,0.1663979,0.1926509,0.2157325,0.2365727,0.2557201,0.2735304,0.2902499,0.3060574,0.3210876,0.3354450,0.3492127,0.3624578,0.3752356,0.3875924,0.3995673,0.4111936,0.4225000,0.4335117,0.4431076,0.4530600,0.4627984,0.4723361,0.4816850,0.4908558,0.4998584,0.5087018,0.5173940,0.5259425,0.5343543,0.5426358,0.5507927,0.5588306,0.5667545,0.5745692,0.5822789,0.5898879,0.5974000,0.6048188,0.6121573,0.6194041,0.6265671,0.6336492,0.6406530,0.6475810,0.6544356,0.6612193,0.6679340,0.6745819,0.6811649,0.6876849,0.6941437,0.7005429,0.7068842,0.7131691,0.7193991,0.7255756,0.7317000,0.7347410,0.7377695,0.7407856,0.7437894,0.7467812,0.7497610,0.7527291,0.7556855,0.7586304,0.7615638,0.7644861,0.7673972,0.7702973,0.7731865,0.7760650,0.7789328,0.7817901,0.7846370,0.7874736,0.7903000,0.7931164];

player_level = 15;
pokemon_level_max = 1 + player_level * 2

arc_max = arc_table[pokemon_level_max + 1]

print("pokemon_level_max=" + str(pokemon_level_max))

def extract_digits(str):
    pattern = r"\d+"
    rep = re.compile(pattern)
    result = rep.search(str)
    if result:
        return result.group()
    else:
        return "null"

def extarct_hp(str):
    pattern = r"(?:HP)?(?:\d+/)?(\d+)"
    rep = re.compile(pattern)
    result = rep.search(str.replace(" ", ""))
    if result:
        return result.group(1)
    else:
        return "null"

def analyze_image(pokemon, path):
    tools = pyocr.get_available_tools()

    if len(tools) == 0:
        print("OCR-Tool is not found.")
        sys.exit(1)

    tool = tools[0]
    img_source = Image.open("image/fuga.png")
    img_cp = img_source.crop((218,59,218+201,59+79))
    img_name = img_source.crop((34,507,34+585,507+66))
    img_hp = img_source.crop((198,600,198+267,600+29))

    res_cp = tool.image_to_string(img_cp, lang="eng", builder=pyocr.builders.TextBuilder())
    res_name = tool.image_to_string(img_name, lang="jpn", builder=pyocr.builders.TextBuilder())
    res_hp = tool.image_to_string(img_hp, lang="eng", builder=pyocr.builders.TextBuilder())

    radius = (640 - 62*2) / 2
    center = ((640 - 62*2)/2 + 62, 403)

    pokemon_level = 0

    for i in range(0, pokemon_level_max + 1):
        theta = arc_table[i] / arc_max * math.pi + 0.02
        p = (-math.cos(theta) * radius, -math.sin(theta) * radius)
        pos = tuple([a + b for (a,b) in zip(p, center)])
        pix = img_source.getpixel( pos )
        if max(pix) >= 245:
            pokemon_level = i

    pokemon.cp = extract_digits(res_cp)
    pokemon.hp = extarct_hp(res_hp)
    pokemon.nickname = res_name.replace(" ", "").replace("　", "")
    pokemon.level = pokemon_level

pokemon = Pokemon(1)
analyze_image(pokemon, "image/fuga.png")

print("pokemon_level = " + str(pokemon.level / 2 + 1))
print("CP => " + pokemon.cp)
print("NAME => " + pokemon.nickname)
print("HP => " + pokemon.hp)
