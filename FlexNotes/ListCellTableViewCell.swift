//
//  ListCellTableViewCell.swift
//  FlexNotes
//
//  Created by Anil on 04/04/23.
//  Copyright © 2023 Variance. All rights reserved.
//

import UIKit

class ListCellTableViewCell: UITableViewCell {

    //MARK:- Outlets --
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView.layer.cornerRadius = self.imgView.frame.size.width / 2
    }

}
