//: Playground - noun: a place where people can play

import UIKit

var arr = [8, 3, 9, 21]

/*for x in arr {
    
    print(x)
    
}*/


/*for (index, value) in arr.enumerate() {
    
    arr[index] = value + 1
    
}

print(arr)*/

/*
for var i = 2; i <= 20; i = i + 2 {

    print(i)
    
}
*/



// Chalange (Me)

var chArr:Array<Double> = [30, 13, 97, 34, 21, 95]

print("before: \(chArr)")

for (index, value) in chArr.enumerate() {
    
    chArr[index] = value / 2
    
}

print("after:  \(chArr)")



// Chalange (Rob)
var myArr = [8.0, 7.0, 19.0, 28.0];

for (index, value) in myArr.enumerate() {

    myArr[index] = value / 2
    
}

print("after:  \(myArr)")
