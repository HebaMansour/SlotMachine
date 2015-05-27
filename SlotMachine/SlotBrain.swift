//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Heba Mansour on 5/26/15.
//  Copyright (c) 2015 Heba Mansour. All rights reserved.
//

import Foundation
class SlotBrain {
    class func computeWinnings(slots: [[Slot]]) -> Int {
        var slotInRows = updateSlotsIntoSlotsArray(slots)
        var winnings = 0
        var FlushWinCount = 0
        var threeOfAKindCount = 0
        var straightWinCount = 0
        for slotRow in slotInRows {
            if checkFlush(slotRow) == true {
                winnings += 1
                FlushWinCount += 1
            }
            if checkThreeInRow(slotRow) {
                winnings += 1
                straightWinCount += 1
            }
            if checkThreeOfAKind(slotRow) {
                winnings += 3
                threeOfAKindCount += 1
            }
        }
        if FlushWinCount == 3 {
            winnings += 50
        }
        if straightWinCount == 3 {
            winnings += 100
        }
        if threeOfAKindCount == 3 {
            winnings += 20
        }
        return winnings
    }
    
    
    
    
    class func updateSlotsIntoSlotsArray(slots : [[Slot]]) -> [[Slot]] {
        var slotRow = [Slot]()
        var slotRow2 = [Slot]()
        var slotRow3 = [Slot]()
        
        for slotArray in slots {
            for var index = 0; index<slotArray.count; index++ {
                let slot = slotArray[index]
                
                if index == 0 {
                    slotRow.append(slot)
                }
                else if index == 1 {
                    slotRow2.append(slot)
                }
                else if index == 2 {
                    slotRow3.append(slot)
                }
            }
        }
        let slotInRows : [[Slot]] = [slotRow, slotRow2, slotRow3]
        return slotInRows
    }
    
    class func checkFlush(slots: [Slot]) -> Bool{
        let slot1 = slots[0]
        let slot2 = slots[1]
        let slot3 = slots[2]
        if slot1.isRed == true && slot2.isRed == true && slot3.isRed == true {
            return true
        }
        else if slot1.isRed == false && slot2.isRed == false && slot3.isRed == false {
            return true
        }
        else {
            return false
        }
    }
    
        class func checkThreeInRow(slots: [Slot]) -> Bool{
            let slot1 = slots[0]
            let slot2 = slots[1]
            let slot3 = slots[2]
            
            if slot1.value == slot2.value - 1 && slot1.value == slot3.value - 2 {
                return true
            }
            else if slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2 {
                return true
            }
            else {
                return false
            }
    }
    
    class func checkThreeOfAKind(slots: [Slot]) -> Bool {
        let slot1 = slots[0]
        let slot2 = slots[1]
        let slot3 = slots[2]
        
        if slot1.value == slot2.value && slot1.value == slot3.value  {
            return true
        }
        else {
            return false
        }

    }
    
    
    
    
    
    
    
}
    
    
    
    
    
    



    