from PIL import Image
import sys
import pyocr
import pyocr.builders
import re

def extract_digits(str):
    pattern = r"\d+"
    rep = re.compile(pattern)
    result = rep.search(str)
    if result:
        return result.group()
    else:
        return "null"

tools = pyocr.get_available_tools()

if len(tools) == 0:
    print("OCR-Tool is not found.")
    sys.exit(1)

tool = tools[0]


img_source = Image.open("image/hoge.png")
img_cp = img_source.crop((218,59,218+201,59+79))
img_name = img_source.crop((34,507,34+585,507+66))
img_hp = img_source.crop((198,600,198+267,600+29))

res_cp = extract_digits( tool.image_to_string(img_cp, lang="eng", builder=pyocr.builders.TextBuilder()) )
res_name = tool.image_to_string(img_name, lang="jpn", builder=pyocr.builders.TextBuilder())
res_hp = tool.image_to_string(img_hp, lang="eng", builder=pyocr.builders.TextBuilder())

print("CP => " + res_cp)
print("NAME => " + res_name)
print("HP => " + res_hp)
