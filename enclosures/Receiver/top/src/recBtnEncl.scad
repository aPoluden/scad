$fn = 70;
recBtnEncl();
module recBtnEncl() {
    union() {
        difference() {
            translate([0, 0, -2]) {
                // cube is receiver border imitation
                //cube([2.29, 11.9 +4 , 11.9 + 4]);
            }
            cut(2.29, 0, 0);
        }
        box(2.29, 0, 0);
    }
}

module cut(xpos, ypos, zpos) {
    btnWH = 11.9;
    union() {
        translate ([xpos, ypos, zpos]) {
            translate([-1.5, 2, 0]) {
                translate([0, 0, -0.3]) {
                    cube([1.5, btnWH, btnWH + 0.6]);
                }
                translate([-0.8, 5.95, 5.95]) {
                        rotate([0, 90, 0]) {
                            cylinder(h = 2.29, r = 2.6);
                    }
                }
            }
        }
    }
}

module box(xpos, ypos, zpos) {
    translate([xpos, ypos, zpos]) {
        difference() {
            // 2 is button enclousure width
            cube([6.7 + 2, 11.9 + 4, 11.9 + 2]);
            translate([-0.05, 2 - 0.05, 0]) {
                cube([6.7 + 0.1, 11.9 + 0.1, 11.9]);
            }
        }
    }
}