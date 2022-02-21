//
//  GameViewController.swift
//  SwiftBreak
//
//  Created by wsucatslabs on 10/15/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
   var skscene : BreakScene?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      if let view = self.view as! SKView? {
         skscene = BreakScene(fileNamed: "BreakScene")
         skscene!.scaleMode = .aspectFill
         view.presentScene(skscene)
         view.showsFPS = true
      }
   }
   
   @IBAction func handlePan(_ gesture: UIPanGestureRecognizer) {
      skscene!.touchMoved(toPoint: gesture.translation(in: view))
   }
}
