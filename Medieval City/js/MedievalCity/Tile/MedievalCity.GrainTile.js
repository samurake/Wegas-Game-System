MedievalCity.GrainTile = function () {

    MedievalCity.Tile.call( this );

    this.meshObject = 'grain';
    this.meshTexture = 'grain';
    this.material = new THREE.MeshLambertMaterial( { color: 0xf47912 } );
    this.materialEmissive = '0xf47912';
}

MedievalCity.GrainTile.prototype = Object.create( MedievalCity.Tile.prototype);

MedievalCity.GrainTile.prototype.create = function () {

    MedievalCity.Tile.prototype.create.call(this);

    this.object.rotation.x = Math.PI / 2;
    this.object.scale.x = 10;
    this.object.scale.y = 9;
    this.object.scale.z = 8;
    return this.object;
}

MedievalCity.GrainTile.prototype.select = function() {
    return false;
}
MedievalCity.GrainTile.prototype.deselect = function() {
    return false;
}