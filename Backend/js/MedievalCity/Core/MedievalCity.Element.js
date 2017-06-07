/**
 * Basic method that apply to all objects will be placed here.
 * @constructor
 */
MedievalCity.Element = function () {

    /**
     * The unique id of the object
     */
    this.id = MedievalCity.elementCount++;

    /**
     * Type of the current object. e.g. building or ENEMY. Can be used to handle special
     * actions.
     * @type {string}
     */
    this.type = '';

    this.material = {};
    this.geometry = {};
    this.meshTexture = ''; // Key with the texture. @see MedievalCity.meshTextures
    this.meshTextureSpec = null;
    this.meshTextureNormal = null;
    this.phongMaterial = false;
    this.receiveShadow = true;
    this.castShadow = true;
    this.meshObject = ''; // Key with object. @see MedievalCity.meshObjects
    this.materialTransparent = false;

    this.materialEmissive = '0x000000';

    /**
     * Holds the 3D (Three) mesh
     */
    this.object = {};

    /**
     * Whether this object is selected or not
     * @type {boolean}
     */
    this.selected = false;

    /**
     * Whether the current object is selectable
     * @type {boolean}
     */
    this.selectable = false;

}

MedievalCity.Element.prototype = {

    /**
     * Creates the three.js mesh with this.material and this.geometry.
     */
    create: function() {

        if (this.meshObject != null && this.meshObject != '') {
            var refObject = MedievalCity.meshObjects[this.meshObject];
            this.geometry = refObject.object.geometry;
        }

        if (this.meshTexture != null && this.meshTexture != '') {
            var texture = MedievalCity.meshTextures[this.meshTexture];
            texture = texture.texture;
            var spec = null;
            if (this.meshTextureSpec != null) {
                spec = MedievalCity.meshTextures[this.meshTextureSpec];
                spec = spec.texture;
            }
            var normal = null;
            if (this.meshTextureNormal != null) {
                normal = MedievalCity.meshTextures[this.meshTextureNormal];
                normal = normal.texture;
            }
            if (this.phongMaterial == true && MedievalCity.settings.advancedMaterials == true) {
                this.material = new THREE.MeshPhongMaterial(
                  {
                      map: texture,
                      emissive: parseInt(this.materialEmissive),
                      specularMap: spec,
                      normalMap: normal,
                      shininess: 0,
                      transparent: this.materialTransparent
                  }
                );
            }
            else {
                this.material = new THREE.MeshLambertMaterial(
                  {
                      map: texture,
                      emissive: parseInt(this.materialEmissive),
                      specularMap: spec,
                      transparent: this.materialTransparent
                  }
                );
            }
            if (this.materialTransparent == true) {
                this.material.depthWrite = false;
            }
        }

        this.geometry.computeVertexNormals();

        this.object = new THREE.Mesh( this.geometry, this.material );
        if (MedievalCity.settings.advancedLight == true && this.receiveShadow == true) {
            this.object.receiveShadow = true;
        }
        if (MedievalCity.settings.advancedLight == true && this.castShadow == true) {
            this.object.castShadow = true;
        }
        return this.object;

    },

    /**
     * Spawn the object into the game.
     */
    spawn: function() {

    },

    add: function () {

        return MedievalCity.__addObject(this);

    },

    remove: function () {

        MedievalCity.__removeObject(this);

    },

    update: function() {

    },

    /**
     * Logical callback after user clicked on this object
     */
    select: function() {

    },

    /**
     * Logical callback after object is deselected
     */
    deselect: function() {

    }

}

MedievalCity.elementCount = 0;