%% 
% �h���b�O����Ɠ�������


%%
function test
f = figure();
ax = axes();
axis([0 5 0 5]); %���W�͈̔͂�x:0�`5,y:0�`5��
pat = patch([0,1,1,0],[0,0,1,1],'r'); %(0,0),(1,0),(1,1),(0,1)�𒸓_�Ƃ��鐳���`
pat.ButtonDownFcn = @bdf; %�@

    function bdf(object,eventdata) %pat���N���b�N���ꂽ���Ɏ��s�����֐��Cobject�ɂ�pat������
        cp = ax.CurrentPoint %�A
        x = cp(1,1);
        y = cp(1,2);
        pat.XData = [x-0.5 x+0.5 x+0.5 x-0.5]; %pat�̒��S��x���W���}�E�X�ʒu�ɕύX
        pat.YData = [y-0.5 y-0.5 y+0.5 y+0.5]; %pat�̒��S��y���W���}�E�X�ʒu�ɕύX
        f.WindowButtonMotionFcn = @wbmf; %�B
        f.WindowButtonUpFcn = @wbuf; %�B
    end

    function wbmf(fig,eventdata) %figure��Ń}�E�X�����������Ɏ��s�����֐��Cfig�ɂ�f������
        cp = ax.CurrentPoint; %�C
        x = cp(1,1);
        y = cp(1,2);
        pat.XData = [x-0.5 x+0.5 x+0.5 x-0.5]; 
        pat.YData = [y-0.5 y-0.5 y+0.5 y+0.5];
    end

    function wbuf(fig,eventdata) %�}�E�X�����ꂽ�Ƃ��Ɏ��s�����֐��Cfig�ɂ�f������
        fig.WindowButtonMotionFcn = ''; %�D
        fig.WindowButtonUpFcn = ''; %�D
    end
end