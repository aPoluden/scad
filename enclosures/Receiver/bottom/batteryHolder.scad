$fn = 50;

//battholder(0, 0, 0);
battConnector(0, 0, 0);

// prostranstvo dlia kontaktov batarei
module battConnector(xpos, ypos, zpos) {
    w = 2;
    l = 7.3;
    h = 19.8;
    smallW = 0.5;
    smallH = 17;
    translate([xpos, ypos, zpos]) {
        difference() {
            cube([w, l, h]);
            translate([smallW, 0, 0]) {
                cube([w - smallW, l ,smallH]);
            }
        }
    }
}

// battery holder
module battholder(xpos, ypos, zpos) {
    // battery params
    batL = 65;
    batDiam = 18.5;
    //holder params
    w = batDiam * 2;
    l = batDiam / 2;
    // openscad paklaida 0.01
    hdeep = 4.01;
    translate([xpos, ypos, zpos]) {
        difference() {
            cube([hdeep, w, l]);
           translate([0, batDiam / 2, 0]) {
                rotate([0, 90, 0]) {
                    cylinder(h = hdeep, r = l);
                }
            }
            translate([0, (batDiam + l), 0]) {
                rotate([0, 90, 0]) {
                    cylinder(h = hdeep, r =l);
                }
            }
        }
    }
}