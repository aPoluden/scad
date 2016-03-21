$fn = 100;
// Cap width
capW = 37;
// Cap length
capL = 65;
// Cap height
capH = 2.03;
// screw slot radius
screwR = 8.5;

// init CAP
cap(0, 0, 0);

// main module
module cap(xpos, ypos, zpos)  {
    rCorners = 2; 
    holderL = 5 ;
    holderW = 5;
    holderH = 1;
    union() {
       translate([xpos + rCorners, ypos + rCorners, zpos]) {
            // main surface
            hull() {    
                cylinder(h = capH, r = rCorners);
                translate([capW, 0, 0]) {
                    cylinder(h = capH, r = rCorners);
                }
                translate([capW, capL, 0]) {
                    cylinder(h = capH, r = rCorners);
                }
                translate([0, capL, 0]) {
                    cylinder(h = capH, r = rCorners);
                }
            }
            // screw holder
            translate([capW + rCorners, (capL)  / 2 - screwR , 0]) {
                halfCyl(0, 0, 0);
            }
        }
        translate([-2, rCorners + capL - holderW, capH]) {
            cube([holderW, holderL, holderH]);
        }
        translate([-2, rCorners, capH]) {
            cube([holderW, holderL, holderH]);
        }
    }
    
}
// cap holder
module halfCyl(xpos, ypos, zpos) {
    w = screwR;
    h = capH;
    screwCapR = 2.6;
    //screw cylinder
    r = 4;
    screwh = 2;
    movex = screwR - r;
    translate([xpos - w, ypos, zpos]) {
        // half cilinder
        difference() {
            translate([xpos + w, ypos + w, zpos]) {
                cylinder(h = h, r = w);
            }
            // screw hole
           translate([w + movex, w]) {
                cylinder(r = screwCapR, h = h);
            }
            cube([w, 2 * w, h]);
        }
        // upper holder
        translate([w + movex, w, capH]) {
            difference() {
                cylinder(h = screwh, r = r);
                // here 1.5 wall wide 
                cylinder(r = screwCapR, h = h - 1.5);
                // cylinder for screw
                cylinder(r = 1.6, h = h );
            }
            //translate([0, 0, screwh]) {
                //cylinder(h = 7, r = 1.1);
            //}
        }
    }
}
