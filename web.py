import bottle
from bottle import route, run, template, static_file, request
import pdb
from main import analyze_image, Pokemon
import uuid

@route('/')
def index():
    return template('index', pokemon=None)

@route('/upload', method='POST')
def upload():
    file = bottle.request.files.get("img")
    tmpname = "tmp/" + str(uuid.uuid4()) + ".png"
    file.save(tmpname)
    poke = Pokemon(int(request.forms.get("pno")))
    analyze_image(int(request.forms.get("plv")), poke, tmpname)
    poke.calc_iv()

    print("( a,  d,  s)")
    for iv in poke.iv:
        print("({0:>2}, {1:>2}, {2:>2})".format(iv.attack, iv.defense, iv.stamina))
    return template('index', pokemon=poke, img=tmpname + ".out.png")

@route('/tmp/<filepath:path>')
def static(filepath):
    return static_file(filepath, root="./tmp")

#run(host='192.168.33.10', port=3000)
run(host='10.0.2.15', port=3000)
