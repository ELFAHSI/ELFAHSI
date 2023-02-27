//
//  Tools.swift
//  SQLIQUIZ
//
//  Created by OUSSAMA BENNOUR EL FAHSI on 02/1/2023.
//

import UIKit

//UIImageView
extension UIImageView {
    func loadFrom(URLAddress: String, indicator: UIActivityIndicatorView) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        // Start the activity indicator animation
        indicator.startAnimating()
        
        // Create a URLSessionDataTask to download the image data
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // Stop the activity indicator animation on the main thread
            DispatchQueue.main.async {
                indicator.stopAnimating()
                indicator.isHidden = true
            }
            
            // Check for errors
            if let error = error {
                print("Error loading image from URL: \(error)")
                return
            }
            
            // Check that the response is an HTTPURLResponse with a success status code
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response: \(response.debugDescription)")
                return
            }
            
            // Check that the data is an image
            guard let imageData = data,
                  let loadedImage = UIImage(data: imageData) else {
                print("Invalid image data")
                return
            }
            
            // Set the image on the main thread
            DispatchQueue.main.async {
                self?.image = loadedImage
            }
        }
        
        // Start the data task
        task.resume()
    }
}
