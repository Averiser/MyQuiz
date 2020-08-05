//
//  GameViewController.swift
//  MyQuiz
//
//  Created by MyMacBook on 01.08.2020.
//  Copyright © 2020 MyMacBook. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var gameModels = [Question]()
  var currentQuestion: Question?
  
  @IBOutlet var label: UILabel!
  @IBOutlet var table: UITableView!
  
  @IBAction func backButtonTapped(_ sender: UIButton) {
    dismiss(animated: true)
  }
  

    override func viewDidLoad() {
        super.viewDidLoad()
      table.delegate = self
      table.dataSource = self
      setupQuestions()
      configureUI(question: gameModels.first!)
    }
  
  private func configureUI(question: Question) {
    label.text = question.text
    currentQuestion = question
    table.reloadData()
  }
  
  private func checkAnswer(answer: Answer, question: Question) -> Bool {
    return question.answers.contains(where: { $0.text == answer.text }) && answer.correct
   
  }
  
  private func setupQuestions() {
    gameModels.append(Question(text: "... two kittens.", answers: [
      Answer(text: "He does", correct: false),
      Answer(text: "He got", correct: false),
      Answer(text: "He has got", correct: true),
      Answer(text: "He have", correct: false)
      ]))
    
    gameModels.append(Question(text: "... Tom play tennis?", answers: [
      Answer(text: "Has", correct: false),
      Answer(text: "Does", correct: true),
      Answer(text: "Do", correct: false),
      Answer(text: "Is", correct: false)
      ]))
    
    gameModels.append(Question(text: "There isn't ... money in my pockets.", answers: [
      Answer(text: "much", correct: true),
      Answer(text: "some", correct: false),
      Answer(text: "a few", correct: false),
      Answer(text: "no", correct: false)
      ]))
    
    gameModels.append(Question(text: "What did she ... you about it?", answers: [
    Answer(text: "told", correct: false),
    Answer(text: "talk", correct: false),
    Answer(text: "speak", correct: false),
    Answer(text: "say to", correct: true)
    ]))
    
    gameModels.append(Question(text: "How much ... ", answers: [
    Answer(text: "did it costed", correct: false),
    Answer(text: "does it cost", correct: true),
    Answer(text: "do this sweater cost", correct: false),
    Answer(text: "does it costs", correct: false)
    ]))
    
    gameModels.append(Question(text: "We ..., when the phone rang.  ", answers: [
    Answer(text: "cook", correct: false),
    Answer(text: "don't cook", correct: false),
    Answer(text: "cooked", correct: false),
    Answer(text: "were cooking", correct: true)
    ]))
    
    gameModels.shuffle()
  }
  
  //    = ["... two kittens.", "... Tom play tennis?",  "There isn't ... money in my pockets.", "What did she ... you about it?", "How much ... ", "We ..., when the phone rang."]
  //
  //  var options = [["He does","He got","He has got", "He have"], ["Has", "Does", "Do", "Is",], ["much", "some","a few","no"], ["told", "talk", "speak", "say to"], ["did it costed", "does it cost", "do this sweater cost", "does it costs"], ["cook", "don't cook", "cooked", "were cooking"]]
  
  // Table view functions
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentQuestion?.answers.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
//    // initialize an empty array
//   // var gameModels = [Question]()  - initialized above
//    
//    // create a random number between 0 and the number of items in the array
//    var randomGameModel = arc4random_uniform(UInt32(gameModels.count - 1))
//    
//    // randomly add an item from the numbers array to the empty array
//    gameModels.append(
    
    guard let question = currentQuestion else { return }
    
    let answer = question.answers[indexPath.row]
    
    if checkAnswer(answer: answer, question: question) {
      //
      if let index = gameModels.firstIndex(where: { $0.text == question.text }) {
        if index < (gameModels.count - 1) {
          // next question
          let nextQuestion = gameModels[index + 1]
          print("\(nextQuestion.text)")
          currentQuestion = nil
          configureUI(question: nextQuestion)
      } else {
        // end of game
          let alert = UIAlertController(title: "Done", message: "You beat the game", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
          present(alert, animated: true)
        }
      }
    }
    else {
      // wrong
      let alert = UIAlertController(title: "Wrong", message: "You suck", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
      present(alert, animated: true)
    }
  }
  }
  
  struct Question {
    let text: String
    let answers: [Answer]
  }
  
  struct Answer {
    let text: String
    let correct: Bool // true / false
    
  }
    

