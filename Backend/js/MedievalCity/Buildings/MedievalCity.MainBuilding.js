MedievalCity.MainBuilding = function () {

    MedievalCity.Building.call( this );

    this.name = 'Main Building';
    this.description = '<p>The main building in the game.</p>';
    this.meshObject = 'building-01';
    this.meshTexture = 'building-01';
    this.icon = 'building-01.png';
    this.stats = {
        grain: 500,
        stone: 500,
        lumber: 500
    }
    this.material = new THREE.MeshLambertMaterial( { color: 0xcccccc } );
    this.materialEmissive = '0xcecece';
}

MedievalCity.MainBuilding.prototype = Object.create( MedievalCity.Building.prototype );

MedievalCity.MainBuilding.prototype.create = function () {

    MedievalCity.Building.prototype.create.call(this);

    this.object.rotation.x = Math.PI / 2;
    this.object.scale.x = 6;
    this.object.scale.y = 5;
    this.object.scale.z = 6;

    return this.object;

}

MedievalCity.MainBuilding.prototype.spawn = function(tileObject){

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

    mainBuildingRes++;
    var updateStats = setInterval(function () {
        grainTotal = grainTotal + mainBuildingRes;
        stoneTotal = stoneTotal + mainBuildingRes;
        woodTotal = woodTotal + mainBuildingRes;
    }, 1000);
    mainBuildingExist = true;
    return true;
}

MedievalCity.MainBuilding.prototype.buildingAbility = function () {

}