//
//  ViewController.swift
//  RandomPhoto
//
//  Created by Connor Groen on 2022-01-18.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {
    
    //Gets the region for the image
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.borderWidth = 5
        return imageView
    }()
    
    //gets the region for the button
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 15
        button.setTitle("Random Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 6
        button.layer.borderColor = UIColor.black.cgColor
        
        return button
    }()
    
    
    //array for the button colours
    let colors: [UIColor] = [
        .systemGreen,
        .systemPink,
        .systemRed,
        .systemBlue,
        .systemTeal,
        .systemOrange,
        .systemYellow,
        .systemPurple,
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen //changes background colour
        view.addSubview(imageView) //makes image visable
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300) //sets the dimensions for the image
        imageView.center = view.center //puts the image in the center
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        view.addSubview(button) //Puts the button on the screen
        
        
        getRandomPhoto() //calls getRandomPhoto function
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside) //sending the signal that the button gets pressed
    }
    
    //When the button gets pressed this is what it does
    @objc func didTapButton() {
        getRandomPhoto()
        
        view.backgroundColor = colors.randomElement() //sets the random backgroundcolour when the button is pressed
        button.backgroundColor = colors.randomElement()
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        
        
        if button.backgroundColor == view.backgroundColor {
            button.backgroundColor = colors.randomElement()
            
            print("The backgrounds are the same so they have been changed.")
            
        }
        
        
    }
    
    //Makes the button not in the "back to home screen bar"
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.frame = CGRect(
            x: 35,
            y:
                view.frame.size.height-200-view.safeAreaInsets.bottom,
            width: view.frame.size.width-60,
            height: 55)
    }
    
    //function to get a random photo
    func getRandomPhoto() {
        let urlString = "https://picsum.photos/600" //set a url as a string constant
        let url = URL(string: urlString)! //makes a new constant set as the other constant and tells it to make it into a working URL. Put the "!" so it knows it'll work
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        imageView.image = UIImage(data: data)
    }

}

