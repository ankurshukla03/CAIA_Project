function [one_count, zero_count, max_gap] = count_segments(line)
    cur_gap = 0;
    max_gap = 0;
    zero_count = 0;
    one_count = 0;
    prev = 1;
    for i=1:length(line)
        cur = line(1);
        if cur == 1
            one_count = one_count + 1;
        else 
            zero_count = zero_count + 1;
        end

        % gap start, begin counting
        if prev == 1 && cur == 0
            cur_gap = 1;
        % gap end, stop couting
        elseif prev == 0 && cur == 1
            if cur_gap > max_gap
                max_gap = cur_gap;
            end
        % traversing a gap
        else % 0, 0
            cur_gap = cur_gap + 1;
        end
        prev = cur;
    end
end