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

import PDFKit

class ExistingContractsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var myCurrentButton: Int = 0
    
    var currentFilteredArray: [MyContracts] = []  //for search
    var searchController: UISearchController!
    var shouldShowSearchResults: Bool = false
    var clientID: String = ""
    var allContracts: [ MyContracts ] = []
    
    var ref: DatabaseReference!
    
    var indicator:ProgressIndicator?
    
    private let refreshControl = UIRefreshControl()
    
    let myVertCellSize:  CGSize  = CGSize( width: 340, height: 60 )
    
    let myVertCVSpacing: CGFloat = CGFloat( 4.0 ) //vertical spacing for
    
    
    @IBOutlet weak var contractCollectionView: UICollectionView!
    
    
    
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
    
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        Utilities.vibrate()
        customSearch()
        
    }
    
    
    @IBAction func verticalDotTapped(_ sender: Any) {
        Utilities.vibrate()
        
    // print("Cell number \(String(indexPath.item)) tapped" )
        prepCustomMenu()
        
        
    }
    
    
    
    
    func prepCustomMenu()  {
        
        
        
        let tempView: UIView     = UIView.init()    // Fill screen with invisible view to disable taps in back
        tempView.tag             = 1000
        tempView.frame           = self.view.frame
        tempView.backgroundColor = UIColor.clear
        self.view.addSubview( tempView )
        
        //-----------------------------------------------------------------------------------
        
        var buttonRect: CGRect = CGRect.zero
        buttonRect.origin.x    = contractCollectionView.frame.origin.x + 40
        buttonRect.origin.y    = 0
        buttonRect.size.width  = contractCollectionView.frame.size.width - 80.0
        buttonRect.size.height = 44
        
        let buttonGap:CGFloat  = 10.0 // vertical gap between buttons
        
        //-----------------------------------------------------------------------------------
        
        let bgLabel: UILabel    = UILabel.init()
        bgLabel.backgroundColor = UIColor.white
        var bgRect: CGRect      = CGRect.zero
        bgRect.origin.x         = contractCollectionView.frame.origin.x + 20
        bgRect.origin.y         = 0
        bgRect.size.width       = contractCollectionView.frame.size.width - 60.0
        bgRect.size.height      = ( buttonRect.size.height * 4.0 ) + ( buttonGap * 5.0 )
        bgLabel.frame           = bgRect
        tempView.addSubview( bgLabel )
        
        bgLabel.layer.cornerRadius = 10.0
        bgLabel.clipsToBounds      = true
        bgLabel.center             = self.view.center
        
        
        //-----------------------------------------------------------------------------------
        
        
        
        let viewPDFButton:  UIButton            = UIButton.init()
        viewPDFButton.backgroundColor           =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //UIColor(named: "myLightGray")
        viewPDFButton.titleLabel?.textAlignment = .center
        viewPDFButton.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 20.0 )
        viewPDFButton.setTitleColor( UIColor.white, for: .normal)
        viewPDFButton.setTitle("View PDF", for: .normal )
        viewPDFButton.addTarget(self, action: #selector( self.handleViewPDF ), for: .touchUpInside )
        
        tempView.addSubview( viewPDFButton )
        viewPDFButton.layer.cornerRadius = 8.0
        viewPDFButton.clipsToBounds      = true
        
        buttonRect.origin.y        = bgLabel.frame.origin.y + buttonGap
        viewPDFButton.frame = buttonRect
        
        buttonRect.origin.y += buttonRect.size.height + buttonGap
        
        //-----------------------------------------------------------------------------------
        
        
        let editContractButton: UIButton             = UIButton.init()
        editContractButton.backgroundColor           =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            //UIColor(named: "myLightGray")
        editContractButton.titleLabel?.textAlignment = .center
        editContractButton.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 20.0 )
        editContractButton.setTitleColor( UIColor.white, for: .normal)
        editContractButton.setTitle("Edit Contract", for: .normal )
        editContractButton.addTarget(self, action: #selector( self.handleUpdateContract ), for: .touchUpInside )
        tempView.addSubview( editContractButton )
        editContractButton.layer.cornerRadius = 8.0
        editContractButton.clipsToBounds      = true
        
        editContractButton.frame = buttonRect
        
        buttonRect.origin.y += buttonRect.size.height + buttonGap
        
        
        
        //-----------------------------------------------------------------------------------
        
        
        let deleteContractButton: UIButton             = UIButton.init()
        deleteContractButton.backgroundColor           =  UIColor.red
            //#colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            //UIColor(named: "myLightGray")
        deleteContractButton.titleLabel?.textAlignment = .center
        deleteContractButton.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 20.0 )
        deleteContractButton.setTitleColor( UIColor.white, for: .normal)
        deleteContractButton.setTitle("Delete Contract", for: .normal )
        deleteContractButton.addTarget(self, action: #selector( self.handleDeleteContract ), for: .touchUpInside )
        tempView.addSubview( deleteContractButton )
        deleteContractButton.layer.cornerRadius = 8.0
        deleteContractButton.clipsToBounds      = true
        
        deleteContractButton.frame = buttonRect
        
        buttonRect.origin.y += buttonRect.size.height + buttonGap
        
        
        //-----------------------------------------------------------------------------------
        
        let cancelMenuButton: UIButton             = UIButton.init()
        cancelMenuButton.backgroundColor           = #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //UIColor(named: "myLightGray")
        cancelMenuButton.setTitleColor( UIColor.red, for: .normal)
        cancelMenuButton.titleLabel?.textAlignment = .center
        cancelMenuButton.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 20.0 )
        cancelMenuButton.setTitle("Cancel", for: .normal )
        cancelMenuButton.addTarget(self, action:#selector( self.handleCancel ), for: .touchUpInside )
        tempView.addSubview( cancelMenuButton )
        cancelMenuButton.frame = buttonRect
        cancelMenuButton.layer.cornerRadius = 8.0
        cancelMenuButton.clipsToBounds      = true
        
    }
    
    
    
    
    
    
    //MARK:- POPUP VIEW ACTIONS
    @objc func handleViewPDF(_ sender: UIButton) {
        
        Utilities.vibrate()
        
        sender.tag = myCurrentButton
        
        print("VIEW PDF Button \(String(sender.tag)) pressed!")
        
        
        
        var tempServiceRequest: MyContracts
        
        tempServiceRequest = MyContracts.init()
        
        
        if shouldShowSearchResults {
            
            tempServiceRequest = currentFilteredArray[sender.tag]
            
            searchController.dismiss(animated: false, completion: nil)
            
        } else {
            
            tempServiceRequest = allContracts[sender.tag]
        }
        
        
        let singletonInstance = ContractSingleton.shared
        
        singletonInstance.setContractorCompanyName(theName: tempServiceRequest.companyName)
        
        singletonInstance.setContractorAddress(theAddress: tempServiceRequest.companyAddress)
        
        singletonInstance.setContractorEmail(theEmail: tempServiceRequest.companyEmail)
        
        singletonInstance.setClientName(theName: tempServiceRequest.clientName)
        singletonInstance.setClientAddress(theAddress: tempServiceRequest.clientAdress)
        singletonInstance.setContractDate(theDate: tempServiceRequest.clientDate)
        
        singletonInstance.setClientSignUri(theUri: tempServiceRequest.clientSignUrl)
        
        singletonInstance.setContractorSignUrl(theUri: tempServiceRequest.contractorSignUrl)
        
        singletonInstance.setContractDescription(theDesc: tempServiceRequest.clientDesc)
        singletonInstance.setContractAmount(theAmount: Double( tempServiceRequest.clientPrice)!)
        //setContractAmount(theAmount: Int(tempServiceRequest.clientPrice)!)
        
        //singletonInstance.setA
        
        
        
        
//        singletonInstance.setRequestID(theID: tempServiceRequest.requestID)
//
//        //===================SERVICE IDS====
//        singletonInstance.setServiceID(theID: tempServiceRequest.serviceID)
//
//        singletonInstance.setServiceTitle(theTitle: tempServiceRequest.serviceRequestTitle)
//
        
       
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "GeneratePDFID") as? GeneratePDFViewController
        
        homeVC?.modalPresentationStyle = .fullScreen
        self.present(homeVC!, animated: true, completion: nil)
        
      
        
      
        self.view.viewWithTag(1000)?.removeFromSuperview()
     
    }
    
    
    
    
    
    
    //MARK:-CONTRACT Update
    @objc func handleUpdateContract(sender: UIButton) {
        
        Utilities.vibrate()
        sender.tag = myCurrentButton
        
        print("Share Button \(String(sender.tag)) pressed!")
        
        var tempService:MyContracts
        
        //initialising
        tempService = MyContracts.init()
        
        
        if shouldShowSearchResults {
            
            tempService = currentFilteredArray[sender.tag]
            
            searchController.dismiss(animated: false, completion: nil)
            
        } else {
            
            tempService = allContracts[sender.tag]
        }
        
        
   
        
        self.view.viewWithTag(1000)?.removeFromSuperview()
        
    }
    
    
    
    
    
    //MARK:-CONTRACT Delete
    @objc func handleDeleteContract(sender: UIButton) {
        
        Utilities.vibrate()
        sender.tag = myCurrentButton
        
        print("Share Button \(String(sender.tag)) pressed!")
        
        var tempService:MyContracts
        
        //initialising
        tempService = MyContracts.init()
        
        
        if shouldShowSearchResults {
            
            tempService = currentFilteredArray[sender.tag]
            
            searchController.dismiss(animated: false, completion: nil)
            
        } else {
            
            tempService = allContracts[sender.tag]
        }
        
        
   
        
        self.view.viewWithTag(1000)?.removeFromSuperview()
        
    }
    
    
    
    
    @objc func handleCancel() {
        Utilities.vibrate()
        self.view.viewWithTag(1000)?.removeFromSuperview()
        
    }
    
    //END OF POPUP VIEW ACTIONS
    
    
    
 
    
    
    
    
    
    //🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷
    func customSearch() {
        //https://www.raywenderlich.com/9218753-what-s-new-with-uisearchcontroller-and-uisearchbar#toc-anchor-002
        //https://stackoverflow.com/questions/38729151/show-search-bar-with-action-bar-item
        
        //https://www.youtube.com/watch?v=55YdwGvIZwY&t=42s
        
        
        //https://www.raywenderlich.com/9218753-what-s-new-with-uisearchcontroller-and-uisearchbar#toc-anchor-002
        //https://stackoverflow.com/questions/38729151/show-search-bar-with-action-bar-item
        
        //https://www.youtube.com/watch?v=55YdwGvIZwY&t=42s
        
        
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search By Name"
        searchController.searchBar.tintColor = UIColor.red
        
        //will enable didSelectRowAtIndexPath
        searchController.obscuresBackgroundDuringPresentation = false
        
        
        // Set any properties (in this case, don't hide the nav bar and don't show the emoji keyboard option)
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        present(searchController, animated: true, completion: nil)
        
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
        
        if shouldShowSearchResults {
            
            return currentFilteredArray.count
            
        } else {
            
            return allContracts.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Utilities.vibrate()
        
        myCurrentButton = indexPath.item
        
        //Feedback on button tapped
        Utilities.vibrate()
    
        
    // print("Cell number \(String(indexPath.item)) tapped" )
        prepCustomMenu()
        print("\(indexPath.item) tapped")
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // print("sizeForItemAt hit!")
        
        return myVertCellSize
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let contractCell = contractCollectionView.dequeueReusableCell(withReuseIdentifier: "MyContractsID", for: indexPath) as! MyContractsCollectionViewCell
        
       
        
        contractCell.shadowDecorate()
        
        contractCell.viewBtn.tag = indexPath.item
        
    
        if (shouldShowSearchResults) {
            
            contractCell.clientNameLabel.text = currentFilteredArray[indexPath.item].clientName
            
           
            
            
        } else {
            
            contractCell.clientNameLabel.text = allContracts[indexPath.item].clientName
      
        }
        
      
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


@available(iOS 13.0, *)
extension ExistingContractsViewController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if !shouldShowSearchResults {
            
            shouldShowSearchResults = true
            contractCollectionView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
        
    }
    
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        contractCollectionView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        contractCollectionView.reloadData()
    }
}


extension ExistingContractsViewController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let lowerSearchText = searchController.searchBar.text?.lowercased()
        
        currentFilteredArray = [] //clear the array
        
        currentFilteredArray = searchController.searchBar.text!.isEmpty ? allContracts :
            
            allContracts.filter { item -> Bool in
                
                let clientName: NSString = item.clientName  as NSString
                
                return  clientName.lowercased(with: NSLocale.current).contains(lowerSearchText!)
                
            }
        
        contractCollectionView.reloadData()
        
    }
    
}
