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
        // Bilder aus Xcassets-Datei
        if let detailViewDatas=detailViewData{
            
            let name = detailViewDatas.name.replacingOccurrences(
                of: "ü", with: "ue")
            
             if let okBundeslandName=bundesLand,
                let okUnterTitle=untTitle,
                let okMyimage=myImage{
                
                okBundeslandName.text=detailViewDatas.name
                okUnterTitle.text=detailViewDatas.capital
                okMyimage.image=UIImage(named: name)
            }
            
        }
    }
    
}
