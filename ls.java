class Solution {
    public int rob(int[] nums) {
        int n = nums.length;
        if (n == 1) {
            return nums[0];
        }
        return Math.max(rob(nums,0, n - 2), rob(nums, 1, n - 1));
    }

    public int rob(int[] nums, int start, int end) {
        // 长度
        int length = end - start + 1;
        // 如果长度为1, 说明只有1项,直接返回即可
        if (length == 1) {
            return nums[start];
        }
        // 总价
        int[] total = new int[length];
        total[0] = nums[start];
        total[1] = Math.max(nums[start], nums[start + 1]);
        for (int i = 2; i < length; i++) {
            total[i] = Math.max(total[i - 2] + nums[start + i], total[i - 1]);
        }
        return total[length - 1];
    }
}