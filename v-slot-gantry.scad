v_slot_kit();
//V-slot组合体
module v_slot_kit(){
    translate([-65.5/2,-(10.23/2+9),65.5]){
 rotate([-90,0,0]){
  v_slot_plate();  
  translate([12.75,12.90,10.23/2+9]){
      v_slot_wheel();
      }  
    translate([52.75,12.90,10.23/2+9]){
      v_slot_wheel();
      }
     translate([12.75,52.60,10.23/2+9 ]){
      v_slot_wheel();
      }  
    translate([52.75,52.60,10.23/2+9]){
      v_slot_wheel();
 }    
}
    }}


//单个轮子
module v_slot_wheel(){
translate([0,0,3]){
cylinder($fn = 0, $fa = 20, $fs = 2, h = 2.115, r1 = 23.89/2, r2 = 10, center = false);}

translate([0,0,-3]){
cylinder($fn = 0, $fa =20,$fs = 2, h = 6, r1 = 23.89/2, r2 = 23.89/2, center = false);}

translate([0,0,-15]){
cylinder($fn = 0, $fa =20,$fs = 2, h = 25, r1 = 4, r2 =4, center = false);}

mirror([0,0,1]){
translate([0,0,3]){
cylinder($fn = 0, $fa =20, $fs = 2, h = 2.115, r1 = 23.89/2, r2 = 10, center = false);}
    }
}

//滑轮片

module v_slot_plate(){
 difference(){
    cube([65.5,65.5,3]);

//长条形大孔
translate([12.75-5.1/2,(65.6-25)/2,-1]){
    cube([5.1,25,10]);
    }
translate([52.75-5.1/2,(65.6-25)/2,-1]){
    cube([5.1,25,10]);
    }

//左侧大孔
translate([12.75,12.90,0]){
    cylinder(h=10,r=3.6,center=true);
    }
translate([ 22.75,12.90,0]){
    cylinder(h=10,r=2.55,center=true);
    }
translate([ 32.75,12.90,0]){
    cylinder(h=10,r=3.6,center=true);
    }
translate([ 42.75,12.90,0]){
    cylinder(h=10,r=2.55,center=true);
    }
translate([  52.75,12.90,0]){
    cylinder(h=10,r=3.6,center=true);
    }
    
//中间5个孔
translate([32.75,22.75,0]){
    cylinder(h=10,r=2.55,center=true);
    } 
translate([32.75,32.75,0]){
    cylinder(h=10,r=2.55,center=true);
    }

translate([22.75,32.75,0]){
    cylinder(h=10,r=2.55,center=true);
    }
translate([42.75,32.75,0]){
    cylinder(h=10,r=2.55,center=true);
    }

translate([32.75,42.75,0]){
    cylinder(h=10,r=2.55,center=true);
    }    
    
  //右侧5个孔  
translate([12.75,52.75,0]){
    cylinder(h=10,r=2.55,center=true);
    }
translate([ 22.75,52.75,0]){
    cylinder(h=10,r=2.55,center=true);
    }
translate([ 32.75,52.75,0]){
    cylinder(h=10,r=2.55,center=true);
    }
translate([ 42.75,52.75,0]){
    cylinder(h=10,r=2.55,center=true);
    }
translate([ 52.75,52.75,0]){
    cylinder(h=10,r=2.55,center=true);
    }
    }
}
