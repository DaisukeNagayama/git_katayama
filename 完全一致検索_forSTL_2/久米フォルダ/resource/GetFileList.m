function [fileList, dirList] = GetFileList(dirPath)
%GetFileList �����Ŏw�肵���t�H���_�����ɂ���t�@�C�����E�t�H���_���̃��X�g���擾
%   �ڍא����������ɋL�q
  temp = dir(dirPath);
  temp(1:2) = [];
  fileList = {temp([temp.isdir] == 0).name}'; % �t�H���_�ȊO�̃��X�g
  dirList = {temp([temp.isdir] == 1).name}';  % �t�H���_�̃��X�g
end

