//
//  ContinuityDemoViewController.swift
//  BasicSample
//
//  Created by Omer Rahmany on 01/09/2019.
//  Copyright © 2019 bold360ai. All rights reserved.
//

import UIKit
import Bold360AI

class ContinuityDemoViewController: AgentViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.chatController.continuityProvider = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

