<h1>poke-lyze</h1>
<form action='/upload' method='POST' enctype='multipart/form-data'>
<input type='file' name='img' multiple />
<p> プレイヤーレベル <input type='text' name='plv'/> </p>
<p> 図鑑番号 <input type='text', name='pno'/> </p>
<input type='submit' value='送信' />
</form>

% if not pokemon is None:
<p>{{pokemon.nickname}} lv-{{pokemon.level / 2 + 1}}</p>
<p>hp: {{pokemon.hp}}</p>
<p>cp: {{pokemon.cp}}</p>
<h3>可能性のある個体値</h3>
<table>
<tr><th>attack</th><th>defense</th><th>stamina</th></tr>
%     for iv in pokemon.iv:
<tr><td>{{iv.attack}}</td><td>{{iv.defense}}</td><td>{{iv.stamina}}</td></tr>
%     end
</table>
<img src="{{img}}" />
% end

