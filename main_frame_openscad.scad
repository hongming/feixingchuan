include <NopSCADlib/lib.scad>
include <Connector_2040_L.scad>
//include <v-slot-gantry.scad>


//基本参数
E2040_width = extrusion_width(E2040);
E2040_height = extrusion_height(E2040);
E2020_width = extrusion_width(E2020);

//V-slot
v_plate_thickness = 10; //卡在缝隙间的厚度
v_plate_width = 65.5;//面板长宽

//底部
base_frame_width = 1000;
base_frame_length = 1000;
base_frame_height = 100;

//主体框架
main_frame_width = 1500;
main_frame_length = 1500;
main_frame_height = 1200;

//顶部盖子
movable_cover_width = 500;
movable_cover_length = 1000;
movable_cover_height = 500;

//内容展示
 

//Module模块
//主体框架
////主体框架-立柱
for (i = [[0, -(E2040_height - E2040_width) / 2, 0],
          [main_frame_width - E2040_height / 2, -(E2040_height - E2040_width) / 2, 0],
          [main_frame_width - E2040_height / 2, main_frame_length - (E2040_height - E2040_width) / 2, 0],
          [0, main_frame_length - E2040_width / 2, 0]])
{
  translate(i)
  extrusion(E2040, main_frame_height, center = false);
}

////主体框架-立柱-支撑四根横梁的竖立支架
for (i = [[main_frame_width/2, 0, E2020_width],
          [main_frame_width - E2020_width, main_frame_length / 2-300, E2020_width],
                    [main_frame_width - E2020_width, main_frame_length / 2+300, E2020_width],
          [main_frame_width/2, main_frame_length-E2020_width, E2020_width],
          [0, main_frame_length / 2-300, E2020_width],
          [0, main_frame_length / 2+300, E2020_width]
          
          ])
{
  translate(i)
  extrusion(E2020, main_frame_height-2*E2020_width, center = false);
}
 


////立柱框架-立柱-前方四个滑块
translate([0, -E2040_height/2, main_frame_height-2*E2020_width-v_plate_width ]) {
import ("v-slot-gantry.stl");
//  v_slot_kit();
}
translate([(main_frame_width-E2020_width)/2  -v_plate_width/2, -E2040_height/2, main_frame_height-E2020_width/2 -v_plate_width/2 ]) {
import ("v-slot-gantry.stl");
//  v_slot_kit();
}
translate([(main_frame_width-E2020_width)/2 +v_plate_width/2, -E2040_height/2, main_frame_height-E2020_width/2 -v_plate_width/2 ]) {
  color("black")
  import ("v-slot-gantry.stl");
//  v_slot_kit();
}
translate([(main_frame_width-E2020_width), -E2040_height/2, main_frame_height-2*E2020_width-v_plate_width ]) {
  color("black")
  import ("v-slot-gantry.stl");
  //v_slot_kit();
}


////立柱框架-立柱-后方四个滑块
mirror([0,1,0]){
translate([0, -main_frame_length, main_frame_height-2*E2020_width-v_plate_width ]) {
import ("v-slot-gantry.stl");
//  v_slot_kit();
}
translate([(main_frame_width-E2020_width)/2  -v_plate_width/2, -main_frame_length, main_frame_height-E2020_width/2 -v_plate_width/2 ]) {
import ("v-slot-gantry.stl");
//  v_slot_kit();
}
translate([(main_frame_width-E2020_width)/2 +v_plate_width/2, -main_frame_length, main_frame_height-E2020_width/2 -v_plate_width/2 ]) {
  color("black")
  import ("v-slot-gantry.stl");
//v_slot_kit();
}
translate([(main_frame_width-E2020_width), -main_frame_length, main_frame_height-2*E2020_width-v_plate_width ]) {
  color("black")
import ("v-slot-gantry.stl");
//v_slot_kit();
}
}



