//
//  GeneratePDFViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/30/21.
//

import UIKit
import SimplePDF
import WebKit
import Firebase


class GeneratePDFViewController: UIViewController {
    
    
    enum possibleModes: Int {
        
        case generatePDF
        //        case modeUpdate
        case modeDelete
        case modeInactive
        
    }
    
    //holding mode of button use to chnage label on both button and title of Register For Service with respect to click item
    var valueForInfo:Int = 0
    
    let defualts = UserDefaults.standard
    
    
    var currentMode: Int = possibleModes.modeInactive.rawValue     // Just a safeguard ‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️
    
    
    let docsDir: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! //document directory
    
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        
    }
    
    @IBOutlet weak var genericView: UIView!
    
    @IBOutlet weak var contractHeaderLabel: UILabel!
    
    @IBOutlet weak var contractorAddressLabel: UILabel!
    
    @IBOutlet weak var clientAddressLabel: UILabel!
    
    @IBOutlet weak var contractDescriptionHeader: UILabel!
    
    @IBOutlet weak var contractDescriptionDetail: UILabel!
    
    
    @IBOutlet weak var contractPriceLabel: UILabel!
    
    @IBOutlet weak var signatureHeaderLabel: UILabel!
    
    @IBOutlet weak var clientSignHeaderLabel: UILabel!
    @IBOutlet weak var contractorSignHeaderLabel: UILabel!
    
    @IBOutlet weak var generatePDFNowBtn: UIButton!
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var contractorImageView: UIImageView!
    @IBOutlet weak var clientImageView: UIImageView!
    var contractorCompanyName: String  = ""
    var contractorCompanyAddress: String  = ""
    var contractorCompanyEmail: String  = ""
    var contractorSignUrl: String  = ""
    var contractType: String = ""
    
    
    var clientName: String  = ""
    var clientAdress: String  = ""
    var contractDate: String  = ""
    var clientSignUri: String  = ""
    
    var contractDesc: String  = ""
    var contractPrice: Double  = 0.0
    
    var userUID: String  = ""
    
    var contractID: String  = ""
    
    
    
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    let singletonInstance = ContractSingleton.shared
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getSentData()
        
        updateLabel()
        
        // createDir(dir: "AllPDFS" )
        view.backgroundColor = #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        
        genericView.backgroundColor = #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    
    func updateLabel() {
        
        valueForInfo = UserDefaults.standard.integer(forKey: "UpdateInfo")
        
        switch valueForInfo {
        
        //========= ADD SERVICE ============================================================================
        
        case possibleModes.generatePDF.rawValue:
            
            generatePDFNowBtn.tintColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //UIColor(named: "myTintGreen")
            //addServiceButtonOutlet.backgroundColor =  UIColor(named: "myTintGreen")
            
            navBar.topItem?.title = clientName
            
            generatePDFNowBtn.setTitle("GENERATE PDF AND SHARE", for: .normal)
            
            
            break
            
            
            
        //===== DELETE SERVICE =============================================================================
        
        case possibleModes.modeDelete.rawValue:
            
            generatePDFNowBtn.backgroundColor = UIColor.red
            generatePDFNowBtn.setTitle("DELETE", for: .normal)
           // generatePDFNowBtn.titleLabel?.font = .systemFont(ofSize: 16.0)
            //generatePDFNowBtn.titleLabel?.font = .boldSystemFont(ofSize: 16.0)
            
          
                
                generatePDFNowBtn.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 20.0 )
                
              
            
            navBar.topItem?.title = "Delete Contract Information"
            
            
            break
            
        default:
            
            return
            
        }
        
        
        
    }
    
    //🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷//🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷
    
    
    
    //MARK:- CREATE DIRECTORY
    func createDir( dir: String ) {
        
        let fullDirPath           = docsDir + "/" + dir
        
        print(fullDirPath) //‼️‼️‼️‼️ Only here for development - Remove before uploading to Apple ‼️‼️‼️‼️‼️
        
        let fileManager           = FileManager.default
        var isDirectory: ObjCBool = false
        
        if !fileManager.fileExists(atPath: fullDirPath, isDirectory: &isDirectory) {
            
            // Only create the directory if it does not already exist
            
            do {
                try FileManager.default.createDirectory(atPath: fullDirPath, withIntermediateDirectories: true, attributes: nil)
                
                print("Subdirectory " + dir + " created")  // Remove before uploading to Apple
                
            } catch {
                
                print(error)
                
            }
            
        }
        
    }
    
    
    
    @IBAction func generatePdfNowAction(_ sender: Any) {
        
        
        Utilities.vibrate()
        
        
        switch valueForInfo {
        
        case possibleModes.generatePDF.rawValue:
            generatePDFNow()
            
            break
            
        case possibleModes.modeDelete.rawValue:
            
            
            let alert = UIAlertController(title: "Delete Contract" ,message: "Are you sure you want to delete this  Contract?",preferredStyle: .alert)
            
            // Change font and color of title
            alert.setTitle(font: UIFont.boldSystemFont(ofSize: 26), color: UIColor.white)
            
            // Change font and color of message
            alert.setMessage(font: UIFont(name: "", size: 18), color: UIColor.white)
            
            // Change background color of UIAlertController
            alert.setBackgroudColor(color: UIColor.red)
            
            // Accessing alert view backgroundColor :
            //alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.red
            
            alert.view.tintColor = UIColor.white
            
            alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (UIAlertAction) in
                
                self.dismiss(animated: true, completion: nil)
                
            }))
            
            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (UIAlertAction) in
                
                
                self.deleteContract()
                
                
            }))
            
            self.present(alert,animated: true, completion: nil)
            
            break
            
        default:
            
            return
            
        }
        
        
        
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        
        Utilities.vibrate()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    private func generatePDFNow() {
        
        
        if(clientImageView.isEmpty && contractorImageView.isEmpty) {
            return
        }
        
        
        if(clientImageView.isEmpty){
            self.displayMessage(title: "Error", userMessage: "Opps!! An error has occured")
            return
        }
        
        if(contractorImageView.isEmpty){
            self.displayMessage(title: "Error", userMessage: "Opps!! An error has occured")
            return
        }
        
        
        
        
        let A4paperSize = CGSize(width: 595, height: 1224) //842
        let pdf = SimplePDF(pageSize: A4paperSize, pageMarginLeft: 35, pageMarginTop: 50, pageMarginBottom: 40, pageMarginRight: 35)
        
        
        
        
        pdf.setContentAlignment(.center)
        pdf.addText( "CONTRACT DETAILS", font: UIFont.boldSystemFont(ofSize: 24.0 ), textColor: UIColor.blue )
        
        
        pdf.addVerticalSpace(2)
        pdf.addLineSpace(2.0)
        pdf.addVerticalSpace(15)
        
        
        
        pdf.setContentAlignment(.right)
        pdf.addText( "CONTRACTOR DETAILS", font: UIFont.boldSystemFont(ofSize: 16.0 ), textColor: UIColor.blue )
        pdf.setContentAlignment(.right)
        pdf.addText( contractorAddressLabel.text! )
        
        pdf.addVerticalSpace(2)
        pdf.addLineSpace(2.0)
        pdf.addVerticalSpace(15)
        
        
        pdf.setContentAlignment(.left)
        pdf.addText( "CLIENT DETAILS", font: UIFont.boldSystemFont(ofSize: 16.0 ), textColor: UIColor.blue )
        pdf.setContentAlignment(.left)
        pdf.addText( clientAddressLabel.text! )
        
        
        pdf.addVerticalSpace(40)
        pdf.setContentAlignment(.left)
        pdf.addText( "TYPE OF CONTRACTOR", font: UIFont.boldSystemFont(ofSize: 16.0), textColor: UIColor.blue )
        pdf.addVerticalSpace(4)
        
        pdf.setContentAlignment(.left)
        pdf.addText( contractType )
        
        pdf.addVerticalSpace(2)
        pdf.addLineSpace(2.0)
        pdf.addVerticalSpace(4)
        
        
        pdf.addVerticalSpace(10)
        pdf.setContentAlignment(.left)
        pdf.addText( "CONTRACT DESCRIPTION", font: UIFont.boldSystemFont(ofSize: 16.0), textColor: UIColor.blue )
        pdf.addVerticalSpace(4)
        
        pdf.setContentAlignment(.left)
        pdf.addText( contractDescriptionDetail.text! )
        
        pdf.addVerticalSpace(2)
        pdf.addLineSpace(2.0)
        pdf.addVerticalSpace(15)
        
        
        
        
        
        
        
        pdf.setContentAlignment(.left)
        pdf.addText( "PRICE", font: UIFont.boldSystemFont(ofSize: 16.0), textColor: UIColor.blue )
        pdf.addVerticalSpace(4)
        
        pdf.setContentAlignment(.left)
        pdf.addText( contractPriceLabel.text!)
        
        pdf.addVerticalSpace(2)
        pdf.addLineSpace(2.0)
        pdf.addVerticalSpace(15)
        
        
        
        
        
        
        pdf.setContentAlignment(.center)
        pdf.addText( "SIGNATURES", font: UIFont.boldSystemFont(ofSize: 16.0), textColor: UIColor.blue )
        pdf.addVerticalSpace(10)
        
        pdf.setContentAlignment(.left)
        pdf.addText( "CLIENT", font: UIFont.boldSystemFont(ofSize: 12.0), textColor: UIColor.blue )
        pdf.setContentAlignment(.left)
        pdf.addImage(resizeImage(image: clientImageView.image!, targetSize: CGSize(width: 50.0, height: 50.0))!)
        
        
        pdf.addVerticalSpace(2)
        pdf.addLineSpace(2.0)
        pdf.addVerticalSpace(15)
        
        pdf.setContentAlignment(.left)
        pdf.addText( "CONTRACTOR", font: UIFont.boldSystemFont(ofSize: 12.0), textColor: UIColor.blue )
        
        pdf.setContentAlignment(.left)
        pdf.addImage(resizeImage(image: contractorImageView.image!, targetSize: CGSize(width: 50.0, height: 50.0))!)
        // pdf.addImage(contractorImageView.image!)
        
        pdf.addVerticalSpace(2)
        pdf.addLineSpace(2.0)
        pdf.addVerticalSpace(15)
        
        
        
        
        pdf.setContentAlignment(.center)
        pdf.addText( fromLabel.text!, font: UIFont.boldSystemFont(ofSize: 16.0), textColor: UIColor.black )
        
        
        
        
        pdf.addVerticalSpace(20)
        pdf.setContentAlignment(.center)
        pdf.addText( "****END****", font: UIFont.boldSystemFont(ofSize: 16.0), textColor: UIColor.blue )
        pdf.addVerticalSpace(10)
        
        
        let pdfData = pdf.generatePDFdata()
        
        
        var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last as NSURL?
        
        docURL = docURL?.appendingPathComponent( "\(clientName)" + ".pdf") as NSURL?
        
        //Lastly, write your file to the disk.
        try? pdfData.write(to: docURL! as URL)
        
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        var documentsDirectory = paths[0]
        let docURLReceived = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let targetURL = docURLReceived.appendingPathComponent("\(clientName)" + ".pdf")
        var request = URLRequest(url: targetURL)
        //        webView.loadRequest(request)
        //        view.addSubview(webView)
        
        
        var shareItems = [Any]()
        shareItems.append("Compartilhar em...")
        shareItems.append(targetURL)
        
        let avController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        avController.excludedActivityTypes  = [
            .postToWeibo,
            .message,
            .mail,
            .print,
            .copyToPasteboard,
            .assignToContact,
            .saveToCameraRoll,
            .addToReadingList,
            .postToFlickr,
            .postToVimeo,
            .postToTencentWeibo,
            .airDrop
        ] // caso queira excluir alguma opção
        
        self.present(avController, animated: true, completion: nil)
        
        
        
        
    }
    
    
    
    
    private  func deleteContract() {
        let uid = Auth.auth().currentUser!.uid
        
        
        let   ref = Database.database().reference().child("/user-contracts/\(userUID)/").child(contractID)
        
        ref.removeValue { error,arg  in
            if error != nil {
                print("error \(error)")
            }
        }
        
        
        self.dismiss(animated: true, completion: nil)
        
        print("REF: \(ref)")
        
     
        
        
    }
    
    
    
    
    private  func showSavedPdf(url:String, fileName:String) {
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains("\(fileName).pdf") {
                        // its your file! do what you want with it!
                        
                    }
                }
            } catch {
                print("could not locate pdf file !!!!!!!")
            }
        }
    }
    
    
    
    func getSentData() {
        
        generatePDFNowBtn.layer.cornerRadius = Constants.cornerRadius
        
        contractDescriptionDetail.backgroundColor = .clear
        
        let singletonInstance = ContractSingleton.shared
        
        userUID = singletonInstance.getUID()
        
        contractID = singletonInstance.getContractID()
        
        print("THIS IS USER UID: \(userUID)")
        
        print("THIS IS CONTRCT ID: \(contractID)")
        
        contractorCompanyName = singletonInstance.getContractorCompanyName()
        contractorCompanyAddress = singletonInstance.getContractorAddress()
        contractorCompanyEmail = singletonInstance.getContractorEmail()
        contractorSignUrl = singletonInstance.getContractorSignUrl()
        clientName = singletonInstance.getClientName()
        clientAdress = singletonInstance.getClientAddress()
        contractDate = singletonInstance.getContractDate()
        clientSignUri = singletonInstance.getClientSignUri()
        contractDesc = singletonInstance.getContractDescription()
        contractPrice = singletonInstance.getContractAmount()
        contractType = singletonInstance.getContractType()
        
        
        //print("Contract Price: \(contractPrice)")
        
        //        let contractTypeData  = "\(contractType)"
        
        // navBar.topItem?.title = clientName
        
        
        
        contractorAddressLabel.text = "\(contractorCompanyName)\n\(contractorCompanyAddress)\n\(contractorCompanyEmail)\n\(contractType)"
        
        clientAddressLabel.text = "\(clientName)\n\(clientAdress)\n\(contractDate)"
        
        
        contractDescriptionDetail.text = contractDesc
        
        let formattedContractPrice = contractPrice.formattedWithSeparator
        
        
        contractPriceLabel.text = "\("$" + String(formattedContractPrice))"
        
        fromLabel.text = "FROM: \(clientName)"
        
        
        
        
        clientImageView.loadImageUsingCacheFromUrlString(urlString: clientSignUri)
        clientImageView.contentMode = .scaleAspectFit
        
        
        
        contractorImageView.loadImageUsingCacheFromUrlString(urlString: contractorSignUrl)
        contractorImageView.contentMode = .scaleAspectFit
        
        
        
        
        
    }
    
    
    func savePdf(urlString:String, fileName:String) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "CommanderContracts-\(fileName).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!")
            } catch {
                print("Pdf could not be saved")
            }
        }
    }
    
    
    
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
    //============function to display alert messages==================
    private   func displayMessage(title: String, userMessage: String ) -> Void {
        
        DispatchQueue.main.async {
            
            Utilities.vibrateOnNotificationError()
            
            let alertController = UIAlertController (title: title, message: userMessage, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    
    
    
    
    
    
}



