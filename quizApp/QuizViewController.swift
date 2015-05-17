//
//  QuizViewController.swift
//  quizApp
//
//  Created by Yuta Chiba on 2015/05/14.
//  Copyright (c) 2015年 yuinchirn. All rights reserved.
//

import UIKit
import RealmSwift

class QuizViewController: QuizCommonViewController {

    /* UI関連 */
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    var resultAlertController = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func initialize() {
        super.initialize()
        setQuestion()
        setAlertController()
    }
    
    func setQuestion(){
        questionLabel.text = questionList![progress].valueForKey(questionTextKey) as? String
        answerButton1.setTitle(questionList![progress].valueForKey(choice1Key) as? String, forState: UIControlState.Normal)
        answerButton2.setTitle(questionList![progress].valueForKey(choice2Key) as? String, forState: UIControlState.Normal)
        answerButton3.setTitle(questionList![progress].valueForKey(choice3Key) as? String, forState: UIControlState.Normal)
        answerButton4.setTitle(questionList![progress].valueForKey(choice4Key) as? String, forState: UIControlState.Normal)
    }
    
    func setAlertController(){
        resultAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        // TODO AlertControllerまわりのだしわけをクロージャと関数オブジェクトでいい感じにかけそう
        // 次へ
        let nextAction = UIAlertAction(title: "Next", style: .Default) { action in
            self.progress++
            if self.progress >= self.questionList?.count {
                self.performSegueWithIdentifier(self.showResultSegue,sender: nil)
                return
            }
            self.setQuestion()
        }
        resultAlertController.addAction(nextAction)
    }
    
    @IBAction func btnTouched(selectedBtn: UIButton) {
        println(selectedBtn.tag)
        let answerNum = questionList![progress].valueForKey("answerNum") as? Int
        
        let resultText:String
        if selectedBtn.tag == answerNum {
            resultText = "あたり！"
        } else {
            resultText = "はずれ！"
        }
        showResultAlertView(resultText, selectedAnswer: selectedBtn.titleLabel!.text!)
    }
    
    func showResultAlertView(resultText:String, selectedAnswer:String){
        
        let answerText = questionList![progress].valueForKey("answerText") as! String
        let message = "正解は\(answerText)！あなたの答えは\(selectedAnswer)"
        
        resultAlertController.title = resultText
        resultAlertController.message = message
        
        presentViewController(resultAlertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == showResultSegue) {
            // ResultViewControllerクラスをインスタンス化してsegue（画面遷移）で値を渡せるようにバンドルする
            var resultView : ResultViewController = segue.destinationViewController as! ResultViewController
        }
    }
}
