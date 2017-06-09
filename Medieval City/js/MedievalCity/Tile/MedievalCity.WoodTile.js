MedievalCity.WoodTile = function () {

    MedievalCity.Tile.call( this );
    this.meshObject = 'log';
    this.meshTexture = 'log';

}

MedievalCity.WoodTile.prototype = Object.create( MedievalCity.Tile.prototype );

MedievalCity.WoodTile.prototype.create = function () {

    MedievalCity.Tile.prototype.create.call(this);

    this.object.scale.x = 0.07;
    this.object.scale.y = 0.045;
    this.object.scale.z = 0.04;
    return this.object;
}

MedievalCity.WoodTile.prototype.select = function() {
    return false;
}
MedievalCity.WoodTile.prototype.deselect = function() {
    return false;
}