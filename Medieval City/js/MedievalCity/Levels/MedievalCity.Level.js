MedievalCity.Level = function () {
    /**
     * List of meshes to load on the current level
     * @type {Array}
     * @example
     {
         'key': 'building-01',
         'file': 'assets/buildings/building-01.obj'
     },
     */
    this.meshes = [];

    /**
     * List of textures to load for the current level
     * @type {Array}
     * @example
     {
         'key': 'building-01',
         'file': 'assets/buildings/building-01.jpg'
     },
     */
    this.textures = [];

    this.sizes = {
        x: 15,
        y: 15
    }

    /**
     * The complete grid with [x][y] = tile info
     * @type {Array}
     */


    var random1,random2,random3,random4,random5,random6;
    do {
        random1 = Math.floor((Math.random() * 15) + 1) - 1;
        random2 = Math.floor((Math.random() * 15) + 1) - 1;
        random3 = Math.floor((Math.random() * 15) + 1) - 1;
        random4 = Math.floor((Math.random() * 15) + 1) - 1;
        random5 = Math.floor((Math.random() * 15) + 1) - 1;
        random6 = Math.floor((Math.random() * 15) + 1) - 1;
    } while((random1 == random3 && random2 == random4) || (random1 == random5 && random2 == random6) || (random3 == random5 && random4 == random6)
    || (random1 == random3) || (random1 == random5) || (random3 == random5));

    MedievalCity.Level.woodTilePosX = random1;
    MedievalCity.Level.woodTilePosY = random2;
    MedievalCity.Level.stoneTilePosX = random3;
    MedievalCity.Level.stoneTilePosY = random4;
    MedievalCity.Level.grainTilePosX = random5;
    MedievalCity.Level.grainTilePosY = random6;

    console.log("Lemn:" + random1 + " " + random2);
    console.log("Stone:" + random3 + " " + random4);
    console.log("Grau:" + random5 + " " + random6);

    this.grid = [];
    this.grid[random1] = [];
    this.grid[random1][random2] = {
        object: function() {
            return new MedievalCity.WoodTile();
        },
        callback: function(tile) {
            MedievalCity.WoodTile = tile;
        }
    };
    this.grid[random3] = [];
    this.grid[random3][random4] = {
        object: function() {
            return new MedievalCity.StoneTile();
        },
        callback: function(tile) {
            MedievalCity.StoneTile = tile;
        }
    };

    this.grid[random5] = [];
    this.grid[random5][random6] = {
        object: function() {
            return new MedievalCity.GrainTile();
        },
        callback: function(tile) {
            MedievalCity.Grain = tile;
        }
    };
}

MedievalCity.Level.getWoodTilePositionX = function() {
    return MedievalCity.Level.woodTilePosX;
}

MedievalCity.Level.getWoodTilePositionY = function() {
    return MedievalCity.Level.woodTilePosY;
}

MedievalCity.Level.getStoneTilePositionX = function() {
    return MedievalCity.Level.stoneTilePosX;
}

MedievalCity.Level.getStoneTilePositionY = function() {
    return MedievalCity.Level.stoneTilePosY;
}

MedievalCity.Level.getGrainTilePositionX = function() {
    return MedievalCity.Level.grainTilePosX;
}

MedievalCity.Level.getGrainTilePositionY = function() {
    return MedievalCity.Level.grainTilePosY;
}

MedievalCity.Level.prototype.constructor = MedievalCity.Level;

MedievalCity.Level.prototype.update = function() {
}

/**
 * Loads all objects for this level.
 * @param callback the callback after finishing loading. Default this.start
 */
MedievalCity.Level.prototype.load = function(callback) {

    MedievalCity.meshObjects = this.meshes;
    MedievalCity.meshTextures = this.textures;
    MedievalCity.loadObjects(callback);

}

/**
 * Starts the level timing,etc
 */
