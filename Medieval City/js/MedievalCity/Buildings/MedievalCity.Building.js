MedievalCity.Building = function () {

    MedievalCity.Element.call( this );
    this.name = ''; // Name of the Building
    this.description = ''; // Description of the Building. May contain HTML
    this.stats = {
        grain: 1,
        stone: 1,
        lumber: 1
    }
    this.icon = 'default.png'; // Building icon

    this.material = new THREE.MeshLambertMaterial( { color: 0x368218 } );
    this.geometry = new THREE.BoxGeometry( .85, .85, 2 );
    this.collisionable = true;

    this.lastUpdate = Date.now();
}
// @todo create prototype
MedievalCity.Building.prototype = Object.create( MedievalCity.Element.prototype );

MedievalCity.Building.prototype.constructor = MedievalCity.Building;

MedievalCity.Building.prototype.create = function () {

    MedievalCity.Element.prototype.create.call(this);

}

/**
 * Spawns the Building to the selected tileObject
 * @param tileObject
 * @returns boolean
 */
MedievalCity.Building.prototype.spawn = function(tileObject) {

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
        MedievalCity.gridPath[tileObject.gridPosition.x][tileObject.gridPosition.y] = false;
    }
    MedievalCity.Building.buildingPosX = tileObject.gridPosition.x;
    MedievalCity.Building.buildingPosY = tileObject.gridPosition.y;
    tileObject.object.add(this.object);
    tileObject.currentBuilding = this;
    return true;

}

MedievalCity.Building.prototype.update = function () {
    this.lastUpdate = Date.now();
    if (this.object.parent != null && (this.lastUpdate + this.stats.speed < MedievalCity.time)) {
        this.buildingAbility();
    }
}