MedievalCity.Tile = function () {

    MedievalCity.Element.call( this );
    this.gridPosition = { x: 0, y: 0 };
    this.material = new THREE.MeshPhongMaterial( { color: 0xffffff, transparent: true, opacity:0 } );
    this.squareSize = 60;
    this.geometry = new THREE.PlaneGeometry( this.squareSize, this.squareSize);
    this.selectable = true;
    this.open = true; // open or closed for enemy traffic
    this.currentBuilding = {}; // Object with the current Building
}

MedievalCity.Tile.prototype = Object.create( MedievalCity.Element.prototype );

MedievalCity.Tile.prototype.constructor = MedievalCity.Tile;

MedievalCity.Building.prototype.create = function () {

    MedievalCity.Element.prototype.create.call(this);

}

MedievalCity.Tile.prototype.select = function() {

    this.selected = true;
    MedievalCity.selectedObject = this;
    MedievalCity.Ui.showBuildMenu();
    this.object.material.opacity = .2;

};

MedievalCity.Tile.prototype.deselect = function() {

    this.selected = false;
    this.object.material.opacity = 0;

};

MedievalCity.Tile.prototype.update = function() {

};