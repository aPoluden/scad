$fn = 100;
// var
// Cap width
capW = 37;
// Cap length
capL = 65;
// Cap height
capH = 2.03;
// screw slot radius
screwR = 8.5;
// element box
boxW = 42.5;
boxL = 70.5;
boxH = 20;

// Main Model init
mainBox(0, 0, 0);

module mainBox(xdip, ydip, zdip) {
   cornerR = 10.17;
   hdip = 2.03;
   batteryH = 16;
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
   // antenna
   antR = 3.4;
   difference() {
       union() {
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
                        // antenna hole 11.7 (emphirically)
                        translate([0, owidth / 2, 11.7]) {
                            rotate([0, 90 , 0]) {
                                cylinder(h = hdip, r = antR);
                            }
                        }
                        // wiring space
                        translate([1, owidth / 2, 20]) {
                            cube([1.5, 2, 4]);
                        }
                        // button place
                        movey = owidth / 2 - 11.9 / 2;
                        movez = oheight / 2 - 11.9 / 2;
                        rotate([0, 0, 180]) {
                            cut(-owidth + 2.29, -11.9 - movey, movez);
                        }
                    }
                    // PCB holders
                    innerCilinder(xy, xy, hdip);
                    innerCilinder(xy, yx, hdip);
                    innerCilinder(yx, yx, hdip);
                    innerCilinder(yx, xy, hdip);
                    // derzhatelj knopki
                    movey = owidth / 2 - 11.9 / 2;
                    movez = oheight / 2 - 11.9 / 2;
                    rotate([180, 0, 180]) {
                        box(-owidth + hdip, movey-2, -11.9 - 2 - movez + 2 + 0.35);
                    }
                }
                // Inner cylinder holes
                translate([xy, xy, 0]) {
                    cylinder(h = 4.39 + batteryH, r1 = 2.92, r2 = 3.30);
                }
                translate([xy, yx, 0]) {
                    cylinder(h = 4.39 + batteryH, r1 = 2.92, r2 = 3.30);
                }
                translate([yx, yx, 0]) {
                    cylinder(h = 4.39 + batteryH, r1 = 2.92, r2 = 3.30);
                }
                translate([yx, xy, 0]) {
                    cylinder(h = 4.39 + batteryH, r1 = 2.92, r2 = 3.30);
                }
            }
            // battery slot
            x = (owidth / 2) - (boxW / 2);
            y = (olength / 2) - (boxL / 2);
            // Otverstie dlia shurupa
            difference() {
                //outer box - Battery Box
                space = iwidth - boxL; // free space
                echo(space);
                translate([x, y - (space / 2), hdip]) {
                    cube([boxW, boxL + space, boxH]);
                }
                // inner box
                paz = 1;
                border = 1.5;
                inBoxW = boxW - border - paz; // 40
                inBoxL = boxL - border - paz; // 68
                inBoxH = boxH; // 20
                ix = (owidth / 2) - (inBoxW / 2);
                iy = (olength / 2) - (inBoxL / 2);
                translate([ix, iy, hdip]) {
                    cube([inBoxW, inBoxL, inBoxH]);
                }
                // space for wifi antenna
                translate([(owidth / 2) - (boxW / 2), (owidth/2) - 5, 11.7 - 5]) {
                    cube([1.5, 10, 10]);
                }
            }
            w = screwR - 1.5;
            l = screwR * 2;
            h = 7;
            // screw place
            translate([(owidth / 2) + boxW/2, (olength / 2) - screwR, hdip]) {
                cube([w, l, h]);
             }
             // here 18.5 battery diammeter
             movexx = -18.5 * 2 - owidth / 2 + 37 / 2 ;
             moveyy = (owidth / 2) - 68 / 2;
             moveyy01 = (owidth / 2) + (68 / 2) - 4;
             movezz = hdip + batteryH + 4 - 18.5 / 2;
             // battery place
             // !rotate reverses switched x - y coords 
             rotate([0, 0, 90]) {
                 battholder(moveyy, movexx, movezz);
             }
             rotate([0, 0, 90]) {
                 battholder(moveyy01, movexx, movezz);
             }
         } // union
        // battery cap slot
        // +4 radiusy cylindrov
        xx = (owidth / 2) - ((capW + 4) / 2);
        yy = (olength / 2) - ((capL + 4) / 2);
        cap(xx, yy, 0);
         // battery connectors
         moveconx1 = -7.3 - (owidth/2) + (18.5 / 2) + (7.3/2);
         movecony1 = 4.35 -1.5;
         moveconz1 = hdip + 0.21;
         // modified connector
         battConnector1((owidth/2) - (18.5 / 2) - (7.3/2), 4.35 - 1.5, 1);
         rotate([0, 0 , 90]) {
             // coordintes reversed
             battConnector(movecony1, moveconx1, moveconz1);
         }
         moveconx2 = -7.3 - (owidth/2) - (18.5 / 2) + (7.3/2);
         movecony2 = 4.35 -1.5;
         moveconz2 = hdip + 0.21;
         // modified connector
         battConnector1((owidth/2) + (18.5 / 2) - (7.3/2), 4.35 - 1.5, 1);
         rotate([0, 0 , 90]) {
             // coordintes reversed
             battConnector(movecony2, moveconx2, moveconz2);
         }
         moveconx3 = 0 + (owidth / 2) + (18.5 / 2) - (7.3 / 2);
         movecony3 = -owidth + 4.35 -1.5;
         moveconz3 = hdip + 0.21;
         translate([7.3 + (owidth / 2) + (18.5 / 2) - (7.3 / 2), owidth - 4.35 + 1.5, 1]) {
            rotate([0, 0, 180]) {
                 battConnector1(0, 0, 0); 
             }
          }
         rotate([0, 0 , 270]) {
             // coordintes reversed
             battConnector(movecony3, moveconx3, moveconz3);
         }
         moveconx4 = 0 + (owidth / 2) - (18.5 / 2) - (7.3 / 2);
         movecony4 = -owidth + 4.35 -1.5;
         moveconz4 = hdip + 0.21;
         translate([7.3 + (owidth / 2) - (18.5 / 2) - (7.3 / 2), owidth - 4.35 + 1.5, 1]) {
            rotate([0, 0, 180]) {
                 battConnector1(0, 0, 0); 
             }
         }
         rotate([0, 0 , 270]) {
             // coordintes reversed
             battConnector(movecony4, moveconx4, moveconz4);
         }
         // wiring space
         translate([(owidth/2) - (boxW / 2) ,  owidth - 4.35 +1.5 - 2 ,hdip + boxH - 2]) {
             cube([boxW, 2, 2+1]);
         }
         translate([(owidth/2) - (boxW / 2) ,  owidth - 4.35 +0.5 - 2 ,(hdip + boxH) / 2]) {
             cube([boxW, 2, 2+1]);
         }
         // wiring space
         translate([(owidth/2) - (boxW / 2) , 4.35 +1.5 - 2 ,hdip + boxH - 2]) {
             cube([boxW, 2, 2+1]);
         }
         translate([(owidth/2) - (boxW / 2) , 4.35 +0.5 - 2 ,(hdip + boxH) / 2]) {
             cube([boxW, 2, 2+1]);
         }
         // DW antenna connectors space
         translate([yx - 21, yx ,hdip +boxH - 2]) {
             cube([7.6, 7.6, 2.4]);
         }
    } //diff
} // main model
// PCB holders
module innerCilinder(xdim, ydim, hdim) {
    // Cilinder outer
    rTop = 3.96;
    rBottom = rTop + 0.77;
    batteryH = 16;
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
                    cylinder(h = cilHbottom + batteryH, r2 = rTop, r1 = rBottom);
                }
           }
           translate([xdim, ydim, cilTopPos + batteryH]) {
               cylinder(h = cilHTop, r = rInner);
           }
       }
       translate([xdim, ydim, 4.39 + batteryH]) {
           cylinder(h = 2.03 + cilHTop, r = 1.68);
       }
   }
}
// contact place
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
// modified connector
module battConnector1(xpos, ypos, zpos) {
    w = 2;
    l = 7.3;
    h = 22;
    smallW = 0.5;
    smallH = 7.1 - 1;
    translate([xpos, ypos, zpos]) {
        difference() {
            cube([l,w , h]);
            translate([0, smallW, smallH]) {
                cube([l, w - smallW ,h - smallH]);
            }
        }
    }
}
// battery cap slot
module cap(xpos, ypos, zpos)  {
    rCorners = 2; 
    holderL = 5 ;
    holderW = 5;
    // + 1 printer err
    holderH = 1 + 1;
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
            // holder
            translate([-3, rCorners + capL - holderW - 2, capH]) {
                cube([holderW, holderL, holderH]);
            }
            // holder
            translate([-3, rCorners - 2, capH]) {
                cube([holderW, holderL, holderH]);
            }
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
            cube([w, 2 * w, h]);
        }
        // upper hold
        translate([w + movex, w, capH - 0.01]) {
           cylinder(h = screwh, r = r);
            translate([0, 0, screwh]) {
                cylinder(h = 7, r = 1.1);
            }
        }
    }
}
// button cut
module cut(xpos, ypos, zpos) {
    btnWH = 11.9;
    union() {
        translate ([xpos, ypos, zpos]) {
            translate([-1.5, 0, -0.35]) {
                cube([1.5, btnWH, btnWH + 0.35]);
                translate([-0.8, 5.95, 5.95 + 0.35]) {
                        rotate([0, 90, 0]) {
                            cylinder(h = 2.29, r = 2.6);
                    }
                }
            }
        }
    }
}
// button box
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
// battery holder
module battholder(xpos, ypos, zpos) {
    // battery params
    batL = 65;
    batDiam = 18.5;
    //holder params
    w = batDiam * 2;
    l = batDiam / 2;
    // !openscad paklaida 0.01
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
// rounded corners
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