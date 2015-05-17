//
//  QuizCommonViewController.swift
//  quizApp
//
//  Created by Yuta Chiba on 2015/05/17.
//  Copyright (c) 2015年 yuinchirn. All rights reserved.
//

import UIKit
import RealmSwift

class QuizCommonViewController: UIViewController {
    
    /* 各種キー */
    // TODO 本当はmodelに書きたい。。。
    let questionTextKey = "questionText"
    let choice1Key = "choice1"
    let choice2Key = "choice2"
    let choice3Key = "choice3"
    let choice4Key = "choice4"
    let answerText = "answerText"
    
    /* その他 */
    var progress = 0 // 現在の問題の番号を示すInt
    let showResultSegue = "showResult"
    let dbName = "initial.realm"
    
    /* DB関連 */
    var realm = Realm()
    var questionList:Results<Question>?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /* 各種初期処理を行う */
    func initialize(){
        setDatabase()
        progress = 0
    }
    
    /* データの設定 */
    // TODO むしろAppdelegateでいいかも。。。
    func setDatabase(){
        // TODO DBが存在しないにDBを配置、存在しない場合に初期DBを作成する処理
        let dbPath :String = NSBundle.mainBundle().pathForResource(dbName, ofType:nil)!
        realm = Realm(path: dbPath, readOnly: true, encryptionKey: nil, error: nil)!
        questionList = realm.objects(Question)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
