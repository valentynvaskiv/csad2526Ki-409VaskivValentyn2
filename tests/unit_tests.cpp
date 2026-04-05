#include "../math_operations.h"
#include <gtest/gtest.h>

TEST(MathOperationsTest, Add) {
    EXPECT_EQ(add(2, 3), 5);
    EXPECT_EQ(add(-1, 1), 0);
    EXPECT_EQ(add(0, 0), 0);
    EXPECT_EQ(add(-5, -7), -12);
    EXPECT_EQ(add(100, 200), 300);
}
