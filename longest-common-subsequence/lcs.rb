def lcs(s, t)
    s_idx = 0
    matrix = []
    while s_idx < s.size
        matrix[s_idx] = []
        t_idx = 0
        while t_idx < t.size
            if s[s_idx] == t[t_idx]
                if s_idx == 0 || t_idx == 0
                    matrix[s_idx][t_idx] = 1
                else
                    matrix[s_idx][t_idx] = matrix[s_idx - 1][t_idx - 1] + 1
                end
            else
                opts = [0]
                
                opts << matrix[s_idx - 1][t_idx] if s_idx > 0
                
                opts << matrix[s_idx][t_idx - 1] if t_idx > 0
                
                matrix[s_idx][t_idx] = opts.max
            end
            
            t_idx += 1
        end
        s_idx += 1
    end
    
    matrix[s.size - 1][t.size - 1]
end
