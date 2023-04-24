//
//  ViewController1.swift
//  FlexNotes
//
//  Created by Anil on 14/04/23.
//  Copyright © 2023 Variance. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
    
    var data: NSData = NSData()
    var name: String = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ImgView.image = UIImage(data: data)
        self.detailLabelNamee.text = name
        
    }
    


}
