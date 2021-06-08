
module Connector_2040_L(){
    translate([0, 0, 16]) {
        
  
    rotate([0,90,0]){
        
  
difference(){
    cube([16,28.3,3]);
    translate([(16-5.5)/2,-1,-1]){
        
        color("blue"){
        cube([5.5,23.5,6]);}    }
        }
 
    
    

translate([0,3,0]){
rotate([90,0,0]){
difference(){
    cube([16,62.3,3]);
    translate([(16-5.5)/2,-1,-1]){cube([5.5,57.8,6]);    }}
    
}}
    }}}