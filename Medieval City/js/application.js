var gameRender;

/**
 * Camera Lookpoint. Because we use MouseOrbit.
 * @type {THREE.Vector3}
 */
var lookpoint = new THREE.Vector3(0,10,0);
var mainBuildingExist = false;
/**
 * Resource multipliers and vars.
 */
var woodResources  = 0;
var stoneResources = 0;
var grainResources = 0;

var woodTotal = 600;
var stoneTotal = 600;
var grainTotal = 600;

var mainBuildingRes = 0;

/**
 * Three.js render starting function!
 */

function render() {

    gameRender = requestAnimationFrame(render, null);
    MedievalCity.renderer.render(MedievalCity.scene, MedievalCity.camera);
    MedievalCity.update();

}

MedievalCity.initialize();