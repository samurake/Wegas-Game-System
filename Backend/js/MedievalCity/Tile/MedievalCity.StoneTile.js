MedievalCity.StoneTile = function () {

    MedievalCity.Tile.call( this );
    this.meshObject = 'stone';
    this.meshTexture = 'stone';

}

MedievalCity.StoneTile.prototype = Object.create( MedievalCity.Tile.prototype);

MedievalCity.StoneTile.prototype.create = function () {

    MedievalCity.Tile.prototype.create.call(this);

    this.object.rotation.x = Math.PI / 2;
    this.object.scale.x = 20;
    this.object.scale.y = 20;
    this.object.scale.z = 20;

    return this.object;
}

MedievalCity.StoneTile.prototype.select = function() {
    return false;
}
MedievalCity.StoneTile.prototype.deselect = function() {
    return false;
}