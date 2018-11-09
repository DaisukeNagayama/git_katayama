function labellist = VolumeRatio(model)

    t_labellist = fieldnames(model);
    n_t_labellist = length(t_labellist);
    labellist = zeros(n_t_labellist, 1);
    
    for i_label = 1 : n_t_labellist
        
        t_model = model.(t_labellist{i_label});
        vol = sum(t_model(:));
        labellist(i_label) = vol;
        
    end %for

end %function