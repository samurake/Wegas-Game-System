MedievalCity.LumberJackBuilding = function () {

    MedievalCity.Building.call( this );

    this.name = 'Lumberjack Building';
    this.description = '<p>This building generates lumber.</p>';
    this.meshObject = 'building-02';
    this.meshTexture = 'building-02';
    this.icon = 'building-02.png';
    this.stats = {
        grain: 50,
        stone: 40,
        lumber: 85
    }
    this.material = new THREE.MeshLambertMaterial( { color: 0xcccccc } );
    this.materialEmissive = '0xfffde8';
}
MedievalCity.LumberJackBuilding.prototype = Object.create( MedievalCity.Building.prototype );

MedievalCity.LumberJackBuilding.prototype.create = function () {

    MedievalCity.Building.prototype.create.call(this);

    this.object.rotation.x = Math.PI / 2;
    this.object.scale.x = 0.145;
    this.object.scale.y = 0.107;
    this.object.scale.z = 0.145;

    return this.object;
}

MedievalCity.LumberJackBuilding.prototype.spawn = function(tileObject){

    if (tileObject == null) {
        console.log('Cannot build Building on the selected tile.');
        return false;
    }
    if (tileObject.currentBuilding.id != null) {
        console.log('Already Building on this tile.');
        return false;
    }

    if (this.collisionable == true) {
        MedievalCity.grid[tileObject.gridPosition.x][tileObject.gridPosition.y].open = false;
    }
    tileObject.object.add(this.object);
    tileObject.currentBuilding = this;

    grainTotal= grainTotal - this.stats.grain;
    stoneTotal = stoneTotal - this.stats.stone;
    woodTotal = woodTotal - this.stats.lumber;

    var posBuildingX = tileObject.gridPosition.x;
    var posBuildingY = tileObject.gridPosition.y;
    var posWoodTileX = MedievalCity.Level.getWoodTilePositionX();
    var posWoodTileY = MedievalCity.Level.getWoodTilePositionY();
    if ( ((posWoodTileX - posBuildingX == 0) || (posWoodTileX - posBuildingX == 1) || (posWoodTileX - posBuildingX == -1))
        && ((posWoodTileY - posBuildingY == 0) || (posWoodTileY - posBuildingY == 1) || (posWoodTileY - posBuildingY == -1)) ) {
        woodResources++;
        var updateStats = setInterval(function() {
            woodTotal = woodTotal + woodResources;
        }, 1000);
    }
    return true;
}

MedievalCity.LumberJackBuilding.prototype.buildingAbility = function () {
}