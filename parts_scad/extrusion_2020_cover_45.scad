
include <NopSCADlib/lib.scad>
      rotate([0, 90, 0]) {
difference(){

            extrusion(E2020, 4 * extrusion_width(E2020)+extrusion_width(E2020)/cos(45), center = false);

translate([-extrusion_width(E2020)/2,0,0]){
rotate([0,45,0]){
cube([extrusion_width(E2020)/cos(45),extrusion_width(E2020)/cos(45),extrusion_width(E2020)/cos(45)],center=true);}}}}