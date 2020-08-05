//
//  ViewController.swift
//  MyQuiz
//
//  Created by MyMacBook on 23.07.2020.
//  Copyright © 2020 MyMacBook. All rights reserved.
//

/*
 Things we need
 - Menu screen
 - Game screen
 - Answer object
 - Question object
 
 
 */

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  @IBAction func startGame() {
    let vc = storyboard?.instantiateViewController(identifier: "game") as! GameViewController
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true) 
  }


}

