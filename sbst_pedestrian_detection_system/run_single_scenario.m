% load the static scene
ret = sendCommand('LOAD', '192.168.1.106', 'prescan_repl_minimal.script');

% Turn on "cast shadows" for the pedestrian's 19 body parts
%ret = sendCommand('COMD', '192.168.1.106', 'run toggle_pedestrian_shadows.script')

% set properties of the car (that has cruise control)
init_car_speed_cmd = ['ego_car/car.SetInitSpeed ' num2str(car_speed)];
car_speed_cmd = ['ego_car/car.SetSpeed ' num2str(car_speed)];
car_speed_control_cmd = ['ego_car/car.SetInitSpeedLimit ', num2str(car_speed)];
ret = sendCommand('COMD', '192.168.1.106', init_car_speed_cmd);
ret = sendCommand('COMD', '192.168.1.106', car_speed_cmd);
ret = sendCommand('COMD', '192.168.1.106', car_speed_control_cmd);

% set properties for the pedestrian
init_ped_position_cmd = ['dummy/pedestrian.SetPosition ' num2str(ped_x) ' ' num2str(ped_y)]; % skip the Z coordinate, road is ground
ret = sendCommand('COMD', 'localhost', init_ped_position_cmd);
init_ped_orientation_cmd = ['dummy/pedestrian.SetInitAngle 0 0 ' num2str(ped_orient)];
ret = sendCommand('COMD', 'localhost', init_ped_orientation_cmd);
set_ped_speed_cmd = ['dummy/pedestrian.SetSpeed ' num2str(ped_speed)];

% pause the simulation (in order to later launch pass command)
ret = sendCommand('PAUSE', 'localhost');
ret = sendCommand('COMD', 'localhost', set_ped_speed_cmd);

% Workaround: intentionally drop the first data from DDS
%ret = sendCommand('COMD', 'localhost', 'pass 8'); % workaround: ignore the first
%[car_head, car_data] = ProSiVIC_DDS('car_obs','objectobserver');
%[ped_head, ped_data] = ProSiVIC_DDS('ped_obs','objectobserver');
%[cam_head, cam_data] = ProSiVIC_DDS('ego_car/chassis/dashcam/cam','camera');
%[radar_head, target_data] = ProSiVIC_DDS('radar/radar','radar');
%pause(1)

% Start the simulation in Pro-SiVIC and start the Simulink model
%ret = sendCommand('SYNCHRODDS', 'localhost');
%ret = sendCommand('PLAY', 'localhost');
%ret = sendCommand('TOGGLEPAUSE', 'localhost');

%sim_out = sim(fullfile(mfilepath,'/pedestrian_detection_system.slx'));
sim_out = sim(fullfile(mfilepath,'/mock_pedestrian_detection_system.slx'));

clear mex
