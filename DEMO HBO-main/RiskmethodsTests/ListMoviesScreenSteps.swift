//
//  ListMoviesScreenSteps.swift
//  RiskmethodsUITests
//
//  Created by Erinson Villarroel on 28/02/2022.
//

import Foundation
import UIKit
import XCTest
import Cucumberish

final class ListMoviesScreenSteps: AllMovieScreen {
    
    var recordedSeriesProgramName: String?
    var recordedProgramName: String?
    var beforeRestartSliderValue: Int32?
    let application = XCUIApplication()
    
    func liveTVScreenSteps(application: XCUIApplication) {

        backgroundSteps()
        openMovieSteps()
        displayDetailsSteps()
        selectMovieWatched()
        selectMovieNoWatched()
    }

    func backgroundSteps() {
        Given("The user Open list of Movies") { (_, _) -> Void in
          
        }
    }

    func openMovieSteps() {
  
        Given("I Open list of Movies") { (_, _) in
           
        }
        When("The list of popular movies is open") { (_, _) in
            
        }
        When("Select Upcoming movies") { (_, _) in
          
        }
        Then("Select the Top rates movies") { (_, _) in
          
        }

    }
    
    func displayDetailsSteps() {

        Given("I Open list of Movies") { (_, _) in
          
        }
        When("I selected a movie") { (_, _) in
           
        }
        When("The detail page is displayed") { (_, _) in
        }
        
        Then("I close detail page") { (_, _) in
        }
        
    }
  

    func selectMovieWatched() {

        Given("I Open list of Movies") { (_, _) in
            
        }
        When("I selected a movie watched") { (_, _) in
           
        }
        Then("Confirm movie watched") { (_, _) in
          
        }
    }
        
    func selectMovieNoWatched() {
        Given("I Open list of Movies") { (_, _) in
                
        }
        When("I selected a movie watched") { (_, _) in
               
        }
        When("I confirm movie watched") { (_, _) in
              
        }
        When("I selected a movie no watched") { (_, _) in
              
        }
        Then("I confirm movie no watched") { (_, _) in
              
        }
    }
}
