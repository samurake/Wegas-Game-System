MedievalCity.WindMill = function () {

    MedievalCity.Building.call( this );

    this.name = 'WindMill';
    this.description = '<p>This building generates grains.</p>';
    this.meshObject = 'building-04';
    this.meshTexture = 'building-04';
    this.icon = 'building-04.png';
    this.stats = {
        grain: 50,
        stone: 20,
        lumber: 150
    }
    this.material = new THREE.MeshLambertMaterial( { color: 0xcccccc } );
    this.materialEmissive = '0xcecece';
}

MedievalCity.WindMill.prototype = Object.create( MedievalCity.Building.prototype );

MedievalCity.WindMill.prototype.create = function () {

    MedievalCity.Building.prototype.create.call(this);

    this.object.rotation.x = Math.PI / 2;
    this.object.scale.x = 0.05;
    this.object.scale.y = 0.07;
    this.object.scale.z = 0.05;

    return this.object;
}

MedievalCity.WindMill.prototype.spawn = function(tileObject){

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
    var posWoodTileX = MedievalCity.Level.getGrainTilePositionX();
    var posWoodTileY = MedievalCity.Level.getGrainTilePositionY();
    if ( ((posWoodTileX - posBuildingX == 0) || (posWoodTileX - posBuildingX == 1) || (posWoodTileX - posBuildingX == -1))
        && ((posWoodTileY - posBuildingY == 0) || (posWoodTileY - posBuildingY == 1) || (posWoodTileY - posBuildingY == -1)) ) {
        grainResources++;
        var updateStats = setInterval(function() {
            grainTotal = grainTotal + grainResources;
        }, 1000);
    }
    return true;
}

MedievalCity.WindMill.prototype.buildingAbility = function () {
}