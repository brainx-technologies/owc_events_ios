//
//  EventsDetailViewModel.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/26/21.
//

import CoreLocation
import EventKit
import Foundation
import MapKit

class EventsDetailViewModel {
    // MARK: - Instance Properties

    private var router: EventsDetailRouter
    let eventStore = EKEventStore()

    // MARK: - Init Methods

    required init(router: EventsDetailRouter) {
        self.router = router
    }

    // MARK: - Private Methods

    func openInAppleMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span),
        ]
        let placeMark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = "Lahore" // will replace with actual data after api implementation
        mapItem.openInMaps(launchOptions: options)
    }

    func openInGoogleMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        if UIApplication.shared.canOpenURL(URL(string: AppConstants.googleMapUrlString)!) {
            if let url = EndPoints.createGoogleMapURL(latitude, longitude) {
                UIApplication.shared.open(url, options: [:])
            }
        } else {
            router.viewController?.showAlertView(message: LocalizedKey.cannotUseGoogleMapMessage.string, title: LocalizedKey.error.string)
        }
    }

    // MARK: - Public Methods

    func backButtonPressed() {
        router.dismissVC(navigationType: .stack, animated: true, completion: nil)
    }

    func viewInMap() {
        let latitude: CLLocationDegrees = 31.5204 // will replace with actual data after api implementation
        let longitude: CLLocationDegrees = 74.3587 // will replace with actual data after api implementation
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.view.tintColor = Color.tintColor

        let openGoogleMapAction = UIAlertAction(title: LocalizedKey.openGoogleMap.string, style: .default, handler: { _ in
            self.openInGoogleMap(latitude: latitude, longitude: longitude)
        })
        openGoogleMapAction.setValue(Color.googleAppleMapButtonColor, forKey: AppConstants.titleTextColor)
        alert.addAction(openGoogleMapAction)
        let openAppleMapAction = UIAlertAction(title: LocalizedKey.openAppleMap.string, style: .default, handler: { _ in
            self.openInAppleMap(latitude: latitude, longitude: longitude)
        })
        openAppleMapAction.setValue(Color.googleAppleMapButtonColor, forKey: AppConstants.titleTextColor)
        alert.addAction(openAppleMapAction)
        let cancelAction = UIAlertAction(title: LocalizedKey.cancel.string, style: .cancel, handler: nil)
        cancelAction.setValue(Color.tintColor, forKey: AppConstants.titleTextColor)
        alert.addAction(cancelAction)
        router.showActionSheet(alert: alert, animated: true, completion: nil)
    }

    func showThisCustomAlertView(title: String, Message: String) {
        let alertController = UIAlertController(title: title, message: Message, preferredStyle: .alert)
        alertController.setTitle(font: Font.muliBold(18), color: UIColor.black)
        alertController.setMessage(font: Font.muliRegular(13), color: UIColor.black)
        alertController.setBackgroundColor(color: Color.white)
        let okButton = UIAlertAction(title: LocalizedKey.ok.string, style: .default, handler: nil)
        okButton.setValue(Color.black, forKey: AppConstants.titleTextColor)
        alertController.addAction(okButton)
        router.viewController?.showAlert(alertController: alertController)
    }

    func addToCalendar() {
        eventStore.requestAccess(to: .event) { granted, error in
            if granted, error == nil {
                let event = EKEvent(eventStore: self.eventStore)
                event.title = "Test Title" // will replace with actual data after api implementation
                event.startDate = Date()
                event.endDate = Date()
                event.notes = "This is a note" // will replace with actual data after api implementation
                event.calendar = self.eventStore.defaultCalendarForNewEvents
                do {
                    try self.eventStore.save(event, span: .thisEvent)
                    DispatchQueue.main.async {
                        self.showThisCustomAlertView(title: LocalizedKey.successTitle.string, Message: LocalizedKey.successMessage.string)
                    }
                } catch let error as NSError {
                    let message = "\(LocalizedKey.failedToSave.string) : \(error)"
                    self.router.viewController?.showAlertView(message: message, title: LocalizedKey.error.string)
                }
            } else {
                self.router.viewController?.showAlertView(message: LocalizedKey.failedToSave.string, title: LocalizedKey.error.string)
            }
        }
    }
}
