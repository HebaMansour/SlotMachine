//
//  Factory.swift
//  SlotMachine
//
//  Created by Heba Mansour on 5/26/15.
//  Copyright (c) 2015 Heba Mansour. All rights reserved.
//

import Foundation
import UIKit

class Factory {
    class func createSlots() -> [[Slot]] {
        let kNumberOfContainers = 3
        let kNumberOfSlots = 3
        var slots = [[Slot]]()
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            var arrayOFSlots = [Slot]()
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber{
                var slot = Factory.createSlot(arrayOFSlots)
                arrayOFSlots.append(slot)
            }
            slots.append(arrayOFSlots)
        }
        return slots
    }
    class func createSlot(currentCards: [Slot]) -> Slot {
        var currentCardsValue = [Int]()
        for slot in currentCards {
            currentCardsValue.append(slot.value)
        }
            var randomNumber = Int(arc4random_uniform(UInt32(13)))
        while contains(currentCardsValue, randomNumber){
            var randomNumber = Int(arc4random_uniform(UInt32(13)))
        }
        var slot:Slot
        switch randomNumber {
        case 0 :
             slot = Slot(value: 0, image: UIImage(named: "Ace")!, isRed: true)
        case 1 :
             slot = Slot(value: 0, image: UIImage(named: "Two")!, isRed: true)
        case 2 :
             slot = Slot(value: 0, image: UIImage(named: "Three")!, isRed: true)
        case 3 :
             slot = Slot(value: 0, image: UIImage(named: "Four")!, isRed: true)
        case 4 :
             slot = Slot(value: 0, image: UIImage(named: "Five")!, isRed: false)
        case 5 :
             slot = Slot(value: 0, image: UIImage(named: "Six")!, isRed: false)
        case 6 :
             slot = Slot(value: 0, image: UIImage(named: "Seven")!, isRed: true)
        case 7 :
             slot = Slot(value: 0, image: UIImage(named: "Eight")!, isRed: false)
        case 8 :
             slot = Slot(value: 0, image: UIImage(named: "Nine")!, isRed: false)
        case 9 :
             slot = Slot(value: 0, image: UIImage(named: "Ten")!, isRed: true)
        case 10 :
             slot = Slot(value: 0, image: UIImage(named: "Jack")!, isRed: false)
        case 11 :
             slot = Slot(value: 0, image: UIImage(named: "Queen")!, isRed: false)
        case 12 :
             slot = Slot(value: 0, image: UIImage(named: "King")!, isRed: true)
        default:
             slot = Slot(value: 0, image: UIImage(named: "Ace")!, isRed: true)
        }
        
        return slot
    }
}