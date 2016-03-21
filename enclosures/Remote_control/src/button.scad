$fn = 100;
wthikness = 1.5;

cylinder(r =3.5, h = 1);
translate([0, 0 ,1]) {
    cylinder(r = 3, h = wthikness + 1);
}