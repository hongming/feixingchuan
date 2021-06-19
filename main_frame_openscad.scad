/*
  2021-06-08
  搞定
  -底部全部改为20*40厘米
  -立柱底部横杆上边，不直接到底
  -底部连接处留1厘米空隙用于通风透气
  -增加两根1.2米高的立柱，在外侧，相距50厘米，未来放置全天相机、雨雪检测器等
  -顶盖中间横杆改用20*40结构
  2021-06-11
  -顶部改为高低搭配、互锁防水
  -顶盖下方延长3厘米

  待办
  --重要：连接开窗器的pink横杆，中间镂空，这样上下移动不会挡住；或者改为两个竖立的20*40杆
  -立柱+顶部方变为1厘米
  -开窗器侧面增加盖板，8厘米空间
  -底部增加脚垫
  -顶盖改为平-135度-平结构
  -连接处尽量使用T型和L型外置连接板

  2021-06-13
  -升降机放在上边
  -横杆-135度连接件-横杆，一共4组
  -互锁结构采用两个L型
*/


include <NopSCADlib/lib.scad>
include <Connector_2040_L.scad>
//include <v-slot-gantry.scad>



//基本参数
E2040_width = extrusion_width(E2040);//20
E2040_height = extrusion_height(E2040); //40
E2020_width = extrusion_width(E2020);

//V-slot
v_plate_thickness = 10; //卡在缝隙间的厚度
v_plate_width = 65.5;//面板长宽

//主体框架
main_frame_width = 1500;
main_frame_length = 1500;
main_frame_height = 1200;

//顶部盖子
movable_cover_width = 500;
movable_cover_length = 1000;
movable_cover_height = 500;

//转接版厚度
connector_thickness_3 = 3; //3mm

 
//Module模块
//主体框架
////主体框架-立柱
for (i = [[0, -(E2040_height - E2040_width) / 2, E2040_width],
          [main_frame_width - E2040_height / 2, -(E2040_height - E2040_width) / 2, E2040_width],
          [main_frame_width - E2040_height / 2, main_frame_length - (E2040_height - E2040_width) / 2, E2040_width],
          [0, main_frame_length - E2040_width / 2, E2040_width]])
{
  translate(i)
  extrusion(E2040, main_frame_height - E2040_width, center = false);
}

////主体框架-立柱-支撑四根横梁的竖立支架
for (i = [[main_frame_width / 2, 0, E2040_width],
          [main_frame_width - E2020_width, main_frame_length / 2 - 300, E2040_width],
          [main_frame_width - E2020_width, main_frame_length / 2 + 300, E2040_width],
          [main_frame_width / 2, main_frame_length - E2020_width, E2040_width],
          [0, main_frame_length / 2 - 300, E2040_width],
          [0, main_frame_length / 2 + 300, E2040_width]

         ])
{
  translate(i)
  extrusion(E2020, main_frame_height - 2 * E2020_width, center = false);
}

////框架外置物台
for (i = [[200, -E2040_height - 500, E2040_width]

          , [main_frame_width - E2040_height / 2 - 200, -E2040_height - 500, E2040_width]

         ])
{

  translate(i)
  { extrusion(E2020, main_frame_height - 2 * E2020_width, center = false);
    rotate([-90, 0, 0]) {
      translate([0, E2020_width / 2, E2040_width / 2 - 2 * E2020_width]) {
        color("blue") {
          extrusion(E2020, 500 + 2 * E2020_width, center = false);
        }
      }
    }

  }
}


////立柱框架-立柱-前方四个滑块
translate([0, -E2040_height / 2, main_frame_height - 2 * E2020_width - v_plate_width ]) {
  import ("v-slot-gantry.stl");
  //  v_slot_kit();
}
translate([(main_frame_width - E2020_width) / 2  - v_plate_width / 2, -E2040_height / 2, main_frame_height - E2020_width / 2 - v_plate_width / 2 ]) {
  import ("v-slot-gantry.stl");
  //  v_slot_kit();
}
translate([(main_frame_width - E2020_width) / 2 + v_plate_width / 2, -E2040_height / 2, main_frame_height - E2020_width / 2 - v_plate_width / 2 ]) {
  color("black")
  import ("v-slot-gantry.stl");
  //  v_slot_kit();
}
translate([(main_frame_width - E2020_width), -E2040_height / 2, main_frame_height - 2 * E2020_width - v_plate_width ]) {
  color("blue")
  import ("v-slot-gantry.stl");
  //v_slot_kit();
}
////立柱框架-立柱-前方四个滑块-立柱附加的两个滑块
translate([0, -E2040_height / 2, main_frame_height - 2 * E2020_width - v_plate_width - 13 * E2020_width ]) {
  import ("v-slot-gantry.stl");
  //  v_slot_kit();
}
translate([(main_frame_width - E2020_width), -E2040_height / 2, main_frame_height - 2 * E2020_width - v_plate_width - 13 * E2020_width ]) {
  color("blue")
  import ("v-slot-gantry.stl");
  //v_slot_kit();
}


