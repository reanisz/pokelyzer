<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Pokelyzer</title>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/main.css">
</head>

<body>
    <h1>poke-lyzer</h1>
    <form action='/upload' method='POST' enctype='multipart/form-data'>
        <input type='file' name='img' multiple />
        <p> プレイヤーレベル <input type='text' name='plv'/> </p>
        <p> 図鑑番号 <input type='text', name='pno'/> </p>
        <input type='submit' value='送信' />
    </form>

% if not pokemons is None:
%   for pokemon in pokemons:

    <div class="pokemon">
        <div class="column column-left">
            <img src="{{pokemon.img_path}}" />
        </div>
        <div classs="column column-right">
            <h2>{{pokemon.nickname}} Lv:{{pokemon.level / 2 + 1}}</h2>
            <p>HP: {{pokemon.hp}} CP: {{pokemon.cp}}</p>
            
            <h3> RANK: {{pokemon.rank}} / 100 </h3>

            <h3>可能性のある個体値</h3>
            <table class="type01">
                <tr><th>attack</th><th>defense</th><th>stamina</th><th>a+d/s</th></tr>
%     for iv in pokemon.iv:
                <tr><td>{{iv.attack}}</td><td>{{iv.defense}}</td><td>{{iv.stamina}}</td><td>{{iv.attack + iv.defense}}/{{iv.stamina}}</td></tr>
%     end
            </table>
        </div>
    </div>
%   end
% end

</body>
</html>
