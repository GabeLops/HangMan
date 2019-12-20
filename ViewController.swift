//
//  ViewController.swift
//  Challenge3
//
//  Created by Gabriel Lops on 12/16/19.
//  Copyright © 2019 Gabriel Lops. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var wordBank = [String]()
    var usedLetters = [String]()
    var wrongAnswers: UILabel!
    var scoreLabel: UILabel!
    var cluesLabel: UILabel!
    var answerLabel: UILabel!
    var wrongAnswer = 7 {
        didSet {
            if wrongAnswer < 0 {wrongAnswer = 0}
            wrongAnswers.text = "You have \(wrongAnswer) attempts"
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .gray
        navigationController?.navigationBar.barTintColor = UIColor.gray
        navigationItem.titleView = UIView()
        wordBank += ["train", "energy", "table", "rhythm", "letter", "cat", "benny", "lola"]
        let startingWord = wordBank.randomElement()
        title = startingWord
        
        
        
        
       
        wrongAnswers = UILabel()
        wrongAnswers.translatesAutoresizingMaskIntoConstraints = false
        wrongAnswers.textAlignment = .left
        wrongAnswers.text = "You have \(wrongAnswer) attempts"
        view.addSubview(wrongAnswers)
        
        
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.text = " "
        cluesLabel.font = UIFont.systemFont(ofSize: 22)
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.font = UIFont.systemFont(ofSize: 22)
        let word = title
        let used = usedLetters
        var promptWord = ""
        for letter in word! {
            let strLetter = String(letter)
            if used.contains(strLetter) {
                promptWord += strLetter
            } else {
                promptWord += "? "
            }
        }
        answerLabel.text = promptWord
        answerLabel.textColor = .green
        answerLabel.textAlignment = .right
        answerLabel.numberOfLines = 0
        answerLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answerLabel)
        
        let guess = UIButton(type: .system)
        guess.translatesAutoresizingMaskIntoConstraints = false
        guess.setTitle("GUESS", for: .normal)
        guess.setTitleColor(.black, for: .normal)
        guess.addTarget(self, action: #selector(guessLetter), for: .touchUpInside)
        view.addSubview(guess)
        
        NSLayoutConstraint.activate([
        
        cluesLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -400),
        cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 25),
        cluesLabel.widthAnchor.constraint(equalTo:
            view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -50),
        answerLabel.bottomAnchor.constraint(equalTo: cluesLabel.bottomAnchor),
        answerLabel.trailingAnchor.constraint(equalTo:
            view.layoutMarginsGuide.trailingAnchor, constant: -25),
        answerLabel.widthAnchor.constraint(equalTo:
            view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -50),
        answerLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
        guess.leadingAnchor.constraint(equalTo: cluesLabel.trailingAnchor, constant: -45),
        guess.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 25),
        wrongAnswers.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
        wrongAnswers.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
            ])
        
        guess.layer.borderWidth = 1
        guess.layer.borderColor = UIColor.black.cgColor
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
        
        }
    
    @objc func guessLetter() {
        let gl = UIAlertController(title: "Guess your letter", message: nil, preferredStyle: .alert)
        gl.addTextField()
        // handler will be what checks if letter is in word and then assigns letter to word they are guessing
       let submitAnswer = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak gl] _ in
            guard let answer = gl?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        gl.addAction(submitAnswer)
        present(gl, animated: true)
        
    }
    
    @objc func restartGame() {
        usedLetters.removeAll()
        wrongAnswer = 7
        
        let ac = UIAlertController(title: "New Game", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default))
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        present(ac, animated: true)
        title = wordBank.randomElement()
        let word = title
        let used = usedLetters
        var promptWord = ""
        for letter in word! {
            let strLetter = String(letter)
            if used.contains(strLetter) {
                promptWord += strLetter
            } else {
                promptWord += "? "
            }
        }
        answerLabel.text = promptWord
        cluesLabel.text = " "

        }
        
    
    
    @objc func startGame() {
        usedLetters.removeAll()
        wrongAnswer = 7
        let ac = UIAlertController(title: "New Game", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default))
        present(ac, animated: true)
        title = wordBank.randomElement()
        let word = title
        let used = usedLetters
        var promptWord = ""
        for letter in word! {
            let strLetter = String(letter)
            if used.contains(strLetter) {
                promptWord += strLetter
            } else {
                promptWord += "? "
            }
        }
        answerLabel.text = promptWord
        cluesLabel.text = " "

    }
    
    func gameOver() {
        let gg = UIAlertController(title: "Game Over", message: "your word was \(title!), Would you like to try again?", preferredStyle: .alert)
        gg.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        gg.addAction(UIAlertAction(title: "Okay", style: .default, handler: {
            (action: UIAlertAction)  in
            self.startGame()
            
        }))
        present(gg, animated: true)
            
        }
    func submit(_ answer: String) {
        
        if !title!.contains(answer){
            if wrongAnswer == 1 {
                gameOver()
            }else{
                wrongAnswer -= 1
            }
        }
        if answer.count == 1 {
            if !usedLetters.contains(answer) {
                usedLetters.append(answer)
                cluesLabel.text?.append("\(answer) ")
                }else {
                    let wa = UIAlertController(title: "You cant guess the same letter", message: nil, preferredStyle: .alert)
                        wa.addAction(UIAlertAction(title: "Okay", style: .default))
                        present(wa, animated: true)
                        
            }
            }else {
                let wa = UIAlertController(title: "You cant guess more than one letter!", message: nil, preferredStyle: .alert)
                wa.addAction(UIAlertAction(title: "Okay", style: .default))
                present(wa, animated: true)
            }
        
        let word = title
        let used = usedLetters
        var promptWord = ""
        for letter in word! {
            let strLetter = String(letter)
            if used.contains(strLetter) {
                promptWord += strLetter
                
            } else {
                promptWord += "? "
            }
        }
        answerLabel.text = promptWord
        
        if answerLabel.text == title {
            let youWin = UIAlertController(title: "You Win!", message: "Would you like to play again?", preferredStyle: .alert)
            youWin.addAction(UIAlertAction(title: "Okay", style: .default,handler: {(action: UIAlertAction) in self.startGame()} ))
            youWin.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
                
            present(youWin, animated: true)
            }
            
            
        }
        
            
            
                   
               
    
       
    
    }

        
    