////立柱框架-立柱-前面四个滑块-立柱附加的两个滑块//-增加连接器
translate([-v_plate_width / 2 - connector_thickness_3 - E2020_width - connector_thickness_3,
           -3 * E2020_width / 2 - 3 - 3 - 2 - 3,
           main_frame_height + 2 - 3 * E2020_width - v_plate_width / 2 - 13 * E2020_width]) {
  color("red") {
    Connector_2040_L();
  }
}

translate([-v_plate_width / 2 - connector_thickness_3 - E2020_width - connector_thickness_3,
           -3 * E2020_width / 2 - 3 - 3 - 2 - 3,
           main_frame_height + 2 - 3 * E2020_width - v_plate_width / 2 + 20 - 13 * E2020_width]) {
  color("yellow") {
    Connector_2040_L();
  }
}
translate([-v_plate_width / 2 - connector_thickness_3,
           -3 * E2020_width / 2 - 3 - 3 - 2,
           main_frame_height + 2 - 3 * E2020_width - v_plate_width / 2 - 13 * E2020_width]) {
  color("blue") {
    Connector_2040_L();
  }
}

translate([-v_plate_width / 2 - connector_thickness_3,
           -3 * E2020_width / 2 - 3 - 3 - 2,
           main_frame_height + 2 - 3 * E2020_width - v_plate_width / 2 + 20 - 13 * E2020_width]) {
  color("black") {
    Connector_2040_L();
  }
}

////立柱框架-立柱-前面四个滑块-立柱附加的两个滑块//-增加连接器-结束


////立柱框架-立柱-后方四个滑块
mirror([0, 1, 0]) {
  translate([0, -main_frame_length, main_frame_height - 2 * E2020_width - v_plate_width ]) {
    import ("v-slot-gantry.stl");
    //  v_slot_kit();
  }
  translate([(main_frame_width - E2020_width) / 2  - v_plate_width / 2, -main_frame_length, main_frame_height - E2020_width / 2 - v_plate_width / 2 ]) {
    import ("v-slot-gantry.stl");
    //  v_slot_kit();
  }
  translate([(main_frame_width - E2020_width) / 2 + v_plate_width / 2, -main_frame_length, main_frame_height - E2020_width / 2 - v_plate_width / 2 ]) {
    color("black")
    import ("v-slot-gantry.stl");
    //v_slot_kit();
  }
  translate([(main_frame_width - E2020_width), -main_frame_length, main_frame_height - 2 * E2020_width - v_plate_width ]) {
    color("grey")
    import ("v-slot-gantry.stl");
    //v_slot_kit();
  }
}

////立柱框架-立柱-后方四个滑块-立柱附加的两个滑块

mirror([0, 1, 0]) {
  translate([0, -main_frame_length, main_frame_height - 2 * E2020_width - v_plate_width - 13 * E2020_width ]) {
    import ("v-slot-gantry.stl");
    //  v_slot_kit();
  }

  translate([(main_frame_width - E2020_width), -main_frame_length, main_frame_height - 2 * E2020_width - v_plate_width - 13 * E2020_width]) {
    color("grey")
    import ("v-slot-gantry.stl");
    //v_slot_kit();
  }
}

////立柱框架-立柱-后方四个滑块-立柱附加的两个滑块-附加L型支架-开始
translate([-v_plate_width / 2 - connector_thickness_3,
           main_frame_length - 32 + 2 * E2020_width + v_plate_thickness,
           main_frame_height + 16 + 2 - 3 * E2020_width - v_plate_width / 2 - 13 * E2020_width]) {
  color("black") {
    rotate([180, 0, 0]) {
      Connector_2040_L();
    }
  }
}

translate([-v_plate_width / 2 - connector_thickness_3,
           main_frame_length - 32 + 2 * E2020_width + v_plate_thickness,
           main_frame_height + 16 + 2 - 3 * E2020_width - v_plate_width / 2 + 20 - 13 * E2020_width]) {
  color("blue") {
    rotate([180, 0, 0]) {
      Connector_2040_L();
    }
  }
}

//顶部盖子-左侧-后面的固定L型镂空连接器-附加
translate([-v_plate_width / 2 - connector_thickness_3 - E2040_width - connector_thickness_3,
           main_frame_length - 32 + 2 * E2020_width + v_plate_thickness + connector_thickness_3,
           main_frame_height + 16 + 2 - 3 * E2020_width - v_plate_width / 2 - 13 * E2020_width]) {
  color("red") {
    rotate([180, 0, 0]) {
      Connector_2040_L();
    }
  }
}

