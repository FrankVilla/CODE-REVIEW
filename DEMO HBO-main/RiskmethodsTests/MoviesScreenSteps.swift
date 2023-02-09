//
//  MoviesScreenSteps.swift
//  RiskmethodsUITests
//
//  Created by Erinson Villarroel on 28/02/2022.
//

import Foundation
import XCTest
import Cucumberish

class MoviesScreenSteps: MovieScreen {
    
    var application: XCUIApplication!
   
    func ListMoviesScreenSteps(application: XCUIApplication) {
        self.application = application
        
        Given("The list of Movies screen is visible") { (_, _) -> Void in
           
        }

        MatchAll("The list of Movies screen is visible") { (_, _) -> Void in
            
        }

         Then("The Movies app is started") { (_, _) -> Void in
            
        }
    }
    
    func verifyMovieScreen() {
      
    }

}