//主体框架-立柱-四根支撑住-T型固定-上方
  for(i=[[main_frame_width/2,E2020_width/2+2,main_frame_height],[main_frame_width/2,main_frame_length-3*E2020_width/2-2,main_frame_height]]){
translate(i){
 
    rotate([0,180,0]){
joint_plate_2020T_T();
}
}
}

 for(i=[[E2020_width/2+2,main_frame_length/2-300,main_frame_height]
 ,
 [E2020_width/2+2,main_frame_length/2+300,main_frame_height],[main_frame_width-3*E2020_width/2-2,main_frame_length/2+300,main_frame_height]
 ,
 [main_frame_width-3*E2020_width/2-2,main_frame_length/2-300,main_frame_height]]){
translate(i){
 
rotate([0,180,90]){
joint_plate_2020T_T();
}
}
}
//主体框架-立柱-四根支撑住-T型固定-下方
 for(i=[[main_frame_width/2,E2020_width/2+2,0],[main_frame_width/2,main_frame_length-3*E2020_width/2-2,0]]){
translate(i){
 
joint_plate_2020T_T();

}
}

 for(i=[[E2020_width/2+2,main_frame_length/2+300,0],
 [E2020_width/2+2,main_frame_length/2-300,0],[main_frame_width-3*E2020_width/2-2,main_frame_length/2+300,0],
 [main_frame_width-3*E2020_width/2-2,main_frame_length/2-300,0]]){
translate(i){
 
rotate([0,0,90]){
joint_plate_2020T_T();}

}
}


//主体框架-立柱-四根支撑住-L型固定-上方

translate([-E2020_width/2-2,0,main_frame_height]){

rotate([0,180,0]){
  joint_plate_2020T_L();
}
}

translate([-E2020_width/2-2,main_frame_length-E2020_width,main_frame_height]){
rotate([0,180,180])
{joint_plate_2020T_L();}}
 

translate([main_frame_width-E2020_width/2+2,0,main_frame_height]){
rotate([0,180,0]){joint_plate_2020T_L();}}

translate([main_frame_width-E2020_width/2,main_frame_length-E2020_width,main_frame_height]){
rotate([0,180,180])
{joint_plate_2020T_L();}}


/**
备注：为了固定开窗器，下方改用20*40铝型材
////主体框架-立柱-四根支撑住-L型固定-下方

// translate([-E2020_width/2-2,0,0]){
// joint_plate_2020T_L();}

// translate([-E2020_width/2-2,main_frame_length-E2020_width,0]){
// rotate([0,0,180])
// {joint_plate_2020T_L();}}
 

// translate([main_frame_width-E2020_width/2+2,0,0]){
// joint_plate_2020T_L();}

// translate([main_frame_width-E2020_width/2,main_frame_length-E2020_width,0]){
// rotate([0,0,180])
// {joint_plate_2020T_L();}}
**/

////主体框架-Width横柱-逆时针-下半部分
for (i = [[0, 0, 0]])
{
  translate(i) {
    rotate([0, 90, 0]) {
      translate([-E2020_width / 2, 0, E2020_width / 2]) {
        extrusion(E2020, main_frame_width - 2 * E2020_width, center = false);
      }
    }
    translate([main_frame_width - E2020_width/2, 0, 0]) {
      rotate([-90, 0, 0]) {
        translate([0, -E2020_width / 2, E2020_width / 2]) {
          rotate([0,0,90]){
            extrusion(E2040, main_frame_width - 2 * E2020_width, center = false);
          }
        }
      }
    }
    translate([0, main_frame_length - E2020_width, 0]) {
      rotate([0, 90, 0]) {
        translate([-E2020_width / 2, 0, E2020_width / 2]) {
          extrusion(E2020, main_frame_width - 2 * E2020_width, center = false);
        }
      }
    }
    rotate([-90, 0, 0]) {
      translate([-E2020_width / 2, -E2020_width / 2, E2020_width / 2]) {
                  rotate([0,0,90]){
        extrusion(E2040, main_frame_width - 2 * E2020_width, center = false);}
      }
    }
  }
}

