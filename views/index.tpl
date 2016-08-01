<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Pokelyzer</title>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.rawgit.com/twbs/bootstrap/v4-dev/dist/css/bootstrap.css">
    <link rel="stylesheet" href="css/main.css">
</head>

<body>

    <nav class="navbar navbar-fixed-top navbar-dark bg-inverse">
    <a class="navbar-brand" href="/">Pokelyzer</a>
    <ul class="nav navbar-nav">
    <li class="nav-item active">
    <a class="nav-link" href="/">Home <span class="sr-only">(current)</span></a>
    </li>
    </ul>
    </nav>

    <div class="container">
        <div class="row">
            <div class="form-group col-xs-12 col-md-6 card card-block">
            <form action='/upload' method='POST' enctype='multipart/form-data'>
                <div class="form-group row">
                    <input type='file' name='img' class="form-control" multiple />
                </div>
                <div class="form-group row">
                    <label for="plv" class="col-form-label col-xs-8">プレイヤーレベル</label>
                    <div class="col-xs-4">
                        <select name="plv" class="form-control col-xs-4">
    % for i in range(1,41):
                        <option value="{{i}}">{{i}}</option>
    % end
                        </select>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="pno" class="col-form-label col-xs-5">
                        ポケモン
                    </label>
                    <div class="col-xs-7">
                        <select name="pno" class="form-control">
% for pokemon in sorted(pokename, key=lambda p: p['name']):
                        <option value="{{pokemon['id']}}">{{pokemon['name']}}</option>
% end
                    </select>
                    </div>
                </div>
                <input type='submit' value='送信' class="btn btn-primary"/>
            </form>
        </div>
    </div>

% if not pokemons is None:
% i = 0
%   for pokemon in pokemons:

    <div class="col-sm-12 col-md-4 col-xl-3">
    <div class="card">
        <img src="{{pokemon.img_path}}" class="card-img-top" style="width:100%; height:auto"/>
        <div class="card-block">
            <h4 class="card-title">{{pokemon.nickname}} Lv:{{pokemon.level / 2 + 1}}</h4>
            <h4 class="card-title"> RANK: {{pokemon.rank}} / 100 </h3>
            <p class="card-text">
                HP: {{pokemon.hp}} CP: {{pokemon.cp}}
            </p>
                

            <a class="btn btn-primary" data-toggle="collapse" href="#pokemon-iv-{{i}}" aria-expanded="false" aria-controls="pokemon-iv-{{i}}">個体値を見る</a>
            <div class="collapse" id="pokemon-iv-{{i}}">
            <table class="table">
                <thead class="thead-inverse">
                <tr><th>atk</th><th>def</th><th>sta</th><th>ad/s</th></tr>
                </thead>
                <tbody>
%     for iv in pokemon.iv:
                <tr><td>{{iv.attack}}</td><td>{{iv.defense}}</td><td>{{iv.stamina}}</td><td>{{iv.attack + iv.defense}}/{{iv.stamina}}</td></tr>
%     end
                </tbody>
            </table>
            </div>
        </div>
    </div>
    </div>
% i = i + 1
%   end
% end
    </div>

    </div>


    <script   src="https://code.jquery.com/jquery-2.2.4.min.js"   integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="   crossorigin="anonymous"></script>
    <script src="https://cdn.rawgit.com/twbs/bootstrap/v4-dev/dist/js/bootstrap.js"></script>
    <script>
        //$(".collapse").collapse();
    </script>
</body>
</html>
