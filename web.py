import bottle
from bottle import route, run, template, static_file, request
import pdb
from main import analyze_image, Pokemon
import uuid
import concurrent.futures

def analyze(file, pno, plv):
    print("Analyze Start")
    tmpname = "tmp/" + str(uuid.uuid4()) + ".png"
    file.save(tmpname)
    poke = Pokemon(pno)
    analyze_image(plv, poke, tmpname)
    poke.calc_iv()
    poke.img_path = tmpname + ".out.png"

    print("( a,  d,  s)")
    for iv in poke.iv:
        print("({0:>2}, {1:>2}, {2:>2})".format(iv.attack, iv.defense, iv.stamina))
    print("Analyze Complete")
    return poke


@route('/')
def index():
    return template('index', pokemons=None)

@route('/upload', method='POST')
def upload():
    files = list(map(lambda form: form[1], filter(lambda form: form[0] == "img", bottle.request.POST.allitems())))
    pool = concurrent.futures.ThreadPoolExecutor(max_workers=8)
    pno = int(request.forms.get("pno"))
    plv = int(request.forms.get("plv"))
    def co_analyze(file):
        return analyze(file, pno, plv)
    poke = list(pool.map(co_analyze, files))
    #poke = [analyze(f) for f in files]
    return template('index', pokemons=poke)

@route('/tmp/<filepath:path>')
def static_img(filepath):
    return static_file(filepath, root="./tmp")

@route('/css/<filepath:path>')
def static_css(filepath):
    return static_file(filepath, root="./css")

#run(host='192.168.33.10', port=3000)
run(host='10.0.2.15', port=3000)
