
include <NopSCADlib/lib.scad>
translate([0,0,-extrusion_width(E2020)/2]){
      rotate([0, 90, 0]) {
difference(){


translate([-extrusion_width(E2020)/2,0,0]){
    extrusion(E2020, 6 * extrusion_width(E2020), center = false);}

translate([-120,-40,0]){
rotate([0,45,0]){
cube([3*extrusion_width(E2020)/cos(45),3*extrusion_width(E2020)/cos(45),3*extrusion_width(E2020)/cos(45)],center=false);}}

}}}