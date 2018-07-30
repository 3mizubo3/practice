function setup(){
			THREE.Object3D.prototype.clear = function(){
   				 var children = this.children;
    			for(var i = children.length-1;i>=0;i--){
     			   var child = children[i];
       				scene.remove(child);
   			 };
			};






			var scene = new THREE.Scene(),
   				 camera = new THREE.PerspectiveCamera( 40,  800 / 480, 0.1, 1000 );
   			var position = {x:0, y:150, z:200};
   			var target = {x:1045,y:150,z:180};
   			var tween = new TWEEN.Tween(position).to(target, 9000);
   				tween.onUpdate(function(){
   						    camera.position.z = position.z;
		    				camera.position.y = position.y;
		    				camera.position.x = position.x;
				});
				tween.easing(TWEEN.Easing.Cubic.Out)
				tween.start();

			var geometry;
			var hemLight = new THREE.HemisphereLight(0xff2222,0xff8888,0.8);
				hemLight.position.set(0,500,0);
				hemLight.castShadow = true;
				scene.add(hemLight);
			 var spotLight = new THREE.SpotLight( 0xffffff );
			 var logo;
			 spotLight.position.set( 300, 5000, 0 );
			 var endLight = new THREE.PointLight( 0xffffff,2.5,200 );
				endLight.position.set(1100,150,180)

			  endLight.castShadow = true;
			 spotLight.castShadow = true;

			spotLight.shadowMapWidth = 2024;
			spotLight.shadowMapHeight = 1024;

			spotLight.shadowCameraNear = 500;
			spotLight.shadowCameraFar = 4000;
			spotLight.shadowCameraFov = 30;
			scene.add( endLight );
			 scene.add( spotLight );



			scene.fog = new THREE.Fog(0x551010, 120, 200)
			var loader = new THREE.ColladaLoader();
			var cells = [];
				loader.load("https://s3-us-west-2.amazonaws.com/s.cdpn.io/152724/low.dae",function ( obj ) {
  				var	mesh1 = obj.scene.children[0].children[0].clone();


  					for ( var i = 0; i < 600; i ++ ) {

						var mesh = new THREE.Mesh( mesh1.geometry, mesh1.material );
						for(var e = 0, x1 = 0; e < 6; e++){
							x1 += Math.random() * 1060 + 250;
						}
						var x = x1 / 6;
						mesh.position.x = x;

						mesh.position.y = Math.random() * 100 + 100;
						mesh.position.z = Math.random() * 300 - 10;

						mesh.rotation.x = Math.random() * 2 * Math.PI;
						mesh.rotation.y = Math.random() * 2 * Math.PI;
						mesh.scale.x = mesh.scale.y = mesh.scale.z = Math.random() * .09 + .01;

					cells.push(mesh);
					scene.add( mesh );



				}
				logoRend();
				render();



				});
				function logoRend(){
					var loader = new THREE.ColladaLoader();
					var position = {x:10,y:10,z:0};
					var target = {x:0,y:0,z:0};
					var spin = new TWEEN.Tween(position).to(target, 9650);
  					loader.options.convertUpAxis = true;

  					loader.load( 'https://s3-us-west-2.amazonaws.com/s.cdpn.io/152724/logoSolid.dae', function ( obj ) {
 						var	mesh1 = obj.scene.children[0].children[0].clone();

  						 logo = new THREE.Mesh( mesh1.geometry, mesh1.material );


   				spin.onUpdate(function(){
   						    logo.rotation.z = position.z;
		    				logo.rotation.y = position.y;
		    				logo.rotation.x = position.x;
				});
   						spin.easing(TWEEN.Easing.Cubic.Out)
						spin.start();
						 logo.position.set(1040,153,160);
						logo.scale.set(.03,.03,.03);
						//logo.rotation.set(0,0,0)


						scene.add(logo);

				});
				}

			var renderer = new THREE.WebGLRenderer({alpha:true,
													antialias:true});
			renderer.setSize( 800 , 480 );
			document.body.appendChild( renderer.domElement );
			var clock = new THREE.Clock();
			function render() {

				requestAnimationFrame(render);
				var delta = clock.getDelta();
				TWEEN.update();

			    //camera.lookAt(new THREE.Vector3(0,0,0));

				for ( var i = 0, il = cells.length; i < il; i ++ ) {

					cells[ i ].rotation.x += 0.03;
					cells[ i ].rotation.y += 0.05;

				}

   				renderer.render(scene, camera);

			}

			function reset(){
				var banner = document.querySelector('.banner');
				scene.clear();

				var replay = banner.cloneNode(true);
				banner.parentNode.replaceChild(replay, banner);
				setup();
			}
			document.getElementById("reset").addEventListener("click", reset);
		}
		setup();
