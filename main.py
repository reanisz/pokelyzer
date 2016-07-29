from PIL import Image, ImageDraw
import sys
import pyocr
import pyocr.builders
import re
import math
import json
from itertools import product

arc_table = [0.0940000,0.1351374,0.1663979,0.1926509,0.2157325,0.2365727,0.2557201,0.2735304,0.2902499,0.3060574,0.3210876,0.3354450,0.3492127,0.3624578,0.3752356,0.3875924,0.3995673,0.4111936,0.4225000,0.4335117,0.4431076,0.4530600,0.4627984,0.4723361,0.4816850,0.4908558,0.4998584,0.5087018,0.5173940,0.5259425,0.5343543,0.5426358,0.5507927,0.5588306,0.5667545,0.5745692,0.5822789,0.5898879,0.5974000,0.6048188,0.6121573,0.6194041,0.6265671,0.6336492,0.6406530,0.6475810,0.6544356,0.6612193,0.6679340,0.6745819,0.6811649,0.6876849,0.6941437,0.7005429,0.7068842,0.7131691,0.7193991,0.7255756,0.7317000,0.7347410,0.7377695,0.7407856,0.7437894,0.7467812,0.7497610,0.7527291,0.7556855,0.7586304,0.7615638,0.7644861,0.7673972,0.7702973,0.7731865,0.7760650,0.7789328,0.7817901,0.7846370,0.7874736,0.7903000,0.7931164];

class IV:
    def __init__(self, stamina, attack, defense, cp):
        self.stamina = stamina
        self.attack = attack
        self.defense = defense
        self.cp = cp


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
        self.base_defense = self.data["BaseDefense"]
        self.min_cp = -1
        self.max_cp = 1
        self.iv = []
        self.rank = 0

    def calc_iv(self):
        self.min_cp = math.floor((self.base_attack + 0) * math.sqrt(self.base_defense + 0) * math.sqrt(self.base_stamina + 0) * math.pow(arc_table[self.level], 2) / 10)
        self.max_cp = math.floor((self.base_attack + 15) * math.sqrt(self.base_defense + 15) * math.sqrt(self.base_stamina + 15) * math.pow(arc_table[self.level], 2) / 10)
        self.rank = int((self.cp - self.min_cp) / (self.max_cp - self.min_cp) * 100)

        for s in range(0,16):
            estimated_hp = math.floor((self.base_stamina + s) * arc_table[self.level])
            if(estimated_hp != self.hp):
                continue
            #print("hp: {0} - {1}".format(estimated_hp, self.hp))
            for a in range(0,16):
               for d in range(0,16):
                   estimated_cp = math.floor((self.base_attack + a) * math.sqrt(self.base_defense + d) * math.sqrt(self.base_stamina + s) * math.pow(arc_table[self.level], 2) / 10)
                   # print("  | cp: {0} - {1}".format(estimated_cp, self.cp))
                   if(self.cp == estimated_cp):
                       self.iv.append(IV(s,a,d,estimated_cp))
                       #print("{0}, {1}, {2}".format(s,a,d))
    



def extract_digits(str):
    pattern = r"\d+"
    rep = re.compile(pattern)
    result = rep.search(str)
    if result:
        return int(result.group())
    else:
        return -1

def extarct_hp(str):
    pattern = r"(?:HP)?(?:\d+/)?(\d+)"
    rep = re.compile(pattern)
    result = rep.search(str.replace(" ", ""))
    if result:
        return int(result.group(1))
    else:
        return -1

def fitting(t, f, to):
    res = tuple([v * to / f for (v) in t])
    print(str(t))
    print(str(res))
    return res

def is_white(pixel):
    if(pixel[0] + pixel[1] + pixel[2] > 230*3):
        return 1
    return 0

def analyze_image(player_level, pokemon, image):
    pokemon_level_max = 1 + player_level * 2
    arc_max = arc_table[pokemon_level_max + 1]
    arc_max = arc_table[player_level * 2 - 2]

    tools = pyocr.get_available_tools()

    if len(tools) == 0:
        print("OCR-Tool is not found.")
        sys.exit(1)

    tool = tools[0]
    img_source = Image.open(image)
    draw = ImageDraw.Draw(img_source)

    for x,y in product(*map(range, img_source.size)):
        if(not is_white(img_source.getpixel((x,y)))):
            draw.point((x,y), (0x00,0x00,0x00))

    img_width = img_source.width
    img_mul = img_source.width / 640
    img_cp   = img_source.crop(fitting((218,59,218+201,59+79), 640, img_width))
    img_name = img_source.crop(fitting((34,507,34+585,507+66), 640, img_width))
    img_hp   = img_source.crop(fitting((198,600,198+267,600+29), 640, img_width))

    res_cp = tool.image_to_string(img_cp, lang="eng", builder=pyocr.builders.TextBuilder())
    res_name = tool.image_to_string(img_name, lang="jpn", builder=pyocr.builders.TextBuilder())
    res_hp = tool.image_to_string(img_hp, lang="eng", builder=pyocr.builders.TextBuilder())

    radius = (640 - 62*2) / 2 * img_mul
    center = fitting(((640 - 62*2)/2 + 62, 403), 640, img_width)

    pokemon_level = 1


    for i in range(0, pokemon_level_max + 1):
        theta = ((arc_table[i]-0.094) * 202.037116 / arc_max) * math.pi / 180 + 0.00
        p = (-math.cos(theta) * radius, -math.sin(theta) * radius)
        pos = tuple([a + b for (a,b) in zip(p, center)])
        pix = img_source.getpixel( pos )
        col = (0x00,0xff,0xff)
        if max(pix) >= 245:
            pokemon_level = i
            col = (0xff,0xff,0x00)
        draw.point(pos, col)
        draw.line((pos, center), col)
    img_source.save(image + ".out.png")

    pokemon.cp = int(extract_digits(res_cp))
    pokemon.hp = int(extarct_hp(res_hp))
    pokemon.nickname = res_name.replace(" ", "").replace("　", "")
    pokemon.level = pokemon_level


def test():
    pokemon = Pokemon(134)
    analyze_image(15, pokemon, open("image/piyo.png"))

    print("pokemon_level = " + str(pokemon.level / 2 + 1))
    print("CP => " + str(pokemon.cp))
    print("NAME => " + pokemon.name)
    print("NICKNAME => " + pokemon.nickname)
    print("HP => " + str(pokemon.hp))

    pokemon.calc_iv()

    print("( a,  d,  s)")
    for iv in pokemon.iv:
        print("({0:>2}, {1:>2}, {2:>2})".format(iv.attack, iv.defense, iv.stamina))

