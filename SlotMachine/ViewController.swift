//
//  ViewController.swift
//  SlotMachine
//
//  Created by Heba Mansour on 5/22/15.
//  Copyright (c) 2015 Heba Mansour. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Containers
    
    var firstContainer:UIView!
    var secondContainer:UIView!
    var thirdontainer:UIView!
    var forthContainer:UIView!
    
    var titleLabel:UILabel!
    var creditLabel:UILabel!
    var betLabel:UILabel!
    var winnerPaidLabel:UILabel!
    var creditTitleLabel:UILabel!
    var betTitleLabel:UILabel!
    var winnerPaidTitleLabel:UILabel!
    
    var resetButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var spinButton: UIButton!
    
    var credits: Int = 0
    var winnings: Int = 0
    var currentBet:Int = 0
    
    var slots = [[Slot]]()
    
    //Constants
    
    let kMargin : CGFloat = 10.0
    let kSlotMargin : CGFloat = 2.0
    let kHieght : CGFloat = 1.0/6.0
    let kEigth : CGFloat = 1.0/8.0
    let kHalf : CGFloat = 1.0/2.0
    let kThird:CGFloat = 1.0/3.0
    let kNumberOfRows = 3
    let kNumberOfColmns = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupContainerViews()
        
        setupFirstContaner(self.firstContainer)
        setupThirdContainer(self.thirdontainer)
        setupForthContainer(self.forthContainer)
        
        hardReset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBActions 
    
    func resetButtonPressed(button : UIButton) {
        hardReset()
    }
    
    func betOneButtonPressed(button: UIButton) {
        if credits <= 0 {
            showAlertWithText(header: "No more credits", message: "Reset Game")
        } else {
            if currentBet < 5 {
                currentBet += 1
                credits -= 1
                updateMainView()
            } else {
                showAlertWithText(message: "You can only bet 5 credits at a time")
            }
        }
    }
    
    func betMaxButtonPressed(button:UIButton) {
        if credits <= 5 {
            showAlertWithText(header: "No more credits", message: "Bet less")
        } else {
            if currentBet < 5 {
                currentBet = 5
                credits -= 5 - currentBet
                updateMainView()
            } else {
                 showAlertWithText(message: "You can only bet 5 credits at a time")
            }
        }
    }
    
    func spinButtonPressed(button:UIButton) {
        removeImageViews()
        slots = Factory.createSlots()
        setupSecondContainer(self.secondContainer)
        var computedWinnings = SlotBrain.computeWinnings(slots)
        winnings = computedWinnings * currentBet
        credits += winnings
        currentBet = 0
        updateMainView()
    }
    
    func setupContainerViews () {
        self.firstContainer = UIView(frame: CGRectMake(self.view.bounds.origin.x + kMargin, self.view.bounds.origin.y, self.view.bounds.width - ( kMargin * 2), self.view.bounds.height * kHieght))
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.firstContainer)
        
        self.secondContainer = UIView(frame: CGRectMake(self.view.bounds.origin.x + kMargin, self.firstContainer.frame.height, self.view.bounds.width - (kMargin * 2), self.view.bounds.height * (kHieght * 3)))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(secondContainer)
        
        self.thirdontainer = UIView(frame: CGRectMake(self.view.bounds.origin.x + kMargin, self.firstContainer.frame.height + self.secondContainer.frame.height, self.view.bounds.width - (kMargin * 2), self.view.bounds.height * kHieght))
        self.thirdontainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(thirdontainer)
        
        self.forthContainer = UIView(frame: CGRectMake(self.view.bounds.origin.x + kMargin, self.firstContainer.frame.height + self.secondContainer.frame.height + self.thirdontainer.frame.height, self.view.bounds.width - (kMargin * 2), self.view.bounds.height * kHieght))
        self.forthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(forthContainer)
        
    }
    
    func setupFirstContaner(containerView : UIView) {
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slot"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = containerView.center
        containerView.addSubview(titleLabel)
    }
   
    func setupSecondContainer(containerView : UIView) {
        for var row = 0; row < kNumberOfRows; ++row {
            for var colmn = 0; colmn < kNumberOfColmns; ++colmn{
                var mySlot : Slot
                var slotImage = UIImageView()
                if slots.count != 0 {
                   let slotContainer = slots[row]
                    mySlot = slotContainer[colmn]
                    slotImage.image = mySlot.image
                } else {
                    slotImage.image = UIImage(named: "Ace")
                }

                slotImage.frame = CGRectMake(containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(row) * kThird), containerView.bounds.origin.y + (containerView.bounds.size.height * CGFloat(colmn) * kThird) , containerView.bounds.width * kThird - kSlotMargin, containerView.bounds.height * kThird - kSlotMargin )
                containerView.addSubview(slotImage)
                
            }
        }
        
    }
    func setupThirdContainer(containerView:UIView) {
        self.creditLabel = UILabel()
        self.creditLabel.text = "000000"
        self.creditLabel.textColor = UIColor.redColor()
        self.creditLabel.font = UIFont(name: "Menlo-Blod", size: 16)
        self.creditLabel.sizeToFit()
        self.creditLabel.center = CGPoint(x: containerView.frame.width * kHieght, y: containerView.frame.height * kThird)
        self.creditLabel.textAlignment = NSTextAlignment.Center
        self.creditLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.creditLabel)
        
        self.betLabel = UILabel()
        self.betLabel.text = "0000"
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name: "Menlo-Blod", size: 16)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPoint(x: containerView.frame.width * kHieght * 3, y: containerView.frame.height * kThird)
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.betLabel)
        
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000"
        self.winnerPaidLabel.textColor = UIColor.redColor()
        self.winnerPaidLabel.font = UIFont(name: "Menlo-Blod", size: 16)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.center = CGPoint(x: containerView.frame.width * kHieght * 5, y: containerView.frame.height * kThird)
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.winnerPaidLabel)
        
        self.creditTitleLabel = UILabel()
        self.creditTitleLabel.text = "Credits"
        self.creditTitleLabel.textColor = UIColor.blackColor()
        self.creditTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.creditTitleLabel.sizeToFit()
        self.creditTitleLabel.center = CGPoint(x: containerView.frame.width * kHieght, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.creditTitleLabel)
        
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "Bet"
        self.betTitleLabel.textColor = UIColor.blackColor()
        self.betTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(x: containerView.frame.width * kHieght * 3, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.betTitleLabel)
        
        self.winnerPaidTitleLabel = UILabel()
        self.winnerPaidTitleLabel.text = "Winner paid"
        self.winnerPaidTitleLabel.textColor = UIColor.blackColor()
        self.winnerPaidTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.winnerPaidTitleLabel.sizeToFit()
        self.winnerPaidTitleLabel.center = CGPoint(x: containerView.frame.width * kHieght * 5, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.winnerPaidTitleLabel)
        
        
    }
    func setupForthContainer(containerView: UIView) {
        self.resetButton = UIButton()
        self.resetButton.setTitle("Reset", forState: .Normal)
        self.resetButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.resetButton.backgroundColor = UIColor.lightGrayColor()
        self.resetButton.sizeToFit()
        self.resetButton.center = CGPoint(x: containerView.frame.width * kEigth, y: containerView.frame.height * kHalf)
        self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.resetButton)
        
        self.betOneButton = UIButton()
        self.betOneButton.setTitle("Bet one", forState: .Normal)
        self.betOneButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.betOneButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betOneButton.backgroundColor = UIColor.greenColor()
        self.betOneButton.sizeToFit()
        self.betOneButton.center = CGPoint(x: containerView.frame.width * kEigth * 3,  y: containerView.frame.height * kHalf)
        self.betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betOneButton)
        
        self.betMaxButton = UIButton()
        self.betMaxButton.setTitle("Bet max", forState: .Normal)
        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betMaxButton.backgroundColor = UIColor.redColor()
        self.betMaxButton.sizeToFit()
        self.betMaxButton.center = CGPoint(x: containerView.frame.width * kEigth * 5,  y: containerView.frame.height * kHalf)
        self.betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betMaxButton)
        
        self.spinButton = UIButton()
        self.spinButton.setTitle("Spin", forState: .Normal)
        self.spinButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.spinButton.backgroundColor = UIColor.greenColor()
        self.spinButton.sizeToFit()
        self.spinButton.center = CGPoint(x: containerView.frame.width * kEigth * 7,  y: containerView.frame.height * kHalf)
        self.spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.spinButton)
    }
    
    func removeImageViews() {
        if self.secondContainer != nil {
            let containerView : UIView? = self.secondContainer!
            let subViews:Array? = containerView!.subviews
            for view in subViews! {
                view.removeFromSuperview()
            }
        }
    }
    
    func hardReset() {
        removeImageViews()
        slots.removeAll(keepCapacity: true)
        self.setupSecondContainer(self.secondContainer)
        credits = 50
        winnings = 0
        currentBet = 0
        
        updateMainView()
    }
    
    func updateMainView() {
        self.betLabel.text = "\(currentBet)"
        self.creditLabel.text = "\(credits)"
        self.winnerPaidLabel.text = "\(winnings)"
    }
    
    func showAlertWithText(header: String = "Warning'", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}

