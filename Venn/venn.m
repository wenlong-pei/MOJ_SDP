classdef venn
    properties
        ax % 绘图坐标区域
        % -----------------------------------------------------------------
        linePnts
        labelSet={' ',' ',' ',' ',' ',' ',' '};
%         labels={'AAA','BBB','CCC','DDD','EEE','FFF','GGG'};
        labelPos
        % -----------------------------------------------------------------
        classNum    % 多边形数量
        dataList    % 数据列表
        pshapeHdl   % polyshape对象
        fillHdl     % fill绘制的半透明多边形
        textHdl     % 绘制文本的句柄
        labelHdl    % 绘制标签的句柄
    end

    methods
        function obj = venn(varargin)
            if isa(varargin{1},'matlab.graphics.axis.Axes')
                obj.ax=varargin{1};varargin(1)=[];
            else
                obj.ax=gca;
            end
            hold on
            obj.classNum=length(varargin);
            obj.dataList=varargin;

            obj.linePnts=load('LD.mat');
            obj.linePnts=obj.linePnts.lineData;

            obj.labelPos{2}=[-.38,.3;.38,.3];
            obj.labelPos{3}=[-.38,.3;-.38,-.4;.38,-.4];
            obj.labelPos{4}=[-.38,.2;.38,.2;-.15,.3;.15,.3];
            obj.labelPos{5}=[cos(linspace(2*pi/5,2*pi,5)+2*pi/5-pi/7).*.47;
                             sin(linspace(2*pi/5,2*pi,5)+2*pi/5-pi/7).*.47]';
            obj.labelPos{6}=[cos(linspace(2*pi/6,2*pi,6)+2*pi/3-pi/6).*.49;
                             sin(linspace(2*pi/6,2*pi,6)+2*pi/3-pi/6).*.49]';
            obj.labelPos{6}=obj.labelPos{6}+[0,+.09;-.01,-.04;0,+.015;0,-.1;0,0;0,-.015];
            obj.labelPos{7}=[cos(linspace(2*pi/7,2*pi,7)+2*pi/5-pi/7).*.47;
                             sin(linspace(2*pi/7,2*pi,7)+2*pi/5-pi/7).*.47]';
            help venn
        end

        function obj=draw(obj)
            warning off

            obj.ax.XLim=[-.5,.5];
            obj.ax.YLim=[-.5,.5];
            obj.ax.XTick=[];
            obj.ax.YTick=[];
            obj.ax.XColor='none';
            obj.ax.YColor='none';
            obj.ax.PlotBoxAspectRatio=[1,1,1];

            tcolorList=lines(7);
            for i=1:obj.classNum
                tPData=obj.linePnts(obj.classNum).pnts{i};
                obj.pshapeHdl{i}=polyshape(tPData(:,1),tPData(:,2));
                obj.fillHdl(i)=fill(tPData(:,1),tPData(:,2),tcolorList(i+4,:),'FaceAlpha',.5,'LineWidth',0.1,'EdgeColor',tcolorList(i+4,:));%%
            end

            baseData=[];
            for i=1:obj.classNum
                baseData=[baseData;obj.dataList{i}(:)];
            end
            baseShpae=polyshape([-.5,-.5,.5,.5],[.5,-.5,-.5,.5]);
            pBool=abs(dec2bin((1:(2^obj.classNum-1))'))-48;
 
            for i=1:obj.classNum
                tPos=obj.labelPos{obj.classNum};
                obj.labelHdl(i)=text(tPos(i,1),tPos(i,2),obj.labelSet{i},...
                    'HorizontalAlignment','center','FontName','Arial','FontSize',16);
            end

            for i=1:size(pBool,1)
                tShpae=baseShpae;
                tData=baseData;
                for j=1:size(pBool,2)
                    switch pBool(i,j)
                        case 1
                            tShpae=intersect(tShpae,obj.pshapeHdl{j});
                            tData=intersect(tData,obj.dataList{j});
                        case 0
                            tShpae=subtract(tShpae,obj.pshapeHdl{j});
                            tData=setdiff(tData,obj.dataList{j});
                    end                 
                end
                [cx,cy]=centroid(tShpae);
                obj.textHdl(i)=text(cx,cy,num2str(length(tData)),...
                    'HorizontalAlignment','center','FontName','Arial');
            end  
        end

        function obj=labels(obj,varargin)
            tlabel{length(varargin)}=' ';            
            for i=1:length(varargin)
                tlabel{i}=varargin{i};
            end
            obj.labelSet=tlabel;
        end

        function setPatch(obj,varargin)
            for i=1:obj.classNum
                set(obj.fillHdl(i),varargin{:})
            end
        end

        function setPatchN(obj,N,varargin)
            for i=1:obj.classNum
                set(obj.fillHdl(N),varargin{:})
            end
        end
        function setFont(obj,varargin)
            for i=1:length(obj.textHdl)
                set(obj.textHdl(i),varargin{:})
            end
        end

        function setLabel(obj,varargin)
            for i=1:length(obj.labelHdl)
                set(obj.labelHdl(i),varargin{:})
            end
        end
    end

end
