var MedievalCity = MedievalCity || {

    revision: 1,
    __pause: true,
    __loading: false,
    currentLevel: {}, // Holds the object of the current level
    gameWidth: window.innerWidth,
    gameHeight: window.innerHeight,
    /**
     * Holds all the game objects. The .update() function will be called for each main
     * update.
     */
    objects: [],
    grid: [], // holds the x, y position of each tile and it's tile object
    gridPath: [], // holds the x, y position of each tile and a zero (open) or one (closed)
    nodes: [], // Holds the x, y position and GraphNode object,

    /**
     * Holds THREE.js objects for rendering the WebGL canvas such as scene, camera and
     * projector for the game.
     */
    scene: {},
    camera: {},
    renderer: {},
    projector: {},
    manager: {}, // Holds three js loading manager

    controls: {}, // Hold the controls for camera movement

    meshObjects: [], // List with key => array(file, key, mesh)
    meshTextures: [], // list with key => array(file, key, texture)

    clock: new THREE.Clock(),

    /**
     * Settings for the game/objects
     */
    settings: {

        debug: false,
        advancedLight: true,
        advancedMaterials: true,
    },

    /**
     * Global config settings and variables
     */
    config: {

        maxRange: 100, // Max range of a building,
        maxSpeed: 50, // Interval in ms for shooting bullets
        maxDamage: 50 // Max damage for bullet impact

    },

    /**
     * Object with game stats like score, grain, etc
     */
    stats: {
        grain: 555,
        stone: 0,
        lumber: 50
    },

    /**
     * Holds all available buildings to build with their info
     */
    availableBuildings: [
        {
            object: function() { return new MedievalCity.MainBuilding(); }
        },
        {
            object: function() { return new MedievalCity.LumberJackBuilding(); }
        },
        {
            object: function() { return new MedievalCity.StoneBuilding(); }
        },
        {
            object: function() { return new MedievalCity.WindMill(); }
        }
    ],


    WoodTile: {},
    StoneTile: {},
    GrainTile: {},
    /**
     * Holds the current selected Object
     */
    selectedObject: {},

    /**
     * Current time in milliseconds. Can be used for buildingAbility.
     */
    time: Date.now(),
    counter: 0,

    FindPath: new Worker("js/lib/Worker.PathFinder.js"),

    initialize: function() {

        // FindPath WebWorker
        this.FindPath.addEventListener("message", function (oEvent) {
            if (oEvent.data.returnAttributes != null && oEvent.data.returnAttributes.moveObject != null && MedievalCity.objects[oEvent.data.returnAttributes.moveObject] != null) {
                MedievalCity.objects[oEvent.data.returnAttributes.moveObject].move(oEvent.data.path);
            }
            if (oEvent.data.returnAttributes != null && oEvent.data.returnAttributes.buildBuilding != null) {
                var building = MedievalCity.availableBuildings[oEvent.data.returnAttributes.buildBuilding].object();
                building.create();
                building.spawn(MedievalCity.selectedObject);
                MedievalCity.stats.grain -= building.stats.costs;
                building.add();
                MedievalCity.Ui.selectedBuilding = null;
                MedievalCity.deselectAll();
                MedievalCity.Ui.hideBuildMenu();
            }
        }, false);

        this.manager = new THREE.LoadingManager();
        this.manager.onProgress = function ( item, loaded, total ) {

            MedievalCity.Ui.loadingProgress(item, loaded, total);

        };

        MedievalCity.Ui.initialize();

    },

    reset: function() {

        this.objects.forEach( function(object) {

            object.remove();

        });
        this.objects = [];
        if (gameRender != null) {
            window.cancelAnimationFrame(gameRender);
        }
        MedievalCity.scene = null;
        MedievalCity.renderer = null;
        MedievalCity.projector = null;
        MedievalCity.camera = null;

    },

    /**
     * Loops through this.meshObjects and this.meshTextures and loads (and fills) the
     * files.
     * @param callback
     */
    loadObjects: function(callback) {

        var meshLoader = new THREE.OBJLoader( this.manager );
        var textureLoader = new THREE.ImageLoader( this.manager );

        var totalLoaded = 0;

        this.meshObjects.forEach (function (mesh) {
            var key = mesh.key;
            if (MedievalCity.meshObjects[key] == null) {
                MedievalCity.meshObjects[key] = {};
            }
            if (mesh.object == null || mesh.object == '') {
                totalLoaded++;
                MedievalCity.meshObjects[key].object = '';
                meshLoader.load( mesh.file + '?t=' + Date.now(), function ( object ) {
                    MedievalCity.meshObjects[key].object = object.children[0];
                    totalLoaded--;
                    finishLoading();
                } );
            }
        });

        this.meshTextures.forEach (function (texture) {
            var key = texture.key;
            if (MedievalCity.meshTextures[key] == null) {
                MedievalCity.meshTextures[key] = {};
            }
            if (texture.texture == null || texture.texture == '') {
                totalLoaded++;
                MedievalCity.meshTextures[key].texture = new THREE.Texture();
                textureLoader.load( texture.file, function ( image ) {

                    MedievalCity.meshTextures[key].texture.image = image;
                    MedievalCity.meshTextures[key].texture.needsUpdate = true;

                    totalLoaded--;
                    finishLoading();
                } );
            }
        });

        var finishLoading = function() {
            if (totalLoaded <= 0 && typeof callback == 'function') {
                callback();
            }

        }

    },

    __addObject: function (object) {

        // Loop through already placed objects and updates them if needed for the lights.
        // https://github.com/mrdoob/three.js/wiki/Updates#materials
        this.objects.forEach( function (object) {
            if (object.material != null && object.material.map != null && object.material.map.needsUpdate == false) {
                object.material.needsUpdate = true;
                object.material.map.needsUpdate = true;
            }
        });
        this.objects[object.id] = object;
        return true;

    },

    __removeObject: function (object) {

        if (object.object != null) {
            MedievalCity.scene.remove(object.object);
        }
        delete(this.objects[object.id]);
        delete(object);

    },

    update: function() {

        this.objects.forEach( function(object) {

            object.update();

        });

        if (this.currentLevel.update != null) {
            this.currentLevel.update();
        }

        this.time = Date.now();
        this.counter++;
        document.getElementById("game-lumber").innerHTML = woodTotal;
        document.getElementById("game-stone").innerHTML = stoneTotal;
        document.getElementById("game-grain").innerHTML = grainTotal;

    },

    deselectAll: function() {

        this.objects.forEach(function(object, index) {

            if (typeof object.deselect == 'function') {

                object.deselect();

            }

        });

        MedievalCity.selectedObject = {};

    },

    /**
     * Clears all objects from a scene
     * @param scene (optional) the scene to clear.
     */
    clearScene: function(scene) {
        if (scene == null && this.scene != null && this.scene.id != null) {
            scene = this.scene;
        }
        if (scene == null || scene.id == null) {
            return;
        }
        this.objects.forEach(function (object) {
            scene.remove(object.object);
        });
    }
}