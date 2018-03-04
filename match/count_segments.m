function [one_count, zero_count, max_gap] = count_segments(line)
    cur_gap = 0;
    max_gap = 0;
    zero_count = 0;
    one_count = 0;
    for i=1:length(line)
        cur = line(i);
        if cur == 1
            one_count = one_count + 1;
            if cur_gap > max_gap
                max_gap = cur_gap;
            end
            cur_gap = 0;
        else 
            zero_count = zero_count + 1;
            cur_gap = cur_gap + 1;
        end
    end
end