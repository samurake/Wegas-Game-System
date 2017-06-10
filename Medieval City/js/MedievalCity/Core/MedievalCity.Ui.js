/**
Logic Interaction with the game will be placed here.
*/
MedievalCity.Ui = {

    level: {},
	
	resetbackground: function() {
    document.getElementById('theBody').style.backgroundImage='none';
    document.getElementById('theBody').style.backgroundColor='#000';
    },
	
	/*popup functions for resources*/

    toggle_visibility: function(id) {
        var e = document.getElementById(id);
        if(e.style.display == 'block')
            e.style.display = 'none';
        else
            e.style.display = 'block';
    },
	
	mypopup:function() {
        var popup = document.getElementById("myPopup");
        popup.classList.toggle("show");
    },

    /**
     * Callback after the game is started.
     */
    initialize: function() {

        $('#game').addEventListener('click', this.click, false);
        window.addEventListener("resize", this.windowResized, false);
        document.addEventListener('keyup', this.keyup, false);

        /**
         * Updates game stats and related dom elements if they exists.
         */
        Object.observe(MedievalCity.stats, function (changes) {
            changes.forEach(function(change) {
                if ($('#game-' + change.name) != null) {
                    $('#game-' + change.name).innerHTML = change.object[change.name];
                }
                // Remove the 'insufficient' class from elements that might be visible
                for (var i = 0; i < $('.'+ change.name).length; i++) {
                    var el = $('.'+ change.name)[i];
                    var statsCosts = el.innerHTML;
                    if (statsCosts <= change.object[change.name]) {
                        el.className = el.className.replace(/insufficient/, '');
                    }
                }
            });
        });

    },

    initializeControls: function(camera) {
        var audio = new Audio('Medieval Music - Sir Tristan.mp3');
        audio.play();

        MedievalCity.controls = new THREE.OrbitControls( camera );
        MedievalCity.controls.damping = 0.2;
        MedievalCity.controls.minDistance = 60;
        MedievalCity.controls.maxDistance = 220;
        MedievalCity.controls.noPan = false;
        MedievalCity.controls.minPolarAngle = 0; // radians
        MedievalCity.controls.maxPolarAngle = 1.5; // radians

    },


    gameMenu: function () {


        // hide in-game
        for (var i = 0; i < $('.status-in-game').length; i++) {
            $('.status-in-game')[i].style.display = 'none';
        }
        // show game menu
        for (var i = 0; i < $('.status-menu-game').length; i++) {
            $('.status-menu-game')[i].style.display = 'block';
        }

        MedievalCity.reset();

    },


    playLevel: function() {

        MedievalCity.reset();

        // show in-game
        for (var i = 0; i < $('.status-in-game').length; i++) {
            $('.status-in-game')[i].style.display = 'block';
        }
        // show game menu
        for (var i = 0; i < $('.status-menu-game').length; i++) {
            $('.status-menu-game')[i].style.display = 'none';
        }

        this.level = new MedievalCity.Level1();
        this.level.start();

    },

    windowResized: function() {
        if (MedievalCity.camera.updateProjectionMatrix != null) {
            MedievalCity.camera.aspect = window.innerWidth / window.innerHeight;
            MedievalCity.camera.updateProjectionMatrix();
            MedievalCity.renderer.setSize( window.innerWidth, window.innerHeight );
            MedievalCity.gameWidth = window.innerWidth;
            MedievalCity.gameHeight = window.innerHeight;
        }
    },

    click: function(event) {
        if (MedievalCity.projector.unprojectVector != null && MedievalCity.camera != null) {
            // Put scene objects in an array
            var objects = [];
            MedievalCity.objects.forEach(function(object, index) {
                if (object.object != null) {
                    object.object.objectIndex = index;
                    objects.push(object.object);
                }
            });

            event.preventDefault();
            var vector = new THREE.Vector3(
              (event.pageX / MedievalCity.gameWidth) * 2 - 1,
              - (event.pageY / MedievalCity.gameHeight) * 2 + 1,
              0.5);
            MedievalCity.projector.unprojectVector(vector, MedievalCity.camera);
            var ray = new THREE.Raycaster(MedievalCity.camera.position, vector.sub(MedievalCity.camera.position).normalize());
            var intersects = ray.intersectObjects(objects, true);
            var objectSelected = false;
            if (intersects.length > 0) {
                for (var i = 0; i < intersects.length; i++) {
                    var currentObject = MedievalCity.objects[intersects[i].object.objectIndex];
                    if (currentObject != null && currentObject.selectable == true && typeof currentObject.select == 'function' && currentObject.selected == false) {
                        MedievalCity.deselectAll();
                        currentObject.select();
                        objectSelected = true;
                        break;
                    }
                }
            }
            if (objectSelected == false) {
                MedievalCity.Ui.hideBuildMenu();
            }
        }
    },

    loadingProgress: function (item, loaded, total) {

        if (loaded < total) {
            if (this.loadingFadeout != null) {
                clearTimeout(this.loadingFadeout);
            }
            var percent = 100 / total * loaded;
            $('#loading-container').style.display = 'block';
            $('#loading').style.width = percent +'%';
            $('#loading').innerHTML = item;
        }
        else {
            $('#loading').style.width = '100%';
            this.loadingFadeout = setTimeout(function() {
                $('#loading-container').style.display = 'none';
            }, 1000);
        }
    },


    /**
     * Displays available Buildings to place on the selected tile
     */
    showBuildMenu: function() {
        if (MedievalCity.selectedObject.currentBuilding.id == null) {
            $('#build-menu').innerHTML = '';
            MedievalCity.availableBuildings.forEach(function(building, index) {
                var extraClass = '';
                var object = building.object();
                if (object.stats.costs > MedievalCity.stats.grain) {
                    extraClass = ' insufficient';
                }
                var image = '<img src="assets/buildings/' + object.icon +'" />';
                var currencyDiv = '<div class="overlay overlay-black bottom text-center grain'+ extraClass+ '">'+ '</div>';
                switch(object.name) {
                    case 'Main Building':
                        var link = '<a class="game-stat tooltipgame'+ extraClass +'" onclick="MedievalCity.Ui.buildBuilding('+ index +');">'+ currencyDiv + image +'<span class="tooltiptext"><ul><li class="a">500</li> <li class="b">500</li>  <li class="c">500</li></ul></span>'+ '</a>';
                        break;
                    case 'Lumberjack Building':
                        var link = '<a class="game-stat tooltipgame'+ extraClass +'" onclick="MedievalCity.Ui.buildBuilding('+ index +');">'+ currencyDiv + image +'<span class="tooltiptext"><ul><li class="a">50</li> <li class="b">40</li> <li class="c">85</li></ul></span>'+ '</a>';
                        break;
                    case 'Stone Building':
                        var link = '<a class="game-stat tooltipgame'+ extraClass +'" onclick="MedievalCity.Ui.buildBuilding('+ index +');">'+ currencyDiv + image +'<span class="tooltiptext"><ul><li class="a">50</li> <li class="b">60</li> <li class="c">75</li></ul></span>'+ '</a>';
                        break;
                    case 'WindMill':
                        var link = '<a class="game-stat tooltipgame'+ extraClass +'" onclick="MedievalCity.Ui.buildBuilding('+ index +');">'+ currencyDiv + image +'<span class="tooltiptext"><ul><li class="a">30</li> <li class="b">20</li> <li class="c">150</li></ul></span>'+ '</a>';
                        break;
                    default:
                        var link = '<a class="game-stat tooltipgame'+ extraClass +'" onclick="MedievalCity.Ui.buildBuilding('+ index +');">'+ currencyDiv + image +'<span class="tooltiptext">Unknown</span>'+ '</a>';
                }
                $('#build-menu').innerHTML += link;
            });
            $('#build-menu').className = $('#build-menu').className.replace(/(\s)?slide-up/, '');
            $('#build-menu').className = $('#build-menu').className.replace(/(\s)?slide-down/, '');
            $('#build-menu').className += ' slide-up';
        }
    },

    hideBuildMenu: function() {
        MedievalCity.deselectAll();
        $('#build-menu').className = $('#build-menu').className.replace(/(\s)?slide-up/, '');
        $('#build-menu').className = $('#build-menu').className.replace(/(\s)?slide-down/, '');
        $('#build-menu').className += ' slide-down';
    },

    /**
     * Creates a new building on the selected tile. Returns false if the building is failed to
     * build.
     */
    buildBuilding: function (buildingIndex) {
        if (buildingIndex == null) {
//            $('#build-info').innerHTML = 'Select a building to build.';
            return;
        }
        if (MedievalCity.selectedObject.id == null) {
            return;
        }

        var building = MedievalCity.availableBuildings[buildingIndex].object();

        if ( (building.stats.grain > grainTotal) || (building.stats.stone > grainTotal) || (building.stats.lumber > grainTotal) ){
            this.hideBuildMenu();
            this.toggle_visibility('popupBoxOther');
            return;
        }

        if(building.name == 'Main Building') {
            mainBuildingExist = true;
        }

        if(mainBuildingExist == false){
            this.hideBuildMenu();
            this.toggle_visibility('popupBoxMainBuilding');
            return;
        }


        if (building.collisionable == true) {
            var testGrid = [];
            for (var i = 0; i < MedievalCity.gridPath.length; i++) {
                testGrid[i] = [];
                for (var j = 0; j < MedievalCity.gridPath[i].length; j++) {
                    var open = true;
                    if (MedievalCity.gridPath[i][j] == false) {
                        open = false;
                    }
                    testGrid[i][j] = open;
                }
            }
            testGrid[MedievalCity.selectedObject.gridPosition.x][MedievalCity.selectedObject.gridPosition.y] = false;
            MedievalCity.FindPath.postMessage(
              {
                  grid: testGrid,
                  start: {
                      x: MedievalCity.WoodTile.gridPosition.x,
                      y: MedievalCity.WoodTile.gridPosition.y
                  },
                  end: {
                      x: MedievalCity.StoneTile.gridPosition.x,
                      y: MedievalCity.StoneTile.gridPosition.y
                  },
                  returnAttributes: {
                      buildBuilding: buildingIndex
                  }
              }
            );
        }
        else {
            building.create();
            building.spawn(MedievalCity.selectedObject);
            building.add();
            MedievalCity.deselectAll();
            MedievalCity.Ui.hideBuildMenu();
        }
    }

}