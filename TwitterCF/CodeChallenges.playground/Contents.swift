//: Playground - noun: a place where people can play

import UIKit
import Foundation



var array = [1,2,3,4,5]


func reverseArray(arrayToReverse:[Int]) -> [Int] {
    
    var backwardsArray = [Int]()
    let count = arrayToReverse.count - 1
    
    for var i = count; i >= 0; i-- {
        
        backwardsArray.append(arrayToReverse[i])
        
    }
    
    return backwardsArray
    
    
}


reverseArray(array)
 
//----------------------------------------------------------
// Day 2



var str = "Hello, playground"

var count = 100


func fizzbuzz(number: Int) -> String {
    switch (number % 3 == 0, number % 5 == 0) {
    case (true, false):
        return "Fizz"
    case (false, true):
        return "Buzz"
    case (true, true):
        return "FizzBuzz"
    default:
        return String(number)
    }
}

func printResults() -> () {
    
    for var i = count; i > 0; i-- {
        
        fizzbuzz(i)
        
    }
    
}


printResults()



//----------------------------------------------------------
// Day 3


    
var count2 = 0
    
var myString:String = "hi my name is, hi my name is, hi my name is, chicka chicka slim shady"
    
    
var array2 = myString.componentsSeparatedByString(" ")
    
    for item in array2 {
        
        if item == "hi" {
            count2++
        }
        
        
        
}





