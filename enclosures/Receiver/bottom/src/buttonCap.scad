$fn = 50;
capH = 1.6;
capW = 11.5;
capL = 13;

cap(0, 0, 0);    
    
module cap(xpos, ypos, zpos) {
    translate([xpos, ypos, zpos]) {
        cube([capL, capW, capH]);
    }
}