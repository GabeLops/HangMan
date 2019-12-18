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
    var wrongAnswer = 0
    var scoreLabel: UILabel!
    var cluesLabel: UILabel!
    var answerLabel: UILabel!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 22)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.font = UIFont.systemFont(ofSize: 22)
        answerLabel.text = "ANSWER"
        answerLabel.textAlignment = .right
        answerLabel.numberOfLines = 0
        answerLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answerLabel)
        
        let guess = UIButton(type: .system)
        guess.translatesAutoresizingMaskIntoConstraints = false
        guess.setTitle("GUESS", for: .normal)
        guess.addTarget(self, action: #selector(guessLetter), for: .touchUpInside)
        view.addSubview(guess)
        
        NSLayoutConstraint.activate([
        scoreLabel.topAnchor.constraint(equalTo:
            view.layoutMarginsGuide.topAnchor),
        scoreLabel.trailingAnchor.constraint(equalTo:
            view.layoutMarginsGuide.trailingAnchor),
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
        guess.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 25)
            ])
        
        guess.layer.borderWidth = 1
        guess.layer.borderColor = UIColor.black.cgColor
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        wordBank += ["train", "energy", "table", "rhythm", "letter", "cat", "benny", "lola"]
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
    
    @objc func startGame() {
        let ac = UIAlertController(title: "New Game", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        //var startingWord = wordBank.randomElement()
        //view.reloadInputViews()
        present(ac, animated: true)
    }
    
    func gameOver() {
        let gg = UIAlertController(title: "Game Over", message: "Would you like to try again?", preferredStyle: .alert)
        gg.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        gg.addAction(UIAlertAction(title: "Okay", style: .default, handler: {
            (action: UIAlertAction)  in
            self.startGame()
            
        }))
        present(gg, animated: true)
            
        }
    func submit(_ answer: String) {
        if answer.count == 1 {
            
        }else {
            let wa = UIAlertController(title: "You cant guess more than one letter!", message: nil, preferredStyle: .alert)
            wa.addAction(UIAlertAction(title: "Okay", style: .default))
            present(wa, animated: true)
        }
    }
        
    }




