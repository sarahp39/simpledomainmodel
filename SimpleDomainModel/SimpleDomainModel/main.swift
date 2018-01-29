//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
  public func convert(_ to: String) -> Money {
    if currency == "USD"{
        switch to {
            case "GBP":
                return Money(amount: (Int(Double(amount) * 0.5)), currency: "GBP")
            case "EUR":
                return Money(amount: (Int(Double(amount) * 1.5)), currency: "EUR")
            case "CAN":
                return Money(amount: (Int(Double(amount) * 1.25)), currency: "CAN")
            default:
                return self;
        }
    }
    else if currency == "GBP"{
        switch to {
        case "USD":
            return Money(amount: (Int(Double(amount) * 2.0)), currency: "USD")
        case "EUR":
            return Money(amount: (Int(Double(amount) * 3.0)), currency: "EUR")
        case "CAN":
            return Money(amount: (Int(Double(amount) * 2.5)), currency: "CAN")
        default:
            return self
        }
    }
    else if currency == "EUR"{
        switch to {
        case "USD":
            return Money(amount: (Int(Double(amount) * (2/3))), currency: "USD")
        case "GBP":
            return Money(amount: (Int(Double(amount) * (1/3))), currency: "GBP")
        case "CAN":
            return Money(amount: (Int(Double(amount) * (5/6))), currency: "CAN")
        default:
            return self
        }
    }
    else if currency == "CAN"{
        switch to {
        case "USD":
            return Money(amount: (Int(Double(amount) * 0.8)), currency: "USD")
        case "GBP":
            return Money(amount: (Int(Double(amount) * 0.4)), currency: "GBP")
        case "EUR":
            return Money(amount: (Int(Double(amount) * 1.2)), currency: "EUR")
        default:
            return self
        }
    }
    else{
        return self
    }
  }
  
  public func add(_ to: Money) -> Money {
    let sameCurrency = self.convert(to.currency)
    let total = self.amount + sameCurrency.amount;
    return Money(amount: total, currency: currency)
  }
    
  public func subtract(_ from: Money) -> Money {
    let sameCurrency = self.convert(from.currency)
    let total = self.amount - sameCurrency.amount;
    return Money(amount: total, currency: currency)
  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title;
    self.type = type;
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    var total = 0;
    switch self.type{
        case .Hourly(let pay):
            total = Int(pay * Double(hours))
        case .Salary(let annualpay):
            total = annualpay
    }
    return total;
  }
  
  open func raise(_ amt : Double) {
    switch self.type{
        case .Hourly(let pay):
            self.type = .Hourly(pay + amt);
        case .Salary(let annualpay):
            self.type = .Salary(annualpay + (Int(amt)));
    }
  }
}

////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get {
        return self._job;
    }
    set(value) {
        if self.age < 16{
            self._job = nil;
        }
        else{
            self._job = value;
        }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get {
        return self._spouse;
    }
    set(value) {
        if self.age < 21{
            return self.spouse = nil;
        }
        else{
            return self.spouse = value;
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    let theString = "[Person: firstName: \(self.firstName) lastName: \(self.lastName) age: \(self.age) job: \(self._job) spouse: \(spouse?.firstName)]";
    return theString;
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
  }
  
  open func haveChild(_ child: Person) -> Bool {
  }
  
  open func householdIncome() -> Int {
  }
}





