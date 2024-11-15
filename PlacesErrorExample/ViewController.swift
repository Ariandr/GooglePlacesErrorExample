//
//  ViewController.swift
//  PlacesErrorExample
//

import UIKit
import GooglePlaces

class ViewController: UIViewController {
    
    let placeId = "ChIJJb4YZBJtiEcRv3ec1gP4A4k" // Turin, Italy
    
    private let token = GMSAutocompleteSessionToken()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        setupOutputLabel()
    }
    
    // New method in SDK 9.x.x, always returns 403 error
    func useNewBrokenMethodToFetchPlace() {
        let placesClient = GMSPlacesClient.shared()
        let properties = [GMSPlaceProperty.name, GMSPlaceProperty.coordinate].map { $0.rawValue }
        let fetchPlaceRequest = GMSFetchPlaceRequest(placeID: placeId,
                                                     placeProperties: properties, // This shouldn't expect raw values, downgrade from SDK 8.x.x
                                                     sessionToken: token)
        placesClient.fetchPlace(with: fetchPlaceRequest) { place, error in
            if let error = error {
                print("useNewBrokenMethodToFetchPlace")
                print(error)
                print("\n")
                self.outputLabel.text = "\(error)"
                return
            }
            
            print(place!)
            self.outputLabel.text = "\(place!)"
        }
    }
    
    // Deprecated method, but works
    private func useDeprecatedMethodToFetchPlace() {
        let placesClient = GMSPlacesClient.shared()
        placesClient.fetchPlace(fromPlaceID: placeId,
                                placeFields: [.name, .coordinate],
                                sessionToken: token) { place, error in
            if let error = error {
                print("useDeprecatedMethodToFetchPlace")
                print(error)
                print("\n")
                self.outputLabel.text = "\(error)"
                return
            }
            
            print(place!)
            self.outputLabel.text = "\(place!)"
        }
    }
    
    // MARK: - UI Setup
    
    // Label to display output
    private let outputLabel: UILabel = {
        let label = UILabel()
        label.text = "Result will appear here"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private func setupButtons() {
        let buttonNewMethod = UIButton(type: .system)
        buttonNewMethod.setTitle("Use New Method", for: .normal)
        buttonNewMethod.addTarget(self, action: #selector(newMethodButtonTapped), for: .touchUpInside)
        
        let buttonDeprecatedMethod = UIButton(type: .system)
        buttonDeprecatedMethod.setTitle("Use Deprecated Method", for: .normal)
        buttonDeprecatedMethod.addTarget(self, action: #selector(deprecatedMethodButtonTapped), for: .touchUpInside)
        
        // Layout buttons
        buttonNewMethod.translatesAutoresizingMaskIntoConstraints = false
        buttonDeprecatedMethod.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonNewMethod)
        view.addSubview(buttonDeprecatedMethod)
        
        NSLayoutConstraint.activate([
            buttonNewMethod.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonNewMethod.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            
            buttonDeprecatedMethod.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonDeprecatedMethod.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30)
        ])
    }
    
    private func setupOutputLabel() {
            view.addSubview(outputLabel)
            NSLayoutConstraint.activate([
                outputLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                outputLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                outputLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            ])
        }
    
    @objc private func newMethodButtonTapped() {
        useNewBrokenMethodToFetchPlace()
    }
    
    @objc private func deprecatedMethodButtonTapped() {
        useDeprecatedMethodToFetchPlace()
    }
    
}
