%% 
% ドラッグすると動かせる


%%
function test
f = figure();
ax = axes();
axis([0 5 0 5]); %座標の範囲をx:0〜5,y:0〜5に
pat = patch([0,1,1,0],[0,0,1,1],'r'); %(0,0),(1,0),(1,1),(0,1)を頂点とする正方形
pat.ButtonDownFcn = @bdf; %�@

    function bdf(object,eventdata) %patがクリックされた時に実行される関数，objectにはpatが入る
        cp = ax.CurrentPoint %�A
        x = cp(1,1);
        y = cp(1,2);
        pat.XData = [x-0.5 x+0.5 x+0.5 x-0.5]; %patの中心のx座標をマウス位置に変更
        pat.YData = [y-0.5 y-0.5 y+0.5 y+0.5]; %patの中心のy座標をマウス位置に変更
        f.WindowButtonMotionFcn = @wbmf; %�B
        f.WindowButtonUpFcn = @wbuf; %�B
    end

    function wbmf(fig,eventdata) %figure上でマウスが動いた時に実行される関数，figにはfが入る
        cp = ax.CurrentPoint; %�C
        x = cp(1,1);
        y = cp(1,2);
        pat.XData = [x-0.5 x+0.5 x+0.5 x-0.5]; 
        pat.YData = [y-0.5 y-0.5 y+0.5 y+0.5];
    end

    function wbuf(fig,eventdata) %マウスが離れたときに実行される関数，figにはfが入る
        fig.WindowButtonMotionFcn = ''; %�D
        fig.WindowButtonUpFcn = ''; %�D
    end
end