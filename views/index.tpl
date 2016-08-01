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
            <div class="form-group col-xs-12 col-md-6">
            <form action='/upload' method='POST' enctype='multipart/form-data'>
                <div class="form-group row">
                    <input type='file' name='img' class="form-control" multiple />
                </div>
                <div class="form-group row">
                    <label for="plv" class="col-form-label col-xs-8">プレイヤーレベル</label>
                    <div class="col-xs-4">
                        <select name="plv" class="form-control col-xs-4">
    % for i in range(1,40):
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
                        <option value="1">フシギダネ</option>
                        <option value="2">フシギソウ</option>
                        <option value="3">フシギバナ</option>
                        <option value="4">ヒトカゲ</option>
                        <option value="5">リザード</option>
                        <option value="6">リザードン</option>
                        <option value="7">ゼニガメ</option>
                        <option value="8">カメール</option>
                        <option value="9">カメックス</option>
                        <option value="10">キャタピー</option>
                        <option value="11">トランセル</option>
                        <option value="12">バタフリー</option>
                        <option value="13">ビードル</option>
                        <option value="14">コクーン</option>
                        <option value="15">スピアー</option>
                        <option value="16">ポッポ</option>
                        <option value="17">ピジョン</option>
                        <option value="18">ピジョット</option>
                        <option value="19">コラッタ</option>
                        <option value="20">ラッタ</option>
                        <option value="21">オニスズメ</option>
                        <option value="22">オニドリル</option>
                        <option value="23">アーボ</option>
                        <option value="24">アーボック</option>
                        <option value="25">ピカチュウ</option>
                        <option value="26">ライチュウ</option>
                        <option value="27">サンド</option>
                        <option value="28">サンドパン</option>
                        <option value="29">ニドラン♀</option>
                        <option value="30">ニドリーナ</option>
                        <option value="31">ニドクイン</option>
                        <option value="32">ニドラン♂</option>
                        <option value="33">ニドリーノ</option>
                        <option value="34">ニドキング</option>
                        <option value="35">ピッピ</option>
                        <option value="36">ピクシー</option>
                        <option value="37">ロコン</option>
                        <option value="38">キュウコン</option>
                        <option value="39">プリン</option>
                        <option value="40">プクリン</option>
                        <option value="41">ズバット</option>
                        <option value="42">ゴルバット</option>
                        <option value="43">ナゾノクサ</option>
                        <option value="44">クサイハナ</option>
                        <option value="45">ラフレシア</option>
                        <option value="46">パラス</option>
                        <option value="47">パラセクト</option>
                        <option value="48">コンパン</option>
                        <option value="49">モルフォン</option>
                        <option value="50">ディグダ</option>
                        <option value="51">ダグトリオ</option>
                        <option value="52">ニャース</option>
                        <option value="53">ペルシアン</option>
                        <option value="54">コダック</option>
                        <option value="55">ゴルダック</option>
                        <option value="56">マンキー</option>
                        <option value="57">オコリザル</option>
                        <option value="58">ガーディ</option>
                        <option value="59">ウインディ</option>
                        <option value="60">ニョロモ</option>
                        <option value="61">ニョロゾ</option>
                        <option value="62">ニョロボン</option>
                        <option value="63">ケーシィ</option>
                        <option value="64">ユンゲラー</option>
                        <option value="65">フーディン</option>
                        <option value="66">ワンリキー</option>
                        <option value="67">ゴーリキー</option>
                        <option value="68">カイリキー</option>
                        <option value="69">マダツボミ</option>
                        <option value="70">ウツドン</option>
                        <option value="71">ウツボット</option>
                        <option value="72">メノクラゲ</option>
                        <option value="73">ドククラゲ</option>
                        <option value="74">イシツブテ</option>
                        <option value="75">ゴローン</option>
                        <option value="76">ゴローニャ</option>
                        <option value="77">ポニータ</option>
                        <option value="78">ギャロップ</option>
                        <option value="79">ヤドン</option>
                        <option value="80">ヤドラン</option>
                        <option value="81">コイル</option>
                        <option value="82">レアコイル</option>
                        <option value="83">カモネギ</option>
                        <option value="84">ドードー</option>
                        <option value="85">ドードリオ</option>
                        <option value="86">パウワウ</option>
                        <option value="87">ジュゴン</option>
                        <option value="88">ベトベター</option>
                        <option value="89">ベトベトン</option>
                        <option value="90">シェルダー</option>
                        <option value="91">パルシェン</option>
                        <option value="92">ゴース</option>
                        <option value="93">ゴースト</option>
                        <option value="94">ゲンガー</option>
                        <option value="95">イワーク</option>
                        <option value="96">スリープ</option>
                        <option value="97">スリーパー</option>
                        <option value="98">クラブ</option>
                        <option value="99">キングラー</option>
                        <option value="100">ビリリダマ</option>
                        <option value="101">マルマイン</option>
                        <option value="102">タマタマ</option>
                        <option value="103">ナッシー</option>
                        <option value="104">カラカラ</option>
                        <option value="105">ガラガラ</option>
                        <option value="106">サワムラー</option>
                        <option value="107">エビワラー</option>
                        <option value="108">ベロリンガ</option>
                        <option value="109">ガース</option>
                        <option value="110">マタドガス</option>
                        <option value="111">サイホーン</option>
                        <option value="112">サイドン</option>
                        <option value="113">ラッキー</option>
                        <option value="114">モンジャラ</option>
                        <option value="115">ガルーラ</option>
                        <option value="116">タッツー</option>
                        <option value="117">シードラ</option>
                        <option value="118">トサキント</option>
                        <option value="119">アズマオウ</option>
                        <option value="120">ヒトデマン</option>
                        <option value="121">スターミー</option>
                        <option value="122">バリヤード</option>
                        <option value="123">ストライク</option>
                        <option value="124">ルージュラ</option>
                        <option value="125">エレブー</option>
                        <option value="126">ブーバー</option>
                        <option value="127">カイロス</option>
                        <option value="128">ケンタロス</option>
                        <option value="129">コイキング</option>
                        <option value="130">ギャラドス</option>
                        <option value="131">ラプラス</option>
                        <option value="132">メタモン</option>
                        <option value="133">イーブイ</option>
                        <option value="134">シャワーズ</option>
                        <option value="135">サンダース</option>
                        <option value="136">ブースター</option>
                        <option value="137">ポリゴン</option>
                        <option value="138">オムナイト</option>
                        <option value="139">オムスター</option>
                        <option value="140">カブト</option>
                        <option value="141">カブトプス</option>
                        <option value="142">プテラ</option>
                        <option value="143">カビゴン</option>
                        <option value="144">フリーザー</option>
                        <option value="145">サンダー</option>
                        <option value="146">ファイヤー</option>
                        <option value="147">ミニリュウ</option>
                        <option value="148">ハクリュー</option>
                        <option value="149">カイリュー</option>
                        <option value="150">ミュウツー</option>
                        <option value="151">ミュウ</option>
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
