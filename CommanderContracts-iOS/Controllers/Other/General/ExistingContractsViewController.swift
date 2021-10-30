//
//  ExistingContractsViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/29/21.
//

import UIKit

import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ExistingContractsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var indicator:ProgressIndicator?
    
    private let refreshControl = UIRefreshControl()
    
    let myVertCellSize:  CGSize  = CGSize( width: 340, height: 60 )
    
    let myVertCVSpacing: CGFloat = CGFloat( 4.0 ) //vertical spacing for
    
    
    @IBOutlet weak var contractCollectionView: UICollectionView!
    
    var clientID: String = ""
    var allContracts: [ MyContracts ] = []
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        
        loadAllContracts()
        
        contractCollectionView.dataSource = self
        contractCollectionView.delegate = self
        
        self.contractCollectionView.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        
        
        
        //ON REFRESH TO UPDATE COLLECTION VIEW
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        contractCollectionView.alwaysBounceVertical = true
        contractCollectionView.refreshControl = refreshControl // iOS 10+
        super.viewDidLoad()
        self.view.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        Utilities.vibrate()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func didPullToRefresh(_ sender: Any) {
        loadAllContracts()
        refreshControl.endRefreshing()
        
    }
    
    
    private func loadAllContracts() {
        
        
        
        ref = Database.database().reference()
        
        let userID : String = (Auth.auth().currentUser?.uid)!
        
        
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: "Loading Contracts...")
        self.view.addSubview(self.indicator!)
        indicator!.center = view.center
        indicator!.start()
        view.isUserInteractionEnabled = false
        
        
        self.ref?.child("/user-contracts/").child(userID).observe(.value, with: { snapshot in
            
            
            var tempID: MyContracts //the class
            
            self.allContracts = [] // Temporarily clear allContracts when loading new Sections
            
            
            for child in snapshot.children{
                
                
                
                
                tempID = MyContracts.init()
                
                let valueD = child as! DataSnapshot
                
                //                let keyD = valueD.key
                let value1 = valueD.value as? [String:String]
                tempID.clientAdress = (value1!["clientAddress"]!)
                tempID.clientDate = (value1!["clientDate"]!)
                tempID.clientDesc = (value1!["clientDesc"]!)
                tempID.cientID = (value1!["clientID"]!)
                tempID.clientName = (value1!["clientName"]!)
                tempID.clientPrice = (value1!["clientPrice"]!)
                tempID.clientProfile = (value1!["clientProfileLogoUri"]!)
                tempID.clientSignUrl = (value1!["clientSignUri"]!)
                tempID.companyAddress = (value1!["companyAddress"]!)
                tempID.companyEmail = (value1!["companyEmail"]!)
                tempID.companyName = (value1!["companyName"]!)
                tempID.contractorSignUrl = (value1!["contractorSignUri"]!)
                tempID.id = (value1!["id"]!)
                
                self.allContracts.append( tempID )
                
            }
            
            self.indicator!.stop()
            self.view.isUserInteractionEnabled = true
            
            self.allContracts.sort {
                $0.clientName.lowercased() < $1.clientName.lowercased()
                
            }
            
            //            print(self.allContracts)
            
            self.contractCollectionView.reloadData()
            
            
            
            return
            
        })
        
        
        
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return allContracts.count
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // print("sizeForItemAt hit!")
        
        return myVertCellSize
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let contractCell = contractCollectionView.dequeueReusableCell(withReuseIdentifier: "MyContractsID", for: indexPath) as! MyContractsCollectionViewCell
        
        contractCell.shadowDecorate()
        
        
        contractCell.clientNameLabel.text = allContracts[indexPath.item].clientName
        
        
        //
        //
        //        tenMajorCell.shadowDecorate()
        //
        //
        //
        //        tenMajorCell.tenMajorNumber.layer.cornerRadius =   tenMajorCell.tenMajorNumber.layer.frame.width/2
        //        tenMajorCell.tenMajorNumber.layer.masksToBounds = true
        //        tenMajorCell.tenMajorNumber.layer.borderColor = UIColor.white.cgColor
        //        tenMajorCell.tenMajorNumber.layer.borderWidth = 1.0
        //
        //
        //
        //        if (shouldShowSearchResults) {
        //
        //            tenMajorCell.tenMajorNumber.text = String(currentFilteredArray[indexPath.item].tenMajorNumber)
        //            tenMajorCell.tenMajorTitle.text = currentFilteredArray[indexPath.item].tenMajorTitle
        //
        //
        //        } else {
        //
        //            tenMajorCell.tenMajorNumber.text = String(tenMajorSongsArray[indexPath.item].tenMajorNumber)
        //            tenMajorCell.tenMajorTitle.text = tenMajorSongsArray[indexPath.item].tenMajorTitle
        //
        //
        //        }
        
        
        
        return contractCell
    }
    
    
    
    
}



extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 5
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}


extension ExistingContractsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: myVertCVSpacing, left: myVertCVSpacing, bottom: myVertCVSpacing, right: myVertCVSpacing)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return myVertCVSpacing
        
    }
    
}
