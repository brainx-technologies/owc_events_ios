//
//  EventsView.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/24/21.
//

import Foundation

import UIKit

class EventsView: UIView {
    // MARK: Outlets
    
    @IBOutlet var eventsLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var calendarView: UIView!
    @IBOutlet var calendarImageView: UIImageView!
    
    // MARK: Life Cycle Method
    
    override func awakeFromNib() {
        configureView()
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        setCornersAndBorders()
        setFonts()
        setText()
        setColors()
    }

    private func setCornersAndBorders(){
        calendarView.setCornerRadius(22)
        calendarView.setBorderColor(Color.borderGrey, andWidth: 1)
    }
    
    private func setFonts(){

    }
    
    private func setText(){
        
    }
    
    private func setColors(){
        backgroundColor = Color.backgroundPrimary
        
    }
}
