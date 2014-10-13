//
//  CountryTableViewCell.swift
//  searchController
//
//  Created by audrius kucinskas on 12/10/14.
//  Copyright (c) 2014 trueisfalse. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    var countryLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createCountryLabel()
    }
    
    func createCountryLabel() {
        self.countryLabel = UILabel(frame: CGRectMake(10.0, 0.0, self.contentView.frame.width, self.contentView.frame.height))
        self.contentView.addSubview(self.countryLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
