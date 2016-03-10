//: Playground - noun: a place where people can play

import UIKit

// If statements

var age = 20

// Greater than or equal to

if age >= 18 {

    print("You can play!")
    
} else {

    print("Sorry, you're too young")
    
}

// Equal to

var name = "Kristen"

if name == "Pasha" {

    print("Hi " + name + " you can play")
    
} else {
    
    print("Sorry " + name + " you can't play")
    
}

// 2 If statements with AND

if name == "Kristen" && age >= 18 {

    print("You can play!")
    
}

// 2 If statements with OR

if name == "Kristen" || name == "Pasha" {

    print("Welcome " + name)
    
}


var isMale = true

if isMale {
    
    print("You are a man!")
    
}




// Chalange (Me)

var chUserData = ["username": "pasha", "password": "123456"]

var chDBData = ["username": "pasha", "password": "123456"]

if chUserData["username"]! == chDBData["username"]! && chUserData["password"]! == chDBData["password"]! {
    
    print("Welcome, you're logged in!")
    
} else if chUserData["username"]! != chDBData["username"]! && chUserData["password"]! != chDBData["password"]! {
    
    print("Wrong both values")
    
} else if chUserData["username"]! == chDBData["username"]! {
    
    print("Wrong password")
    
} else {
    
    print("Wrong username")
    
}


// Chalange (Rob)

var username = "robpercival"

var password = "myPass123"

if username == "robpercival" && password == "myPass123" {
    
    print("You're In!")

} else if username != "robpercival" && password != "myPass123" {
    
    print("Both your username and password are wrong")

} else if username == "robpercival" {
    
    print("Your password is wrong")

} else {
    
    print("Your username is wrong")
    
}
















