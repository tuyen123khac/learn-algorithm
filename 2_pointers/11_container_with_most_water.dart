// 11. Container With Most Water
// You are given an integer array height of length n. There are n vertical lines drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).

// Find two lines that together with the x-axis form a container, such that the container contains the most water.

// Return the maximum amount of water a container can store.

// Notice that you may not slant the container.

// Example 1:

// Input: height = [1,8,6,2,5,4,8,3,7]
// Output: 49
// Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.

import 'dart:math';

void main() {
  // var height = [1,8,6,2,5,4,8,3,7];
  var height = [2, 3, 4, 5, 18, 17, 6];
  print(maxArea(height));
}

int maxArea(List<int> height) {
  if (height.length < 2) return 0;

  var i = 0;
  var j = height.length - 1;

  var maxIndexLeft = i;
  var maxIndexRight = j;

  int calculateRectangel(List<int> height, int i, int j) {
    return min(height[i], height[j]) * (j - i);
  }

  while (i < j) {
    var currentMaxArea = calculateRectangel(
      height,
      maxIndexLeft,
      maxIndexRight,
    );

    if (height[i] < height[j]) {
      i++;
      var currentIArea = calculateRectangel(height, i, j);
      if (currentIArea > currentMaxArea) {
        maxIndexLeft = i;
        maxIndexRight = j;
      }
    } else {
      j--;
      var currentJArea = calculateRectangel(height, i, j);
      if (currentJArea > currentMaxArea) {
        maxIndexLeft = i;
        maxIndexRight = j;

      }
    }
  }

  return calculateRectangel(height, maxIndexLeft, maxIndexRight);
}


// Optimized version, does not need to store pointer

/*
int maxArea(List<int> height) {
  int i = 0;
  int j = height.length - 1;

  int best = 0;

  while (i < j) {
    final h = min(height[i], height[j]);
    final width = j - i;
    final area = h * width;

    if (area > best) {
      best = area;
    }

    if (height[i] < height[j]) {
      i++;
    } else {
      j--;
    }
  }

  return best;
}
*/