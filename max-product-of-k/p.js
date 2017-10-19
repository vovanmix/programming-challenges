var maximumProductK = function(nums, k) {
    if (nums.length < k) { return 0; }
    
    const maxVal = 2 ** 32 / 2 - 1;
    const minVal = - (2 ** 32) / 2;
    
    var min = [];
    var max = [];
    
    for (let i = 0; i < nums.length; i++) {
        for (let j = k - 1; j >= 0; j--) {
            if (j > 0 && (max[j] === undefined && max[j - 1] === undefined)) { continue; }
            let opts = [];
            if(max[j] !== undefined) {
                opts.push(max[j]);
                opts.push(min[j]);
            }
            if (j > 0) {
                opts.push(nums[i] * min[j - 1]);
                opts.push(nums[i] * max[j - 1]);
            } else {
                opts.push(nums[i]);
            }
            max[j] = Math.max.apply(null, opts);
            min[j] = Math.min.apply(null, opts);
        }
    }
    return max[k - 1];
};
