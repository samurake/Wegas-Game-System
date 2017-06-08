MedievalCity.Level1 = function () {

    MedievalCity.Level.call( this );

    this.meshes = [
        {
            'key': 'building-01',
            'file': 'assets/buildings/building-01.obj'
        },
        {
            'key': 'building-02',
            'file': 'assets/buildings/building-02.obj'
        },
        {
            'key': 'building-03',
            'file': 'assets/buildings/building-03.obj'
        },
        {
            'key': 'building-04',
            'file': 'assets/buildings/building-04.obj'
        },
        {
            'key': 'stone',
            'file': 'assets/resources/stone.obj'
        },
        {
            'key': 'log',
            'file': 'assets/resources/log.obj'
        },
        {
            'key': 'grain',
            'file': 'assets/resources/grain.obj'
        }
    ];
    this.textures = [
        {
            'key': 'building-01',
            'file': 'assets/buildings/building-01.jpg'
        },
        {
            'key': 'building-02',
            'file': 'assets/buildings/building-02.jpg'
        },
        {
            'key': 'building-03',
            'file': 'assets/buildings/building-03.jpg'
        },
        {
            'key': 'building-04',
            'file': 'assets/buildings/building-04.jpg'
        },
        {
            'key': 'bullet-01',
            'file': 'assets/buildings/bullet-01.png'
        },
        {
            'key': 'bullet-02',
            'file': 'assets/buildings/bullet-02.png'
        },
        {
            'key': 'level-01',
            'file': 'assets/levels/level-01_COLOR.png'
        },
        {
            'key': 'level-01-nrm',
            'file': 'assets/levels/level-01_NRM.png'
        },
        {
            'key': 'level-01-spec',
            'file': 'assets/levels/level-01_SPEC.png'
        },
        {
            'key': 'stone',
            'file': 'assets/resources/stone.jpg'
        },
        {
            'key': 'log',
            'file': 'assets/resources/log.jpg'
        },
        {
            'key': 'grain',
            'file': 'assets/resources/grain.jpg'
        }
    ];

}

MedievalCity.Level1.prototype = Object.create( MedievalCity.Level.prototype );