////主体框架-Width横柱-逆时针-上半部分
for (i = [ [0, 0, main_frame_height - E2020_width]])
{
  translate(i) {
    rotate([0, 90, 0]) {
      translate([-E2020_width / 2, -E2040_width / 2, E2040_width / 2]) {
        extrusion(E2040, main_frame_width - 2 * E2020_width, center = false);
      }
    }
    translate([main_frame_width - E2020_width, 0, 0]) {
      rotate([-90, 0, 0]) {
        translate([0, -E2020_width / 2, E2020_width / 2]) {
          extrusion(E2020, main_frame_width - 2 * E2020_width, center = false);
        }
      }
    }
    translate([0, main_frame_length - (E2040_height - E2040_width) / 2, 0]) {
      rotate([0, 90, 0]) {
        translate([-E2020_width / 2, 0, E2020_width / 2]) {
          extrusion(E2040, main_frame_width - 2 * E2020_width, center = false);
        }
      }
    }
    rotate([-90, 0, 0]) {
      translate([0, -E2020_width / 2, E2020_width / 2]) {
        extrusion(E2020, main_frame_width - 2 * E2020_width, center = false);
      }
    }
  }
}
//V-Slot
//开窗器-横杆链接 *由于连接器宽度38，小于标准40毫米，因此使用1毫米高度修正

//顶部盖子-左侧-后面的固定L型镂空连接器
translate([-v_plate_width/2-8,
main_frame_length-32+2*E2020_width+v_plate_thickness,
main_frame_height+16+2-3*E2020_width-v_plate_width/2]) {
color("black"){
  rotate([180,0,0]){Connector_2040_L(); }
} 
}

translate([-v_plate_width/2-8,
main_frame_length-32+2*E2020_width+v_plate_thickness,
main_frame_height+16+2-3*E2020_width-v_plate_width/2+20]) {
color("blue"){
 rotate([180,0,0]){ Connector_2040_L(); }
} 
}

//顶部盖子-左侧-前面的固定L型镂空连接器
translate([-v_plate_width/2-8,
-3*E2020_width/2-3-3-2,
main_frame_height+2-3*E2020_width-v_plate_width/2]) {
color("blue"){
 Connector_2040_L(); 
} 
}

translate([-v_plate_width/2-8,
-3*E2020_width/2-3-3-2,
main_frame_height+2-3*E2020_width-v_plate_width/2+20]) {
color("black"){
 Connector_2040_L(); 
} 
}

//顶部盖子-左侧-前面的固定L型镂空连接器-附加
translate([-v_plate_width/2-8-E2020_width-3,
-3*E2020_width/2-3-3-2-3,
main_frame_height+2-3*E2020_width-v_plate_width/2]) {
color("red"){
 Connector_2040_L(); 
} 
}

translate([-v_plate_width/2-8-E2020_width-3,
-3*E2020_width/2-3-3-2-3,
main_frame_height+2-3*E2020_width-v_plate_width/2+20]) {
color("yellow"){
 Connector_2040_L(); 
} 
}

//顶部盖子-右侧-后面的固定L型镂空连接器
translate([main_frame_width+v_plate_width/2-E2020_width+3+5,
main_frame_length-32+2*E2020_width+v_plate_thickness,
main_frame_height+2-3*E2020_width-v_plate_width/2]) {
color("yellow"){
 rotate([180,180,0]){Connector_2040_L(); }
} 
}

translate([main_frame_width+v_plate_width/2-E2020_width+3+5,
main_frame_length-32+2*E2020_width+v_plate_thickness,
main_frame_height+2-3*E2020_width-v_plate_width/2+20]) {
color("red"){
 rotate([180,180,0]){Connector_2040_L(); }
} 
}


//顶部盖子-右侧-前面的固定L型镂空连接器
translate([main_frame_width+v_plate_width/2-E2020_width+3+5,
-3*E2020_width/2-3-3-2,
main_frame_height+2+16-3*E2020_width-v_plate_width/2]) {
color("blue"){
 rotate([0,180,0]){Connector_2040_L(); }
} 
}

translate([main_frame_width+v_plate_width/2-E2020_width+3+5,
-3*E2020_width/2-3-3-2,
main_frame_height+2+16-3*E2020_width-v_plate_width/2+20]) {
color("pink"){
 rotate([0,180,0]){Connector_2040_L(); }
} 
}


