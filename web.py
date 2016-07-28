from bottle import route, run, template

@route('/')
def webroot():
    return template('index')

@route('/hello/<name>')
def webroot(name):
    return template('<b>hello {{name}}!<\b>!', name=name)

#run(host='192.168.33.10', port=3000)
run(host='10.0.2.15', port=3000)
