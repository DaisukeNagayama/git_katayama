% demo_RotationSHT
% 
% 

% load data
[Ymn,THETA,PHI,Xm,Ym,Zm] = spharm(2,1,[55 55],0);
field = Ymn;
% field = real(field);

% plot
[handle_figure,handle_surf] = plotSphere(field,'abs',[],[]);

    % Create slider
    slider_theta = uicontrol('Style','slider','Min',-2*pi,'Max',2*pi,'Value',0,'Position', [400 40 120 20]);
    slider_phi   = uicontrol('Style','slider','Min',-2*pi,'Max',2*pi,'Value',0,'Position', [400 15 120 20]);
    
    % Add a text uicontrol to label the slider.
    legend_real_plus = uicontrol('Style','text','Position',[10 90 60 20],'String','Real(+)','ForegroundColor',[255,0,13]/255,'BackgroundColor','w');
    legend_real_minus = uicontrol('Style','text','Position',[10 65 60 20],'String','Real(-)','ForegroundColor',[0,13,255]/255,'BackgroundColor','w');
    legend_imag_plus = uicontrol('Style','text','Position',[10 40 60 20],'String','Imag(+)','ForegroundColor',[255,241,0]/255,'BackgroundColor','k');
    legend_imag_minus = uicontrol('Style','text','Position',[10 15 60 20],'String','Imag(-)','ForegroundColor',[13,255,0]/255,'BackgroundColor','k');
    
    % Add a text uicontrol to label the slider.
    slider_label_theta = uicontrol('Style','text','Position',[380 40 20 20],'String','��');
    slider_label_phi = uicontrol('Style','text','Position',[380 15 20 20],'String','��');

    % make event listener
    addlistener(slider_theta,'Value','PostSet',@(event,obj) update(event,obj,field,handle_surf,slider_theta,slider_phi));
    addlistener(slider_phi  ,'Value','PostSet',@(event,obj) update(event,obj,field,handle_surf,slider_theta,slider_phi));


function update(event,obj,field,handle_surf,slider_theta,slider_phi)
[field_rotated,THETA,PHI,Xq,Yq,Zq] = rotSphere(field, slider_theta.Value, slider_phi.Value);

handle_surf.XData = Xq;
handle_surf.YData = Yq;
handle_surf.ZData = Zq;

end

