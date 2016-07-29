import bottle
from bottle import route, run, template, static_file, request
import pdb
from main import analyze_image, Pokemon
import uuid

def analyze(file):
    tmpname = "tmp/" + str(uuid.uuid4()) + ".png"
    file.save(tmpname)
    poke = Pokemon(int(request.forms.get("pno")))
    analyze_image(int(request.forms.get("plv")), poke, tmpname)
    poke.calc_iv()
    poke.img_path = tmpname + ".out.png"

    print("( a,  d,  s)")
    for iv in poke.iv:
        print("({0:>2}, {1:>2}, {2:>2})".format(iv.attack, iv.defense, iv.stamina))
    return poke


@route('/')
def index():
    return template('index', pokemons=None)

@route('/upload', method='POST')
def upload():
    files = list(map(lambda form: form[1], filter(lambda form: form[0] == "img", bottle.request.POST.allitems())))
    poke = [analyze(f) for f in files]
    return template('index', pokemons=poke)

@route('/tmp/<filepath:path>')
def static_img(filepath):
    return static_file(filepath, root="./tmp")

@route('/css/<filepath:path>')
def static_css(filepath):
    return static_file(filepath, root="./css")

#run(host='192.168.33.10', port=3000)
run(host='10.0.2.15', port=3000)
