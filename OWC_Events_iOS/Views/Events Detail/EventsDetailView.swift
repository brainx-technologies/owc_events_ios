//
//  EventsDetailView.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/24/21.
//

import UIKit

class EventsDetailView: UIView {
    // MARK: Outlets
    
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var emailFieldView: UIView!
    @IBOutlet var emailField: UITextField!
    
    // MARK: Life Cycle Method
    
    override func awakeFromNib() {
        configureView()
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        setBorders()
        setFonts()
        setText()
        setColors()
    }
    
    private func setBorders(){
        
    }
    
    private func setFonts(){
        
    }
    
    private func setText(){
        
    }
    
    private func setColors(){
        
    }
}
