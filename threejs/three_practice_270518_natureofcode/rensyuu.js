// forked from shuuuuun's "スマホの傾きでカメラを動かす - three.jsのサンプル" http://jsdo.it/shuuuuun/ceBa
// forked from shuuuuun's "OrbitControlsを入れた状態でカメラを切り替えてみる - three.jsのサンプル" http://jsdo.it/shuuuuun/2l03
// forked from shuuuuun's "OrbitControlsを入れてみる - three.jsのサンプル" http://jsdo.it/shuuuuun/IrKr
// forked from shuuuuun's "forked: three.jsのサンプル" http://jsdo.it/shuuuuun/g7ly
// forked from shuuuuun's "three.jsのサンプル" http://jsdo.it/shuuuuun/cJ5x

var container, camera, scene, renderer, mouse2D, controls,
    perscamera, orthocamera,
    radius = 150,
    theta = 45,
    phi = 0,
    width = window.innerWidth,
    height = window.innerHeight,
    RENDER_INTERVAL = 30,
    TICK_INTERVAL = 500;

init();
start();
//初期関数
function init() {
    // container ------------------------------
    container = document.getElementById('canvas-container');

    // renderer ------------------------------
    renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
    renderer.setSize( width, height );
    container.appendChild( renderer.domElement );

    // scene ------------------------------
    scene = new THREE.Scene();

    // camera ------------------------------
    perscamera = new THREE.PerspectiveCamera( 45, width / height, 1, 10000 ); // fov(視野角),aspect,near,far
    orthocamera = new THREE.OrthographicCamera( width / -2, width / 2, height / 2, height / -2, 1, 10000 );
    camera = perscamera;
    camera.position.set(1800, 200, 200);
    camera.up.set(0, 1, 0);
    camera.lookAt({ x:0, y:0, z:0 });

    // Lights ------------------------------
    var ambientLight = new THREE.AmbientLight(0xffffff);
    scene.add(ambientLight);

    // axis ------------------------------
    //var axis = new THREE.AxisHelper(1000);
    //axis.position.set(0,0,0);
    //scene.add(axis);

    // grid ------------------------------
    var grid = new THREE.GridHelper(50, 10); // size, step
    scene.add(grid);

    // cube ------------------------------
    var loader = new THREE.TextureLoader();
    loader.load("IMG_5838.JPG", function(texture){
        createBox(texture); // mesh作成
        render();
    });
    function createBox(texture){
        for(var i=0; i<10; i++){
        var mesh = new THREE.Mesh(
            new THREE.BoxGeometry(15, 15, 15),
            new THREE.MeshLambertMaterial({map: texture})  // {map: texture}がキモ
        );
        if(i == 0){
        mesh.position.x = 0;
        mesh.position.y = 0;
        mesh.position.z = 0;
        scene.add(mesh);
        }else{
                mesh.position.x = (Math.random() - 0.5) * 150;
                mesh.position.y = (Math.random() - 0.5) * 10;
                mesh.position.z = (Math.random() - 0.5) * 150;
                mesh.rotation.x = Math.random() * 3 * Math.PI;
                mesh.rotation.y = Math.random() * 3 * Math.PI;
                mesh.rotation.z = Math.random() * 2 * Math.PI;
                scene.add(mesh);
              }
        // シーンに追加
      }}
    ///グループを作成
    //const group = new THREE.Group();
    //scene.add(group);

}

//アニメーション関数------------------------------------------------------
//アニメ０ションの時間に関する記述
function start() {
  //現在時刻の取得、一つ前の時刻の取得
  var startTime = Date.now();
  var previousTime = startTime;
  var previousRenderTime = previousTime;
  var previousTickTime = previousTime;
  var loopId;
//ループの関数の指定・・ループ？？？
  (function loop(timestamp){
    var nowTime = Date.now();
    var elapsedTime = nowTime - startTime;
    var deltaTime = nowTime - previousTime;
    var deltaRenderTime = nowTime - previousRenderTime;
    var deltaTickTime = nowTime - previousTickTime;

    if (deltaRenderTime > RENDER_INTERVAL) {
      previousRenderTime = nowTime;
      render();
    }
    if (deltaTickTime > TICK_INTERVAL) {
      previousTickTime = nowTime;
      tick();
    }

    previousTime = nowTime;
    loopId = requestAnimationFrame(loop);
  })();
}

function stop(){
    cancelAnimationFrame(loopId);
}

function tick(){
    //controls.update();
}
//レンダラー
function render(){
    renderer.render( scene, camera );
}



// カメラ位置のアニメーション関数----------------------
var zeroVector = new THREE.Vector3(0, 0, 0);

animateCameraPosition(30,8,0);

function animateCameraPosition(x, y, z){
    var currentVector = camera.position;//初期位置
    var destinationVector = new THREE.Vector3(x, y, z);

    var loopId;
    var duration = 2000;//再生時間：ミリ
    var coords = currentVector;
    //tweennのモーションがかかる部分
    var tween = new TWEEN.Tween(coords)
        .to(destinationVector, duration)//終点位置、再生時間
        .onUpdate(update)//最初に読み込み、一回だけ
        .easing( TWEEN.Easing.Quintic.Out )
        .onComplete(complete)//移動した後に読み込み
        .start();

    animate();
//tweenの呼び出し
    function animate(time) {
        loopId = requestAnimationFrame(animate);
        TWEEN.update(time);
    }
    function complete() {
        cancelAnimationFrame(loopId);
    }
    function update() {
        console.log(this.x, this.y, this.z);

        camera.position.copy(coords);
        camera.lookAt(zeroVector);
    }
}
