// Leetcode: 2 pointers
// 5. Longest Palindromic Substring

// Given a string s, return the longest palindromic substring in s.

// Example 1:

// Input: s = "babad"
// Output: "bab"
// Explanation: "aba" is also a valid answer.
// Example 2:

// Input: s = "cbbd"
// Output: "bb"

// Constraints:

// 1 <= s.length <= 1000
// s consist of only digits and English letters.


void main() {
  final s = longestPalindrome('cbbd');
  print(s);
}

/*
First, we have to think about the palindrome concept.
Given a string, how do we check if it's a palindrome or not?

The palindrome is symmetric and symmetric over a center.
To check a palindrome, we just need to start from the center of a string, check if the first left & the first right values of the center are the same or not, 
If they are the same, we continue to check if the second left & second right values of the center are the same or not.

If all the left values are the same as the right values in pair -> This whole string is a palindrome
If the first left == first right value, but second left != second right value -> We found a child palindrome inside the given string.

So starting from a center of a string, we know how to find the longest palindrome of it.

That's the mental model, technically we need:
Create 2 pointers L, R (left and right the center), check 2 values on those 2 pointers. If they are the same, we expand outward the pointer range and continue to check.

The pseudo-code for that mental model (solution):

  expandAroundCenter(s, L, R):
    while L >= 0 and R < n and s[L] == s[R]:
        L--
        R++
    return [L+1, R-1]  // the palindrome bounds
*/

String expandAroundCenter(String s, int L, int R) {
  while (L >= 0 && R < s.length && s[L] == s[R]) {
    L--;
    R++;
  }

  return s.substring(L+1, R);
}

// One thing need to note is the function expandAroundCenter already cover edge case L >= 0 && R < s.length
// So we dont need to check edge case later, but if you have any doubt, keep thinking and back to here soon.

/**
 * We still didn't solve the issue. We assumed that the center of a possible palindrome is the center of the string as well.
 * The center of the longest palindrome can be anywhere in a given string, so we have to loop through all the character of the string, treat each character as the center and use
 * the above function to find the longest palindrome.
 */

String selectTheLongestPalindrome(
  String globalResult,
  String oddResult,
  String evenResult,
) {
  var best = globalResult;

  if (oddResult.length > best.length) {
    best = oddResult;
  }
  if (evenResult.length > best.length) {
    best = evenResult;
  }

  return best;
}

String longestPalindrome(String s) {
  /* 
  1. s's length <= 1 -> return s
  2. Loop from i = 0 to i = n - 1 (n = s.length). In each i, we need to check 2 cases: ODD and EVEN
    Palindrome "aba" has a single character center (b) → ODD length: Treat i as center 
    Palindrome "abba" has a gap in the middle (between the 2 "b") → EVEN length: Treat the gap between i and i=1 as center
  */


  var globalResult = s[0];

  for (var i = 0; i < s.length ; i++) {

    var oddResult = expandAroundCenter(s, i, i);
 

    var evenResult = expandAroundCenter(s, i, i + 1);

    globalResult = selectTheLongestPalindrome(globalResult, oddResult, evenResult);
  }

  return globalResult;
}


/*
Right now you are creating substrings for every center, then comparing lengths.
Another common optimization is to track indices only, and call substring once at the end.
*/

String longestPalindromeOptimized(String s) {
  if (s.length <= 1) return s;

  int bestStart = 0;
  int bestEnd = 0; // inclusive

  String expandAroundCenter(int left, int right) {
    while (left >= 0 && right < s.length && s[left] == s[right]) {
      left--;
      right++;
    }

    // when loop breaks, left/right are one step too far
    final start = left + 1;
    final end = right - 1;
    final length = end - start + 1;

    final bestLength = bestEnd - bestStart + 1;
    if (length > bestLength) {
      bestStart = start;
      bestEnd = end;
    }

    return '';
  }

  for (var i = 0; i < s.length; i++) {
    expandAroundCenter(i, i);     // odd
    expandAroundCenter(i, i + 1); // even
  }

  return s.substring(bestStart, bestEnd + 1);
}


/*
Summary 
The keypoint to solve this issue:
- Understand the Palindrome, we have to check from the center
- Identify 2 cases to must check ODD and EVEN, we cannot skip one of them, we have to check both cases
- Avoid using substring to optimize performance
*/