//顶部盖子-左侧
for(i=[[0,-2*v_plate_thickness-2*E2020_width,main_frame_height+3*E2020_width+E2020_width/2],
[main_frame_width/8,-2*v_plate_thickness-2*E2020_width,main_frame_height+E2020_width/2+20*E2020_width],
[main_frame_width/2-2*E2020_width,-2*v_plate_thickness-2*E2020_width,main_frame_height+E2020_width/2+30*E2020_width]

]){
translate(i){
 color("red"){
   rotate([-90,0,0]){
   extrusion(E2020,main_frame_length+4*E2020_width+2*v_plate_thickness,center=false);}}}}

for (i = [[0, 0, 0], [0, main_frame_length + E2020_width + E2040_height + 2 * v_plate_thickness, 0]]) {

  translate(i) {
    rotate([0, 0, 0]) {
      translate([0, -E2040_height - v_plate_thickness, main_frame_height - v_plate_width - E2020_width]) {
        color("red"){extrusion(E2020, v_plate_width + E2020_width + 3*E2020_width, center = false);
        }
      }
      translate([main_frame_width/2-2*E2020_width, -E2040_height - v_plate_thickness, main_frame_height]) {
        color("red"){extrusion(E2020, 30* E2020_width  , center = false);
        }
      }


     translate([main_frame_width/8, -E2040_height - v_plate_thickness, main_frame_height]) {
        color("red"){extrusion(E2020, 20*E2020_width , center = false);
        }
      }
    }

    rotate([0, 90, 0]) {
      translate([-main_frame_height + E2020_width / 2, -E2040_height - v_plate_thickness, E2020_width / 2]) {
        color("red"){extrusion(E2020, main_frame_width / 2 - E2020_width, center = false);}
      }
    }
  }
}
//顶部盖子-左侧-横向放置开窗器
        translate([-v_plate_width/2-E2020_width/2-8,  -3*E2020_width/2-v_plate_thickness/2 ,main_frame_height-2*E2020_width-v_plate_width/2]){
rotate([-90, 0, 0]) {
        color("pink"){extrusion(E2040, main_frame_length+2*E2020_width+v_plate_thickness , center = false);}
        translate([-30,40,100]){
          color("silver"){
            cube([40,50,1360]);            }
        }
    //  }
    }
        }

//顶部盖子-右侧-横向放置开窗器
        translate([main_frame_width-E2040_width/2+v_plate_width/2+3+5, -3*E2020_width/2-v_plate_thickness/2,main_frame_height-2*E2020_width-v_plate_width/2]){
rotate([-90, 0, 0]) {
        color("green"){extrusion(E2040, main_frame_length+2*E2020_width+v_plate_thickness , center = false);}
        translate([-10,40,100]){
          color("silver"){
            cube([40,50,1360]);            }
        }
    }
        }

//顶部盖子-右侧-横向放置开窗器-下方固定U型
translate([-v_plate_width/2-E2020_width-8,main_frame_length/2,400]){
 rotate([-90, 0, 0]) {
        extrusion(E2020, 800, center = true);
    }
}
translate([-v_plate_width/2-8+10,main_frame_length/2-300,400]){
 rotate([0, 90, 0]) {
        extrusion(E2020, 50, center = true);
    }
}
translate([-v_plate_width/2-8+10,main_frame_length/2+300,400]){
 rotate([0, 90, 0]) {
        extrusion(E2020, 50, center = true);
    }
}


//顶部盖子-右侧

for(i=[[main_frame_width/2+E2020_width,-2*v_plate_thickness-2*E2020_width,main_frame_height+E2020_width/2+30*E2020_width],
[7*main_frame_width/8-E2020_width,-2*v_plate_thickness-2*E2020_width,main_frame_height+E2020_width/2+20*E2020_width],
[main_frame_width-E2020_width,-2*v_plate_thickness-2*E2020_width,main_frame_height+3*E2020_width+E2020_width/2]

]){
translate(i){
 color("blue"){
   rotate([-90,0,0]){
   extrusion(E2020,main_frame_length+4*E2020_width+2*v_plate_thickness,center=false);}}}}



