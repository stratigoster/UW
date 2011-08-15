%
% function animate_pursuit(t,y,T)
%
%  Animate the movement of the missile and target.
%
%  t is a column vector of time stamps.
%  y is an array that holds the missile trajectory.
%    It has (at least) 2 columns: col1 = x, col2 = y.
%    One row for each time stamp.
%  T is an array that holds the target trajectory.
%    It has (at least) 2 columns: col1 = x, col2 = y.
%    One row for each time stamp.
%
function animate_pursuit(t,y,T)

    figure; clf;
    r_pos = plot(y(1,1), y(1,2), 'ro');
    axis('equal');
    xmin = min( min(y(:,1)) , min(T(:,1)) );
    xmax = max( max(y(:,1)) , max(T(:,1)) );
    ymin = min( min(y(:,2)) , min(T(:,2)) );
    ymax = max( max(y(:,2)) , max(T(:,2)) );
    axis([xmin xmax ymin ymax]);
    xlabel('x'); ylabel('y');
    hold on;
    set(r_pos,'erasemode','xor');
    t_pos = plot(T(1,1),T(1,2),'bo');
    set(t_pos,'erasemode','xor');

    N=length(t);
    for s=2:N,
      set(r_pos,'xdata',y(s,1),'ydata',y(s,2));
      set(t_pos,'xdata',T(s,1),'ydata',T(s,2));
      drawnow;
      pause((t(s)-t(s-1))*2);
    end