translate([-v_plate_width / 2 - connector_thickness_3 - E2040_width - connector_thickness_3,
           main_frame_length - 32 + 2 * E2020_width + v_plate_thickness + connector_thickness_3,
           main_frame_height + 16 + 2 - 3 * E2020_width - v_plate_width / 2 + 20 - 13 * E2020_width]) {
  color("pink") {
    rotate([180, 0, 0]) {
      Connector_2040_L();
    }
  }
}

////立柱框架-立柱-后方四个滑块-立柱附加的两个滑块-附加L型支架-结束

//主体框架-立柱-四根支撑住-T型固定-上方
for (i = [[main_frame_width / 2, E2020_width / 2 + 2, main_frame_height], [main_frame_width / 2, main_frame_length - 3 * E2020_width / 2 - 2, main_frame_height]]) {
  translate(i) {

    rotate([0, 180, 0]) {
      joint_plate_2020T_T();
    }
  }
}

for (i = [[E2020_width / 2 + 2, main_frame_length / 2 - 300, main_frame_height]
          ,
          [E2020_width / 2 + 2, main_frame_length / 2 + 300, main_frame_height], [main_frame_width - 3 * E2020_width / 2 - 2, main_frame_length / 2 + 300, main_frame_height]
          ,
          [main_frame_width - 3 * E2020_width / 2 - 2, main_frame_length / 2 - 300, main_frame_height]]) {
  translate(i) {

    rotate([0, 180, 90]) {
      joint_plate_2020T_T();
    }
  }
}
//主体框架-立柱-四根支撑住-T型固定-下方
for (i = [[main_frame_width / 2, E2020_width / 2 + 2, 0], [main_frame_width / 2, main_frame_length - 3 * E2020_width / 2 - 2, 0]]) {
  translate(i) {

    joint_plate_2020T_T();

  }
}

for (i = [[E2020_width / 2 + 2, main_frame_length / 2 + 300, 0],
          [E2020_width / 2 + 2, main_frame_length / 2 - 300, 0], [main_frame_width - 3 * E2020_width / 2 - 2, main_frame_length / 2 + 300, 0],
          [main_frame_width - 3 * E2020_width / 2 - 2, main_frame_length / 2 - 300, 0]]) {
  translate(i) {

    rotate([0, 0, 90]) {
      joint_plate_2020T_T();
    }

  }
}


//主体框架-立柱-四根支撑住-L型固定-上方

translate([-E2020_width / 2 - 2, 0, main_frame_height]) {

  rotate([0, 180, 0]) {
    joint_plate_2020T_L();
  }
}

translate([-E2020_width / 2 - 2, main_frame_length - E2020_width, main_frame_height]) {
  rotate([0, 180, 180])
  {
    joint_plate_2020T_L();
  }
}


translate([main_frame_width - E2020_width / 2 + 2, 0, main_frame_height]) {
  rotate([0, 180, 0]) {
    joint_plate_2020T_L();
  }
}

translate([main_frame_width - E2020_width / 2, main_frame_length - E2020_width, main_frame_height]) {
  rotate([0, 180, 180])
  {
    joint_plate_2020T_L();
  }
}




