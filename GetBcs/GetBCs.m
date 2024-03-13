%% create model object
clear
clc
%%model name, i.e., MBB.mph of Comsol model
model=mphopen('MBB');
import com.comsol.model.*
import com.comsol.model.util.*
model= ModelUtil.model('Model');
%% extract and process the Comsol model information, sometimes need to modify the file java.opts to adapt to large mesh
[~,meshdata] = mphmeshstats(model);%the whole mesh information
nodes=length(meshdata.vertex(1,:));%number of vertex
nele=length(meshdata.elem{1,2}(1,:));%number of element
vertex=meshdata.vertex';
element=meshdata.elem{1,2}';
ver_size=size(vertex,2);
ele_size=size(element,2);
ph = 'D:\aiwanzhe'; % The path of the output data
%% output the vertex file
fid = fopen(strcat(ph,'\','vertex.txt'),'wt');
for i = 1:nodes
    for j = 1:ver_size
        fprintf(fid,'%f\t',vertex(i,j));
    end
    if i~=nodes
    fprintf(fid,'\n');
    end
end
%% output the element file
fid = fopen(strcat(ph,'\','element.txt'),'wt'); 
for i = 1:nele
    for j = 1:ele_size
        fprintf(fid,'%d\t',element(i,j));
    end
    if i~=nele
    fprintf(fid,'\n');
    end
end

%% Get fixed dofs
%there are generally four types of elements in struct meshdata.elementity,
%i.e.,edge element, volume element, face element and point element, 
%and the corresponding values are stored in struct meshdata.elem,
%we can use these structs to obtain boundary conditions
fixed=find(meshdata.elementity{1,3}==1);%set the No.1 face to be fixed
fixed_nodes=(meshdata.elem{1,3}(:,fixed))';
fix_nodes=reshape(fixed_nodes,[size(fixed_nodes,1)*size(fixed_nodes,2),1]);
fix_nodes=unique(fix_nodes);%remove repeated nodes
fixedDof=zeros(1,3*size(fix_nodes,1),'int32');
for i=1:size(fix_nodes,1)
    fixedDof(i*3-2)=3*fix_nodes(i);
    fixedDof(i*3-1)=3*fix_nodes(i)+1;
    fixedDof(i*3)=3*fix_nodes(i)+2;
end

fixed_size=size(fixedDof,2);
%output
fid = fopen(strcat(ph,'\','fixeddofs.txt'),'wt');
for i = 1:fixed_size
        fprintf(fid,'%d\n',fixedDof(1,i));
end

%% Get the degrees of freedom of load
loaddof=find(meshdata.elementity{1,1}==3);%set the No.3 edge to be loaded
load_nodes=(meshdata.elem{1,1}(:,loaddof))';
load_nodes=reshape(load_nodes,[size(load_nodes,1)*size(load_nodes,2),1]);
load_nodes=unique(load_nodes);%remove repeated nodes
Dof_load=zeros(1,size(load_nodes,1),'int32');
for i=1:size(load_nodes,1)
    Dof_load(i)=3*load_nodes(i)+1;
end

load_size=size(Dof_load,2);
%output
fid = fopen(strcat(ph,'\','loaddof.txt'),'wt'); 
for i = 1:load_size
        fprintf(fid,'%d\t',Dof_load(1,i));
end

load=ones(1,size(load_nodes,1));%set the load to be 1
%output
fid = fopen(strcat(ph,'\','load.txt'),'wt'); 
for i = 1:load_size
        fprintf(fid,'%f\t',load(1,i));
end
 
fclose(fid);
        fprintf(fid,'%f\t',load(1,i));
end
 
fclose(fid);
