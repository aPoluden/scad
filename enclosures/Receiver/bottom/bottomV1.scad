$fn = 50;

// Main Model    
mainBox(0, 0, 0);

// Modules
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
// PCB holders
module innerCilinder(xdim, ydim, hdim) {
    // Cilinder outer
    rTop = 3.96;
    rBottom = rTop + 0.77;
    // Cilinder inner
    riTop = 2.92;
    riBottom = 3.30;
    
    rInner = 2.415;
    cilHbottom = 4.39;
    cilHTop = 0.58;
    cilTopPos = hdim + cilHbottom;
    difference() {
         union() {
           difference() {
                translate([xdim, ydim, hdim]) {
                    cylinder(h = cilHbottom, r2 = rTop, r1 = rBottom);
                }
           }
           translate([xdim, ydim, cilTopPos]) {
               cylinder(h = cilHTop, r = rInner);
           }
       }
       translate([xdim, ydim, 4.39]) {
           cylinder(h = 2.03 + cilHTop, r = 1.68);
       }
   }
}

module mainBox(xdip, ydip, zdip) {
   cornerR = 10.17;
   hdip = 2.03;
   batteryH = 0;
   // outer
   owidth = 76.2;
   olength = 76.2;
   oheight = 8.03 + batteryH; // change
   // inner
   iheight = 6 + batteryH; // change
   iwidth = owidth - (hdip * 2);
   ilength = olength - (hdip * 2);
   ir = cornerR - hdip;
   // paz
   pborder = 1;
   pwidth = owidth - (pborder * 2);
   plength = olength - (pborder * 2);
   pheight = 7.015 + batteryH; // change
   pdip = 1.02;
   // cilinders
   xy = 10.16;
   yx = 66.04;
  
  difference() {
  translate([xdip, ydip, zdip]) {
        difference() {
            roundedCube(olength, owidth, oheight, cornerR);
            translate([hdip, hdip, hdip]) {
                roundedCube(ilength, iwidth, iheight, ir);
            }
            translate([pborder, pborder, pheight]) {
                roundedCube(plength, pwidth, pdip, cornerR - pborder);
            }
            difference() {
                priamougol();
                donut();
            }
        }
        // PCB holders
        // 
        innerCilinder(xy, xy, hdip);
        innerCilinder(xy, yx, hdip);
        innerCilinder(yx, yx, hdip);
        innerCilinder(yx, xy, hdip);
    }
    translate([xy, xy, 0]) {
        cylinder(h = 4.39, r1 = 2.92, r2 = 3.30);
    }
    translate([xy, yx, 0]) {
        cylinder(h = 4.39, r1 = 2.92, r2 = 3.30);
    }
    translate([yx, yx, 0]) {
        cylinder(h = 4.39, r1 = 2.92, r2 = 3.30);
    }
    translate([yx, xy, 0]) {
        cylinder(h = 4.39, r1 = 2.92, r2 = 3.30);
    }
    }
}

module cilin() {
    hull() {
        translate([4.45, 4.45, 4.45]) {
            union() {
                cylinder(h = 10, r =  4.45);
                sphere(r = 4.45);
            }
        }
        translate([4.45, 76.2 - 4.45, 4.45]) {
            union() {
                cylinder(h = 10, r =  4.45);
                sphere(r = 4.45);
            }
        }
        translate([76.2 - 4.45, 4.45, 4.45]) {
            union() {
                cylinder(h = 10, r =  4.45);
                sphere(r = 4.45);
            }
        }
        translate([76.2 - 4.45, 76.2 - 4.45, 4.45]) {
            union() {
                cylinder(h = 10, r =  4.45);
                sphere(r = 4.45);
            }
        }
    }
}

module donut() {
    hull() {
       translate([10.17, 10.17, 4.45]) {
            rotate_extrude(convexity = 100) {
                translate([10.17 - 4.45, 0, 0]) {
                    circle(r = 4.45);
                }
            }
       }
       translate([10.17, 76.2 - 10.17, 4.45]) {
            rotate_extrude(convexity = 100) {
                translate([10.17 - 4.45, 0, 0]) {
                    circle(r = 4.45);
                }
            }
       }
       translate([76.2 - 10.17, 10.17, 4.45]) {
            rotate_extrude(convexity = 100) {
                translate([10.17 - 4.45, 0, 0]) {
                    circle(r = 4.45);
                }
            }
       }
       translate([76.2 - 10.17, 76.2 - 10.17, 4.45]) {
            rotate_extrude(convexity = 100) {
                translate([10.17 - 4.45, 0, 0]) {
                    circle(r = 4.45);
                }
            }
       }
   }
}

module priamougol() {
    translate([0, 0, 0]) {
        cube([76.2, 76.2, 4.45]);
    }
}
    


