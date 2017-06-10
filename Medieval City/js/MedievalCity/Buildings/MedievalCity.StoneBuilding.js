MedievalCity.StoneBuilding = function () {

    MedievalCity.Building.call( this );

    this.name = 'Stone Building';
    this.description = '<p>This building generates stone.</p>';
    this.meshObject = 'building-03';
    this.meshTexture = 'building-03';
    this.stats = {
        grain: 50,
        stone: 60,
        lumber: 75
    }
    this.icon = 'building-03.png';
    this.material = new THREE.MeshLambertMaterial( { color: 0xcccccc } );
    this.materialEmissive = '0xcecece';
}

MedievalCity.StoneBuilding.prototype = Object.create( MedievalCity.Building.prototype );

MedievalCity.StoneBuilding.prototype.create = function () {

    MedievalCity.Building.prototype.create.call(this);

    this.object.rotation.x = Math.PI / 2;
    this.object.scale.x = 0.05;
    this.object.scale.y = 0.05;
    this.object.scale.z = 0.05;

    return this.object;

}

MedievalCity.StoneBuilding.prototype.spawn = function(tileObject){

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
    var posWoodTileX = MedievalCity.Level.getStoneTilePositionX();
    var posWoodTileY = MedievalCity.Level.getStoneTilePositionY();
    if ( ((posWoodTileX - posBuildingX == 0) || (posWoodTileX - posBuildingX == 1) || (posWoodTileX - posBuildingX == -1))
        && ((posWoodTileY - posBuildingY == 0) || (posWoodTileY - posBuildingY == 1) || (posWoodTileY - posBuildingY == -1)) ) {
        stoneResources++;
        var updateStats = setInterval(function() {
            stoneTotal = stoneTotal + stoneResources;
        }, 1000);
    }
    return true;
}

MedievalCity.StoneBuilding.prototype.buildingAbility = function () {

}