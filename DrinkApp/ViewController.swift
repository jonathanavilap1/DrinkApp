//
//  ViewController.swift
//  DrinkApp
//
//  Created by Jonathan Avila on 27/01/22.
//

import UIKit


class ViewController: UIViewController, DrinkManagerDelegate {
    var backgroundColor = UIColor(cgColor: CGColor(red: 3/255, green: 25/255, blue: 109/255, alpha: 1))
    var appTitleLabel : UILabel?
    var drinkInput : UITextField?
    var searchDrink: UIView?
    var foundDrinkTitle: UILabel?
    var foundDrinkType: UILabel?
    var drinkImg : UIImageView?
    var searchButton: UIButton?
    var drinkDesc : UILabel?
    var drinkManager = DrinkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = backgroundColor
        
        drinkManager.delegate = self
        
        initUI()
    }
    
    func initUI() {
        titleLabel()
        searcher()
        searButton()
        drinkTitle()
        drinkType()
        drinkImage()
        drinkDescription()
        drinkIngredients()
        
    }
    
    


    
    func titleLabel(){
        appTitleLabel = UILabel()
        appTitleLabel?.text = "DrinkApp"
        appTitleLabel?.backgroundColor = .clear
        appTitleLabel?.textColor = .white
        appTitleLabel?.adjustsFontSizeToFitWidth = true
        view.addSubview(appTitleLabel!)
        appTitleLabel?.addAnchorsAndSize(width: 200, height: 50, left: 10, top: 20, right: nil, bottom: nil)
    }
    func searcher(){
        searchDrink = UIView()
        searchDrink?.backgroundColor = .white
        searchDrink?.layer.cornerRadius = 10
        searchDrink?.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        searchDrink?.layer.borderWidth = 1
        view.addSubview(searchDrink!)
        searchDrink?.addAnchorsAndSize(width: nil, height: 50, left: 20, top: 15, right: 20, bottom: nil, withAnchor: .top, relativeToView: appTitleLabel)
        
        drinkInput = UITextField()
        drinkInput?.placeholder = "  Ingresa tu bebida"
        searchDrink?.addSubview(drinkInput!)
        drinkInput?.addAnchorsAndSize(width: nil, height: 50, left: 5, top: nil, right: 40, bottom: nil)
        
    }
    func searButton(){
        searchButton = UIButton()
        searchButton?.backgroundColor = .clear
        searchButton?.setImage(UIImage(named: "searcher"), for: .normal)
        searchDrink?.addSubview(searchButton!)
        searchButton?.addAnchorsAndSize(width: 40, height: 40, left: nil, top: 5, right: 5, bottom: 5)
        let tapRegisterButton = UITapGestureRecognizer(target: self, action: #selector(newSearchButton))
        searchButton?.addGestureRecognizer(tapRegisterButton)
    }
    @objc func newSearchButton() {
        drinkManager.getDrink(drinkName: drinkInput?.text ?? "")
        
    }
    func drinkTitle(){
        foundDrinkTitle = UILabel()
        foundDrinkTitle?.backgroundColor = .clear
        foundDrinkTitle?.textColor = .white
        foundDrinkTitle?.font = UIFont(name: "Helvetica", size: 35.0)
        view.addSubview(foundDrinkTitle!)
        foundDrinkTitle?.textAlignment = .center
        foundDrinkTitle?.addAnchorsAndSize(width: nil, height: 40, left: 20, top: 50, right: 20, bottom: nil, withAnchor: .top, relativeToView: searchDrink)
    }
    func drinkType(){
        foundDrinkType = UILabel()
        foundDrinkType?.backgroundColor = .clear
        foundDrinkType?.textColor = .white
        foundDrinkType?.textAlignment = .center
        view.addSubview(foundDrinkType!)
        foundDrinkType?.addAnchorsAndSize(width: nil, height: 30, left: 20, top: 10, right: 20, bottom: nil, withAnchor: .top, relativeToView: foundDrinkTitle)

    }
    func drinkImage(){
        drinkImg = UIImageView()
        drinkImg?.backgroundColor = .clear
        view.addSubview(drinkImg!)
        drinkImg?.addAnchorsAndSize(width: 200, height: 200, left: 40, top: 20, right: 40, bottom: nil, withAnchor: .top, relativeToView: foundDrinkType)
        
    }
    func drinkDescription(){
        drinkDesc = UILabel()
        drinkDesc?.backgroundColor = UIColor(cgColor: CGColor(red: 3/255, green: 20/255, blue: 100/255, alpha: 1))
        drinkDesc?.numberOfLines = 20
        drinkDesc?.textColor = .white
        drinkDesc?.font = UIFont(name: "Helvetica", size: 20.0)
        view.addSubview(drinkDesc!)
        drinkDesc?.addAnchorsAndSize(width: nil, height: 250, left: 40, top: 20, right: 40, bottom: nil, withAnchor: .top, relativeToView: drinkImg)
    }
    func drinkIngredients(){
        
    }
    
    func didUpdateDrink(_ drinkManager: DrinkManager, drink: DrinkModel) {
        DispatchQueue.main.async {
            self.foundDrinkTitle?.text = "\(drink.name)"
            self.foundDrinkType?.text = "\(drink.type!)"
            if let url = NSURL(string: drink.image!) {
                print(type(of: url), url)
                if let data = NSData(contentsOf: url as URL) {
                    self.drinkImg?.image = UIImage(data: data as Data)
                    self.drinkImg?.layer.cornerRadius = 10
                    self.drinkImg?.layer.masksToBounds = true
              }
            }
            self.drinkDesc?.text = "\(drink.instructions!)"
            
        }
    }
}

