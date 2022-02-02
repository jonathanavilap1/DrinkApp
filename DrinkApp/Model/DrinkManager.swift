//
//  DrinkManager.swift
//  DrinkApp
//
//  Created by Adriana Limon on 1/28/22.
//
import Foundation

protocol DrinkManagerDelegate {
    func didUpdateDrink(_ drinkManager: DrinkManager, drink: DrinkModel)
}

struct DrinkManager {
    let drinkUrl = "https://www.thecocktaildb.com/api/json/v1/1/search.php?"
    
    var delegate: DrinkManagerDelegate?
    
    func getDrink(drinkName: String) {
        let urlString = "\(drinkUrl)s=\(drinkName)"
        perfomRequest(urlString: urlString)
    }
    
    func perfomRequest(urlString: String) {
        // Hacemos los 4 pasos
        //1.Crear un URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Darle la session una tarea

            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    print(error)
                    
                    return
                }

                if let safeData = data {
                    if  let drink = self.parseJSON(drinks: safeData) {
                        delegate?.didUpdateDrink(self, drink: drink)
                    }
                }
            }

            task.resume()
        }
    }
    
    func parseJSON(drinks: Data) -> DrinkModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(DrinksDataModel.self, from: drinks)
            
            let drinkData = decodedData.drinks[0]
            
            let drink = DrinkModel(id: drinkData.idDrink, name: drinkData.strDrink, type: drinkData.strCategory, glassType: drinkData.strGlass, instructions: drinkData.strInstructions, image: drinkData.strDrinkThumb, ingredients: drinkData.strIngredient1, measure: drinkData.strMeasure1)
            
            return drink
        } catch {
            print(error)
            
            return nil
        }
    }
}
