//
//  DetailPhotoView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class DetailPhotoView: UIView {
    static let KILOBYTE: Int = 1024
    
    private let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-YYYY"
        return df
    }()
    
    var delegate: DetailPhotoDelegate?
    
    var image: Image? {
        didSet {
            DispatchQueue.main.async {
                self.imageView.image = self.image?.imageData
                
                self.detailView.nameLabel.text? = "Name: \(self.image?.name ?? "Unknown")"
                
                if let timestamp = self.image?.timestamp {
                    self.detailView.dateLabel.text? = "Date: \(self.formatter.string(from: timestamp))"
                }
                
                if let description = self.image?._description {
                    self.detailView.descriptionLabel.text = "Description: \(description)"
                }
                
                if let size = self.image?.size {
                    let sizeInMegaBytes = Float(size) / Float(DetailPhotoView.KILOBYTE * DetailPhotoView.KILOBYTE)
                    self.detailView.sizeLabel.text = "Size: \(sizeInMegaBytes.truncate(places: 2)) MB"
                }
            }
        }
    }
    
    var mapPin: MapPin! {
        didSet {
            detailView.map.addAnnotation(mapPin)
            
            detailView.map.setCenter(mapPin.coordinate, animated: true)
        }
    }
    
    private var imageLayoutConstraints: [NSLayoutConstraint] = []
    private var detailsLayoutConstraints: [NSLayoutConstraint] = []
    
    var detailsViewIsActive: Bool = false
    
    var tapGestureRecognizer = UITapGestureRecognizer()
    var swipeUpGestureRecognizer = UISwipeGestureRecognizer()
    var swipeDownGestureRecognizer = UISwipeGestureRecognizer()
    
    var bottomConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    var topConstraint: NSLayoutConstraint!
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = false
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        return iv
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.minimumZoomScale = 1.0
        sv.maximumZoomScale = 4.0
        sv.alwaysBounceVertical = false
        sv.alwaysBounceHorizontal = false
        sv.showsVerticalScrollIndicator = true
        return sv
    }()
    
    let detailView: AssetDetailView = {
        let v = AssetDetailView()
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = true
        
        scrollView.delegate = self
        
        setupViews()
        setConstraints()
    }
    
    func didLoadDelegate() {
        // Add gesture recognizer
        tapGestureRecognizer.addTarget(delegate!, action: #selector(delegate!.didTapView(_:)))
        addGestureRecognizer(tapGestureRecognizer)
        
        swipeUpGestureRecognizer.direction = .up
        swipeUpGestureRecognizer.addTarget(delegate!, action: #selector(delegate!.didSwipeUp(_:)))
        addGestureRecognizer(swipeUpGestureRecognizer)
        
        swipeDownGestureRecognizer.direction = .down
        swipeDownGestureRecognizer.addTarget(delegate!, action: #selector(delegate!.didSwipeDown(_:)))
        addGestureRecognizer(swipeDownGestureRecognizer)
        
    }
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        addSubview(detailView)
    }
    
    func setConstraints() {
        
        // The value of these constraints depend on the state of the view
        imageLayoutConstraints = [
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            detailView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            detailView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 400)
        ]
        NSLayoutConstraint.activate(imageLayoutConstraints)
        
        detailsLayoutConstraints = [
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: -1000),
            scrollView.bottomAnchor.constraint(equalTo: topAnchor, constant: 0),
            
            detailView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            detailView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ]
        
        
        NSLayoutConstraint.activate([
            // These constraints should always be active
            scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            
            imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),
            imageView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0),
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 0),
            
            detailView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            detailView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didSwipeUp() {
        NSLayoutConstraint.deactivate(imageLayoutConstraints)
        NSLayoutConstraint.activate(detailsLayoutConstraints)
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
        detailsViewIsActive = true
    }
    
    func didSwipeDown() {
        NSLayoutConstraint.deactivate(detailsLayoutConstraints)
        NSLayoutConstraint.activate(imageLayoutConstraints)
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
        detailsViewIsActive = false
    }
}

extension DetailPhotoView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
