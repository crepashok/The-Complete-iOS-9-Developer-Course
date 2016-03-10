//: Playground - noun: a place where people can play

import UIKit

// Dictionaries

var dictionary = ["computer": "something to play Call Of Duty on", "coffee": "best string ever"]

print(dictionary["coffee"]!)

print(dictionary.count)

dictionary["pen"] = "old fashioned writing implement"

dictionary.removeValueForKey("computer")

print(dictionary)



// Chalange (Me)

var chDict = ["salad": 48.15, "soup": 25.00, "bread": 0.5]

print("Total cost for your meal is: \(chDict["salad"]! + chDict["soup"]! + chDict["bread"]!)")




// Chalange (Rob)

var chMenu = ["pizza": 10.99, "ice cream": 4.99, "salad": 7.99]

var totalCost = chMenu["pizza"]! + chMenu["ice cream"]! + chMenu["salad"]!

print("Total cost ot the three items is \(totalCost)")




// Arrays

var array = [17, 25, 13, 47]

print(array[0])

// Chalange
print(array[2])

print(array.count)

array.append(56)

array.removeAtIndex(3)

print(array)

array.sort()



// Chalange (Me)

var chArray:Array = [13, 34, 6]

chArray.removeAtIndex(1)

chArray.append(chArray[0] * chArray[chArray.count - 1])



// Chalange (Rob)

var myArray = [3.87, 7.1, 8.9]

myArray.removeAtIndex(1)

myArray.append(myArray[0] * myArray[1])