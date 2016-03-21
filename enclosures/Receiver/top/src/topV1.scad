$fn = 50;
// Main Model
difference() {
    mainBox(0, 0, 0);

    // esp antenna hole
    translate([49.7 + 5.5, 76.2 - 3 , 9 - 0.47 + 3]) {
        rotate([0, 87, 90]) {
            antenna();
        }
    }
    // dw antenna hole
    translate([76.2 - 3, 24.5, 9 - 0.47 + 3]) {
        rotate([0, 87, 0]) {
            antenna();
        }
    }
     //nrf antenna hole
     translate([0, 16.5, 9 + 3]) {
         rotate([0, 93, 0]) {
             antenna();
         }    
     }
     // led hole
     // + 0.9 emphirically
     translate([0, 28.7 - 3, 2 + 0.9]) {
        rotate([0, 90, 0]) {
            led();
        }
    }
 }

// Rounded cube with angle
module roundedCubeAngle(xdim, ydim, zdim, rdim) {
    deg = 3;
    h = zdim;
    rTop = rdim - tan(deg) * h;
    hull() {
        translate([rdim, rdim, 0]) {
            cylinder(r1 = rdim, r2 = rTop, h=zdim);
        }
        translate([xdim - rdim, rdim,0]) {
            cylinder(r1 = rdim, r2 = rTop, h = zdim);
        }
        translate([rdim, ydim - rdim, 0]) {
            cylinder(r1 = rdim, r2 = rTop, h = zdim);
        }
        translate([xdim - rdim, ydim - rdim, 0]) {
            cylinder(r1 = rdim, r2 = rTop, h = zdim);
        }
    }
}

// Rounded cube without angle
module roundedCube(xdim, ydim, zdim, rdim) {
    hull() {
        translate([rdim, rdim, 0]) {
            cylinder(r = rdim, h=zdim);
        }
        translate([xdim - rdim, rdim,0]) {
            cylinder(r = rdim, h = zdim);
        }
        translate([rdim, ydim - rdim, 0]) {
            cylinder(r = rdim, h = zdim);
        }
        translate([xdim - rdim, ydim - rdim, 0]) {
            cylinder(r = rdim, h = zdim);
        }
    }
}

// Inner cilinders
module innerCilinder(xdim, ydim, hdim) {
    // inner parameters
    radius = 2.375;
    batteryH = 11;
    // remove batteryH in case of external power supply
    // cilH = 14.98 + batteryH;
    cilH = 14.98;
    translate([xdim, ydim, 0]) {
        difference() {
            cylinder(h = cilH, r = radius);
            // -5 for resistance
            // inner hole diameter = 2.2
            cylinder(h = cilH - 5, r = 1.1);
        }
        translate([-0.5, radius, 2]) {
            cube([1, radius, cilH - 2]);
        }
        translate([radius, -0.5 , 2]) {
            cube([radius, 1, cilH - 2]);
        }
    }
}

module mainBox(xdim, ydim, zdim) {
   R = 10.17;
   borderH = 2.29;
   batteryH = 11;
   // outer
   owidth = 76.2;
   olength = 76.2;
   // if battery won't be used remove batteryH
   // oheight = 16.92 + batteryH;
    oheight = 16.92;
   // inner
   iwidth = owidth - (borderH * 2);
   ilength = olength - (borderH * 2);
   iheight = oheight - borderH;
   r = 7.25;
   // pazz
   pazHeight = 1.12;
   floatPazWidth = 1;
   // cilinders pos according to box size
   xy = 10.16;
   yx = 66.04;
   
   translate([xdim, ydim, zdim + pazHeight]) {
       difference() {
            roundedCubeAngle(olength, owidth, oheight, R);
                translate([borderH , borderH , 0]) {
                    roundedCubeAngle(ilength, iwidth, iheight, r);
            }
       }
       translate([xy * 2, xy * 2, 0]) {
           rotate([0, 0, 180]) {
                innerCilinder(xy, xy, borderH);
           }
       }
       translate([yx + xy, yx - xy, 0]) { 
           rotate([0, 0, 90]) {
               innerCilinder(xy, yx, borderH);
           }
       }
       translate([yx - xy, yx + xy, 0]) {
            rotate([0, 0, 270]) {
                innerCilinder(yx, xy, borderH);
            }
       }
       innerCilinder(yx, yx, borderH);
   }
   difference() {
       translate([floatPazWidth + xdim, floatPazWidth + ydim, zdim]) {
               roundedCube(74.2, 74.2, pazHeight, R - floatPazWidth);
       }
       translate([borderH + xdim, borderH + ydim, zdim]) {
            roundedCube(iwidth, iwidth, pazHeight, r);
       }
   }
}

module antenna() {
    hull() {
           translate([2.75, 2.75, 0]) {
               // h=3 emphirical, real 2.29
               cylinder(h=3, r=2.75);
           }
           translate([2.75, 0, 0]) {
               // z = 3 emphirical, real 2.29
               cube([9 - 2.75 + 3, 2.75 * 2 , 3]);
           }
    }
}

module led() {
    translate([1, 1, 0]) {
        cylinder(r = 1, h = 3);
    }
}

module cut(xpos, ypos, zpos) {
    btnWH = 11.9;
    translate ([xpos, ypos, zpos]) {
        rotate([0, 90, 0]) {
            cylinder(h = 2.29, r = 2.6);
        }
    }
}

module cutOld(xpos, ypos, zpos) {
    btnWH = 11.9;
    union() {
        translate ([xpos, ypos, zpos]) {
            translate([-1.5, 0, 0]) {
                cube([1.5, btnWH, btnWH + 0.7]);
                translate([-0.8, 5.95, 5.95 + 0.35]) {
                        rotate([0, 90, 0]) {
                            cylinder(h = 2.29, r = 2.6);
                    }
                }
            }
        }
    }
}