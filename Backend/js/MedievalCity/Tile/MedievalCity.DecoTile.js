/**
 * Tile for decoration the underground
 * @constructor
 */
MedievalCity.DecoTile = function () {

    MedievalCity.Tile.call( this );
    this.meshTexture = 'level-01';
    this.meshTextureSpec = 'level-01-spec';
    this.phongMaterial = true;
    this.geometry = new THREE.BoxGeometry( 1000, 1000, 1);
    this.selectable = false;

}

MedievalCity.DecoTile.prototype = Object.create( MedievalCity.Tile.prototype );

MedievalCity.DecoTile.prototype.select = function() {
    return false;
}