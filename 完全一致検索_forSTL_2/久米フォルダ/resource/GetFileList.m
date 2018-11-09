function [fileList, dirList] = GetFileList(dirPath)
%GetFileList 引数で指定したフォルダ直下にあるファイル名・フォルダ名のリストを取得
%   詳細説明をここに記述
  temp = dir(dirPath);
  temp(1:2) = [];
  fileList = {temp([temp.isdir] == 0).name}'; % フォルダ以外のリスト
  dirList = {temp([temp.isdir] == 1).name}';  % フォルダのリスト
end

