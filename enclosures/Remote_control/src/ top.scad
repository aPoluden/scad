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

difference() {
    translate([0, 0, oheight]) {
        enclousureTop(0, 0, 0);
    }
    enclousureBottom(0, 0, 0);
}

// Enclousure module
module enclousureTop(xpos, ypos, zpos) {
    // buttons specs
    butw = 3.5;
    butcenter = wthikness + (butw / 2);
    but1 = 3 + butcenter;
    but2 = but1 + butw + 7;
    but3 = but2 + butw + 7.7;
    
    translate([xpos, ypos, zpos]) {
        difference() {
            mainBox();
            translate([wthikness, wthikness ,0]) {
                cube([ilenght, iwidht, iheight]);
            }
            // buttons spaces
            translate([but1, wthikness + (iwidht / 2), oheight - wthikness]) {
                cylinder(r = br, h = wthikness);
            }
            translate([but2, wthikness + (iwidht / 2), oheight - wthikness]) {
                cylinder(r = br, h = wthikness);
            }            translate([wthikness, wthikness ,0]) {
                cube([ilenght, iwidht, iheight]);
            }
            translate([but3, wthikness + (iwidht / 2), oheight - wthikness]) {
                cylinder(r = br, h = wthikness);
            }
            // led space
            translate([wthikness + 3, wthikness + 5, oheight - wthikness]) {
                cylinder(r = 2 , h = wthikness);
            }
        }
    }
}

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