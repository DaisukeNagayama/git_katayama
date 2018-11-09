function proj_1d = Projection1dFromProjection2d(proj_2d)
% Function to create 1D projection structure from 2D projection structure.
% 
% proj_2d : structure of projection of model
%           e.g. Projection.Model.Label.projectionArray(x,y,N)
% proj_1d : structure of projection of model
%           e.g. Projection.Model.Label.projectionArray(x,N)
% 

ModelName = fieldnames(proj_2d);

for iModel = 1:length(ModelName)
     fSum = @(x) squeeze(sum(x,2));
     proj_1d.(ModelName{iModel}) = structfun(fSum, proj_2d.(ModelName{iModel}), 'UniformOutput',false);
end

end