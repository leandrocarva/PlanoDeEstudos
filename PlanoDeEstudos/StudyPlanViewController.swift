//
//  StudyViewController.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2017 Eric Brito. All rights reserved.

import UIKit
import UserNotifications

class StudyPlanViewController: UIViewController {

    @IBOutlet weak var tfCourse: UITextField!
    @IBOutlet weak var tfSection: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dpDate.minimumDate = Date()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func schedule(_ sender: UIButton) {
        
        // para enviar notificação/////////
        let id = String(Date().timeIntervalSince1970)
        let studyPlan = StudyPlan(course: tfCourse.text!, section: tfSection.text!, date: dpDate.date, done: false, id: id)
        
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Matéria: \(studyPlan.course)"
        content.body = "Está na hora de estudar \(studyPlan.section)"
        content.categoryIdentifier = "Lembrete"
        content.badge = 1
        //content.sound = UNNotificationSound(named: "meuSom.caf")
        
       // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        
        let dateComponents = Calendar.current.dateComponents([.year,.month,.day, .hour, .minute], from: dpDate.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        //////////////////////////////////////////////////////////////////////////////////////////////
        StudyManager.shared.addPlan(studyPlan)
        navigationController?.popViewController(animated: true)
        
    }
    
}
