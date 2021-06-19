
include <NopSCADlib/lib.scad>

//主体框架
main_frame_width = 1500;
 
difference(){

            extrusion(E2020, (main_frame_width / 2 - 10 * extrusion_width(E2020))*sqrt(2) + extrusion_width(E2020) * 0.3+3*extrusion_width(E2020), center = false);

translate([extrusion_width(E2020)/2,0,0]){
rotate([0,45,0]){
cube([extrusion_width(E2020)/cos(45),extrusion_width(E2020)/cos(45),extrusion_width(E2020)/cos(45)],center=true);}}}