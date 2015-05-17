//
//  ResultViewController.swift
//  quizApp
//
//  Created by Yuta Chiba on 2015/05/17.
//  Copyright (c) 2015年 yuinchirn. All rights reserved.
//

import UIKit
import RealmSwift

class ResultViewController: QuizCommonViewController {
    
    /* UI関連 */
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    /* KEY */
    let explanationTextKey = "explanationText"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func initialize() {
        super.initialize()
        setResultContents()
    }
    
    func setResultContents(){
        titleLabel.text = "第\(progress+1)問"
        questionLabel.text = questionList![progress].valueForKey(questionTextKey) as? String
        answerButton.setTitle(questionList![progress].valueForKey(answerText) as? String, forState: UIControlState.Normal)
        explanationLabel.text = questionList![progress].valueForKey(explanationTextKey) as? String
    }

    @IBAction func prev(btn: UIButton) {
        if canGoBack() {
            progress--
            updateBtnLogic()
            setResultContents()
        }
    }
    
    @IBAction func next(btn: UIButton) {
        if isLastQuestion() {
            self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        }
        if canGoNext() {
            progress++
            updateBtnLogic()
            setResultContents()
        }
    }
    
    func updateBtnLogic(){
        nextBtnLogic()
        prevBtnLogic()
    }
    
    func nextBtnLogic() {
        let nextBtnText = isLastQuestion() ? "終了":"次へ"
        nextBtn.setTitle(nextBtnText, forState: UIControlState.Normal)
    }
    
    func prevBtnLogic() {
        prevBtn.hidden = isFirstQuestion()
    }
    
    func isFirstQuestion() -> Bool {
        return progress == 0
    }
    
    func isLastQuestion() -> Bool {
        return progress == questionList!.count-1
    }
    
    func canGoBack() -> Bool {
        return progress > 0
    }
    
    func canGoNext() -> Bool {
        return progress < questionList!.count-1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
