//
//  ContainerVC.swift
//  CRACC
//
//  Created by Khoi Nguyen on 10/1/17.
//  Copyright © 2017 Cracc LLC. All rights reserved.
//
import SidebarOverlay
import UIKit

class ContainerVC: SOContainerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.menuSide = .left
        self.topViewController = self.storyboard?.instantiateViewController(withIdentifier: "2")
        self.sideViewController = self.storyboard?.instantiateViewController(withIdentifier: "1")
    }

    

}