translate([main_frame_width-E2020_width,main_frame_length-E2020_width,0]){
rotate([0,0,180]){

for (i = [[0, 0, 0], [0, main_frame_length + E2020_width + E2040_height + 2 * v_plate_thickness, 0]]) {

  translate(i) {
    rotate([0, 0, 0]) {
      translate([0, -E2040_height - v_plate_thickness, main_frame_height - v_plate_width - E2020_width]) {
        color("blue"){extrusion(E2020, v_plate_width + E2020_width + 3*E2020_width, center = false);
        }
      }
      translate([main_frame_width/2-2*E2020_width, -E2040_height - v_plate_thickness, main_frame_height]) {
        color("blue"){extrusion(E2020, 30* E2020_width  , center = false);
        }
      }
     translate([main_frame_width/8, -E2040_height - v_plate_thickness, main_frame_height]) {
        color("blue"){extrusion(E2020, 20*E2020_width , center = false);
        }
      }
    }

    rotate([0, 90, 0]) {
      translate([-main_frame_height + E2020_width / 2, -E2040_height - v_plate_thickness, E2020_width / 2]) {
        color("blue"){extrusion(E2020, main_frame_width / 2 - E2020_width, center = false);}
      }

    }
  }
}
}
}

 
//装配零件-外置支架
module brackets(){
    extrusion_corner_bracket_assembly(E20_corner_bracket);
    }

module brackets_group_tri(){
translate([0,0,E2020_width/2]){
for(i=[[0,0,0],[90,0,0],[0,-90,0]])
{rotate(i){
translate([E2020_width/2,E2020_width/2,0]){  brackets();}
 }
}}
    }

module brackets_group_tri_verse(){
translate([0,0,main_frame_height-E2020_width/2]){
for(i=[[0,0,0],[-90,0,0],[0,90,0]])
{rotate(i){
translate([E2020_width/2,E2020_width/2,0]){  color("red"){brackets();}}
 }
}}
    }

brackets_group_tri_verse();
translate([main_frame_width-E2020_width,0,0]){
rotate([0,0,90]){
brackets_group_tri_verse();
}
}
translate([main_frame_width-E2020_width,main_frame_length-E2020_width,0]){
rotate([0,0,180]){
brackets_group_tri_verse();
}
}
translate([0,main_frame_length-E2020_width,0]){
rotate([0,0,-90]){
brackets_group_tri_verse();
}}


brackets_group_tri();
translate([main_frame_width-E2020_width,0,0]){
rotate([0,0,90]){
brackets_group_tri();
}
}
translate([main_frame_width-E2020_width,main_frame_length-E2020_width,0]){
rotate([0,0,180]){
brackets_group_tri();
}
}
translate([0,main_frame_length-E2020_width,0]){
rotate([0,0,-90]){
brackets_group_tri();
}}


 
//装配零件-外置转接板
////装配零件-外置转接板-2020T-5孔转接板-L型
module 
joint_plate_2020T_L()
{
  translate([0,-E2020_width/2,60]){
  rotate([0,90,0]){
 
linear_extrude(height=4,center=true){
polygon(
points=[[0,0],[60,0],[60,60],[40,60],[0,20]]
);}

for(
    i=[
[10,10,0],
[30,10,0],
[50,10,0],
[50,30,0],
[50,50,0],
]
    )
{
    translate(i)
color("black"){cylinder(r=5.5/2,h=6,center=true);}}

}
}}


////装配零件-外置转接板-2020T-5孔转接板-T型
module 
joint_plate_2020T_T()
{
  translate([-30,0,0]){
     rotate([90,0,0]){
 
linear_extrude(height=4,center=true){
polygon(
points=[[0,0],[60,0],[60,20],[40,60],[20,60],[0,20]]
);}

for(
    i=[
[10,10,0],
[30,10,0],
[50,10,0],
[30,30,0],
[30,50,0],
]
    )
{
    translate(i)
color("black"){ cylinder(r=5.5/2,h=6,center=true);}

}}}}