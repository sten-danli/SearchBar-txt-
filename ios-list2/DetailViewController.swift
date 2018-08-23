//
//  DetailViewController.swift
//  ios-list2
//
//  Created by Dan Li on 23.08.18.
//  Copyright © 2018 Michael Kofler. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailViewData:Country?
    
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var bundesLand: UILabel!
    
    @IBOutlet weak var untTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView(){
       
        if let detailViewDatas=detailViewData{
            if let bundeslandName=bundesLand,
                let unterTitle=untTitle{
                
                bundeslandName.text=detailViewDatas.name
                unterTitle.text=detailViewDatas.capital
            }
            
        }
    }
    
}