////主体框架-Width横柱-逆时针-下半部分
for (i = [[0, 0, 0]])
{
  translate(i) {
    rotate([0, 90, 0]) {
      translate([-E2020_width / 2, -E2020_width / 2, E2020_width / 2 + 10]) {
        //两边各留出1厘米用于通风
        color("grey") {
          extrusion(E2040, main_frame_width - 2 * E2040_width - 20, center = false);
        }
      }
    }
    translate([main_frame_width+E2020_width/2, -E2040_height, 0]) {
      rotate([-90, 0, 0]) {
        translate([0, -E2020_width / 2, E2020_width / 2]) {
          rotate([0, 0, 90]) {
            color("red") {
              extrusion(E2080, main_frame_length + E2040_height, center = false);
            }
          }
        }
      }
    }
    translate([10, main_frame_length - E2020_width / 2, 0]) {
      rotate([0, 90, 0]) {
        translate([-E2020_width / 2, 0, E2020_width / 2]) {
          color("grey") {
            extrusion(E2040, main_frame_width - 2 * E2040_width - 20, center = false);
          }
        }
      }
    }
    rotate([-90, 0, 0]) {
      translate([-3*E2020_width/2, -E2020_width / 2, -3 * E2020_width / 2]) {
        rotate([0, 0, 90]) {
          color("red") {
            extrusion(E2080, main_frame_length + E2040_height, center = false);
          }
        }
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
translate([-v_plate_width / 2 - connector_thickness_3,
           main_frame_length - 32 + 2 * E2020_width + v_plate_thickness,
           main_frame_height + 16 + 2 - 3 * E2020_width - v_plate_width / 2]) {
  color("black") {
    rotate([180, 0, 0]) {
      Connector_2040_L();
    }
  }
}

translate([-v_plate_width / 2 - connector_thickness_3,
           main_frame_length - 32 + 2 * E2020_width + v_plate_thickness,
           main_frame_height + 16 + 2 - 3 * E2020_width - v_plate_width / 2 + 20]) {
  color("blue") {
    rotate([180, 0, 0]) {
      Connector_2040_L();
    }
  }
}

//顶部盖子-左侧-后面的固定L型镂空连接器-附加
translate([-v_plate_width / 2 - connector_thickness_3 - E2040_width - connector_thickness_3,
           main_frame_length - 32 + 2 * E2020_width + v_plate_thickness + connector_thickness_3,
           main_frame_height + 16 + 2 - 3 * E2020_width - v_plate_width / 2]) {
  color("red") {
    rotate([180, 0, 0]) {
      Connector_2040_L();
    }
  }
}

translate([-v_plate_width / 2 - connector_thickness_3 - E2040_width - connector_thickness_3,
           main_frame_length - 32 + 2 * E2020_width + v_plate_thickness + connector_thickness_3,
           main_frame_height + 16 + 2 - 3 * E2020_width - v_plate_width / 2 + 20]) {
  color("pink") {
    rotate([180, 0, 0]) {
      Connector_2040_L();
    }
  }
}

//顶部盖子-左侧-前面的固定L型镂空连接器
translate([-v_plate_width / 2 - connector_thickness_3,
           -3 * E2020_width / 2 - 3 - 3 - 2,
           main_frame_height + 2 - 3 * E2020_width - v_plate_width / 2]) {
  color("blue") {
    Connector_2040_L();
  }
}

translate([-v_plate_width / 2 - connector_thickness_3,
           -3 * E2020_width / 2 - 3 - 3 - 2,
           main_frame_height + 2 - 3 * E2020_width - v_plate_width / 2 + 20]) {
  color("black") {
    Connector_2040_L();
  }
}

//顶部盖子-左侧-前面的固定L型镂空连接器-附加
translate([-v_plate_width / 2 - connector_thickness_3 - E2020_width - connector_thickness_3,
           -3 * E2020_width / 2 - 3 - 3 - 2 - 3,
           main_frame_height + 2 - 3 * E2020_width - v_plate_width / 2]) {
  color("red") {
    Connector_2040_L();
  }
}

translate([-v_plate_width / 2 - connector_thickness_3 - E2020_width - connector_thickness_3,
           -3 * E2020_width / 2 - 3 - 3 - 2 - 3,
           main_frame_height + 2 - 3 * E2020_width - v_plate_width / 2 + 20]) {
  color("yellow") {
    Connector_2040_L();
  }
}

//顶部盖子-右侧-后面的固定L型镂空连接器
translate([main_frame_width + v_plate_width / 2 - E2020_width + connector_thickness_3,
           main_frame_length - 32 + 2 * E2020_width + v_plate_thickness,
           main_frame_height + 2 - 3 * E2020_width - v_plate_width / 2]) {
  color("yellow") {
    rotate([180, 180, 0]) {
      Connector_2040_L();
    }
  }
}

translate([main_frame_width + v_plate_width / 2 - E2020_width + connector_thickness_3,
           main_frame_length - 32 + 2 * E2020_width + v_plate_thickness,
           main_frame_height + 2 - 3 * E2020_width - v_plate_width / 2 + 20]) {
  color("red") {
    rotate([180, 180, 0]) {
      Connector_2040_L();
    }
  }
}

//左侧盖子
dome_half_cover();


//顶部盖子-左侧-横向连接开窗器的架子-下沉支架+固定U型
translate([-v_plate_width / 2 - E2020_width / 2 - connector_thickness_3,  -3 * E2020_width / 2 - v_plate_thickness / 2 , main_frame_height - 2.5 * E2020_width- v_plate_width / 2 - 300]) {

  translate([0, E2020_width, E2020_width / 2]) {
    rotate([0, 0, 0]) {
      color("blue") {
        extrusion(E2040, 16.5 * E2020_width,  center = false);
      }
    }
  }
  translate([0, main_frame_length + 2 * E2020_width - E2020_width / 2, E2020_width / 2]) {
    rotate([0, 0, 0]) {
      color("blue") {
        extrusion(E2040, 16.5 * E2020_width , center = false);
      }
    }
  }
translate([E2020_width/2,0,0]){
    rotate([-90, 90, 0]) {
    color("pink") {
      extrusion(E2040, main_frame_length + 2 * E2020_width + v_plate_thickness , center = false);
    }
  }
}

}


//顶部盖子-左侧-横向放置开窗器
translate([-v_plate_width / 2 - connector_thickness_3,  -3 * E2020_width / 2 - v_plate_thickness / 2 , main_frame_height - 3.5 * E2020_width- v_plate_width / 2 - 300]) {
  rotate([-90, 0, 0]) {
    translate([-30, 0, 100]) {
      color("grey") {
        cube([40, 50, 1360]);
      }
    }
  }
}


//顶部盖子-左侧-横向放置开窗器--链子
for (i = [
           [-4 * E2020_width / 2 - connector_thickness_3 - connector_thickness_3, main_frame_length / 2 - 300, E2020_width  ],
           [-50, main_frame_length / 2 + 300, E2020_width  ]
         ])
{
  translate(i)
  color("orange", alpha = 0.5) {
    linear_extrude(height = 740, twist = 360) {
      square([10, 10], center = false);
    }
    //extrusion(E2020, 740, center = false);
  }
}

//左侧内嵌板
translate([1, 0, E2020_width / 2]) {
  color("black" , alpha = 0.5) {
    cube([2, main_frame_length, main_frame_height - E2020_width]);
  }
}

//左侧外置遮雨板-内嵌5毫米
translate([-v_plate_width / 2 - connector_thickness_3 - 2 - E2020_width - E2020_width, E2020_width / 2, 0]) {
  color("black", alpha = 0.6) {
    translate([0,-5,0]){
    cube([2, main_frame_length - 2 * E2020_width+10, main_frame_height - 15 * E2020_width]);}
  }
  for (i=[[0,0,0],[0,main_frame_length - 2 * E2020_width+15,0]]){
translate(i){
translate([-2, -E2020_width/2, 0]) {
         extrusion(E2020,  main_frame_height - 15 * E2020_width,  center = false);
}
translate([E2020_width/2-2,-E2020_width/2,1.5*E2020_width]){
rotate([0,90,0]){
         extrusion(E2020, 3* E2020_width,  center = false);}
}
translate([E2020_width/2-2,-E2020_width/2,5*E2020_width]){
rotate([0,90,0]){
         extrusion(E2020, 3* E2020_width,  center = false);}
}}}
}

translate([-v_plate_width / 2 - connector_thickness_3 - 2 - E2020_width - E2020_width, E2020_width / 2, main_frame_height - 15 * E2020_width + 2]) {
  rotate([0, 90, 0]) {
    color("grey", alpha = 0.6) {
      cube([2, main_frame_length - 2 * E2020_width, v_plate_width / 2 + connector_thickness_3 + 2 + E2020_width + E2020_width / 2]);
    }
  }
}



//右侧盖子
translate([main_frame_width - E2020_width, main_frame_length - E2020_width, 0]) {
  rotate([0, 0, 180]) {

    //左侧镜像
    dome_half_cover();

  }
}


//顶部盖子-右侧-横向连接开窗器的架子-下沉支架+固定U型
translate([main_frame_width - E2020_width - v_plate_width / 2 - connector_thickness_3 + 4 * E2020_width,  -3 * E2020_width / 2 - v_plate_thickness / 2 , main_frame_height - 2.5 * E2020_width- v_plate_width / 2 - 300]) {

  translate([0, E2020_width, E2020_width / 2]) {
    rotate([0, 0, 0]) {
      color("grey") {
        extrusion(E2040, 16.5 * E2020_width,  center = false);
      }
    }
  }
  translate([0, main_frame_length + 2 * E2020_width - E2020_width / 2, E2020_width / 2]) {
    rotate([0, 0, 0]) {
      color("grey") {
        extrusion(E2040, 16.5 * E2020_width , center = false);
      }
    }
  }
  translate([-E2020_width/2,0,0]){
  rotate([-90, 90, 0]) {
    color("pink") {
      extrusion(E2040, main_frame_length + 2 * E2020_width + v_plate_thickness , center = false);
    }
  }}
}

//顶部盖子-右侧-前面的固定L型镂空连接器
translate([main_frame_width + v_plate_width / 2 - E2020_width + connector_thickness_3,
           -3 * E2020_width / 2 - 3 - 3 - 2,
           main_frame_height + 2 + 16 - 3 * E2020_width - v_plate_width / 2]) {
  color("red") {
    rotate([0, 180, 0]) {
      Connector_2040_L();
    }
  }
}
translate([main_frame_width + v_plate_width / 2 - E2020_width + connector_thickness_3,
           -3 * E2020_width / 2 - 3 - 3 - 2,
           main_frame_height + 2 + 16 - 3 * E2020_width - v_plate_width / 2 + 20]) {
  color("red") {
    rotate([0, 180, 0]) {
      Connector_2040_L();
    }
  }
}
translate([main_frame_width + v_plate_width / 2 - E2020_width + connector_thickness_3,
           -3 * E2020_width / 2 - 3 - 3 - 2,
           main_frame_height + 2 + 16 - 3 * E2020_width - v_plate_width / 2 - 13 * E2020_width]) {
  color("red") {
    rotate([0, 180, 0]) {
      Connector_2040_L();
    }
  }
}
translate([main_frame_width + v_plate_width / 2 - E2020_width + connector_thickness_3,
           -3 * E2020_width / 2 - 3 - 3 - 2,
           main_frame_height + 2 + 16 - 3 * E2020_width - v_plate_width / 2 + 20 - 13 * E2020_width]) {
  color("red") {
    rotate([0, 180, 0]) {
      Connector_2040_L();
    }
  }
}

//顶部盖子-右侧-横向放置开窗器
translate([main_frame_width - E2020_width, 0, 0]) {
  mirror([1, 0, 0])
  {
    translate([-v_plate_width / 2 - connector_thickness_3,  -3 * E2020_width / 2 - v_plate_thickness / 2 , main_frame_height - 3.5 * E2020_width- v_plate_width / 2 - 300]) {
      rotate([-90, 0, 0]) {
        translate([-30, 0, 100]) {
          color("grey") {
            cube([40, 50, 1360]);
          }
        }
      }
    }
  }
}


//顶部盖子-右侧-横向放置开窗器--链子
for (i = [
           [E2020_width  - connector_thickness_3 - connector_thickness_3+main_frame_width, main_frame_length / 2 - 300, E2020_width  ],
           [E2020_width  - connector_thickness_3 - connector_thickness_3+main_frame_width, main_frame_length / 2 + 300, E2020_width  ]
         ])
{
  translate(i)
  color("orange", alpha = 0.5) {
    linear_extrude(height = 740, twist = 360) {
      square([10, 10], center = false);
    }
    //extrusion(E2020, 740, center = false);
  }
}

//右侧外置遮雨板
translate([main_frame_width+v_plate_width / 2 + connector_thickness_3 + 2 + E2020_width , E2020_width / 2, 0]) {
  color("black", alpha = 0.6) {
    cube([2, main_frame_length - 2 * E2020_width, main_frame_height - 15 * E2020_width]);
  }
}


translate([main_frame_width-E2020_width / 2, E2020_width / 2, main_frame_height - 15 * E2020_width + 2]) {
  rotate([0, 90, 0]) {
    color("grey", alpha = 0.6) {
      cube([2, main_frame_length - 2 * E2020_width, v_plate_width / 2 + connector_thickness_3 + 2 + E2020_width + E2020_width / 2]);
    }
  }
}


//装配零件-外置支架
module brackets() {
  extrusion_corner_bracket_assembly(E20_corner_bracket);
}

module brackets_group_tri() {
  translate([0, 0, E2020_width / 2]) {
    for (i = [[0, 0, 0], [90, 0, 0], [0, -90, 0]])
    { rotate(i) {
        translate([E2020_width / 2, E2020_width / 2, 0]) {
          brackets();
        }
      }
    }
  }
}

module brackets_group_tri_verse() {
  translate([0, 0, main_frame_height - E2020_width / 2]) {
    for (i = [[0, 0, 0], [-90, 0, 0], [0, 90, 0]])
    { rotate(i) {
        translate([E2020_width / 2, E2020_width / 2, 0]) {
          color("red") {
            brackets();
          }
        }
      }
    }
  }
}

brackets_group_tri_verse();
translate([main_frame_width - E2020_width, 0, 0]) {
  rotate([0, 0, 90]) {
    brackets_group_tri_verse();
  }
}
translate([main_frame_width - E2020_width, main_frame_length - E2020_width, 0]) {
  rotate([0, 0, 180]) {
    brackets_group_tri_verse();
  }
}
translate([0, main_frame_length - E2020_width, 0]) {
  rotate([0, 0, -90]) {
    brackets_group_tri_verse();
  }
}


brackets_group_tri();
translate([main_frame_width - E2020_width, 0, 0]) {
  rotate([0, 0, 90]) {
    brackets_group_tri();
  }
}
translate([main_frame_width - E2020_width, main_frame_length - E2020_width, 0]) {
  rotate([0, 0, 180]) {
    brackets_group_tri();
  }
}
translate([0, main_frame_length - E2020_width, 0]) {
  rotate([0, 0, -90]) {
    brackets_group_tri();
  }
}



//装配零件-外置转接板
////装配零件-外置转接板-2020T-5孔转接板-L型
module
joint_plate_2020T_L()
{
  translate([0, -E2020_width / 2, 60]) {
    rotate([0, 90, 0]) {

      linear_extrude(height = 4, center = true) {
        polygon(
          points = [[0, 0], [60, 0], [60, 60], [40, 60], [0, 20]]
        );
      }

      for (
        i = [
              [10, 10, 0],
              [30, 10, 0],
              [50, 10, 0],
              [50, 30, 0],
              [50, 50, 0],
            ]
      )
      {
        translate(i)
        color("black") {
          cylinder(r = 5.5 / 2, h = 6, center = true);
        }
      }

    }
  }
}


////装配零件-外置转接板-2020T-5孔转接板-T型
module
joint_plate_2020T_T()
{
  translate([-30, 0, 0]) {
    rotate([90, 0, 0]) {

      linear_extrude(height = 4, center = true) {
        polygon(
          points = [[0, 0], [60, 0], [60, 20], [40, 60], [20, 60], [0, 20]]
        );
      }

      for (
        i = [
              [10, 10, 0],
              [30, 10, 0],
              [50, 10, 0],
              [30, 30, 0],
              [30, 50, 0],
            ]
      )
      {
        translate(i)
        color("black") {
          cylinder(r = 5.5 / 2, h = 6, center = true);
        }

      }
    }
  }
}




//～～～～～～～～～模块组

//顶盖半边模块
module dome_half_cover()
{

  //顶部盖子-左侧1-纵向杆
  for (i = [[0, -2 * v_plate_thickness - 2 * E2020_width, main_frame_height + 3 * E2020_width + E2020_width / 2 + 9 * E2020_width]]) {
    translate(i) {
      color("blue") {
        rotate([-90, 0, 0]) {
          extrusion(E2020, main_frame_length + 4 * E2020_width + 2 * v_plate_thickness, center = false);
        }
      }
    }
  }

  //顶部盖子-左侧4-纵向杆的互锁机构
  translate([main_frame_width / 2 - E2020_width, -2 * v_plate_thickness - 2 * E2020_width, main_frame_height + E2020_width / 2 + 40 * E2020_width]) {
    rotate([-90, 0, 0]) {
      extrusion(E2020, main_frame_length + 4 * E2020_width + 2 * v_plate_thickness, center = false);
    }
  }


//竖杆挡水片
            translate([main_frame_width / 2 - 1.5 * E2020_width, -E2040_height - v_plate_thickness+E2020_width/2-E2020_width-2, main_frame_height]) {
        color("black",0.2) {
          cube([2*E2020_width,2,41 * E2020_width]);
          // extrusion(E2020, 40 * E2020_width  , center = false);

        }
        //固定螺丝-开始
    for(i=[[E2020_width/2,10,2],
        [E2020_width/2,400,2],
        [E2020_width/2,800-10,2]
    ]){
rotate([90,0,0]){
    translate(i){
      screw(M5_cap_screw, 8);
  translate([0,0,-4]){
     rotate([0, 180, 90]) {
       sliding_t_nut(M5_sliding_t_nut);
     }}}
}
    
     }
      //固定螺丝-结束
      }    

  //顶部盖子-左侧1-4-支撑立柱
  for (i = [[0, 0, 0], [0, main_frame_length + E2020_width + E2040_height + 2 * v_plate_thickness, 0]]) {
    //立柱
    translate(i) {
      translate([0, -E2040_height - v_plate_thickness, main_frame_height - v_plate_width - E2020_width]) {
        color("pink") {
          extrusion(E2020, v_plate_width + E2020_width + 3 * E2020_width + 9 * E2020_width, center = false);
        }
      }
      //  translate([3* E2020_width, -E2040_height - v_plate_thickness, main_frame_height]) {
      //     color("grey"){extrusion(E2020, 3*E2020_width+9*E2020_width , center = false);
      //     }
      //   }
      // translate([main_frame_width/2-5*E2020_width, -E2040_height - v_plate_thickness, main_frame_height]) {
      //   color("red"){extrusion(E2020, 40* E2020_width  , center = false);
      //   }
      // }
      translate([main_frame_width / 2 - 1 * E2020_width, -E2040_height - v_plate_thickness, main_frame_height]) {
        color("black") {
          extrusion(E2020, 40 * E2020_width  , center = false);
        }
      }



      ////顶部盖子-左侧45度斜杆左侧的横杆
      translate([E2020_width / 2, -E2040_height - v_plate_thickness, main_frame_height + 3 * E2020_width + E2020_width / 2 + 9 * E2020_width]) {

        rotate([0, 90, 0]) {
          color("red") {
            extrusion(E2020, 3 * E2020_width+E2020_width/cos(45), center = false);
          }
        }
      }

      ////顶部盖子-左侧45度斜杆
     
      translate([4 * E2020_width - (E2020_width / 2 - E2020_width / 2 * cos(45)), -E2040_height - v_plate_thickness, main_frame_height + 3 * E2020_width + (E2020_width - E2020_width / 2 * cos(45)) + 9 * E2020_width]) {

        rotate([0, 45, 0]) {
          color("orange") {
            import("extrusion_2020_cover_45_inclined_support.stl");
            //extrusion(E2020, (main_frame_width / 2 - 10 * E2020_width)*sqrt(2) + E2020_width * 0.3+3*E2020_width, center = false);
          }
        }
      }
      
      ////顶部盖子-左侧45度斜杆右侧的横杆
      translate([main_frame_width / 2 - 5 * E2020_width - E2020_width / 2, -E2040_height - v_plate_thickness, main_frame_height + E2020_width / 2 + 40 * E2020_width]) {

import("extrusion_2020_cover_45.stl");
        // rotate([0, 90, 0]) {
        //   color("yellow") {
        //     extrusion(E2020, 4 * E2020_width+E2020_width/cos(45), center = false);
        //   }
        // }
        
      }

      //顶部盖子-左侧-底部横向杆
      rotate([0, 90, 0]) {
        translate([-main_frame_height + E2020_width / 2, -E2040_height - v_plate_thickness, E2020_width / 2]) {
          color("black") {
            extrusion(E2020, main_frame_width / 2 - E2020_width, center = false);
          }
        }
      }
    }
  }


  //顶部盖子-左侧-底部横杆突出物
  for (i = [[0, 0, 0], [0, main_frame_length + 3 * E2020_width + E2020_width / 2 + E2040_height + 2 * v_plate_thickness, 0]]) {

    translate(i) {
      translate([main_frame_width / 2 - 1 * E2020_width, -E2020_width / 2 - E2040_height - v_plate_thickness, main_frame_height - E2020_width / 2]) {
        color("orange") {
          rotate([90, 0, 0]) {
            extrusion(E2020, 1.5 * E2020_width  , center = false);
          }

        }
      }


    }
  }

}


//顶部盖子-左侧4-纵向杆的互锁机构-L型装置
  translate([main_frame_width / 2 - 3*E2020_width/2, -2 * v_plate_thickness - 2 * E2020_width-E2020_width/2, main_frame_height + E2020_width / 2 + 40.5 * E2020_width]) {
    rotate([0, 0, 0]) {
      color("grey"){
    cover_weatherboard(); 
    }

    //固定螺丝-开始
    for(i=[[E2020_width/2,20,2],
        [E2020_width/2,main_frame_length/3,2],
        [E2020_width/2,main_frame_length + 4 * E2020_width + 2 * v_plate_thickness-10,2],
        [E2020_width/2,main_frame_length + 4 * E2020_width + 2 * v_plate_thickness-main_frame_length/3,2]
    ]){
  translate(i){
      screw(M5_cap_screw, 8);
  translate([0,0,-4]){
     rotate([0, 180, 90]) {
       sliding_t_nut(M5_sliding_t_nut);
     }}}}
     //固定螺丝-结束

  }
     
  }



  //顶部盖子-右侧1-纵向杆的互锁机构—L型装置+增高器
  translate([main_frame_width / 2 +E2020_width, -2 * v_plate_thickness - 2 * E2020_width, main_frame_height + E2020_width / 2 + 41 * E2020_width]) {
    rotate([-90, 0, 0]) {
      color("yellow"){
      extrusion(E2020, main_frame_length + 4 * E2020_width + 2 * v_plate_thickness, center = false);}
    }

    //L型（135）遮雨装置
    translate([E2020_width*0.5,-E2020_width/2,E2020_width*0.5]){
   color("grey")cover_weatherboard_135(main_frame_length + 4 * E2020_width +E2020_width+ 2 * v_plate_thickness);}

        //固定螺丝-开始
        rotate([0,90,0]){
    for(i=[[0,10,2+E2020_width/2],
        [0,main_frame_length/3,2+E2020_width/2],
        [0,main_frame_length + 4 * E2020_width + 2 * v_plate_thickness-10,2+E2020_width/2],
        [0,main_frame_length + 4 * E2020_width + 2 * v_plate_thickness-main_frame_length/3,2+E2020_width/2]
    ]){
  translate(i){
      screw(M5_cap_screw, 8);
  translate([0,0,-4]){
     rotate([0, 180, 90]) {
       sliding_t_nut(M5_sliding_t_nut);
     }}
     
     }}}
     //固定螺丝-结束

  }





//顶部遮雨L型（90度）结构
module cover_weatherboard() {
    cube([2 * E2020_width, main_frame_length + 5 * E2020_width + 2 * v_plate_thickness, 2]);
    translate([2 * E2020_width, 0, 0]) {
        rotate([0, -90, 0]) {
            cube([E2020_width, main_frame_length + 5 * E2020_width + 2 * v_plate_thickness, 2]);
        }
    }
}




//顶部遮雨L型（135度）结构
module cover_weatherboard_135(L_length) {

    translate([ - 30, 0, 2]) {
        rotate([ - 90, 0, 0]) {
            linear_extrude(height = L_length, center = false) {

                    square([30, 2]);
                    translate([30,0,0]){
                        square([2, 20+2]);
                        }
             

                rotate([0, 0, 135]) {
                    translate([0, -2, 0]) {
                        square([20, 2]);
                    }
                }
            }
        }

    }
}


              

