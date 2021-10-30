//
//  PDFViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/30/21.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    public var documentData: Data?

    @IBOutlet weak var pdfView: PDFView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = documentData {
          pdfView.document = PDFDocument(data: data)
          pdfView.autoScales = true
        }
    }
    

    @IBAction func dismissBtnTapped(_ sender: Any) {
        Utilities.vibrate()
        
        self.dismiss(animated: true, completion: nil)
    }
    

}
