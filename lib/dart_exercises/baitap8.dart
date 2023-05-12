String reverseString(String srcString) {
  return srcString.split('').reversed.join();
}

void main() {
  var list1 = [1, 2, 3, 4];
  var reverseList = list1.reversed;
  
  print(reverseList);

  var testString = "Hello World!";
  print(reverseString(testString));
}