MedievalCity.Level.prototype.start = function () {

    var self = this;
    this.load(function() {
        self.createScene();
        self.createGrid();
        self.createDecoration();
        $('#game').appendChild( MedievalCity.renderer.domElement );
        handleWebGlErrors(
          MedievalCity.renderer.domElement,
          function (event) {
              event.preventDefault();
              cancelAnimationFrame(gameRender);
              console.log('WebGL context lost.', event);
          }
        );
        render();
        MedievalCity.Ui.initializeControls(MedievalCity.camera);
        MedievalCity.currentLevel = self;
    });
    //$('#game-maxwave').innerHTML = this.waves.length;
    //$('#game-wave').innerHTML = this.currentWave;
}

MedievalCity.Level.prototype.createScene = function () {

    MedievalCity.clearScene(MedievalCity.scene);
    MedievalCity.scene = new THREE.Scene();
    MedievalCity.camera = new THREE.PerspectiveCamera( 70, MedievalCity.gameWidth / MedievalCity.gameHeight, 1, 10000 );
    MedievalCity.camera.position.x = 60;
    MedievalCity.camera.position.y = -170;
    MedievalCity.camera.position.z = 120;
    MedievalCity.camera.up = new THREE.Vector3(0,0,1);
    MedievalCity.camera.lookAt(lookpoint);
    MedievalCity.renderer = new THREE.WebGLRenderer({alpha:true});
    MedievalCity.renderer.setSize( MedievalCity.gameWidth, MedievalCity.gameHeight );
    MedievalCity.renderer.setClearColorHex( 0xa5dfd8, 1 );
    MedievalCity.projector = new THREE.Projector();
    cancelAnimationFrame(gameRender);
    $('#game').innerHTML = '';

}

MedievalCity.Level.prototype.createGrid = function() {

    var x = 0;
    var y = 0;
    var tile = {};
    for (var i = 0; i <= this.sizes.x; i++ ) {

        x = i;
        if (this.grid[x] == null) {
            this.grid[x] = [];
        }
        MedievalCity.grid[x] = [];
        MedievalCity.gridPath[x] = [];
        for (var j = 0; j <= this.sizes.y; j++) {

            y = j;
            if (this.grid[x][y] == null) {
                this.grid[x][y] = [];
            }
            if (typeof this.grid[x][y].object == 'function') {
                tile = this.grid[x][y].object();
                if (typeof this.grid[x][y].callback == 'function') {
                    this.grid[x][y].callback(tile);
                }
            }
            else {
                tile = new MedievalCity.BasicTile();
            }
            tile.gridPosition = { x: x, y: y };
            MedievalCity.grid[x][y] = tile;
            MedievalCity.gridPath[x][y] = tile.open;
            tile.create();
            tile.add();
            var positionX = -(this.sizes.x * tile.squareSize / 2) + (i * Math.round(tile.squareSize));
            var positionY = -(this.sizes.y * tile.squareSize / 2) + (j * Math.round(tile.squareSize));
            tile.object.position.x = positionX;
            tile.object.position.y = positionY;
            MedievalCity.scene.add(tile.object);

        }

    }

}

/**
 * Callback after the grid and tiles are created.
 */
MedievalCity.Level.prototype.createDecoration = function() {

    var decoTile = new MedievalCity.DecoTile();
    decoTile.create();
    decoTile.object.position.z = -.6;
    decoTile.add();
    MedievalCity.scene.add(decoTile.object);

    var hemiLight = new THREE.HemisphereLight( 0xffe0cb, 0xffe0cb, 1); // sky, ground, intensity
    hemiLight.position.set( 0, 0, 50 );
    hemiLight.shadowBias = -0.001;
    MedievalCity.scene.add( hemiLight );

    var imagePrefix = "assets/skybox/";
    var directions  = ["posx", "negx", "posy", "negy", "posz", "negz"];
    var imageSuffix = ".png";

    var materialArray = [];
    for (var i = 0; i < 6; i++)
        materialArray.push( new THREE.MeshBasicMaterial({
            map: THREE.ImageUtils.loadTexture( imagePrefix + directions[i] + imageSuffix ),
            side: THREE.BackSide
        }));

    var skyGeometry = new THREE.CubeGeometry( 8500, 8500, 8500 );
    var skyMaterial = new THREE.MeshFaceMaterial( materialArray );
    var skyBox = new THREE.Mesh( skyGeometry, skyMaterial );
    skyBox.rotation.x += Math.PI / 2;
    MedievalCity.scene.add( skyBox );
}