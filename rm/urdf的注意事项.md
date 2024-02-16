# 学习如何写urdf

### 怎么写

- ```
  <robot name="">
  	<link>
  		<visual>
  			<origin xyz="" rpy=""/>
  			<geometry>
  				<box size=""/>
  			</geometry>
  		</visual>
  		<collision>
  			<origin xyz="" rpy=""/>
  			<geometry>
  				<box size=""/>
  			</geometry>
  		</collision>
  		<inertial>
  			<origin xyz="" rpy=""/>
  			<mass value=""/>
  			<inertia ixx="" ixy="" ixz="" iyy="" iyz="" izz=""/>
  		</inertial>
  	</link>
  	
  	<joint name="" type="">
  		<origin xyz="" rpy=""/>
  		<parent link=""/>
  		<child link=""/>
  		<axis xyz=""/>
  	</joint>
  	
  	<transmission name="">
  		<type>transmission_inteerface/SimpleTransmission</type>
  		<joint name="">
  			<hardwareInterface>hardware_interface/EffortJointInterface</hardwareInterface>
  		</joint>
  		<actuator>
  			<hardwareInterface>hardware_interface/EfforJointInterface</hardwareInterface> //optional
  			<mechanicalReduction>50</mechanicalReduction> //optional
  		</actuator>
  	</transmission>
  	
  	//要识别transmission，就要用对应的plugin
  	<gazebo>
  		<plugin name="">
  			<robotNamespace>/</robotNamespace>
  		</plugin>
  	</gazebo>
  	
  </robot>
  ```
  
  

### 易错点

- 写完两个link和一个joint之后，发现在rviz里面无法正常显示

- ```
  /*解决方法*/
  <!--launch文件里没有启动robot_state_publisher,故关节的TF关系无法确定，所以就不能正常显示了-->
  
  <node name="robot_state_publisher" pkg="robot_state_publisher" type="robot_state_publisher" />
  ```

- 将joint的类型改为continuous(除了fixed以外的类型)，发现在rviz里面无法正常显示

- ```
  /*解决方法*/
  <!-- launch文件里没有启动joint_state_publisher,故关节的状态无法确定，TF关系无法确定 -->
  
  <node name="joint_state_publisherjoint_state_publisher" pkg="joint_state_publisherjoint_state_publisher" type="joint_state_publisher"/>
  ```

- 将urdf载入gazebo中，但发现没有模型

- ```
  /*注意，当 URDF 需要与 Gazebo 集成时，和 Rviz 有明显区别:
  
  1.必须使用 collision 标签，因为既然是仿真环境，那么必然涉及到碰撞检测，collision 提供碰撞检测的依据。
  
  2.必须使用 inertial 标签，此标签标注了当前机器人某个刚体部分的惯性矩阵，用于一些力学相关的仿真计算。
  
  3.颜色设置，也需要重新使用 gazebo 标签标注，因为之前的颜色设置为了方便调试包含透明度，仿真环境下没有此选项。*/
  
  <!--对于collision,如果机器人link是标准的几何体形状，和link的 visual 属性设置一致即可。-->
  <!--对于规则几何体inertial,可以参考对应公式 -->
  ```

- 关节的base_link在urdf中具有惯性参数，但是KDL不支持，建议的解决办法是，增加一个额外的dummy link。

- ```
  /*Create a frame 'odom' and a frame 'base_link' or whatever you like. Then joint them toghether with a fixed joint. The inertia must be put on the child frame, in this case 'base_link' otherwise you get the error.*/
  
  <!-- 这也是为什么要出现一个odom的原因 -->
    <link name="odom">
    </link>
    <joint name="dummy_joint" type="fixed">
       <parent link="odom"/>
       <child link="base_link"/>
    </joint>
    
  <!-- root frame 要设置几何形状,inertial要写在base_link下 -->
  ```
  
- XML不完整引号

- ```
  /*
   *Error parsing Element.//少""
   *Error reading Attributes.//少结束符/
   *Error parsing XML: not well-formed (invalid token)//代码里面有注释之类的
   *[GazeboRosSkidSteerDrive::Load]: GazeboRosSkidSteerDrive missing <covariance_x>//对应参数未补全
   */
  ```

- ```
  检测XML格式，赋值有没有"",结尾有没有/>
  ```


- 

- controllers.yaml文件里面的controller没有给PID参数

- ```
   [Pid::init]: No p gain specified for pid.  Namespace: /controllers/effort_joint_controller/pid
   [ControllerManager::loadController]: Initializing controller 'controllers/effort_joint_controller' failed
  ```

- ==检查惯性矩有没有写对==

> gazebo里面的惯性矩应该包住整一个模型

- ==joint实际上是现实的actuator的映射==

> joint通过urdf里面的transmission映射为关节，额外的减速箱的减速比会在mechanicalReduction里面设置



#出urdf

- urdf的base_link应该出在车架的几何中心，出urdf时可以让机械组把轮子什么的全部都去掉，单独把车架扔在地面上，再这样算出它的质心坐标

- joint的xyz其实就是两个link的偏移值，而子link的质心填的是相对于joint的（记得让机械组衍生再移到原点，给出对应的偏移）

- 惯性矩和质量都是确定的，但要注意单位转换

- 一般把一个电机当成一个link

- ```
  <limit effort="1.2" velocity="13.82" lower="-1E10" upper="1E10"/> 
  <safety_controller k_velocity="0.1"
                     k_position="100" 
                     soft_lower_limit="${pitch_lower_limit+threshold}"
                     soft_upper_limit="${pitch_upper_limit-threshold}"/> 软限位
  ```

- ```
      <xacro:property name="wheel_track" value="0.31"/> //横向轮距
      <xacro:property name="wheel_base" value="0.281"/> //轮子轴距
      <xacro:property name="wheel_offset_z" value="0.072"/>  //车架和轴心之间的距离
  ```

- gimbal_imu的坐标系要改为和实际的一致

- 记得选好joint的转轴

- ==减速比的正负是以电机轴方向成右手螺旋定则==

- 控制器有命令输出，但控不住电机，pid没调对

- 控制器控制的位置与实际不符，减速比没给对

如果是想要实车测试控制器的话，只需要把urdf里面的link和joint填写好，再完善关节映射就行了