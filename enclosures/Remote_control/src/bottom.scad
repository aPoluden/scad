$fn = 100;

// vysota schemy
h = 10.5;
// enclousure params
paz = 2;
// enclousure wall thikness
wthikness = 1.5;
// i* - inner
iheight = h / 2;
iwidht = 31.5;
ilenght = 41.2;

// o* - outer
olenght = ilenght + wthikness * 2;
owidht = iwidht + wthikness * 2;
oheight = iheight + wthikness;
// corner radius
cr = 2.5;
pazcr = cr - 1; // s obei storon po 0.5 
// buttons radius
br = 3;

enclousureBottom(0, 0, 0);

module mainBox() {
    hull() {
        translate([cr, cr, 0]) {
            cylinder(r = cr, h = iheight + wthikness);
        }
        translate([olenght - cr, owidht - cr, 0]) {
            cylinder(r = cr, h = iheight + wthikness);
        }
        translate([olenght - cr, cr, 0]) {
            cylinder(r = cr, h = iheight + wthikness);
        }
        translate([cr, owidht - cr, 0]) {
            cylinder(r = cr, h = iheight + wthikness);
        }
    }
}

// Enclousure module
module enclousureBottom(xpos, ypos, zpos) {
    translate([xpos, ypos, zpos]) {
        difference() {
            mainBox();
            translate([wthikness, wthikness , wthikness]) {
                cube([ilenght, iwidht, iheight]);
            }
        }
        // Peregorodka
        translate([33, wthikness + (iwidht - 20) / 2, wthikness]) {
            cube([1, 20, iheight]);
        }
        // Paz
        translate([wthikness - 0.5 , wthikness - 0.5, wthikness + iheight]) {
            paz();
        }
    }
}

module paz() {
    difference() {
        cube([ilenght + 1, iwidht + 1, paz]);
        translate([0.5, 0.5, 0]) {
            cube([ilenght, iwidht, paz]);
        }
    }
}